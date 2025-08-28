module 0xe8f612c2b8e0d4c08f0bbbba150508962d8eb70629fb43e7a5bbe9f6edc80369::tge_detection {
    struct TokenCreationEvent has copy, drop {
        token_type: 0x1::string::String,
        issuer: address,
        initial_supply: u64,
        tx_digest: vector<u8>,
    }

    public fun detect_tge<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenCreationEvent{
            token_type     : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            issuer         : 0x2::tx_context::sender(arg1),
            initial_supply : 0x2::coin::value<T0>(arg0),
            tx_digest      : *0x2::tx_context::digest(arg1),
        };
        0x2::event::emit<TokenCreationEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

