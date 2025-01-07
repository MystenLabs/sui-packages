module 0xa13758ddb653b2b98446201435cf52604b884aa731023644abe2662ca3df3ea::gamble {
    struct GAMBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAMBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMBLE>(arg0, 6, b"GAMBLE", b"Keep Gambling", b"99% of traders quit right before the 1000x.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_L3_Ys3m2_K6s986q6_Dyzs_G_Hm5k_Mqaqtqpr_M_Hv_U3j_K35_SA_ed85e95108.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAMBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAMBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

