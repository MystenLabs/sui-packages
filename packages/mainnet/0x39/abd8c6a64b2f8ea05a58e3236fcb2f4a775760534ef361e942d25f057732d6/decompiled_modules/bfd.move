module 0x39abd8c6a64b2f8ea05a58e3236fcb2f4a775760534ef361e942d25f057732d6::bfd {
    struct BFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFD>(arg0, 6, b"Bfd", b"ddwd", b"wdwd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_a_a_a_a_a_a_a_2024_10_08_202112_d9f3edd68c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

