module 0xa49b66b08c0715a4cbd4e00d2a684a89be2076d214f50ab3e0ff01fc318dc1cc::swhale {
    struct SWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWHALE>(arg0, 6, b"SWHALE", b"SoWHALE", b"$SWHALE, the purple SUI whale dripped out in chains, flexing on everyone. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dh_We_Vz_K_Argx_R2_Z5e_F_Lj98fxag_F_Fq6pu2_PL_Mro_AC_Jpump_9c0494a5bc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

