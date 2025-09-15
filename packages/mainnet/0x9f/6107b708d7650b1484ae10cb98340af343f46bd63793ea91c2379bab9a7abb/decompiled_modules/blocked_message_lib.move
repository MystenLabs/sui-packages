module 0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib {
    struct BLOCKED_MESSAGE_LIB has drop {
        dummy_field: bool,
    }

    struct BlockedMessageLib has key {
        id: 0x2::object::UID,
        call_cap: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::CallCap,
    }

    fun init(arg0: BLOCKED_MESSAGE_LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BlockedMessageLib{
            id       : 0x2::object::new(arg1),
            call_cap : 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call_cap::new_package_cap<BLOCKED_MESSAGE_LIB>(&arg0, arg1),
        };
        0x2::transfer::share_object<BlockedMessageLib>(v0);
    }

    public fun quote(arg0: &BlockedMessageLib, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_quote::QuoteParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::messaging_fee::MessagingFee>) {
        abort 1
    }

    public fun send(arg0: &BlockedMessageLib, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendParam, 0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_send::SendResult>) {
        abort 1
    }

    public fun set_config(arg0: &BlockedMessageLib, arg1: 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Call<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::message_lib_set_config::SetConfigParam, 0x26848d191c6b922a0bf185c4b3f6333179ce3b48df47d83fb112868bb65c2f37::call::Void>) {
        abort 1
    }

    public fun version() : (u64, u8, u8) {
        (18446744073709551615, 255, 2)
    }

    // decompiled from Move bytecode v6
}

