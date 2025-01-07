module 0xe2005dffd3995f5bef1a0c8f447f7c5ad61b6e5d132987cfab11ae8c21eac3c7::j4f {
    struct J4F has drop {
        dummy_field: bool,
    }

    fun init(arg0: J4F, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J4F>(arg0, 9, b"J4F", b"Just4FUN ", b"Meme token created just for fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/134d0240-5745-4e30-8551-165bc4ce76c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J4F>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J4F>>(v1);
    }

    // decompiled from Move bytecode v6
}

