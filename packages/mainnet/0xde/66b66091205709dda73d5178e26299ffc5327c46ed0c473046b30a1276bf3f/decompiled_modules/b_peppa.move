module 0xde66b66091205709dda73d5178e26299ffc5327c46ed0c473046b30a1276bf3f::b_peppa {
    struct B_PEPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_PEPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_PEPPA>(arg0, 9, b"bPEPPA", b"bToken PEPPA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_PEPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_PEPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

