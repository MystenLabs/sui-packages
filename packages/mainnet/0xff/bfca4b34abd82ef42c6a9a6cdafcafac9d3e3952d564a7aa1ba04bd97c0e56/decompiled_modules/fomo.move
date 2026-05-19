module 0xffbfca4b34abd82ef42c6a9a6cdafcafac9d3e3952d564a7aa1ba04bd97c0e56::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOMO>, arg1: 0x2::coin::Coin<FOMO>) {
        0x2::coin::burn<FOMO>(arg0, arg1);
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"FOMO", b"Custom SUI Token: FOMO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOMO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<FOMO>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOMO>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

