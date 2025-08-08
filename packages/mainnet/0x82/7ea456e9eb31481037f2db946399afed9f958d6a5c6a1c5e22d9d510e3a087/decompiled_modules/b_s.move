module 0x827ea456e9eb31481037f2db946399afed9f958d6a5c6a1c5e22d9d510e3a087::b_s {
    struct B_S has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_S>(arg0, 9, b"bS", b"bToken S", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_S>>(v1);
    }

    // decompiled from Move bytecode v6
}

