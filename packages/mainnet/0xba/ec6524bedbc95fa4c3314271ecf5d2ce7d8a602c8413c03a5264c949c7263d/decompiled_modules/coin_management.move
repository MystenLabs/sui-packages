module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management {
    struct CoinManagement<phantom T0> has store {
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        distributor: 0x1::option::Option<address>,
        operator: 0x1::option::Option<address>,
        flow_limit: 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::FlowLimit,
        dust: u256,
    }

    public(friend) fun mint<T0>(arg0: &mut CoinManagement<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), arg1, arg2)
    }

    public fun add_distributor<T0>(arg0: &mut CoinManagement<T0>, arg1: address) {
        assert!(has_treasury_cap<T0>(arg0), 13906834457811222529);
        0x1::option::fill<address>(&mut arg0.distributor, arg1);
    }

    public fun add_operator<T0>(arg0: &mut CoinManagement<T0>, arg1: address) {
        0x1::option::fill<address>(&mut arg0.operator, arg1);
    }

    public(friend) fun burn<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)), arg1);
    }

    public(friend) fun destroy<T0>(arg0: CoinManagement<T0>) : (0x1::option::Option<0x2::coin::TreasuryCap<T0>>, 0x1::option::Option<0x2::balance::Balance<T0>>) {
        let CoinManagement {
            treasury_cap : v0,
            balance      : v1,
            distributor  : _,
            operator     : _,
            flow_limit   : _,
            dust         : _,
        } = arg0;
        (v0, v1)
    }

    public fun distributor<T0>(arg0: &CoinManagement<T0>) : &0x1::option::Option<address> {
        &arg0.distributor
    }

    public(friend) fun give_coin<T0>(arg0: &mut CoinManagement<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::add_flow_in(&mut arg0.flow_limit, arg1, arg2);
        if (has_treasury_cap<T0>(arg0)) {
            mint<T0>(arg0, arg1, arg3)
        } else {
            assert!(0x1::option::is_some<0x2::balance::Balance<T0>>(&arg0.balance), 13906834685445013513);
            0x2::coin::take<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg0.balance), arg1, arg3)
        }
    }

    public fun has_treasury_cap<T0>(arg0: &CoinManagement<T0>) : bool {
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
            flow_limit   : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::new(),
            dust         : 0,
        }
    }

    public fun new_with_cap<T0>(arg0: 0x2::coin::TreasuryCap<T0>) : CoinManagement<T0> {
        CoinManagement<T0>{
            treasury_cap : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg0),
            balance      : 0x1::option::none<0x2::balance::Balance<T0>>(),
            distributor  : 0x1::option::none<address>(),
            operator     : 0x1::option::none<address>(),
            flow_limit   : 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::new(),
            dust         : 0,
        }
    }

    public fun operator<T0>(arg0: &CoinManagement<T0>) : &0x1::option::Option<address> {
        &arg0.operator
    }

    public(friend) fun remove_cap<T0>(arg0: &mut CoinManagement<T0>) : 0x2::coin::TreasuryCap<T0> {
        assert!(has_treasury_cap<T0>(arg0), 13906834840063574021);
        0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap)
    }

    public(friend) fun restore_cap<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x2::coin::TreasuryCap<T0>) {
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&arg0.balance), 13906834865833508871);
        0x1::option::fill<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap, arg1);
    }

    public(friend) fun set_flow_limit<T0>(arg0: &mut CoinManagement<T0>, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x1::option::Option<u64>) {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1);
        assert!(0x1::option::contains<address>(&arg0.operator, &v0), 13906834758459064323);
        set_flow_limit_internal<T0>(arg0, arg2);
    }

    public(friend) fun set_flow_limit_internal<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x1::option::Option<u64>) {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::set_flow_limit(&mut arg0.flow_limit, arg1);
    }

    public(friend) fun take_balance<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : u64 {
        0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::flow_limit::add_flow_out(&mut arg0.flow_limit, 0x2::balance::value<T0>(&arg1), arg2);
        if (has_treasury_cap<T0>(arg0)) {
            burn<T0>(arg0, arg1);
        } else {
            assert!(0x1::option::is_some<0x2::balance::Balance<T0>>(&arg0.balance), 13906834629610438665);
            0x2::balance::join<T0>(0x1::option::borrow_mut<0x2::balance::Balance<T0>>(&mut arg0.balance), arg1);
        };
        0x2::balance::value<T0>(&arg1)
    }

    public fun treasury_cap<T0>(arg0: &CoinManagement<T0>) : &0x1::option::Option<0x2::coin::TreasuryCap<T0>> {
        &arg0.treasury_cap
    }

    public(friend) fun update_distributorship<T0>(arg0: &mut CoinManagement<T0>, arg1: 0x1::option::Option<address>) {
        arg0.distributor = arg1;
    }

    public(friend) fun update_operatorship<T0>(arg0: &mut CoinManagement<T0>, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel, arg2: 0x1::option::Option<address>) {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::to_address(arg1);
        assert!(0x1::option::contains<address>(&arg0.operator, &v0), 13906834818588606467);
        arg0.operator = arg2;
    }

    // decompiled from Move bytecode v6
}

