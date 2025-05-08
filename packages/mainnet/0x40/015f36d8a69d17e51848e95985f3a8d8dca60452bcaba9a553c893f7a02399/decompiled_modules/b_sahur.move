module 0x40015f36d8a69d17e51848e95985f3a8d8dca60452bcaba9a553c893f7a02399::b_sahur {
    struct B_SAHUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SAHUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SAHUR>(arg0, 9, b"bSAHUR", b"bToken SAHUR", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SAHUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SAHUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

