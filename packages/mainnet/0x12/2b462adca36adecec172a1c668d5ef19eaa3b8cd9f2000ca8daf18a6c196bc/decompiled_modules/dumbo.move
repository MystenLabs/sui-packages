module 0x122b462adca36adecec172a1c668d5ef19eaa3b8cd9f2000ca8daf18a6c196bc::dumbo {
    struct DUMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMBO>(arg0, 6, b"DUMBO", b"Dumbo Octopus", b"Dumbo Octopus on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_06_16_22_366ac70590.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

