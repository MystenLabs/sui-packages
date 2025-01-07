module 0xf8e5c5fd7e8c13a9b9ebfeefb47e7129d448f91b2b79bf1c957d9d6729d9a17f::bem {
    struct BEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEM>(arg0, 6, b"BEM", b"Blue Eyed Milton", b"The 1st Blue Eyed Hurricane ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a3_d3fd92f9e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

