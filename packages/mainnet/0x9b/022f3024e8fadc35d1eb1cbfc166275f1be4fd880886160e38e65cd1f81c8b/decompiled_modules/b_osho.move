module 0x9b022f3024e8fadc35d1eb1cbfc166275f1be4fd880886160e38e65cd1f81c8b::b_osho {
    struct B_OSHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_OSHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_OSHO>(arg0, 9, b"bOSHO", b"bToken OSHO", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_OSHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_OSHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

