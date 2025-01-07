module 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::receive_message {
    struct Receipt {
        caller: address,
        recipient: address,
        source_domain: u32,
        sender: address,
        nonce: u64,
        message_body: vector<u8>,
        state_compatible_versions: 0x2::vec_set::VecSet<u64>,
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

    public fun receive_message(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg3: &0x2::tx_context::TxContext) : Receipt {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg2));
        assert!(!0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::paused(arg2), 0);
        let v0 = 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::from_bytes(&arg0);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::attestation::verify_attestation_signatures(arg0, arg1, arg2);
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::destination_domain(&v0) == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::local_domain(arg2), 2);
        let v1 = 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::destination_caller(&v0);
        assert!(v1 == @0x0 || v1 == 0x2::tx_context::sender(arg3), 1);
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::version(&v0) == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::message_version(arg2), 3);
        let v2 = 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::source_domain(&v0);
        let v3 = 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::nonce(&v0);
        assert!(!0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::is_nonce_used(arg2, v2, v3), 4);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::mark_nonce_used(arg2, v2, v3);
        Receipt{
            caller                    : 0x2::tx_context::sender(arg3),
            recipient                 : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::recipient(&v0),
            source_domain             : v2,
            sender                    : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::sender(&v0),
            nonce                     : v3,
            message_body              : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::message::message_body(&v0),
            state_compatible_versions : *0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg2),
        }
    }

    public fun complete_receive_message(arg0: StampedReceipt, arg1: &0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg1));
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*state_compatible_versions(receipt(&arg0)));
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

    fun destroy_receipt(arg0: StampedReceipt) {
        let StampedReceipt { receipt: v0 } = arg0;
        let Receipt {
            caller                    : _,
            recipient                 : _,
            source_domain             : _,
            sender                    : _,
            nonce                     : _,
            message_body              : _,
            state_compatible_versions : _,
        } = v0;
    }

    public fun receipt(arg0: &StampedReceipt) : &Receipt {
        &arg0.receipt
    }

    public fun stamp_receipt<T0: drop>(arg0: Receipt, arg1: T0, arg2: &0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State) : StampedReceipt {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg2));
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*state_compatible_versions(&arg0));
        assert!(arg0.recipient == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::send_message::auth_caller_identifier<T0>(), 5);
        StampedReceipt{receipt: arg0}
    }

    public fun state_compatible_versions(arg0: &Receipt) : &0x2::vec_set::VecSet<u64> {
        &arg0.state_compatible_versions
    }

    // decompiled from Move bytecode v6
}

