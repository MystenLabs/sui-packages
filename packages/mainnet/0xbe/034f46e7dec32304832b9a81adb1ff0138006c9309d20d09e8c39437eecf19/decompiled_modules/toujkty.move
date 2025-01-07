module 0xbe034f46e7dec32304832b9a81adb1ff0138006c9309d20d09e8c39437eecf19::toujkty {
    struct TOUJKTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOUJKTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOUJKTY>(arg0, 9, b"TOUJKTY", b"Hj", b"Gjb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6132eef-ab7e-4acf-9bee-49076de69d0f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOUJKTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOUJKTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

