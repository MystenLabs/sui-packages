module 0x568933f8aec594cb560410f33c590f5ad02154f4bd4f91b7a90e0414a91d5de::ada {
    struct ADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADA>(arg0, 6, b"ADA", b"Solama", b"Sheep in the desert are extremely rare' or hold them if you are a good shepherd, they will make you rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000507_71dc78d2cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

