module 0x6f4a6d162af6734524e6c11ae6949dea5a4432152a0790a769dd295638788953::aaadog {
    struct AAADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADOG>(arg0, 6, b"AAADOG", b"aaa dog", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_65c577ac09.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

