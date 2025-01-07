module 0x3e166ac21ed8ea3b84545f61e4d6a4a7b31678c4daae4a5fc0cb4e87552fe858::hiro {
    struct HIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIRO>(arg0, 6, b"HIRO", b"HIRO Sui", b"Next Trending", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ek_R57p_MQ_400x400_2c78ff38a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

