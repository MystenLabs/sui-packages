module 0x3e026de7678ac77249882259acad1eeffbc927e59de634e6a87230801e021a22::pepegang {
    struct PEPEGANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEGANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEGANG>(arg0, 6, b"Pepegang", b"pepe gang", b"Sui Pepe Gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_09_23_235444_1d4fa074bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEGANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEGANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

