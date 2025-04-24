module 0xa44cb9a817dc72acd33432dc569a0588fd5ddb1bfa9f403a04534fa0a7ee8f3b::frogin {
    struct FROGIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGIN>(arg0, 6, b"FROGIN", b"Froginme On Sui", x"57652068617665206120636c65617220766973696f6e2e20546865206a6f75726e657920737461727473206e6f772e204368616c6c656e6765732077696c6c20636f6d652c2062757420776520616c7761797320636f6d65206261636b207374726f6e6765722e200a0a2446524f47494e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061861_844f32f1ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

