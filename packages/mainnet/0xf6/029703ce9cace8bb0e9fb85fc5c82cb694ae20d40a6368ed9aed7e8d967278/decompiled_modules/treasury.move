module 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        funds: 0x2::bag::Bag,
    }

    public fun balance_of<T0>(arg0: &mut Treasury, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config) : u64 {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.funds, 0x1::type_name::get<T0>()))
    }

    public(friend) fun create_treasury<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 0);
        let v0 = Treasury{
            id    : 0x2::object::new(arg1),
            funds : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun deposit<T0>(arg0: &Treasury, arg1: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::Config, arg2: 0x2::coin::Coin<T0>) {
        0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config::assert_interacting_with_most_up_to_date_package(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::object::id_to_address(0x2::object::borrow_id<Treasury>(arg0)));
    }

    // decompiled from Move bytecode v6
}

