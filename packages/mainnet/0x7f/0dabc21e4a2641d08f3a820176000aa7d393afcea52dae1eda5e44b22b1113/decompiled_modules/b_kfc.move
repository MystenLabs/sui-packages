module 0x7f0dabc21e4a2641d08f3a820176000aa7d393afcea52dae1eda5e44b22b1113::b_kfc {
    struct B_KFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KFC>(arg0, 9, b"bKFC", b"bToken KFC", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KFC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

