module 0xe372574898c19442673d8a428cd8341a5c173bd812618424c22aac608676323a::slime {
    struct SLIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 6, b"SLIME", b"Slime on Sui", x"546865206669727374206375746520666f726d6c6573730a6d6f6e73746572206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040638_bcc2c6ea96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

