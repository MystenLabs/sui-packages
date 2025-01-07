module 0x6bd1b8718bcdb109b89e369d6ed1d5fec6ebee41abecf7acf7fe7605c13451a0::rb {
    struct RB has drop {
        dummy_field: bool,
    }

    fun init(arg0: RB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RB>(arg0, 6, b"RB", b"Rock Bottom", b"We're at Rock Bottom... now the only way is UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zeet_UF_5_VSUZ_Zu_Nc_Zm_Fx_Bw_Nu_U_Mseg_Php1_Lk_Xru_A21o2x_X_27f04a1bc0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RB>>(v1);
    }

    // decompiled from Move bytecode v6
}

