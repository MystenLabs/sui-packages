module 0x7df5a9cba4dee796c90a3df37e3e69668dc60e6a57ab795cd2f93d96014c6c6::pussify {
    struct PUSSIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSSIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSSIFY>(arg0, 6, b"PUSSIFY", b"Pussify", b"Create, share, and trade meme-inspired digital assets, all while leveraging the power of blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019252_5ae5f50a5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSSIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSSIFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

