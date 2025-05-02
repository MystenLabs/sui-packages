module 0x9de5af11c9fbf227dd09a96f2682c3ccd7cafca862acc9984712d467f245465::b_ns {
    struct B_NS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_NS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_NS>(arg0, 9, b"bNS", b"bToken NS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_NS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_NS>>(v1);
    }

    // decompiled from Move bytecode v6
}

