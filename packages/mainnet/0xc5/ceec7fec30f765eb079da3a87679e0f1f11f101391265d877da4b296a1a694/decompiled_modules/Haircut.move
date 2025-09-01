module 0xc5ceec7fec30f765eb079da3a87679e0f1f11f101391265d877da4b296a1a694::Haircut {
    struct HAIRCUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIRCUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIRCUT>(arg0, 9, b"HAIRCUT", b"Haircut", b"love a new haircut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gzxgof4XYAINqoR?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIRCUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIRCUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

