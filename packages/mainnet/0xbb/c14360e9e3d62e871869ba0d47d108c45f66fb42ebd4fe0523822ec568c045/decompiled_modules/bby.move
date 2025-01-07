module 0xbbc14360e9e3d62e871869ba0d47d108c45f66fb42ebd4fe0523822ec568c045::bby {
    struct BBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBY>(arg0, 9, b"BBY", b"Bboy Coin ", b"The Bboys coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d054b9d5-dd22-4639-b5fa-6cde4e56b2d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

