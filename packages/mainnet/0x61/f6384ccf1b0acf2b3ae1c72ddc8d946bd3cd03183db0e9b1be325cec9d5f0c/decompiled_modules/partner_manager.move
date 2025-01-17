module 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::partner_manager {
    struct PartnerRegistry has store, key {
        id: 0x2::object::UID,
        max_comission_percentage: u64,
        partners: 0x2::bag::Bag,
    }

    struct PartnerRegister has copy, drop, store {
        sender: address,
        partner: address,
    }

    struct Collect has copy, drop, store {
        swapper: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct CommissionCollect has copy, drop, store {
        swapper: address,
        beneficiary: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ChangeMaxCommissionPercentage has copy, drop, store {
        sender: address,
        max_comission_percentage: u64,
    }

    fun collect<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::coin::value<T0>(&arg1);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(arg0, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::get<T0>()), arg1);
    }

    public(friend) fun collect_commission_if_necessary<T0>(arg0: &mut PartnerRegistry, arg1: &mut 0x2::coin::Coin<T0>, arg2: &0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::Commission, arg3: &mut 0x2::tx_context::TxContext) {
        register_partner_if_necessary(arg0, 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2), arg3);
        if (!0x2::bag::contains<address>(&arg0.partners, 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2))) {
            0x2::bag::add<address, 0x2::bag::Bag>(&mut arg0.partners, 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2), 0x2::bag::new(arg3));
        };
        let v0 = 0x2::bag::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.partners, 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2));
        let v1 = if (0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::type(arg2) == 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission_type::flat()) {
            if (0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::value(arg2) > 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::math::mul_div(0x2::coin::value<T0>(arg1), arg0.max_comission_percentage, 1000000)) {
                abort 1
            };
            0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::value(arg2)
        } else {
            if (0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::value(arg2) > arg0.max_comission_percentage) {
                abort 1
            };
            0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::math::mul_div(0x2::coin::value<T0>(arg1), 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::value(arg2), 1000000)
        };
        if (0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::is_direct_transfer(arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v1, arg3), 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2));
        } else {
            collect<T0>(v0, 0x2::coin::split<T0>(arg1, v1, arg3), arg3);
        };
        let v2 = CommissionCollect{
            swapper     : 0x2::tx_context::sender(arg3),
            beneficiary : 0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::commission::partner(arg2),
            coin_type   : 0x1::type_name::get<T0>(),
            amount      : v1,
        };
        0x2::event::emit<CommissionCollect>(v2);
    }

    public entry fun config_max_comission_percentage(arg0: &0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::admin_cap::AdminCap, arg1: &mut PartnerRegistry, arg2: u64, arg3: &0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::versioned::check_version(arg3);
        if (arg2 == 0 || arg2 >= 1000000) {
            abort 2
        };
        arg1.max_comission_percentage = arg2;
        let v0 = ChangeMaxCommissionPercentage{
            sender                   : 0x2::tx_context::sender(arg4),
            max_comission_percentage : arg2,
        };
        0x2::event::emit<ChangeMaxCommissionPercentage>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerRegistry{
            id                       : 0x2::object::new(arg0),
            max_comission_percentage : 50000,
            partners                 : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PartnerRegistry>(v0);
    }

    public fun max_comission_percentage(arg0: &PartnerRegistry) : u64 {
        arg0.max_comission_percentage
    }

    fun register_partner_if_necessary(arg0: &mut PartnerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<address>(&arg0.partners, arg1)) {
            0x2::bag::add<address, 0x2::bag::Bag>(&mut arg0.partners, arg1, 0x2::bag::new(arg2));
            let v0 = PartnerRegister{
                sender  : 0x2::tx_context::sender(arg2),
                partner : arg1,
            };
            0x2::event::emit<PartnerRegister>(v0);
        };
    }

    public entry fun withdraw<T0>(arg0: &mut PartnerRegistry, arg1: u64, arg2: address, arg3: &0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x61f6384ccf1b0acf2b3ae1c72ddc8d946bd3cd03183db0e9b1be325cec9d5f0c::versioned::check_version(arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::bag::contains<address>(&arg0.partners, v0)) {
            abort 0
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::bag::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.partners, v0), 0x1::type_name::get<T0>());
        let v2 = 0x2::math::min(arg1, 0x2::balance::value<T0>(v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v1, v2, arg4), arg2);
        let v3 = Withdraw{
            sender    : v0,
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v2,
        };
        0x2::event::emit<Withdraw>(v3);
    }

    // decompiled from Move bytecode v6
}

