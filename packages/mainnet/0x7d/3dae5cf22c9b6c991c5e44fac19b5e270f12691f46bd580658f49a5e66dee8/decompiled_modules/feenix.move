module 0x7d3dae5cf22c9b6c991c5e44fac19b5e270f12691f46bd580658f49a5e66dee8::feenix {
    struct FEENIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEENIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEENIX>(arg0, 6, b"FEENIX", b"FEENIX ON SUI", b"$FEENIX is here to bring trust & utility to SUI. Use our FeenixBot on Telegram to Swap tokens across 25+ Blockchains with Zero Gas Fees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/P_F_Xlr_k_400x400_1f8443049f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEENIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEENIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

