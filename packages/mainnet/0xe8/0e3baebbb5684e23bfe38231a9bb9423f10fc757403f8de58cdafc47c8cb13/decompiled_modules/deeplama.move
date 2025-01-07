module 0xe80e3baebbb5684e23bfe38231a9bb9423f10fc757403f8de58cdafc47c8cb13::deeplama {
    struct DEEPLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPLAMA>(arg0, 6, b"DEEPLAMA", b"DeepLlama", b"DEEPLAMA is at the forefront of merging the natural world with cutting-edge blockchain technology. Our logo, featuring a neon-lit, cybernetic llama, symbolizes our commitment to innovation and the seamless integration of organic growth with digital advancement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/64356_d533261a91.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

