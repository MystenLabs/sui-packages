module 0xf10504867f1220c5c85b8e722b0dd685feb0ef17dc9d85d2eeefd9cdc078d9b9::mod {
    struct MOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOD>(arg0, 6, b"MOD", b"Meow Deng", b"A cat named meow Deng was born from the stars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3740_125633a233.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

