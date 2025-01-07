module 0x65858f45e960c58f08e841181c794104f8115b4bfe55437d8b8eda149f0d19eb::drphil {
    struct DRPHIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRPHIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRPHIL>(arg0, 6, b"DRPHIL", b"Cash SUI outside, howboutdat", b"Gucci flip flops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050754_ecef07b492.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRPHIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRPHIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

