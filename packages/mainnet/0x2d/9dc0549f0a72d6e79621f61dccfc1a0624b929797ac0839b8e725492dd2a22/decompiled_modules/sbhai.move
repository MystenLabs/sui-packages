module 0x2d9dc0549f0a72d6e79621f61dccfc1a0624b929797ac0839b8e725492dd2a22::sbhai {
    struct SBHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBHAI>(arg0, 6, b"SBHAI", b"SBH AI AGENT", b"SBH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/46e1f148_f3f3_4be1_bb9d_c28a7d891e7d_de1061e39d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBHAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBHAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

