module 0xbd5f7109f5200cd221fc0db2d10f11a992bdbff3422c017e429ef6b5249b1ba0::b_knsui {
    struct B_KNSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KNSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KNSUI>(arg0, 9, b"bKNSUI", b"bToken KNSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KNSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KNSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

