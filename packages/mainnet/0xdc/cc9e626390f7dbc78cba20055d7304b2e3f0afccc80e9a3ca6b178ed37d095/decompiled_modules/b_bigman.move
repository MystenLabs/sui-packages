module 0xdccc9e626390f7dbc78cba20055d7304b2e3f0afccc80e9a3ca6b178ed37d095::b_bigman {
    struct B_BIGMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BIGMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BIGMAN>(arg0, 9, b"bBIGMAN", b"bToken BIGMAN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BIGMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BIGMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

