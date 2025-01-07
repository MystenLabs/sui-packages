module 0xba8205cf6f69689ec91d429272ad512c846914032b9ecdff055154c5628725d0::pgx {
    struct PGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PGX>(arg0, 9, b"PGX", b"PELUMISGRA", b"Meme is the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/062aae42-5fd5-47eb-bca1-f6078688b544.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

