module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management {
    struct CoinManagement<phantom T0> has store {
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        distributor: 0x1::option::Option<address>,
        operator: 0x1::option::Option<address>,
        flow_limit: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::FlowLimit,
        dust: u256,
    }

    public(friend) fun mint<T0>(arg0: &mut CoinManagement<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), arg1, arg2)
    }

    public fun add_distributor<T0>(arg0: &mut CoinManagement<T0>, arg1: address) {
        assert!(has_capability<T0>(arg0), 9223372320322617345);
        0x1::option::fill<address>(&mut arg0.distributor, arg1);
    }

    public fun add_operator<T0>(arg0: &mut CoinManagement<T0>, arg1: address) {
        0x1::option::fill<address>(&mut arg0.operator, arg1);
    }

    public(friend) fun burn<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)), arg1);
    }

    public(friend) fun give_coin<T0>(arg0: &mut CoinManagement<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::add_flow_in(&mut arg0.flow_limit, arg1, arg2);
        if (has_capability<T0>(arg0)) {
            mint<T0>(arg0, arg1, arg3)
        } else {
            0x2::coin::take<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg0.balance), arg1, arg3)
        }
    }

    public fun has_capability<T0>(arg0: &CoinManagement<T0>) : bool {
        0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap)
    }

    public fun is_distributor<T0>(arg0: &CoinManagement<T0>, arg1: address) : bool {
        &arg1 == 0x1::option::borrow<address>(&arg0.distributor)
    }

    public fun new_locked<T0>() : CoinManagement<T0> {
        CoinManagement<T0>{
            treasury_cap : 0x1::option::none<0x2::coin::TreasuryCap<T0>>(),
            balance      : 0x1::option::some<0x2::balance::Balance<T0>>(0x2::balance::zero<T0>()),
            distributor  : 0x1::option::none<address>(),
            operator     : 0x1::option::none<address>(),
            flow_limit   : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::new(),
            dust         : 0,
        }
    }

    public fun new_with_cap<T0>(arg0: 0x2::coin::TreasuryCap<T0>) : CoinManagement<T0> {
        CoinManagement<T0>{
            treasury_cap : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg0),
            balance      : 0x1::option::none<0x2::balance::Balance<T0>>(),
            distributor  : 0x1::option::none<address>(),
            operator     : 0x1::option::none<address>(),
            flow_limit   : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::new(),
            dust         : 0,
        }
    }

    public(friend) fun set_flow_limit<T0>(arg0: &mut CoinManagement<T0>, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: u64) {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1);
        assert!(0x1::option::contains<address>(&arg0.operator, &v0), 9223372599495622659);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::set_flow_limit(&mut arg0.flow_limit, arg2);
    }

    public(friend) fun take_balance<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::flow_limit::add_flow_out(&mut arg0.flow_limit, 0x2::balance::value<T0>(&arg1), arg2);
        if (has_capability<T0>(arg0)) {
            burn<T0>(arg0, arg1);
        } else {
            0x2::balance::join<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg0.balance), arg1);
        };
        0x2::balance::value<T0>(&arg1)
    }

    // decompiled from Move bytecode v6
}

