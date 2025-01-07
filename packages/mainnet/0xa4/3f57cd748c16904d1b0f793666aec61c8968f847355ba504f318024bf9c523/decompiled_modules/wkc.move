module 0xa43f57cd748c16904d1b0f793666aec61c8968f847355ba504f318024bf9c523::wkc {
    struct WKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKC>(arg0, 9, b"WKC", b"Wikicat", b"Wikicat is a memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/baaff3a1-f498-4d54-9059-1fec3f358d6e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKC>>(v1);
    }

    // decompiled from Move bytecode v6
}

