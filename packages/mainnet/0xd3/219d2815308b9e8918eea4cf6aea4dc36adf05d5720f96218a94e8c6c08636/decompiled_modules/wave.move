module 0xd3219d2815308b9e8918eea4cf6aea4dc36adf05d5720f96218a94e8c6c08636::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 0, b"PYM", b"Pyramid", b"The hierarchy of power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/_8KOVnnZAYtu60VxhL8p3dmdvabzvWkGOi-GCJjhaQg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

