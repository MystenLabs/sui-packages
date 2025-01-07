module 0x9650455fbc92a511b126db0d19079971013b208caa7520b451be0a1c8f6c4200::nago {
    struct NAGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGO>(arg0, 6, b"NAGO", b"Sui Wrapped Dog CTO", b"Sui Wrapped Dog CTO, TG updated", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZYB_Qzw_X0_AA_Ey_Q2_1_b870c96678.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

