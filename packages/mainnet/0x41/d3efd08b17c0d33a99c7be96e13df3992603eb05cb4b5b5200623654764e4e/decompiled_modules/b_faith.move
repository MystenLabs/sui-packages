module 0x41d3efd08b17c0d33a99c7be96e13df3992603eb05cb4b5b5200623654764e4e::b_faith {
    struct B_FAITH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FAITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FAITH>(arg0, 9, b"bFAITH", b"bToken FAITH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FAITH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FAITH>>(v1);
    }

    // decompiled from Move bytecode v6
}

