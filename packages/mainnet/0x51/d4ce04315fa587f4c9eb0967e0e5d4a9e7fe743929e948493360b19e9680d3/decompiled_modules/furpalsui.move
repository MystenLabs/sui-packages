module 0x51d4ce04315fa587f4c9eb0967e0e5d4a9e7fe743929e948493360b19e9680d3::furpalsui {
    struct FURPALSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FURPALSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FURPALSUI>(arg0, 6, b"FURPALSUI", b"FURPAL BY MATT FURIE", x"4d6174742046757269652773206675727269657374206372656174696f6e20245355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241209_164048_150_4743802de5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FURPALSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FURPALSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

