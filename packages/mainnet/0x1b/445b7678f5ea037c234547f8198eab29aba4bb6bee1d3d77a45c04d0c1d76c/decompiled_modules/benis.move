module 0x1b445b7678f5ea037c234547f8198eab29aba4bb6bee1d3d77a45c04d0c1d76c::benis {
    struct BENIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENIS>(arg0, 6, b"BENIS", b"BENISUI", b"BENIS ON SUI AND PUMP IT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_22_13_22_42c1cb605b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

