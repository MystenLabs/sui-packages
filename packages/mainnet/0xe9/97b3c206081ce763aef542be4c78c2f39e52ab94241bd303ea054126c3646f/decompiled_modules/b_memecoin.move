module 0xe997b3c206081ce763aef542be4c78c2f39e52ab94241bd303ea054126c3646f::b_memecoin {
    struct B_MEMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MEMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MEMECOIN>(arg0, 9, b"bMEMECOIN", b"bToken MEMECOIN", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MEMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MEMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

