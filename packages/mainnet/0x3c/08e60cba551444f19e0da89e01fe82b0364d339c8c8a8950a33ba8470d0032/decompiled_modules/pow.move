module 0x3c08e60cba551444f19e0da89e01fe82b0364d339c8c8a8950a33ba8470d0032::pow {
    struct POW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POW>(arg0, 6, b"POW", b"POW COIN", x"506f7720706f7720706f7720312073686f742c2031206f70702c20312024504f5720746f2072756c652027656d20616c6c0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_Uvb_Zi_Sdh_Q_Jhp_G_Qyw4o_Jut74oofb_Mm4_Qf_Yw_Akx_Aoe_D_Vz_f0f2663913.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POW>>(v1);
    }

    // decompiled from Move bytecode v6
}

