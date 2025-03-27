module 0x3005b2a01ace4673f8af040e53a6c012e4838543973ff9a3ac5e71b252103e8a::b_wal {
    struct B_WAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WAL>(arg0, 9, b"bWAL", b"bToken WAL", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

