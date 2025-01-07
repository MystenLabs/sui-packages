module 0x41f52f546005fc5090d5ddb7fd09b5a1ce46798f499835d64ac42afcfc78f9dd::wkc {
    struct WKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKC>(arg0, 9, b"WKC", b"Wikicat ", b"Wikicat is meme token for the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c5594fc1-17cd-45b2-9541-24de3a3e53e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

