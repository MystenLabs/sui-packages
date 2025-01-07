module 0xe6f20e235fb888657aaf45a59a788e3c18ad3530713c461cd3391ac6bc2f8e80::lib {
    struct LIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIB>(arg0, 6, b"LIB", b"Screaming LIB", b"Lets Make this Lib Sream Again. Trump 2024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Luke_Crywalker_Main_01_00480_1000x563_77ff879cb1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

