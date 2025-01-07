module 0xc8ff9a27b945fbe3a845f34720d60170dec640c081ef221711c147d4c07d4533::wkc {
    struct WKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKC>(arg0, 9, b"WKC", b"Wikicat ", b"Wikicat is a meme token created for fun and cats animals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/192b9362-8ff7-4115-948b-59802b6598bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

