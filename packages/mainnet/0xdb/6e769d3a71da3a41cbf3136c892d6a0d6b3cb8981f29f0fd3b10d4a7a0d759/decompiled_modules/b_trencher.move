module 0xdb6e769d3a71da3a41cbf3136c892d6a0d6b3cb8981f29f0fd3b10d4a7a0d759::b_trencher {
    struct B_TRENCHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRENCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRENCHER>(arg0, 9, b"bTRENCHER", b"bToken TRENCHER", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRENCHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRENCHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

