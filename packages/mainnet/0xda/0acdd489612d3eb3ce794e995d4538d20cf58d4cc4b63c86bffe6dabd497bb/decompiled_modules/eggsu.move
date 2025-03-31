module 0xda0acdd489612d3eb3ce794e995d4538d20cf58d4cc4b63c86bffe6dabd497bb::eggsu {
    struct EGGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGSU>(arg0, 6, b"EGGSU", b"Eggsu", b"Just egg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052655_7622ba2978.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

