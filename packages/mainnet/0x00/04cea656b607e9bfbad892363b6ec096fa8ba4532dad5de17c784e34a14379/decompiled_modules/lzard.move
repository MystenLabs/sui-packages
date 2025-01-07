module 0x4cea656b607e9bfbad892363b6ec096fa8ba4532dad5de17c784e34a14379::lzard {
    struct LZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LZARD>(arg0, 9, b"LZARD", b"Lizard", b"meme on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5478c287-d82e-49b5-b4d0-9a47aeff0237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LZARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

