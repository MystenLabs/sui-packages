module 0xc27fab826baf7e254a43dfdcc44d4e3076ac56ec889f44332ec6fc643f86cc71::wkc {
    struct WKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKC>(arg0, 9, b"WKC", b"Wikicat", b"Wikicat is a memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/62ed8068-c0c9-4f7a-8e7b-732375511a81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

