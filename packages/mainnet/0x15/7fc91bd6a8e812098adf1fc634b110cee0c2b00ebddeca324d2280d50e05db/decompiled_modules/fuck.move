module 0x157fc91bd6a8e812098adf1fc634b110cee0c2b00ebddeca324d2280d50e05db::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 6, b"FUCK", b"FUCK", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

