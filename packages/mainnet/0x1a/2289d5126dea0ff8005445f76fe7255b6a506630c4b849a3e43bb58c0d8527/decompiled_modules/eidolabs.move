module 0x1a2289d5126dea0ff8005445f76fe7255b6a506630c4b849a3e43bb58c0d8527::eidolabs {
    struct EIDOLABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EIDOLABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EIDOLABS>(arg0, 6, b"EIDOLABS", b"EidoLabs", b"Ai agent onchain, shitposting for treasury gains & building with degens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_R_Tpf_AN_8gh_N_Sp_Pze_L_Yc1gq5x_N_Ursd1ygj9tz28gk_By_H_Ej_976badcdea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EIDOLABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EIDOLABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

