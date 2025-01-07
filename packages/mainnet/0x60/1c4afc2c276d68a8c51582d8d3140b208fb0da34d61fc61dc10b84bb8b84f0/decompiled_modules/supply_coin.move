module 0x601c4afc2c276d68a8c51582d8d3140b208fb0da34d61fc61dc10b84bb8b84f0::supply_coin {
    struct SUPPLY_COIN has drop {
        dummy_field: bool,
    }

    struct SupplyHold<phantom T0> has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    fun init(arg0: SUPPLY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPPLY_COIN>(arg0, 6, b"stan", b"meme", b"this is stan meme", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUPPLY_COIN>>(v1);
        let v2 = SupplyHold<SUPPLY_COIN>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<SUPPLY_COIN>(v0),
        };
        0x2::transfer::share_object<SupplyHold<SUPPLY_COIN>>(v2);
    }

    public fun mint(arg0: &mut SupplyHold<SUPPLY_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUPPLY_COIN> {
        0x2::tx_context::sender(arg2);
        if (arg1 < 10000) {
            abort 0
        };
        0x2::coin::from_balance<SUPPLY_COIN>(0x2::balance::increase_supply<SUPPLY_COIN>(&mut arg0.supply, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

