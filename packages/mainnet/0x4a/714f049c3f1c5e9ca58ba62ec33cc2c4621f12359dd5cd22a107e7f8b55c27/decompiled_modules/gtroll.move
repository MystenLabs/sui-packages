module 0x4a714f049c3f1c5e9ca58ba62ec33cc2c4621f12359dd5cd22a107e7f8b55c27::gtroll {
    struct GTROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GTROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1779483729283-5c642ec854a6a92a56d7ebf0b9648eea.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1779483729283-5c642ec854a6a92a56d7ebf0b9648eea.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<GTROLL>(arg0, 9, b"GTroll", b"TheGoldenTroll", b"The Golden Troll", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<GTROLL>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GTROLL>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GTROLL>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

