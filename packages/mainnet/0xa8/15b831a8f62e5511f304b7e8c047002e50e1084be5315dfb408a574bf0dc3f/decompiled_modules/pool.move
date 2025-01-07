module 0xa815b831a8f62e5511f304b7e8c047002e50e1084be5315dfb408a574bf0dc3f::pool {
    struct COIN_X has drop {
        dummy_field: bool,
    }

    struct COIN_Y has drop {
        dummy_field: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        supply_x: 0x2::balance::Supply<COIN_X>,
        supply_y: 0x2::balance::Supply<COIN_Y>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = COIN_X{dummy_field: false};
        let v1 = COIN_Y{dummy_field: false};
        let v2 = Pool{
            id       : 0x2::object::new(arg0),
            supply_x : 0x2::balance::create_supply<COIN_X>(v0),
            supply_y : 0x2::balance::create_supply<COIN_Y>(v1),
        };
        0x2::transfer::share_object<Pool>(v2);
    }

    public(friend) fun put_coin_x(arg0: &mut Pool, arg1: 0x2::coin::Coin<COIN_X>) {
        0x2::balance::decrease_supply<COIN_X>(&mut arg0.supply_x, 0x2::coin::into_balance<COIN_X>(arg1));
    }

    public(friend) fun put_coin_y(arg0: &mut Pool, arg1: 0x2::coin::Coin<COIN_Y>) {
        0x2::balance::decrease_supply<COIN_Y>(&mut arg0.supply_y, 0x2::coin::into_balance<COIN_Y>(arg1));
    }

    public(friend) fun take_coin_x(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN_X> {
        0x2::coin::from_balance<COIN_X>(0x2::balance::increase_supply<COIN_X>(&mut arg0.supply_x, arg1), arg2)
    }

    public(friend) fun take_coin_y(arg0: &mut Pool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<COIN_Y> {
        0x2::coin::from_balance<COIN_Y>(0x2::balance::increase_supply<COIN_Y>(&mut arg0.supply_y, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

