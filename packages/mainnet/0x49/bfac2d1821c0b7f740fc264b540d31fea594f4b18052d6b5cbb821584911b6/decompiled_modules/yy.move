module 0x49bfac2d1821c0b7f740fc264b540d31fea594f4b18052d6b5cbb821584911b6::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 9, b"YY", b"Yinyang", b"Dunno what is this ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8dea206a-c407-4011-b5d8-f1aa60a056de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YY>>(v1);
    }

    // decompiled from Move bytecode v6
}

