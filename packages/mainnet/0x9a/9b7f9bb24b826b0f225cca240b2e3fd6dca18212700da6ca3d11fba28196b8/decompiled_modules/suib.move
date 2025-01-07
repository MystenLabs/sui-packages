module 0x9a9b7f9bb24b826b0f225cca240b2e3fd6dca18212700da6ca3d11fba28196b8::suib {
    struct SUIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIB>(arg0, 6, b"SUIB", b"SuiBullOptimus", b"SuiBullOptimus, (SUIB)  is an iconic guardian whose strength and dedication are legendary. As a stalwart member of the Iron Guard, SuiBullOptimus is a HIGH GUARDIAN of SUI GALAXY  under the SuiOptimus ($SUIO) command.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Bull_Optimus_247d4310ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

