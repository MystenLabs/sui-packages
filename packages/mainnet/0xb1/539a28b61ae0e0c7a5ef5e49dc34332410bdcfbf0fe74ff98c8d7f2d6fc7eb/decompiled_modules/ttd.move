module 0xb1539a28b61ae0e0c7a5ef5e49dc34332410bdcfbf0fe74ff98c8d7f2d6fc7eb::ttd {
    struct TTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTD>(arg0, 6, b"TTD", b"Tetra_Dream", b"Four dimensions, infinite possibilities. Where the Dreamer imagines, the Theorist explains, the Pragmatist builds, and the Analyst refines - creating AI that thinks across all spectrums.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tetra_3ef2cba890.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

