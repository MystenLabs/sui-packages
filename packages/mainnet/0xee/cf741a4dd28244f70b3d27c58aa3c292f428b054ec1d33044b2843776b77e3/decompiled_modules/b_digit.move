module 0xeecf741a4dd28244f70b3d27c58aa3c292f428b054ec1d33044b2843776b77e3::b_digit {
    struct B_DIGIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DIGIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DIGIT>(arg0, 9, b"bDIGIT", b"bToken DIGIT", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DIGIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DIGIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

