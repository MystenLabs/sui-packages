module 0x3a2829998c5bb2198bb041c63d5999339f6bffe1a3e709e8a677567fcda3d67::zzz {
    struct ZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZZ>(arg0, 6, b"ZZZ", b"zzz dog", b"Can't wake, won't wake (Dreaming about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_18_07_13_11_ea1bbe3510.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

