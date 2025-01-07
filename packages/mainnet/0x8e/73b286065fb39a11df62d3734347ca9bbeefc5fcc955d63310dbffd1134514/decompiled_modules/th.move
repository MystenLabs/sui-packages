module 0x8e73b286065fb39a11df62d3734347ca9bbeefc5fcc955d63310dbffd1134514::th {
    struct TH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TH>(arg0, 9, b"TH", b"Trumphero", b"Meme dedicated to Trump supporters ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/195e2d10-1405-42c8-8074-bc82e6da1e93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TH>>(v1);
    }

    // decompiled from Move bytecode v6
}

