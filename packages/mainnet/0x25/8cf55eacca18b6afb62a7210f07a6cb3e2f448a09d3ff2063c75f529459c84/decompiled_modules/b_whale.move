module 0x258cf55eacca18b6afb62a7210f07a6cb3e2f448a09d3ff2063c75f529459c84::b_whale {
    struct B_WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WHALE>(arg0, 9, b"bWHALE", b"bToken WHALE", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

