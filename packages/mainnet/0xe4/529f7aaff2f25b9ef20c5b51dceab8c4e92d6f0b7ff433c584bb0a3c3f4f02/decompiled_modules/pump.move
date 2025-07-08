module 0xe4529f7aaff2f25b9ef20c5b51dceab8c4e92d6f0b7ff433c584bb0a3c3f4f02::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BjtWWs8PneVvxWcXh7LDMyyQ3xMwLceBBr4Y5jcTpump.png?claimId=LdqEUdcNwxnxkzas                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"pump        ")))), trim_right(b"imposter                        "), trim_right(x"54686520626561757479206f66207468697320746f6b656e20697320617320697420676f6573206869676865722069742062656e656669747320626f74682040626f6e6b5f66756e20616e64204070756d70646f7466756e2e200a0a46696e616c6c792061207469636b6572207468617420627269646765732074686520676170206265747765656e20616c6c206f66204354200a0a2450756d70206f6e20426f6e6b2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

