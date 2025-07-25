module 0xb8fba6ff067be95bf8e641f789ebd77bbc5cc8023bbbc4fda70e68f49e98d9ee::b_evolv {
    struct B_EVOLV has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_EVOLV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_EVOLV>(arg0, 9, b"bEVOLV", b"bToken EVOLV", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_EVOLV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_EVOLV>>(v1);
    }

    // decompiled from Move bytecode v6
}

