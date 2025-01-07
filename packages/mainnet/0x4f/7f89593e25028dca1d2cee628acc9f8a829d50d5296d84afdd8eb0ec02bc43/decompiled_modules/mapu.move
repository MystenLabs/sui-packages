module 0x4f7f89593e25028dca1d2cee628acc9f8a829d50d5296d84afdd8eb0ec02bc43::mapu {
    struct MAPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAPU>(arg0, 6, b"MAPU", b"Murad Apustaja", x"244d41505520416e796f6e652068756e6772793f20244d4150550a0a43757a204920616d0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apustaja_51cdf37336.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

