module 0xa4758428a47539ed88bfafde6ac4d5e695845c33206f5113630e21083296fa21::hop_withdraw {
    struct WithdrawEvent has copy, drop {
        destination: 0x1::string::String,
        receiver_token_account: 0x1::string::String,
    }

    public fun withdraw_event(arg0: 0x1::string::String, arg1: 0x1::string::String) {
        let v0 = WithdrawEvent{
            destination            : arg0,
            receiver_token_account : arg1,
        };
        0x2::event::emit<WithdrawEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

