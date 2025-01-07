module 0xb499add387f4821a1677ab98b618523deaa5dfc6849fa9c4f3f9008f49198cf9::agi {
    struct AGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGI>(arg0, 6, b"AGI", b"Artificial General Intelligence", b"Artificial General Intelligence as a Service. Creating AGI to go beyond the limitations of today's narrow AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/629df4aa_200e_4297_b801_39d5185c8e92_295ba9355b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

