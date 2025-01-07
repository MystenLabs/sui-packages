module 0xa558b576d1eec3f6a7de3420c9d61e9c5fe732e9237963c6805e1e5a5d9af7cc::bluemove_ido {
    struct IDOData<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        fund_to: address,
        coin_raise: 0x2::coin::Coin<T0>,
        coin_deposit: 0x2::coin::Coin<T1>,
        phases: vector<PhaseItem>,
    }

    struct PhaseItem has drop, store {
        name: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        hard_cap: u64,
        total_deposit_amount: u64,
        price_per_token: u64,
        min_deposit_amount: u64,
        token_raise_decimal: u64,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        total_user: u64,
    }

    struct UserInfoDetail has drop, store {
        total_deposit: u64,
        total_recived: u64,
        harvested: bool,
    }

    struct VestingItem has drop, store {
        time_unlock: u64,
        vesting_id: u64,
        amount: u64,
    }

    struct HarvestEvent has copy, drop, store {
        user: address,
        recived_amount: u64,
        remain_amount: u64,
        coin_recived_type: 0x1::string::String,
        coin_remain_type: 0x1::string::String,
        time: u64,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        coin_type: 0x1::string::String,
        amount: u64,
        time: u64,
    }

    public entry fun add_phase_ido<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        assert!(arg5 == 0x2::coin::value<T0>(&arg6), 1);
        let v0 = PhaseItem{
            name                 : arg1,
            start_time           : arg2,
            end_time             : arg3,
            hard_cap             : arg4,
            total_deposit_amount : 0,
            price_per_token      : arg7,
            min_deposit_amount   : arg8,
            token_raise_decimal  : arg9,
        };
        0x2::coin::join<T0>(&mut arg0.coin_raise, arg6);
        0x1::vector::push_back<PhaseItem>(&mut arg0.phases, v0);
    }

    public entry fun deposit<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: &mut UserInfo, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg3 == 0x2::coin::value<T1>(&arg4) && arg3 >= v1.min_deposit_amount, 1);
        assert!(v2 >= v1.start_time && v2 <= v1.end_time, 3);
        if (!0x2::dynamic_field::exists_with_type<address, UserInfoDetail>(&arg1.id, v0)) {
            let v3 = UserInfoDetail{
                total_deposit : 0,
                total_recived : 0,
                harvested     : false,
            };
            0x2::dynamic_field::add<address, UserInfoDetail>(&mut arg1.id, v0, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<address, UserInfoDetail>(&mut arg1.id, v0);
        0x2::coin::join<T1>(&mut arg0.coin_deposit, arg4);
        v1.total_deposit_amount = v1.total_deposit_amount + arg3;
        v4.total_deposit = v4.total_deposit + arg3;
        let v5 = DepositEvent{
            user      : v0,
            coin_type : get_token_name<T1>(),
            amount    : arg3,
            time      : v2,
        };
        0x2::event::emit<DepositEvent>(v5);
    }

    public fun get_token_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public entry fun harvest<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: &mut UserInfo, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg2);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= v1.end_time, 4);
        let v3 = 0x2::dynamic_field::borrow_mut<address, UserInfoDetail>(&mut arg1.id, v0);
        assert!(!v3.harvested, 5);
        let v4 = if (v1.total_deposit_amount / v1.hard_cap < 1) {
            (v3.total_deposit as u256)
        } else {
            (v3.total_deposit as u256) * (v1.hard_cap as u256) / (v1.total_deposit_amount as u256)
        };
        let v5 = v3.total_deposit - (v4 as u64);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_deposit, v5, arg4), v0);
        };
        let v6 = (v4 as u64) / v1.price_per_token * 0x2::math::pow(10, (v1.token_raise_decimal as u8));
        let v7 = v6;
        if (v6 >= 0x2::coin::value<T0>(&arg0.coin_raise)) {
            v7 = 0x2::coin::value<T0>(&arg0.coin_raise);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin_raise, v7, arg4), v0);
        v3.harvested = true;
        v3.total_recived = v7;
        let v8 = HarvestEvent{
            user              : v0,
            recived_amount    : v7,
            remain_amount     : v5,
            coin_recived_type : get_token_name<T0>(),
            coin_remain_type  : get_token_name<T1>(),
            time              : v2,
        };
        0x2::event::emit<HarvestEvent>(v8);
    }

    public entry fun init_ido<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        let v0 = IDOData<T0, T1>{
            id           : 0x2::object::new(arg0),
            fund_to      : @0x1c7eaee4cc2ec57c57f46f1b0046f49fd3056e2a55b96d2539f1269d7ceb12d9,
            coin_raise   : 0x2::coin::zero<T0>(arg0),
            coin_deposit : 0x2::coin::zero<T1>(arg0),
            phases       : 0x1::vector::empty<PhaseItem>(),
        };
        0x2::transfer::public_share_object<IDOData<T0, T1>>(v0);
        let v1 = UserInfo{
            id         : 0x2::object::new(arg0),
            total_user : 0,
        };
        0x2::transfer::public_share_object<UserInfo>(v1);
    }

    public entry fun set_fund_address<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        arg0.fund_to = arg1;
    }

    public entry fun update_hard_cap<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg1).hard_cap = arg2;
    }

    public entry fun update_min_amount_deposit<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg1).min_deposit_amount = arg2;
    }

    public entry fun update_price_per_token<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg1).price_per_token = arg2;
    }

    public entry fun update_time_ido<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 2);
        let v0 = 0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, arg1);
        v0.start_time = arg2;
        v0.end_time = arg3;
    }

    public entry fun withdraw<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.fund_to, 2);
        let v1 = 0x2::coin::value<T1>(&arg0.coin_deposit);
        let v2 = 0x2::coin::value<T0>(&arg0.coin_raise);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin_raise, v2, arg1), v0);
        };
        let v3 = 0;
        let v4 = 0;
        while (v4 < 0x1::vector::length<PhaseItem>(&arg0.phases)) {
            v3 = v3 + 0x1::vector::borrow_mut<PhaseItem>(&mut arg0.phases, v4).hard_cap;
            v4 = v4 + 1;
        };
        if (v1 > v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_deposit, v3, arg1), v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_deposit, v1, arg1), v0);
        };
    }

    public entry fun withdraw_backup<T0, T1>(arg0: &mut IDOData<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1 || v0 == arg0.fund_to, 2);
        let v1 = 0x2::coin::value<T0>(&arg0.coin_raise);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.coin_raise, v1, arg1), v0);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg0.coin_deposit, 0x2::coin::value<T1>(&arg0.coin_deposit), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

