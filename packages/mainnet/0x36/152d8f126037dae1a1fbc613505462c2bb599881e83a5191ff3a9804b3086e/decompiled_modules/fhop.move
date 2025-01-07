module 0x36152d8f126037dae1a1fbc613505462c2bb599881e83a5191ff3a9804b3086e::fhop {
    struct FHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHOP>(arg0, 6, b"FHOP", b"Fuck Hop", b"foooock offf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1_14b4ee3b83.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

