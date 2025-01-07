module 0xb985b2618d44822f7c9096c707e71937bd97e6317d2ba807ad66c1a28f5b0134::gz {
    struct GZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GZ>(arg0, 9, b"GZ", b"Gooz", b"Ghabzo Bede gooz to begir", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7a68e9e2-4219-481a-92bc-324d10beb981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

