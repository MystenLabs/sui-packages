module 0xcf39f3f1acb51d240c039a2abdf95b7282785bbe18ebafcce48b865edc105196::virus {
    struct VIRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/28h1NHtVWNS5xbSKZXAsmHr6d8CrqW69BfDm7VQDXSxN.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIRUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIRUS       ")))), trim_right(b"VIRUS                           "), trim_right(b"The Virus is a revolutionary new rewards token that has a one of kind airdrop system designed to keep the virus spreading. This is the most advanced rewards token ever designed. Earn wBTC , wETH,  SOL + stocks like Apple, Tesla, NVIDIA & even digitalized gold every 15 minutes just for holding $VIRUS.  Receive rewards v"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRUS>>(v4);
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

