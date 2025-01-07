module 0x91382d2c6f2c1d3280cde2b3da3e27ccf7dd497b033aeb5e3055e5faa6d28571::misty {
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

