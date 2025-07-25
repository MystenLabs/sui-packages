module 0xd793d0c9e221ea1e567cdcdb64bafe50fbace14345f82f0469c96eacd8d5ea02::b_lols {
    struct B_LOLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LOLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LOLS>(arg0, 9, b"bLOLS", b"bToken LOLS", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LOLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LOLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

