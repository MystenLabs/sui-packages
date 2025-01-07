module 0x5c688a0d3582ae4011f62a0eeb57a44c802be4206430f107703776473abcc7ad::bebo {
    struct BEBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEBO>(arg0, 6, b"BEBO", b"Bebo Pig", b"Bebo is real KuneKune pig on a mission to MUNCH and spread joy to the crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009417_979b61336e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

