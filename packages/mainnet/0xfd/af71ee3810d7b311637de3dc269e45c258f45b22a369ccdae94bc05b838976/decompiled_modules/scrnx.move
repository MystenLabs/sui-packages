module 0xfdaf71ee3810d7b311637de3dc269e45c258f45b22a369ccdae94bc05b838976::scrnx {
    struct SCRNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCRNX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SCRNX>(arg0, 6, b"SCRNX", b"scrnx AI by SuiAI", b"scrnx is a revolutionary AI platform that turns your dreams into websites in seconds.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2144_4108c8e725.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SCRNX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCRNX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

