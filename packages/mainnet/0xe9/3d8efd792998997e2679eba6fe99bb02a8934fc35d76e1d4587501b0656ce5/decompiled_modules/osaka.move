module 0xe93d8efd792998997e2679eba6fe99bb02a8934fc35d76e1d4587501b0656ce5::osaka {
    struct OSAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSAKA>(arg0, 6, b"Osaka", b"OSAK", b"The official OSAK on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732089119_Cw_Ad_Zfi_Sq_D_Poyrx9spm1apihr_Fd_Nryt_F_Tp_G_Yddb2pump_de5fe80bf7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

