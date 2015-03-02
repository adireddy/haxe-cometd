package cometd;

@:native("org.cometd.CometD")
extern class CometD {

	/**
	 * The constructor for a CometD object, identified by an optional name.
	 * The default name is the string 'default'.
	 * In the rare case a page needs more than one Bayeux conversation,
	 * a new instance can be created via:
	 * <pre>
	 * var bayeuxUrl2 = ...;
	 *
	 * // Dojo style
	 * var cometd2 = new dojox.CometD('another_optional_name');
	 *
	 * // jQuery style
	 * var cometd2 = new $.CometD('another_optional_name');
	 *
	 * cometd2.init({url: bayeuxUrl2});
	 * </pre>
	 * @param name the optional name of this cometd object
	 */
	// IMPLEMENTATION NOTES:
	// Be very careful in not changing the function order and pass this file every time through JSLint (http://jslint.com)
	// The only implied globals must be "dojo", "org" and "window", and check that there are no "unused" warnings
	// Failing to pass JSLint may result in shrinkers/minifiers to create an unusable file.
	function new(?name:String);

	var websocketEnabled:Bool;

	/**
     * Registers the given transport under the given transport type.
     * The optional index parameter specifies the "priority" at which the
     * transport is registered (where 0 is the max priority).
     * If a transport with the same type is already registered, this function
     * does nothing and returns false.
     * @param type the transport type
     * @param transport the transport object
     * @param index the index at which this transport is to be registered
     * @return true if the transport has been registered, false otherwise
     * @see #unregisterTransport(type)
     */
	function registerTransport(type:String, transport:Dynamic, ?index:Int):Bool;

	/**
     * @return an array of all registered transport types
     */
	function getTransportTypes():Array<String>;

	/**
     * Unregisters the transport with the given transport type.
     * @param type the transport type to unregister
     * @return the transport that has been unregistered,
     * or null if no transport was previously registered under the given transport type
     */
	function unregisterTransport(type:String):Dynamic;

	/**
     * Configures the initial Bayeux communication with the Bayeux server.
     * Configuration is passed via an object that must contain a mandatory field <code>url</code>
     * of type string containing the URL of the Bayeux server.
     * @param configuration the configuration object
     */
	function configure(configuration:Dynamic):Void;

	/**
     * Configures and establishes the Bayeux communication with the Bayeux server
     * via a handshake and a subsequent connect.
     * @param configuration the configuration object
     * @param handshakeProps an object to be merged with the handshake message
     * @see #configure(configuration)
     * @see #handshake(handshakeProps)
     */
	function init(configuration:Dynamic, ?handshakeProps:Dynamic):Void;

	/**
     * Establishes the Bayeux communication with the Bayeux server
     * via a handshake and a subsequent connect.
     * @param handshakeProps an object to be merged with the handshake message
     * @param handshakeCallback a function to be invoked when the handshake is acknowledged
     */
	function handshake(handshakeProps:Dynamic, handshakeCallback:Dynamic):Void;

	/**
     * Disconnects from the Bayeux server.
     * It is possible to suggest to attempt a synchronous disconnect, but this feature
     * may only be available in certain transports (for example, long-polling may support
     * it, callback-polling certainly does not).
     * @param sync whether attempt to perform a synchronous disconnect
     * @param disconnectProps an object to be merged with the disconnect message
     * @param disconnectCallback a function to be invoked when the disconnect is acknowledged
     */
	function disconnect(sync:Dynamic, disconnectProps:Dynamic, disconnectCallback:Dynamic):Void;

	/**
     * Marks the start of a batch of application messages to be sent to the server
     * in a single request, obtaining a single response containing (possibly) many
     * application reply messages.
     * Messages are held in a queue and not sent until {@link #endBatch()} is called.
     * If startBatch() is called multiple times, then an equal number of endBatch()
     * calls must be made to close and send the batch of messages.
     * @see #endBatch()
     */
	function startBatch():Void;

	/**
     * Marks the end of a batch of application messages to be sent to the server
     * in a single request.
     * @see #startBatch()
     */
	function endBatch():Void;

	/**
     * Executes the given callback in the given scope, surrounded by a {@link #startBatch()}
     * and {@link #endBatch()} calls.
     * @param scope the scope of the callback, may be omitted
     * @param callback the callback to be executed within {@link #startBatch()} and {@link #endBatch()} calls
     */
	function batch(scope:Dynamic, callback:Dynamic):Void;

	/**
     * Adds a listener for bayeux messages, performing the given callback in the given scope
     * when a message for the given channel arrives.
     * @param channel the channel the listener is interested to
     * @param scope the scope of the callback, may be omitted
     * @param callback the callback to call when a message is sent to the channel
     * @returns the subscription handle to be passed to {@link #removeListener(object)}
     * @see #removeListener(subscription)
     */
	function addListener(channel:Dynamic, ?scope:Dynamic, ?callback:Dynamic):Void;

	/**
     * Removes the subscription obtained with a call to {@link #addListener(string, object, function)}.
     * @param subscription the subscription to unsubscribe.
     * @see #addListener(channel, scope, callback)
     */
	function removeListener(subscription:Dynamic):Void;

	/**
     * Removes all listeners registered with {@link #addListener(channel, scope, callback)} or
     * {@link #subscribe(channel, scope, callback)}.
     */
	function clearListeners():Void;

	/**
     * Subscribes to the given channel, performing the given callback in the given scope
     * when a message for the channel arrives.
     * @param channel the channel to subscribe to
     * @param scope the scope of the callback, may be omitted
     * @param callback the callback to call when a message is sent to the channel
     * @param subscribeProps an object to be merged with the subscribe message
     * @param subscribeCallback a function to be invoked when the subscription is acknowledged
     * @return the subscription handle to be passed to {@link #unsubscribe(object)}
     */
	function subscribe(channel:String, ?scope:Dynamic, ?callback:Dynamic, ?subscribeProps:Dynamic, ?subscribeCallback:Dynamic):Dynamic;

	/**
     * Unsubscribes the subscription obtained with a call to {@link #subscribe(string, object, function)}.
     * @param subscription the subscription to unsubscribe.
     * @param unsubscribeProps an object to be merged with the unsubscribe message
     * @param unsubscribeCallback a function to be invoked when the unsubscription is acknowledged
     */
	function unsubscribe(subscription:Dynamic, unsubscribeProps:Dynamic, unsubscribeCallback:Dynamic):Void;

	/**
     * Sets the log level for console logging.
     * Valid values are the strings 'error', 'warn', 'info' and 'debug', from
     * less verbose to more verbose.
     * @param level the log level string
     */
	function setLogLevel(level:String):Void;
}