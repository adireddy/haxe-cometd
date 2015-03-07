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
     * Returns whether this instance has been disconnected.
     */
	var isDisconnected:Bool;

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
	function handshake(handshakeProps:Dynamic, ?handshakeCallback:Dynamic):Void;

	/**
     * Disconnects from the Bayeux server.
     * It is possible to suggest to attempt a synchronous disconnect, but this feature
     * may only be available in certain transports (for example, long-polling may support
     * it, callback-polling certainly does not).
     * @param sync whether attempt to perform a synchronous disconnect
     * @param disconnectProps an object to be merged with the disconnect message
     * @param disconnectCallback a function to be invoked when the disconnect is acknowledged
     */
	function disconnect(sync:Dynamic, ?disconnectProps:Dynamic, ?disconnectCallback:Dynamic):Void;

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
	function unsubscribe(subscription:Dynamic, ?unsubscribeProps:Dynamic, ?unsubscribeCallback:Dynamic):Void;

	function resubscribe(subscription:Dynamic, ?subscribeProps:Dynamic):Dynamic;

	/**
     * Removes all subscriptions added via {@link #subscribe(channel, scope, callback, subscribeProps)},
     * but does not remove the listeners added via {@link addListener(channel, scope, callback)}.
     */
	function clearSubscriptions():Void;

	/**
     * Publishes a message on the given channel, containing the given content.
     * @param channel the channel to publish the message to
     * @param content the content of the message
     * @param publishProps an object to be merged with the publish message
     * @param publishCallback a function to be invoked when the publish is acknowledged by the server
     */
	function publish(channel:Dynamic, content:Dynamic, ?publishProps:Dynamic, ?publishCallback:Dynamic):Void;

	/**
     * Returns a string representing the status of the bayeux communication with the Bayeux server.
     */
	function getStatus():String;

	/**
     * Sets the backoff period used to increase the backoff time when retrying an unsuccessful or failed message.
     * Default value is 1 second, which means if there is a persistent failure the retries will happen
     * after 1 second, then after 2 seconds, then after 3 seconds, etc. So for example with 15 seconds of
     * elapsed time, there will be 5 retries (at 1, 3, 6, 10 and 15 seconds elapsed).
     * @param period the backoff period to set
     * @see #getBackoffIncrement()
     */
	function setBackoffIncrement(period:Float):Void;

	/**
     * Returns the backoff period used to increase the backoff time when retrying an unsuccessful or failed message.
     * @see #setBackoffIncrement(period)
     */
	function getBackoffIncrement ():Float;

	/**
     * Returns the backoff period to wait before retrying an unsuccessful or failed message.
     */
	function getBackoffPeriod():Float;

	/**
     * Sets the log level for console logging.
     * Valid values are the strings 'error', 'warn', 'info' and 'debug', from
     * less verbose to more verbose.
     * @param level the log level string
     */
	function setLogLevel(level:String):Void;

	/**
     * Registers an extension whose callbacks are called for every incoming message
     * (that comes from the server to this client implementation) and for every
     * outgoing message (that originates from this client implementation for the
     * server).
     * The format of the extension object is the following:
     * <pre>
     * {
     *     incoming: function(message) { ... },
     *     outgoing: function(message) { ... }
     * }
     * </pre>
     * Both properties are optional, but if they are present they will be called
     * respectively for each incoming message and for each outgoing message.
     * @param name the name of the extension
     * @param extension the extension to register
     * @return true if the extension was registered, false otherwise
     * @see #unregisterExtension(name)
     */
	function registerExtension(name:String, extension:Dynamic):Bool;

	/**
     * Unregister an extension previously registered with
     * {@link #registerExtension(name, extension)}.
     * @param name the name of the extension to unregister.
     * @return true if the extension was unregistered, false otherwise
     */
	function unregisterExtension(name:String):Bool;

	/**
     * Find the extension registered with the given name.
     * @param name the name of the extension to find
     * @return the extension found or null if no extension with the given name has been registered
     */
	function getExtension(name:String):Dynamic;

	/**
     * Returns the name assigned to this CometD object, or the string 'default'
     * if no name has been explicitly passed as parameter to the constructor.
     */
	function getName():String;

	/**
     * Returns the clientId assigned by the Bayeux server during handshake.
     */
	function getClientId():Dynamic;

	/**
     * Returns the URL of the Bayeux server.
     */
	function getURL():String;


	function getTransport():Dynamic;

	function getConfiguration():Dynamic;

	function getAdvice():Dynamic;
}