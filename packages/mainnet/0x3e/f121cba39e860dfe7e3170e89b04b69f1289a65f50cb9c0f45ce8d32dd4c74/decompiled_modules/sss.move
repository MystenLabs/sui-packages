module 0x3ef121cba39e860dfe7e3170e89b04b69f1289a65f50cb9c0f45ce8d32dd4c74::sss {
    struct SSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSS>(arg0, 6, b"SSS", b"Sishengsheng", x"53697368656e677368656e672028535353290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7f_U1c_GDU_2h_RP_Gj5ubkc_Af_Lkj4j_Kc_Xr6_P_Gs_F2f9p5pump_f43fccfc08.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

