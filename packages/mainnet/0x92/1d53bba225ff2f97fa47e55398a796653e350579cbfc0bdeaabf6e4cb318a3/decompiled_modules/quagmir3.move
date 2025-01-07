module 0x921d53bba225ff2f97fa47e55398a796653e350579cbfc0bdeaabf6e4cb318a3::quagmir3 {
    struct QUAGMIR3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUAGMIR3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUAGMIR3>(arg0, 6, b"QUAGMIR3", b"QUAGMIR3 ON SUI", b"Sui is about to get wet, GIGITY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_22_33_42_34459e365d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUAGMIR3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUAGMIR3>>(v1);
    }

    // decompiled from Move bytecode v6
}

