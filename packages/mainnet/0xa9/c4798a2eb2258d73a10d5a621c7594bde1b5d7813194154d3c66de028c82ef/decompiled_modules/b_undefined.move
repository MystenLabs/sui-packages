module 0xa9c4798a2eb2258d73a10d5a621c7594bde1b5d7813194154d3c66de028c82ef::b_undefined {
    struct B_UNDEFINED has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_UNDEFINED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_UNDEFINED>(arg0, 9, b"bSDA", b"bToken SDA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_UNDEFINED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_UNDEFINED>>(v1);
    }

    // decompiled from Move bytecode v6
}

