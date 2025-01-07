module 0x6188b7a9368ae56c117986051fb5b1d3632c3e7a1646629b53dcb05a98a391b7::hjkc {
    struct HJKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJKC>(arg0, 9, b"HJKC", b"Hj", b"Hjikoa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/56536908-5ae4-4765-970f-15f29a46ac97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

