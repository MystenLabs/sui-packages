module 0x8c161e0f9af98460fd1e3f59aeb4f0316f7852b8e99254b431a1784d2bfd54c8::partner_manager {
    struct Commission has copy, drop, store {
        level: u8,
        type: u8,
        value: u64,
    }

    struct PartnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerInfo has store {
        name: 0x1::string::String,
        partner_cap_id: 0x2::object::ID,
        commissions: 0x2::bag::Bag,
        balances: 0x2::bag::Bag,
    }

    struct PartnerRegistry has store, key {
        id: 0x2::object::UID,
        max_comission_percentage: u64,
        partners: 0x2::bag::Bag,
    }

    struct PartnerRegister has copy, drop, store {
        sender: address,
        partner: 0x1::string::String,
    }

    struct ConfigCommission has copy, drop, store {
        sender: address,
        partner: 0x1::string::String,
        commission: Commission,
    }

    struct Collect has copy, drop, store {
        swapper: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct Withdraw has copy, drop, store {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun authorize(arg0: &PartnerCap, arg1: &PartnerInfo) {
        if (0x2::object::id<PartnerCap>(arg0) != arg1.partner_cap_id) {
            abort 3
        };
    }

    public fun check_exists(arg0: &PartnerRegistry, arg1: 0x1::string::String) {
        if (!0x2::bag::contains<0x1::string::String>(&arg0.partners, arg1)) {
            abort 0
        };
    }

    fun collect<T0>(arg0: &mut PartnerInfo, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, 0x1::type_name::get<T0>()), arg1);
        let v0 = Collect{
            swapper   : 0x2::tx_context::sender(arg2),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Collect>(v0);
    }

    public(friend) fun collect_commission_if_necessary<T0>(arg0: &mut PartnerRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::coin::Coin<T0>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        check_exists(arg0, arg1);
        let v0 = 0x2::bag::borrow_mut<0x1::string::String, PartnerInfo>(&mut arg0.partners, arg1);
        if (0x2::bag::contains<0x1::type_name::TypeName>(&v0.commissions, 0x1::type_name::get<T0>())) {
            let v1 = 0x2::bag::borrow<0x1::type_name::TypeName, Commission>(&v0.commissions, 0x1::type_name::get<T0>());
            let v2 = if (v1.type == 1) {
                if (v1.value > 0x8c161e0f9af98460fd1e3f59aeb4f0316f7852b8e99254b431a1784d2bfd54c8::math::mul_div(0x2::coin::value<T0>(arg2), arg0.max_comission_percentage, 1000000)) {
                    abort 2
                };
                v1.value
            } else {
                0x8c161e0f9af98460fd1e3f59aeb4f0316f7852b8e99254b431a1784d2bfd54c8::math::mul_div(0x2::coin::value<T0>(arg2), v1.value, 1000000)
            };
            if (arg3 && v1.level == 0) {
                collect<T0>(v0, 0x2::coin::split<T0>(arg2, v2, arg4), arg4);
            } else if (v1.level == 1) {
                collect<T0>(v0, 0x2::coin::split<T0>(arg2, v2, arg4), arg4);
            };
        };
    }

    public entry fun config_commission<T0>(arg0: &PartnerCap, arg1: &mut PartnerRegistry, arg2: vector<u8>, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        if (arg3 != 0 && arg3 != 1 || arg4 != 0 && arg4 != 1 || arg4 == 0 && arg5 > arg1.max_comission_percentage || arg5 == 0) {
            abort 4
        };
        let v0 = 0x1::string::utf8(arg2);
        check_exists(arg1, v0);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, PartnerInfo>(&mut arg1.partners, v0);
        authorize(arg0, v1);
        let v2 = Commission{
            level : arg3,
            type  : arg4,
            value : arg5,
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&v1.commissions, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, Commission>(&mut v1.commissions, 0x1::type_name::get<T0>(), v2);
        } else {
            *0x2::bag::borrow_mut<0x1::type_name::TypeName, Commission>(&mut v1.commissions, 0x1::type_name::get<T0>()) = v2;
        };
        let v3 = ConfigCommission{
            sender     : 0x2::tx_context::sender(arg6),
            partner    : v0,
            commission : v2,
        };
        0x2::event::emit<ConfigCommission>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerRegistry{
            id                       : 0x2::object::new(arg0),
            max_comission_percentage : 0,
            partners                 : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<PartnerRegistry>(v0);
    }

    public entry fun register_partner(arg0: &0x8c161e0f9af98460fd1e3f59aeb4f0316f7852b8e99254b431a1784d2bfd54c8::admin_cap::AdminCap, arg1: &mut PartnerRegistry, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        if (0x2::bag::contains<0x1::string::String>(&arg1.partners, v0)) {
            abort 0
        };
        let v1 = PartnerCap{id: 0x2::object::new(arg4)};
        let v2 = PartnerInfo{
            name           : v0,
            partner_cap_id : 0x2::object::id<PartnerCap>(&v1),
            commissions    : 0x2::bag::new(arg4),
            balances       : 0x2::bag::new(arg4),
        };
        0x2::bag::add<0x1::string::String, PartnerInfo>(&mut arg1.partners, v0, v2);
        0x2::transfer::public_transfer<PartnerCap>(v1, arg3);
        let v3 = PartnerRegister{
            sender  : 0x2::tx_context::sender(arg4),
            partner : v0,
        };
        0x2::event::emit<PartnerRegister>(v3);
    }

    public entry fun withdraw<T0>(arg0: &PartnerCap, arg1: &mut PartnerRegistry, arg2: vector<u8>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        check_exists(arg1, v0);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, PartnerInfo>(&mut arg1.partners, v0);
        authorize(arg0, v1);
        let v2 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.balances, 0x1::type_name::get<T0>());
        let v3 = 0x2::math::min(arg3, 0x2::balance::value<T0>(v2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(v2, v3, arg5), arg4);
        let v4 = Withdraw{
            sender    : 0x2::tx_context::sender(arg5),
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v3,
        };
        0x2::event::emit<Withdraw>(v4);
    }

    // decompiled from Move bytecode v6
}

