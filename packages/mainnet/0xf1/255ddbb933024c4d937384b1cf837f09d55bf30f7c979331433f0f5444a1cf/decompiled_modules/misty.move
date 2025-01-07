module 0xf1255ddbb933024c4d937384b1cf837f09d55bf30f7c979331433f0f5444a1cf::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 9, b"MISTY", b"MISTY", x"4a6f696e204d6973747920616e64205374617279752061732073686520626174746c6573207468726f75676820746865205355492065636f73797374656d200a2068747470733a2f2f747769747465722e636f6d2f6d697374796f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1751352102880935936/mu3ZGnuT_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MISTY>>(v1);
        0x2::coin::mint_and_transfer<MISTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

