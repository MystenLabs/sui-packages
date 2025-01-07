module 0x1aa3065d37b2fb13ce5ae2903c7ab51e5c8b8dd1cfcd642a412793583ef34ecd::wewepumpit {
    struct WEWEPUMPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEPUMPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEPUMPIT>(arg0, 9, b"WEWEPUMPIT", b"Wpump", b"Am bullish on WEWE token about to be launched on Sui Blockchain,am so exicted,it is going to be massive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b8029328-801d-4875-831a-232f2425630c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEPUMPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEPUMPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

