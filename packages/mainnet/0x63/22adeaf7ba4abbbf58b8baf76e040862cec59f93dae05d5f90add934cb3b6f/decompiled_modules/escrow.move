module 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::escrow {
    struct EscrowState has key {
        id: 0x2::object::UID,
        orders: 0x2::table::Table<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>,
        destination_domain: u32,
        max_order_size: u64,
        order_count: u64,
    }

    public fun borrow_order(arg0: &EscrowState, arg1: u64) : &0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order {
        assert!(0x2::table::contains<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, arg1), 2);
        0x2::table::borrow<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, arg1)
    }

    entry fun cancel_order(arg0: &mut EscrowState, arg1: u64, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg6: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg7: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, arg1), 2);
        let v0 = 0x2::table::borrow_mut<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&mut arg0.orders, arg1);
        assert!(0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::status(v0) == 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::status_created(), 4);
        assert!(0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::sender(v0) == 0x2::tx_context::sender(arg7), 3);
        let (_, _) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::replace_deposit_for_burn_with_package_auth<0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::EscrowAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_replace_deposit_for_burn_ticket<0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::EscrowAuth>(0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::new(), arg2, arg3, 0x1::option::none<address>(), 0x1::option::some<address>(arg4)), arg5, arg6);
        0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::mark_cancelled(v0);
        0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::events::emit_order_cancelled(arg1, 0x2::tx_context::sender(arg7));
    }

    public fun destination_domain(arg0: &EscrowState) : u32 {
        arg0.destination_domain
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowState{
            id                 : 0x2::object::new(arg0),
            orders             : 0x2::table::new<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(arg0),
            destination_domain : 9,
            max_order_size     : 0,
            order_count        : 0,
        };
        0x2::transfer::share_object<EscrowState>(v0);
    }

    entry fun initiate_order<T0: drop>(arg0: &mut EscrowState, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg4: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg5: &0x2::deny_list::DenyList, arg6: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg8);
        let v2 = arg0.destination_domain;
        assert!(v0 > 0, 0);
        assert!(arg2 != @0x0, 1);
        let (_, v4) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_package_auth<T0, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::EscrowAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::EscrowAuth>(0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::auth::new(), arg1, v2, arg2), arg3, arg4, arg5, arg6, arg8);
        let v5 = v4;
        let v6 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v5);
        let v7 = 0x2::clock::timestamp_ms(arg7);
        assert!(!0x2::table::contains<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, v6), 5);
        0x2::table::add<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&mut arg0.orders, v6, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::new(v6, v1, arg2, v0, v2, v7));
        arg0.order_count = arg0.order_count + 1;
        0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::events::emit_order_created(v6, v1, arg2, v0, v2, v7);
    }

    entry fun mark_settled(arg0: &mut EscrowState, arg1: u64) {
        assert!(0x2::table::contains<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, arg1), 2);
        let v0 = 0x2::table::borrow_mut<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&mut arg0.orders, arg1);
        assert!(0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::status(v0) == 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::status_created(), 4);
        0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::mark_settled(v0);
        0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::events::emit_order_settled(arg1);
    }

    public fun max_order_size(arg0: &EscrowState) : u64 {
        arg0.max_order_size
    }

    public fun order_count(arg0: &EscrowState) : u64 {
        arg0.order_count
    }

    public fun order_exists(arg0: &EscrowState, arg1: u64) : bool {
        0x2::table::contains<u64, 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order::Order>(&arg0.orders, arg1)
    }

    // decompiled from Move bytecode v6
}

