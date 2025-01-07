module 0x386a0e6aba0abcc1527560632ad5803b8a80e0d8649cbc4d06325c0c0478a8f1::suichat {
    struct SUICHAT has drop {
        dummy_field: bool,
    }

    struct NewMsg has copy, drop, store {
        user: address,
        msg_type: 0x1::string::String,
        value: u64,
        msg: 0x1::string::String,
        coin_type: 0x1::string::String,
    }

    public entry fun emit_new_msg(arg0: address, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = NewMsg{
            user      : arg0,
            msg_type  : 0x1::string::utf8(arg1),
            value     : arg2,
            msg       : 0x1::string::utf8(arg3),
            coin_type : 0x1::string::utf8(arg4),
        };
        0x2::event::emit<NewMsg>(v0);
    }

    fun init(arg0: SUICHAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUICHAT>(arg0, arg1);
    }

    entry fun send_msg(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0 != b"", 4);
        emit_new_msg(0x2::tx_context::sender(arg2), b"chat", 0, arg0, arg1);
    }

    entry fun send_msg_with_premium(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == 100000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        assert!(arg2 != b"", 4);
        emit_new_msg(0x2::tx_context::sender(arg4), b"chat-with-lottery", 0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

