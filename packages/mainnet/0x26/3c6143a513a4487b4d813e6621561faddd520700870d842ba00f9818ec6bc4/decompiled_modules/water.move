module 0x263c6143a513a4487b4d813e6621561faddd520700870d842ba00f9818ec6bc4::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"WaterOnSui", b"Welcome to $WATER, the most refreshing token on the Sui blockchain. Dive into a liquid revolution where water isnt just the essence of lifeits the official mascot of Sui! Were here to hydrate your portfolio with a splash of humor, zero drama, and all the liquidity you can handle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001158_4c7592bd87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

