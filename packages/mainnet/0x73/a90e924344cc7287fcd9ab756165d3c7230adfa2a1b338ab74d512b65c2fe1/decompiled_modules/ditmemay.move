module 0x73a90e924344cc7287fcd9ab756165d3c7230adfa2a1b338ab74d512b65c2fe1::ditmemay {
    struct DITMEMAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DITMEMAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DITMEMAY>(arg0, 9, b"DITMEMAY", b"DIT ME MAY", b"Meme number one vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a213cfb-b0d8-4064-92ee-ec18dcb8c1bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DITMEMAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DITMEMAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

