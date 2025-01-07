module 0x6c257951e70255ac2b016fecb13d5beb91afdb29d37fbc9b22a273fcda48eb48::eatiha {
    struct EATIHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATIHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATIHA>(arg0, 6, b"EATIHA", b"EAGLE_TIGER_HAMSTER", b"He is the only one of his kind, we can help him navigate thru disastrous conditions to save him from extinction. can only be done by sending the ticker ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nx_P3a_YJN_400x400_820a796687.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATIHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATIHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

