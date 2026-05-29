module 0xf5f96097fcb3b0ebaab4f96247f4871f7e0b80b7569639fb11fb39fad39697fb::GLS {
    struct GLS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GLS>, arg1: 0x2::coin::Coin<GLS>) {
        0x2::coin::burn<GLS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GLS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GLS>>(0x2::coin::mint<GLS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLS>(arg0, 4, b"GLS", b"GLS", b"GLS is the Core Engine of Autonomous Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lxtry1211.s3.us-west-1.amazonaws.com/gls_token.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

