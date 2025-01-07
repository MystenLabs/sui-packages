module 0xbb44388c0492196860dac65f821c07f552e7cc2deff9f0a6ed541680ad86b16b::brett2 {
    struct BRETT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT2>(arg0, 9, b"Brett2", b"Brett2.0", x"546865206f6e6c7920322e30206e617272617469766520746f20746872697665206f6e20426173652e20427265747420322e30206973207468652063686f73656e207365636f6e64206368616e6365210a0a596f206974277320796120626f6920425245545420322e302c2074686520666972737420322e30206d656d65206f6e20626173652c206e6f772072756e2062792074686520636f6d6d756e69747920212057686f2073616964207365636f6e64206368616e6365732061696e27742061207468696e673f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/rs-vqAhllkYwAZ3U?width=400&height=400&fit=crop&quality=95&format=auto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRETT2>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRETT2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

