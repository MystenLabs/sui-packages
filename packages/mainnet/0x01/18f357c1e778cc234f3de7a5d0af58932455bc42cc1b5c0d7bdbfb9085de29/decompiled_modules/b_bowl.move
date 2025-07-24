module 0x118f357c1e778cc234f3de7a5d0af58932455bc42cc1b5c0d7bdbfb9085de29::b_bowl {
    struct B_BOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BOWL>(arg0, 9, b"bBOWL", b"bToken BOWL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BOWL>>(v1);
    }

    // decompiled from Move bytecode v6
}

