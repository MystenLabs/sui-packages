module 0xc63e2c51c59393add5528797de8c6c5da2499713c7f920940d598a7bb5dda1d3::tc {
    struct TC has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TC>,
    }

    fun init(arg0: TC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TC>(arg0, 6, b"TC", b"TC", b"Test TC", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TC>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = Treasury{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<Treasury>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TC>>(v1);
    }

    // decompiled from Move bytecode v7
}

