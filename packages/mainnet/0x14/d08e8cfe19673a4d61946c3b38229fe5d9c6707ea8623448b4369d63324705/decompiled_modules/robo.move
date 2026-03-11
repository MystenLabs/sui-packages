module 0x14d08e8cfe19673a4d61946c3b38229fe5d9c6707ea8623448b4369d63324705::robo {
    struct ROBO has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROBO>, arg1: 0x2::coin::Coin<ROBO>) {
        0x2::coin::burn<ROBO>(arg0, arg1);
    }

    fun init(arg0: ROBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBO>(arg0, 9, b"ROBO", b"ROBO", b"Custom SUI Token: ROBO", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROBO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBO>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROBO>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ROBO>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ROBO>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

