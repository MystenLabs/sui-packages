module 0xd404d8b92c4881e117d5fddb441f3ba8e32ef160f4ab583e5a5e79c71672f922::buus {
    struct BUUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUUS>(arg0, 6, b"BUUS", b"Buu SUI", b"buuubuuubuuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2025_01_09_05_46_42_072aa86ba6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

