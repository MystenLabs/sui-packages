module 0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib {
    struct BLOCKED_MESSAGE_LIB has drop {
        dummy_field: bool,
    }

    struct BlockedMessageLib has key {
        id: 0x2::object::UID,
        call_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
    }

    fun init(arg0: BLOCKED_MESSAGE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMessageLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::new_package_cap<BLOCKED_MESSAGE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMessageLib>(v0);
    }

    public fun quote(arg0: &BlockedMessageLib, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_quote::QuoteParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::messaging_fee::MessagingFee>) {
        abort 1
    }

    public fun send(arg0: &BlockedMessageLib, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendParam, 0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_send::SendResult>) {
        abort 1
    }

    public fun set_config(arg0: &BlockedMessageLib, arg1: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Call<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::message_lib_set_config::SetConfigParam, 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call::Void>) {
        abort 1
    }

    public fun version() : (u64, u8, u8) {
        (18446744073709551615, 255, 2)
    }

    // decompiled from Move bytecode v6
}

