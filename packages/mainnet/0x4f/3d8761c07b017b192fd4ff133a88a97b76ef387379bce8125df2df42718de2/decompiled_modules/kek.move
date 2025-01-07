module 0x4f3d8761c07b017b192fd4ff133a88a97b76ef387379bce8125df2df42718de2::kek {
    struct KEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEK>(arg0, 6, b"Kek", b"Sui Kek", b"$Kek can make you feel happier", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kek_a81757ce1e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEK>>(v1);
    }

    // decompiled from Move bytecode v6
}

