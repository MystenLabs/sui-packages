module 0x70f73d5a300d12c62dae80931c1dcdc6fc65dba3fa07e1463fce255b5cb26996::b_happy {
    struct B_HAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HAPPY>(arg0, 9, b"bHAPPY", b"bToken HAPPY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

