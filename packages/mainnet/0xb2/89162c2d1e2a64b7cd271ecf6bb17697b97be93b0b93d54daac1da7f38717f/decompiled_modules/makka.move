module 0xb289162c2d1e2a64b7cd271ecf6bb17697b97be93b0b93d54daac1da7f38717f::makka {
    struct MAKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKKA>(arg0, 6, b"MAKKA", b"Makka Pakka", x"4d616b6b612050616b6b612c20416b6b612057616b6b612c204d696b6b61204d616b6b61204d6f6f21204d616b6b612050616b6b612c20417070612059616b6b612c20496b6b6120416b6b61204f6f6f212048756d2044756d2c20416767612050616e672c20496e6720416e67204f6f6f21204d616b6b612050616b6b612c20416b6b612057616b6b612c204d696b6b61204d616b6b61204d6f6f21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pp_M_Zpm8e_Kck69_QXJ_9apn_Nz_Qyhjv_D_Wm3_BR_Rge_GBD_Rc_Zo_R_e8fc5dd331.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

