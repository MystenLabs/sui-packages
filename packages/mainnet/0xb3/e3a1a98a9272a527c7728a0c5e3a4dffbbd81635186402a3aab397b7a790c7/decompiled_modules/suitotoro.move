module 0xb3e3a1a98a9272a527c7728a0c5e3a4dffbbd81635186402a3aab397b7a790c7::suitotoro {
    struct SUITOTORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOTORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITOTORO>(arg0, 6, b"SUITOTORO", b"Suitotoro", b"Suitotoro is a large furry creature that simply wants to grow trees, and your profit in Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_16_20_00_47_0c64883f26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOTORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITOTORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

