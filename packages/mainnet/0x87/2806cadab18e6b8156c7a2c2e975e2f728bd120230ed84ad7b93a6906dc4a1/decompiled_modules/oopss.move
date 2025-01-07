module 0x872806cadab18e6b8156c7a2c2e975e2f728bd120230ed84ad7b93a6906dc4a1::oopss {
    struct OOPSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OOPSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OOPSS>(arg0, 9, b"OOPSS", b"OldPossum", b"Old Possum was here when $BTC was created", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3bd8d68b-610d-4ca0-8389-9d3392832c96.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OOPSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OOPSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

