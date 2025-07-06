module 0xac3440e34d40207109074e4de938fbff7e52e3c9e68ffde202a6b1d5ec51b7f3::b_haedal {
    struct B_HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HAEDAL>(arg0, 9, b"bHAEDAL", b"bToken HAEDAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HAEDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

