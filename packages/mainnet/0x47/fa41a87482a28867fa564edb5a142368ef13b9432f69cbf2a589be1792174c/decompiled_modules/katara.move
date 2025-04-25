module 0x47fa41a87482a28867fa564edb5a142368ef13b9432f69cbf2a589be1792174c::katara {
    struct KATARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATARA>(arg0, 6, b"KATARA", b"Katara", b"Katara on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8394_8695da56a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

