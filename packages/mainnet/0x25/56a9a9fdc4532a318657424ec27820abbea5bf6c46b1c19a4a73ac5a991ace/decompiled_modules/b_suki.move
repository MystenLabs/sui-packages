module 0x2556a9a9fdc4532a318657424ec27820abbea5bf6c46b1c19a4a73ac5a991ace::b_suki {
    struct B_SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUKI>(arg0, 9, b"bSUKI", b"bToken SUKI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

