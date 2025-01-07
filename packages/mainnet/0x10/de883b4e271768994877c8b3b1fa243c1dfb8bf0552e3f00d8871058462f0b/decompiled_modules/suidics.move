module 0x10de883b4e271768994877c8b3b1fa243c1dfb8bf0552e3f00d8871058462f0b::suidics {
    struct SUIDICS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDICS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDICS>(arg0, 6, b"SUIDICS", b"DICS ON SUI", b"Something DICS is Coming on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_updics_d256531920.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDICS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDICS>>(v1);
    }

    // decompiled from Move bytecode v6
}

