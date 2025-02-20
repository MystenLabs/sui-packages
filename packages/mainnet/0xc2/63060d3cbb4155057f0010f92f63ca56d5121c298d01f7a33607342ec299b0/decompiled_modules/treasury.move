module 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::treasury {
    struct Treasury has store, key {
        id: 0x2::object::UID,
        fee_on: bool,
        balances: 0x2::bag::Bag,
    }

    struct Collect has copy, drop, store {
        swapper: address,
        coin_type: 0x1::type_name::TypeName,
        protocol_fee_type: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::protocol_fee_type::ProtocolFeeType,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun collect<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>, arg2: 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::protocol_fee_type::ProtocolFeeType, arg3: &0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg1);
        let v0 = Collect{
            swapper           : 0x2::tx_context::sender(arg3),
            coin_type         : 0x1::type_name::get<T0>(),
            protocol_fee_type : arg2,
            amount            : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Collect>(v0);
    }

    public(friend) fun collect_positive_fee_if_necessary<T0>(arg0: &mut Treasury, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg0.fee_on && 0x2::coin::value<T0>(arg1) > arg2) {
            collect<T0>(arg0, 0x2::coin::split<T0>(arg1, 0x2::coin::value<T0>(arg1) - arg2, arg3), 0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::protocol_fee_type::positive_fee(), arg3);
        };
    }

    public fun fee_on(arg0: &Treasury) : bool {
        arg0.fee_on
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id       : 0x2::object::new(arg0),
            fee_on   : false,
            balances : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    entry fun set_fee_on(arg0: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::admin_cap::AdminCap, arg1: &mut Treasury, arg2: bool, arg3: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned) {
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::check_version(arg3);
        arg1.fee_on = arg2;
    }

    entry fun withdraw_protocol_fee<T0>(arg0: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::admin_cap::AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::Versioned, arg5: &mut 0x2::tx_context::TxContext) {
        0xc263060d3cbb4155057f0010f92f63ca56d5121c298d01f7a33607342ec299b0::versioned::check_version(arg4);
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.balances, 0x1::type_name::get<T0>());
        let v1 = 0x1::u64::min(arg2, 0x2::balance::value<T0>(v0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v0, v1, arg5), arg3);
        let v2 = Withdraw{
            sender    : 0x2::tx_context::sender(arg5),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v1,
        };
        0x2::event::emit<Withdraw>(v2);
    }

    // decompiled from Move bytecode v6
}

