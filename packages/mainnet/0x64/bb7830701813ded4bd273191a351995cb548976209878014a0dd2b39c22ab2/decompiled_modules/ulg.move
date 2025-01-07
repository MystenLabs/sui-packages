module 0x64bb7830701813ded4bd273191a351995cb548976209878014a0dd2b39c22ab2::ulg {
    struct ULG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ULG>(arg0, 6, b"ULG", b"Unicorn Laser Goat", x"646f6e7420676574206c6173657265640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_S8w_Hyf_Kxu_XVTW_Ay_R_Np_YVBM_6_Nyn_GY_Cc8hw_W_Xfe_J44_Pi3_M_9ba623ed4a.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ULG>>(v1);
    }

    // decompiled from Move bytecode v6
}

