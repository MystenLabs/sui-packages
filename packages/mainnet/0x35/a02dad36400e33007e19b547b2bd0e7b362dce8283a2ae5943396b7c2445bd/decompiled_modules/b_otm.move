module 0x35a02dad36400e33007e19b547b2bd0e7b362dce8283a2ae5943396b7c2445bd::b_otm {
    struct B_OTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OTM>(arg0, 9, b"bOTM", b"bToken OTM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

