module 0x33a710e3d1def5948f8c298243f5163a3f5a99d9474bdd31545d3703e0f93373::sps {
    struct SPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPS>(arg0, 6, b"SPS", b"springsui", b"Liquid staking standard for Sui. sSUI coming soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xv_Ruiz_EL_400x400_70c1b5f1a2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

