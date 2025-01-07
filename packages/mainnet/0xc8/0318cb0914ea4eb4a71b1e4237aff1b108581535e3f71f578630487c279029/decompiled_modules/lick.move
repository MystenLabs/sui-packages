module 0xc80318cb0914ea4eb4a71b1e4237aff1b108581535e3f71f578630487c279029::lick {
    struct LICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICK>(arg0, 6, b"LICK", b"Lick It", b"If you Lick it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/81pl_WL_0n_k_L_AC_SX_679_b1e43cc53c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

