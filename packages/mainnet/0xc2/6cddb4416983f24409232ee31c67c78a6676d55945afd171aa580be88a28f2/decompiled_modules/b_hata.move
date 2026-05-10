module 0xc26cddb4416983f24409232ee31c67c78a6676d55945afd171aa580be88a28f2::b_hata {
    struct B_HATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_HATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_HATA>(arg0, 9, b"bHATA", b"bToken HATA", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_HATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_HATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

