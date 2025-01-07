module 0x7a529fe396274cfa72f02ed0a92b53a40f73ee54bf4844c4659909eb51198c8a::strdgfsf {
    struct STRDGFSF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRDGFSF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRDGFSF>(arg0, 9, b"STRDGFSF", b"aygfcrfgb", b"hfhgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18836f70-9fc5-439d-a0af-40581ea443bb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRDGFSF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRDGFSF>>(v1);
    }

    // decompiled from Move bytecode v6
}

