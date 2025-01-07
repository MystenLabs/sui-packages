module 0x155355f585f0d0bac3e2c2c02dd5833c76434edea227398e3ef3a227ea71ed63::rock {
    struct ROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCK>(arg0, 6, b"ROCK", b"Rock Bottom", b"We're at Rock Bottom... now the only way is UP!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Zeet_UF_5_VSUZ_Zu_Nc_Zm_Fx_Bw_Nu_U_Mseg_Php1_Lk_Xru_A21o2x_X_1_8b3b9de1fe.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

