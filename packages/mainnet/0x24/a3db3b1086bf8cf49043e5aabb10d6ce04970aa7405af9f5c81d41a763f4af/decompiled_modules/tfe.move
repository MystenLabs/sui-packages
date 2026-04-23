module 0x24a3db3b1086bf8cf49043e5aabb10d6ce04970aa7405af9f5c81d41a763f4af::tfe {
    struct TFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TFE>(arg0, 6, b"TFE", b"TFE", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TFE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

