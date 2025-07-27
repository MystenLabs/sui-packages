module 0x5bbc742cac803360b690c2ef7689708dc33ece7585f883260fbbde5b7b5e72e7::b_xpump {
    struct B_XPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_XPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_XPUMP>(arg0, 9, b"bXPUMP", b"bToken XPUMP", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_XPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_XPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

