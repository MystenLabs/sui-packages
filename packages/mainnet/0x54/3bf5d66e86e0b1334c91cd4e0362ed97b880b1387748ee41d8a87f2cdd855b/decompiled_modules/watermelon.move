module 0x543bf5d66e86e0b1334c91cd4e0362ed97b880b1387748ee41d8a87f2cdd855b::watermelon {
    struct WATERMELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATERMELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATERMELON>(arg0, 6, b"Watermelon", b"Sui ka", b"A type of large, round fruit with a thick green rind and juicy, red or pink flesh, containing numerous black seeds. It is typically sweet and consumed raw, often served in slices or chunks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9757_840aad1728.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATERMELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATERMELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

