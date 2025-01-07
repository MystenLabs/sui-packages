module 0xca5331316d2758c059126aac4cf12d99a8e2cb4f12ed0c69e13fbcdfba452506::lib {
    struct LIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIB>(arg0, 6, b"Lib", b"Screaming Lib", b"Make libs scream again. Trump 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luke_Crywalker_Main_01_00480_1000x563_cc8189fe2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

