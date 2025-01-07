module 0x93023d54909944c6bdefa836247221fc5c7974e7c35c77e4e959e4190786ec7c::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"ExplainThisBob", x"46697273742062616e6e656420414920626f740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_X7qz_A5_NC_Jic4n_X_Tqb_BG_Voi9ueq4_XJ_Sjcxsstx_RB_Eo_Axp_3d67e71c01.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

