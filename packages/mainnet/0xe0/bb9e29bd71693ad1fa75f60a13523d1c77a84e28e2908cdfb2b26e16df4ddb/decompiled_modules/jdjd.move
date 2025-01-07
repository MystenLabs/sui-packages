module 0xe0bb9e29bd71693ad1fa75f60a13523d1c77a84e28e2908cdfb2b26e16df4ddb::jdjd {
    struct JDJD has drop {
        dummy_field: bool,
    }

    fun init(arg0: JDJD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JDJD>(arg0, 9, b"JDJD", b"Kdidjdjd", b"Dnxiuens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/157c0541-66cc-44f6-b6c7-ff4cb0aebc9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JDJD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JDJD>>(v1);
    }

    // decompiled from Move bytecode v6
}

