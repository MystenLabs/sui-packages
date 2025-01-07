module 0x37c3d3987f4a450965f9a0f189d12b4126d462819e35a676088095195a975f62::chillp {
    struct CHILLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLP>(arg0, 6, b"CHILLP", b"Chillpeanut", b"chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_05_23_31_33_d5805adcf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

