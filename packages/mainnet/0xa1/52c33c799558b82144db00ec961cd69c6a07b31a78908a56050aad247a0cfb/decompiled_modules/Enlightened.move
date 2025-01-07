module 0xa152c33c799558b82144db00ec961cd69c6a07b31a78908a56050aad247a0cfb::Enlightened {
    struct ENLIGHTENED has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENLIGHTENED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENLIGHTENED>(arg0, 0, b"PACK", b"Enlightened", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/packs/Starter_Pack_3.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENLIGHTENED>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENLIGHTENED>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

