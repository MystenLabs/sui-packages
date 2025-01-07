module 0x5f397987440d3324087110a0f9c596576d145d23380984b85c99824edc501a95::puffs {
    struct PUFFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFS>(arg0, 6, b"PUFFS", b"PUFF SUI", b"PUFF ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_22_29_35_00e49cbb7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

