module 0xbf741b4cd2da7241940a062e8e7987de0c3b46481ed537774056312f6f558f6d::b_thogs {
    struct B_THOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_THOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_THOGS>(arg0, 9, b"bThogs", b"bToken Thogs", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_THOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_THOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

