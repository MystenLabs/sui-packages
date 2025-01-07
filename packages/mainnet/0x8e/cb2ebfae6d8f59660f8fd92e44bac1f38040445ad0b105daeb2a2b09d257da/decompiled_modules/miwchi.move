module 0x8ecb2ebfae6d8f59660f8fd92e44bac1f38040445ad0b105daeb2a2b09d257da::miwchi {
    struct MIWCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIWCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIWCHI>(arg0, 6, b"MIWCHI", b"MIWCHI ON SUI", b"legendary michi but its miwchi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/miwchi_5c979dc2bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIWCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIWCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

