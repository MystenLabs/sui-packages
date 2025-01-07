module 0x73311508616e7ce007ad36dffd01f27c95c05af1f6fbdde441f50e90639bf6a7::lkkkkkkkkk {
    struct LKKKKKKKKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LKKKKKKKKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LKKKKKKKKK>(arg0, 9, b"LKKKKKKKKK", b"bnbnbnb", b"fgfgfgfg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dcbb05c-64a6-40b9-8a4f-f025d1bcfb8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LKKKKKKKKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LKKKKKKKKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

