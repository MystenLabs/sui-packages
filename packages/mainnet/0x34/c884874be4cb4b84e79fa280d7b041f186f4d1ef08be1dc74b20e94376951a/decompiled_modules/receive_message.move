module 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::receive_message {
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

    public fun sender(arg0: &Receipt) : address {
        arg0.sender
    }

    public fun message_body(arg0: &Receipt) : &vector<u8> {
        &arg0.message_body
    }

    public fun source_domain(arg0: &Receipt) : u32 {
        arg0.source_domain
    }

    public fun receive_message(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: &0x2::tx_context::TxContext) : Receipt {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg2));
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::paused(arg2), 0);
        let v0 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::from_bytes(&arg0);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::attestation::verify_attestation_signatures(arg0, arg1, arg2);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::destination_domain(&v0) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2), 2);
        let v1 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::destination_caller(&v0);
        assert!(v1 == @0x0 || v1 == 0x2::tx_context::sender(arg3), 1);
        assert!(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::version(&v0) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::message_version(arg2), 3);
        let v2 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::source_domain(&v0);
        let v3 = 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::nonce(&v0);
        assert!(!0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::is_nonce_used(arg2, v2, v3), 4);
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::mark_nonce_used(arg2, v2, v3);
        Receipt{
            caller          : 0x2::tx_context::sender(arg3),
            recipient       : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::recipient(&v0),
            source_domain   : v2,
            sender          : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::sender(&v0),
            nonce           : v3,
            message_body    : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::message::message_body(&v0),
            current_version : 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::current_version(),
        }
    }

    fun assert_valid_receipt_version(arg0: &Receipt) {
        assert!(current_version(arg0) == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::current_version(), 6);
    }

    public fun complete_receive_message(arg0: StampedReceipt, arg1: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg1));
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

    public fun stamp_receipt<T0: drop>(arg0: Receipt, arg1: T0, arg2: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State) : StampedReceipt {
        0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::version_control::assert_object_version_is_compatible_with_package(0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::compatible_versions(arg2));
        assert_valid_receipt_version(&arg0);
        assert!(arg0.recipient == 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::send_message::auth_caller_identifier<T0>(), 5);
        StampedReceipt{receipt: arg0}
    }

    // decompiled from Move bytecode v6
}

