module 0x31630512571ddc827287a7ae0c225729a58a0d59355e09323b4608598b30d090::launchorbt {
    struct LAUNCHORBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUNCHORBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"481ef077bd9391650dfdf6410c87f78b6feefa7bdc86b0407b4c7648ffb3429d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LAUNCHORBT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LAUNCHORBT  ")))), trim_right(b"LAUNCHORBYT                     "), trim_right(b"LaunchOrbyt enables you to turn any tweet into a token. Reply with @launchorbyt NAME: tokenName TICKER: $TICKER Description: Description. Powered by Orbytdotfun.                                                                                                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUNCHORBT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUNCHORBT>>(v4);
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

