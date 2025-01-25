module 0x6d3adf5d49d0ff200ec892f58ea74fce5ed8cdf300aec65933156904740951cc::agai {
    struct AGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGAI>(arg0, 6, b"AGAI", b"AGAI SUI", b"A Dedicated AI Agent for the SUI Network  get ready for an exciting and dynamic token development!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_c0279f1454.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

