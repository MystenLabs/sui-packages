module 0xfa9bfb353bf870a96739f033880217a5cf1b341f165272c5da60ebd34cd47468::b_zpay {
    struct B_ZPAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ZPAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ZPAY>(arg0, 9, b"bZPAY", b"bToken ZPAY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ZPAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ZPAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

