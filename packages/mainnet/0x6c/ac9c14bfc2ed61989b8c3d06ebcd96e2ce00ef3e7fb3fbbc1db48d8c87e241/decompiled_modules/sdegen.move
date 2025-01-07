module 0x6cac9c14bfc2ed61989b8c3d06ebcd96e2ce00ef3e7fb3fbbc1db48d8c87e241::sdegen {
    struct SDEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDEGEN>(arg0, 6, b"SDEGEN", b"Sui Degen", b"Just a fan of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_27_15_48_39_8ae3bf4266.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDEGEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDEGEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

