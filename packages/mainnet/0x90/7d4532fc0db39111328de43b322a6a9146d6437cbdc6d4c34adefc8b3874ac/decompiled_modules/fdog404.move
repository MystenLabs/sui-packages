module 0x907d4532fc0db39111328de43b322a6a9146d6437cbdc6d4c34adefc8b3874ac::fdog404 {
    struct FDOG404 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDOG404, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDOG404>(arg0, 6, b"Fdog404", b"Fault DOG", b"Fault Dog 404", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_N_Uf3_H4ithe_M_Sm51_Gs1de_WSZPK_8y_Rzsx_XV_Aj_Cd_K2c1_Ls_D_acf4290c6a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDOG404>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDOG404>>(v1);
    }

    // decompiled from Move bytecode v6
}

