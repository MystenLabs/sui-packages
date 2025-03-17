module 0x77c1d470c460505a96e6a5db0ab9b4e3dcecbca59774c2f6b3e8e71b2f99c5e6::b_send {
    struct B_SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SEND>(arg0, 9, b"bSEND", b"bToken SEND", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SEND>>(v1);
    }

    // decompiled from Move bytecode v6
}

