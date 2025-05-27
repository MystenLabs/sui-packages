module 0x7f20eaca306872c4b060079fdcfeb14370b4a9824015a63ef7822862dfbc34ae::b_oshi {
    struct B_OSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OSHI>(arg0, 9, b"bOSHI", b"bToken OSHI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

