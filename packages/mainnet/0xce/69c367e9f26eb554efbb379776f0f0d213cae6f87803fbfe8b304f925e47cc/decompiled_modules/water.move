module 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    struct WaterJug has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<WATER>,
    }

    public(friend) fun burn(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: 0x2::balance::Balance<WATER>) {
        0x2::balance::decrease_supply<WATER>(0x2::coin::supply_mut<WATER>(arg0), arg1);
    }

    public fun buy_water(arg0: &mut 0x2::coin::TreasuryCap<WATER>, arg1: &mut 0x2::coin::TreasuryCap<0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::dwl::DWL>, arg2: 0x2::coin::Coin<0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::dwl::DWL>, arg3: &0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::GameConfig, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_version(arg3);
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::assert_not_paused(arg3);
        let v0 = 0x2::coin::value<0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::dwl::DWL>(&arg2);
        assert!(v0 >= (((arg4 as u128) * (0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config::water_price_dwl(arg3) as u128) / 1000000000) as u64), 100);
        0x2::coin::burn<0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::dwl::DWL>(arg1, arg2);
        let v1 = WaterJug{
            id      : 0x2::object::new(arg5),
            balance : 0x2::coin::mint_balance<WATER>(arg0, arg4),
        };
        0x2::transfer::transfer<WaterJug>(v1, 0x2::tx_context::sender(arg5));
        0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::events::emit_water_purchased(0x2::tx_context::sender(arg5), v0, arg4);
    }

    public(friend) fun consume(arg0: &mut WaterJug, arg1: u64) : 0x2::balance::Balance<WATER> {
        assert!(0x2::balance::value<WATER>(&arg0.balance) >= arg1, 101);
        0x2::balance::split<WATER>(&mut arg0.balance, arg1)
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 9, b"WATER", b"DigiWorld Water", b"Water resource for DigiWorld Live", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    public fun merge_jugs(arg0: &mut WaterJug, arg1: WaterJug) {
        let WaterJug {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<WATER>(&mut arg0.balance, v1);
    }

    public fun water_balance(arg0: &WaterJug) : u64 {
        0x2::balance::value<WATER>(&arg0.balance)
    }

    // decompiled from Move bytecode v6
}

