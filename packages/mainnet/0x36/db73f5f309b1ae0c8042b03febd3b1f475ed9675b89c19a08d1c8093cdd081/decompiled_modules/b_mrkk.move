module 0x36db73f5f309b1ae0c8042b03febd3b1f475ed9675b89c19a08d1c8093cdd081::b_mrkk {
    struct B_MRKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MRKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MRKK>(arg0, 9, b"bMRKK", b"bToken MRKK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MRKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MRKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

