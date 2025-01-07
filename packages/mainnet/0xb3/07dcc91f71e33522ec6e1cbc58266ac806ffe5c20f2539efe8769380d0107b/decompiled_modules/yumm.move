module 0xb307dcc91f71e33522ec6e1cbc58266ac806ffe5c20f2539efe8769380d0107b::yumm {
    struct YUMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMM>(arg0, 6, b"Yumm", b"YummyOnSui", b"Yum the fck out $YUM put on your SUIglasses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961435128.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUMM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

