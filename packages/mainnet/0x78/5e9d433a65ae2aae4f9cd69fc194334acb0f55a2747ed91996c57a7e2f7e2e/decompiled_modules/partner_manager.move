module 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::partner_manager {
    struct PartnerRegistry has store, key {
        id: 0x2::object::UID,
        default_partner_fee_rate: u64,
        max_commission_percentage: u64,
        partners: 0x2::table::Table<address, PartnerInfo>,
    }

    struct PartnerInfo has store {
        partner_fee_rate: 0x1::option::Option<u64>,
        balances: 0x2::bag::Bag,
    }

    struct PartnerRegister has copy, drop, store {
        sender: address,
        partner: address,
    }

    struct Collect has copy, drop, store {
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
        max_commission_percentage: u64,
    }

    struct ChangeDefaultPartnerFeeRate has copy, drop, store {
        sender: address,
        default_partner_fee_rate: u64,
    }

    struct ChangePartnerFeeRate has copy, drop, store {
        sender: address,
        partner: address,
        partner_fee_rate: u64,
    }

    public(friend) fun collect_commission_if_necessary<T0>(arg0: &mut PartnerRegistry, arg1: &mut 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::treasury::Treasury, arg2: &mut 0x2::coin::Coin<T0>, arg3: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::Commission, arg4: &mut 0x2::tx_context::TxContext) {
        register_partner_if_necessary(arg0, 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::partner(arg3), arg4);
        let v0 = if (0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission_type::is_flat(0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::commission_type(arg3))) {
            if (0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::value(arg3) > 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::math::mul(0x2::coin::value<T0>(arg2), arg0.max_commission_percentage)) {
                abort 1
            };
            0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::value(arg3)
        } else {
            if (0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::value(arg3) > arg0.max_commission_percentage) {
                abort 1
            };
            0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::math::mul(0x2::coin::value<T0>(arg2), 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::value(arg3))
        };
        let v1 = 0x2::table::borrow_mut<address, PartnerInfo>(&mut arg0.partners, 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::partner(arg3));
        let v2 = 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::math::mul(v0, 0x1::option::get_with_default<u64>(&v1.partner_fee_rate, arg0.default_partner_fee_rate));
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::treasury::collect<T0>(arg1, 0x2::coin::split<T0>(arg2, v2, arg4), 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::protocol_fee_type::partner_fee(), arg4);
        if (0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::is_direct_transfer(arg3)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg2, v0 - v2, arg4), 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::partner(arg3));
        } else {
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&v1.balances, 0x1::type_name::get<T0>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
            };
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.balances, 0x1::type_name::get<T0>()), 0x2::coin::split<T0>(arg2, v0 - v2, arg4));
        };
        let v3 = Collect{
            swapper     : 0x2::tx_context::sender(arg4),
            beneficiary : 0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::commission::partner(arg3),
            coin_type   : 0x1::type_name::get<T0>(),
            amount      : v0,
        };
        0x2::event::emit<Collect>(v3);
    }

    entry fun config_default_partner_fee_rate(arg0: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::admin_cap::AdminCap, arg1: &mut PartnerRegistry, arg2: u64, arg3: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::check_version(arg3);
        arg1.default_partner_fee_rate = arg2;
        let v0 = ChangeDefaultPartnerFeeRate{
            sender                   : 0x2::tx_context::sender(arg4),
            default_partner_fee_rate : arg2,
        };
        0x2::event::emit<ChangeDefaultPartnerFeeRate>(v0);
    }

    entry fun config_max_commission_percentage(arg0: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::admin_cap::AdminCap, arg1: &mut PartnerRegistry, arg2: u64, arg3: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::Versioned, arg4: &0x2::tx_context::TxContext) {
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::check_version(arg3);
        if (arg2 == 0) {
            abort 2
        };
        arg1.max_commission_percentage = arg2;
        let v0 = ChangeMaxCommissionPercentage{
            sender                    : 0x2::tx_context::sender(arg4),
            max_commission_percentage : arg2,
        };
        0x2::event::emit<ChangeMaxCommissionPercentage>(v0);
    }

    entry fun config_partner_fee_rate(arg0: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::admin_cap::AdminCap, arg1: &mut PartnerRegistry, arg2: address, arg3: u64, arg4: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::Versioned, arg5: &0x2::tx_context::TxContext) {
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::check_version(arg4);
        if (!0x2::table::contains<address, PartnerInfo>(&arg1.partners, arg2)) {
            abort 0
        };
        0x1::option::fill<u64>(&mut 0x2::table::borrow_mut<address, PartnerInfo>(&mut arg1.partners, arg2).partner_fee_rate, arg3);
        let v0 = ChangePartnerFeeRate{
            sender           : 0x2::tx_context::sender(arg5),
            partner          : arg2,
            partner_fee_rate : arg3,
        };
        0x2::event::emit<ChangePartnerFeeRate>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerRegistry{
            id                        : 0x2::object::new(arg0),
            default_partner_fee_rate  : 0,
            max_commission_percentage : 50000,
            partners                  : 0x2::table::new<address, PartnerInfo>(arg0),
        };
        0x2::transfer::share_object<PartnerRegistry>(v0);
    }

    public fun max_commission_percentage(arg0: &PartnerRegistry) : u64 {
        arg0.max_commission_percentage
    }

    fun register_partner_if_necessary(arg0: &mut PartnerRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, PartnerInfo>(&arg0.partners, arg1)) {
            let v0 = PartnerInfo{
                partner_fee_rate : 0x1::option::none<u64>(),
                balances         : 0x2::bag::new(arg2),
            };
            0x2::table::add<address, PartnerInfo>(&mut arg0.partners, arg1, v0);
            let v1 = PartnerRegister{
                sender  : 0x2::tx_context::sender(arg2),
                partner : arg1,
            };
            0x2::event::emit<PartnerRegister>(v1);
        };
    }

    public entry fun withdraw<T0>(arg0: &mut PartnerRegistry, arg1: u64, arg2: address, arg3: &0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x785e9d433a65ae2aae4f9cd69fc194334acb0f55a2747ed91996c57a7e2f7e2e::versioned::check_version(arg3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, PartnerInfo>(&arg0.partners, v0)) {
            abort 0
        };
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut 0x2::table::borrow_mut<address, PartnerInfo>(&mut arg0.partners, v0).balances, 0x1::type_name::get<T0>());
        let v2 = 0x1::u64::min(arg1, 0x2::balance::value<T0>(v1));
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

