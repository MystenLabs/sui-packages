module 0x83451e3bff58641ce1b514af15a57d63351cb5e4f0f7cb3d07a555582c284299::b_pok {
    struct B_POK has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POK>(arg0, 9, b"bPOK", b"bToken POK", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POK>>(v1);
    }

    // decompiled from Move bytecode v6
}

