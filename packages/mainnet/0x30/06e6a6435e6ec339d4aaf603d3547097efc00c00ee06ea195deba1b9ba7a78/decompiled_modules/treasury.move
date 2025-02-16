module 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        version: u64,
        funds: 0x2::bag::Bag,
    }

    fun assert_interacting_with_most_up_to_date_package(arg0: &Treasury) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::version::assert_interacting_with_most_up_to_date_package(arg0.version);
    }

    public fun balance_of<T0>(arg0: &mut Treasury) : u64 {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.funds, 0x1::type_name::get<T0>()))
    }

    public(friend) fun create_treasury(arg0: &mut 0x2::tx_context::TxContext) : Treasury {
        Treasury{
            id      : 0x2::object::new(arg0),
            version : 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::version::current_version(),
            funds   : 0x2::bag::new(arg0),
        }
    }

    public fun deposit<T0>(arg0: &Treasury, arg1: 0x2::coin::Coin<T0>) {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::object::id_to_address(0x2::object::borrow_id<Treasury>(arg0)));
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.funds, 0x1::type_name::get<T0>()), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

