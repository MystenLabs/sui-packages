module 0x8ce5a9392d4a545bef354bba17bf5123d7e6146875a14019ceb1f9224ee1c862::b_a {
    struct B_A has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_A>(arg0, 9, b"bA", b"bToken A", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_A>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_A>>(v1);
    }

    // decompiled from Move bytecode v6
}

