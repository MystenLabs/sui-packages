module 0x4300e830560fa6f7a14398560ef588260126a2e6769c10f6cf16c73086d058d9::syn {
    struct SYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYN>(arg0, 6, b"SYN", b"SYNAPTOKEN", b"$SYN is token on the SUI network developed by SynapToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profil_b1b72efb13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

