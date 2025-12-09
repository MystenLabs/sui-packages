module 0xe660f762600d8fccb4ff4bbf890d74263882648744a190020f9ad1678f4eac86::b_dim {
    struct B_DIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_DIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_DIM>(arg0, 9, b"bDIM", b"bToken DIM", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_DIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_DIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

