module 0x47b237e00a3f02b8c9d89f9c6c38898d81565946f914a71c5f63e07d5037a5df::b_suilien {
    struct B_SUILIEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_SUILIEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_SUILIEN>(arg0, 9, b"bSUILIEN", b"bToken SUILIEN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_SUILIEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_SUILIEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

