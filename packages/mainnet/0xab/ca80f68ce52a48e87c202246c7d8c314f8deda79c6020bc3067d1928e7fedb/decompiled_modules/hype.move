module 0xabca80f68ce52a48e87c202246c7d8c314f8deda79c6020bc3067d1928e7fedb::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 6, b"HYPE", b"HypeToken", b"Hype Meme Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/95c67268-b64b-466e-8234-b64d70425cb7.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HYPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

