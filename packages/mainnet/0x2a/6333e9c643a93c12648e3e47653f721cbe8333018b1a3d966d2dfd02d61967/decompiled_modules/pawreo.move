module 0x2a6333e9c643a93c12648e3e47653f721cbe8333018b1a3d966d2dfd02d61967::pawreo {
    struct PAWREO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWREO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWREO>(arg0, 6, b"PAWREO", b"Cat Pawreo", b"Cat paw? Oreo? PAWREO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1006_478b298787.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWREO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWREO>>(v1);
    }

    // decompiled from Move bytecode v6
}

