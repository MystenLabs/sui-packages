module 0x860a4d79fe63fe6705244a0095722e4a4a8f8a2f605bd089af8ccb862009c78a::b_cody {
    struct B_CODY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CODY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CODY>(arg0, 9, b"bCODY", b"bToken CODY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CODY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CODY>>(v1);
    }

    // decompiled from Move bytecode v6
}

