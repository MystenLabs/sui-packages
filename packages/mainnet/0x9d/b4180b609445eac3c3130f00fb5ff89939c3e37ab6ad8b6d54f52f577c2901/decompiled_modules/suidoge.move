module 0x9db4180b609445eac3c3130f00fb5ff89939c3e37ab6ad8b6d54f52f577c2901::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795565154983-0d0bdf57779513fc7bd848237c328b61.png";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1795565154983-0d0bdf57779513fc7bd848237c328b61.png"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<SUIDOGE>(arg0, 9, b"SUIDOGE", b"SUIDOGE", x"53554920444f4745204845524520f09f9882f09f9882", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<SUIDOGE>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDOGE>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

