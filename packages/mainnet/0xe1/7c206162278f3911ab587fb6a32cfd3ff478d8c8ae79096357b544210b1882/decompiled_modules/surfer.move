module 0xe17c206162278f3911ab587fb6a32cfd3ff478d8c8ae79096357b544210b1882::surfer {
    struct SURFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURFER>(arg0, 6, b"SURFER", b"Sui Surfer", b"Surf the water. Surf Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Surfer_ac0598ecae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

