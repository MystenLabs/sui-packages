module 0x3a1fb001ea1ef957f129c01c2cd40df8f8337168e54e9d75604329b16bf69bd5::koikoi {
    struct KOIKOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIKOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIKOI>(arg0, 6, b"KOIKOI", b"KOIKOITOKEN", b"Sui pet fish. Swimming up the charts towards those gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_24_02_42_45_9a7c5cf724.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIKOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOIKOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

