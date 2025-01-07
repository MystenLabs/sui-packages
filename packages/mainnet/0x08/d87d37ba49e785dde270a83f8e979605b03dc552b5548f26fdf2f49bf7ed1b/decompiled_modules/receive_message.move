module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::receive_message {
    struct Receipt {
        caller: address,
        recipient: address,
        source_domain: u32,
        sender: address,
        nonce: u64,
        message_body: vector<u8>,
        current_version: u64,
    }

    struct StampedReceipt {
        receipt: Receipt,
    }

    struct MessageReceived has copy, drop {
        caller: address,
        source_domain: u32,
        nonce: u64,
        sender: address,
        message_body: vector<u8>,
    }

    struct ReceiveMessageTicket<T0: drop> {
        auth: T0,
        message: vector<u8>,
        attestation: vector<u8>,
    }

    struct StampReceiptTicket<T0: drop> {
        auth: T0,
        receipt: Receipt,
    }

    public fun sender(arg0: &Receipt) : address {
        arg0.sender
    }

    public fun message_body(arg0: &Receipt) : &vector<u8> {
        &arg0.message_body
    }

    public fun nonce(arg0: &Receipt) : u64 {
        arg0.nonce
    }

    public fun recipient(arg0: &Receipt) : address {
        arg0.recipient
    }

    public fun source_domain(arg0: &Receipt) : u32 {
        arg0.source_domain
    }

    public fun receive_message(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: &0x2::tx_context::TxContext) : Receipt {
        receive_message_shared(arg0, arg1, 0x2::tx_context::sender(arg3), arg2)
    }

    fun assert_valid_receipt_version(arg0: &Receipt) {
        assert!(current_version(arg0) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::current_version(), 6);
    }

    public fun caller(arg0: &Receipt) : address {
        arg0.caller
    }

    public fun complete_receive_message(arg0: StampedReceipt, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg1));
        assert_valid_receipt_version(receipt(&arg0));
        let v0 = MessageReceived{
            caller        : arg0.receipt.caller,
            source_domain : arg0.receipt.source_domain,
            nonce         : arg0.receipt.nonce,
            sender        : arg0.receipt.sender,
            message_body  : arg0.receipt.message_body,
        };
        0x2::event::emit<MessageReceived>(v0);
        destroy_receipt(arg0);
    }

    public fun create_receive_message_ticket<T0: drop>(arg0: T0, arg1: vector<u8>, arg2: vector<u8>) : ReceiveMessageTicket<T0> {
        ReceiveMessageTicket<T0>{
            auth        : arg0,
            message     : arg1,
            attestation : arg2,
        }
    }

    public fun create_stamp_receipt_ticket<T0: drop>(arg0: T0, arg1: Receipt) : StampReceiptTicket<T0> {
        StampReceiptTicket<T0>{
            auth    : arg0,
            receipt : arg1,
        }
    }

    public fun current_version(arg0: &Receipt) : u64 {
        arg0.current_version
    }

    fun destroy_receipt(arg0: StampedReceipt) {
        let StampedReceipt { receipt: v0 } = arg0;
        let Receipt {
            caller          : _,
            recipient       : _,
            source_domain   : _,
            sender          : _,
            nonce           : _,
            message_body    : _,
            current_version : _,
        } = v0;
    }

    public fun receipt(arg0: &StampedReceipt) : &Receipt {
        &arg0.receipt
    }

    fun receive_message_shared(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : Receipt {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg3));
        assert!(!0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::paused(arg3), 0);
        let v0 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::from_bytes(&arg0);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::attestation::verify_attestation_signatures(arg0, arg1, arg3);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_domain(&v0) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg3), 2);
        let v1 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::destination_caller(&v0);
        assert!(v1 == @0x0 || v1 == arg2, 1);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::version(&v0) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::message_version(arg3), 3);
        let v2 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::source_domain(&v0);
        let v3 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v0);
        assert!(!0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::is_nonce_used(arg3, v2, v3), 4);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::mark_nonce_used(arg3, v2, v3);
        Receipt{
            caller          : arg2,
            recipient       : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::recipient(&v0),
            source_domain   : v2,
            sender          : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::sender(&v0),
            nonce           : v3,
            message_body    : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::message_body(&v0),
            current_version : 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::current_version(),
        }
    }

    public fun receive_message_with_package_auth<T0: drop>(arg0: ReceiveMessageTicket<T0>, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : Receipt {
        let ReceiveMessageTicket {
            auth        : _,
            message     : v1,
            attestation : v2,
        } = arg0;
        receive_message_shared(v1, v2, 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T0>(), arg1)
    }

    public fun stamp_receipt<T0: drop>(arg0: StampReceiptTicket<T0>, arg1: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State) : StampedReceipt {
        let StampReceiptTicket {
            auth    : _,
            receipt : v1,
        } = arg0;
        let v2 = v1;
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg1));
        assert_valid_receipt_version(&v2);
        assert!(v2.recipient == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::auth::auth_caller_identifier<T0>(), 5);
        StampedReceipt{receipt: v2}
    }

    // decompiled from Move bytecode v6
}

