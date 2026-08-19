module 0x71d669cc440f1fa81f3ce80dbaea057dcb8d097249690a9aeba58ac1e1cf5397::greatlp {
    struct GREATLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREATLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREATLP>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"GREATLP", b"make lp great again", b"great lp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREATLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREATLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

