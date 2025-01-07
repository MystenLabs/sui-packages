module 0x15d2729a7c77f441ea28fff30c1dbc6ca001aa2c2e5c0815a1e5073069e092d9::royal {
    struct ROYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROYAL>(arg0, 9, b"ROYAL", b"KING", b"KING is a meme inspired by the spirit of glory and power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a324069-7091-482a-9317-f65da64b7fb5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

