module 0xe29c8bb00b4292ee22b07a4b7ada567ea40a69ae6b2b89be0f2ea4bb317fba60::halfin {
    struct HALFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALFIN>(arg0, 6, b"Halfin", b"First Bitcoin Tweet", x"52756e6e696e6720626974636f696e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_10_05_124837_922c55c886.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

