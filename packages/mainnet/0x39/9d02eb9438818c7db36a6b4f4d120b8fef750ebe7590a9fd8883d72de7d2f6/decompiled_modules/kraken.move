module 0x399d02eb9438818c7db36a6b4f4d120b8fef750ebe7590a9fd8883d72de7d2f6::kraken {
    struct KRAKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAKEN>(arg0, 6, b"KRAKEN", b"Kraken meme", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/fce3d3d4-eca1-4c3e-8a6f-3e7bf99ebf85.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRAKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

