module 0xee71b3e8f7acf97b171c67c673c37b406b58ba2ff3a75a5245a5d3db2a9c5c68::lul {
    struct LUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUL>(arg0, 9, b"LUL", b"lulu", x"66696c6c696e6720796f757220706f7274666f6c696f2077697468206a6f796f75732070726f6669747320616e64206120746f756368206f662068756d6f722120f09f9884f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f84465e9-d1fa-4745-b797-4ede7e15b318.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

