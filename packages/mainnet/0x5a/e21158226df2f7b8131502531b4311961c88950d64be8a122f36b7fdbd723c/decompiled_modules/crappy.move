module 0x5ae21158226df2f7b8131502531b4311961c88950d64be8a122f36b7fdbd723c::crappy {
    struct CRAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRAPPY>(arg0, 6, b"CRAPPY", b"CRAPPY BIRD ON SUI", b"FIRST CRAPPY BIRD ON SUI : https://www.crappybirdsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Il05_Y1_Yv_J_Fa19n_KS_Iw3b_Wg_Ic4_1_18a25e7837.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

