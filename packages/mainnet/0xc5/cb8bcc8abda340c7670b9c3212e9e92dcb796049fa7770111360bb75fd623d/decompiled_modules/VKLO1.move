module 0xc5cb8bcc8abda340c7670b9c3212e9e92dcb796049fa7770111360bb75fd623d::VKLO1 {
    struct VKLO1 has drop {
        dummy_field: bool,
    }

    struct SupplyHold has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<VKLO1>,
    }

    fun init(arg0: VKLO1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VKLO1>(arg0, 6, b"VKLO1", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VKLO1>>(v1);
        let v2 = SupplyHold{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<VKLO1>(v0),
        };
        0x2::transfer::transfer<SupplyHold>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut SupplyHold, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VKLO1> {
        0x2::coin::from_balance<VKLO1>(0x2::balance::increase_supply<VKLO1>(&mut arg0.supply, arg1), arg2)
    }

    public entry fun mint_to(arg0: &mut SupplyHold, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VKLO1>>(mint(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

