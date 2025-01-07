module 0x82f526fb90354d23ae9185b8cb56cfff928c565c5000af26b1cf9fbd7f426b16::dog {
    struct DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG>(arg0, 6, b"DOG", b"dogeth", b"doddddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/MO0wy0XnuD-PRdWkabmJfTzpfBhIEIcrI4wHGpTJVYc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

