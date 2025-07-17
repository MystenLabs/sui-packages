module 0x6669fb8686b6860f64da566f6d0e07da31dfc6c33c708816e1dd3c567825f9b::chickencc {
    struct CHICKENCC has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHICKENCC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHICKENCC>>(0x2::coin::mint<CHICKENCC>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CHICKENCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKENCC>(arg0, 9, b"ChickenCC", b"ChickenCC Token", b"Community Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKENCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICKENCC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

