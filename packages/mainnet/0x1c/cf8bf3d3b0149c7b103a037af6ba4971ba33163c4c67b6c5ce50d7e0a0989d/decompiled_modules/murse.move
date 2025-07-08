module 0x1ccf8bf3d3b0149c7b103a037af6ba4971ba33163c4c67b6c5ce50d7e0a0989d::murse {
    struct MURSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURSE>(arg0, 6, b"MURSE", b"Sui Murse", b"$MURSE is an eccentric dog with a modern style appearance, ready to cause chaos but actually cautious.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087056_025fe4b9e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

