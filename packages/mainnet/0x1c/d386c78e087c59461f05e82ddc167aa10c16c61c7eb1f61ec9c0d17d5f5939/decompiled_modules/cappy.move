module 0x1cd386c78e087c59461f05e82ddc167aa10c16c61c7eb1f61ec9c0d17d5f5939::cappy {
    struct CAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPPY>(arg0, 6, b"CAPPY", b"Sui Cappy", b"be cappy at the creek", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cappy_16da11a7d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

