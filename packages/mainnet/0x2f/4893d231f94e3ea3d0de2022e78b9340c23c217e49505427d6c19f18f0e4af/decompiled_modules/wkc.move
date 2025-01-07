module 0x2f4893d231f94e3ea3d0de2022e78b9340c23c217e49505427d6c19f18f0e4af::wkc {
    struct WKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKC>(arg0, 9, b"WKC", b"Wikicat ", b"Wikicat is a meme token created for fun and cats animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/638813ae-b1a5-47a4-9449-b1d5590c66f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

