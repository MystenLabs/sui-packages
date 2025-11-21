module 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance {
    struct FinanceCap has key {
        id: 0x2::object::UID,
    }

    struct Finance has store, key {
        id: 0x2::object::UID,
        pcs: 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::ProfitCS,
        users: 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::UserPool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        investment_id: u64,
        investment_table: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>,
        version: u64,
    }

    struct UnStakeConfig has store, key {
        id: 0x2::object::UID,
        hashrate_id: u64,
        hr_rate: u64,
    }

    struct EcoConfig has store, key {
        id: 0x2::object::UID,
        eco_sequence: u64,
        eco_receipt: address,
        black_list: 0x2::table::Table<address, bool>,
        black_list2: 0x2::table::Table<address, bool>,
    }

    struct SUIPool has store, key {
        id: 0x2::object::UID,
        sequence: u64,
        receipt: address,
        version: u64,
    }

    struct TopupDivideItem has copy, drop, store {
        user: address,
        value: u64,
    }

    struct MMTPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>,
        balance_usdc: 0x2::balance::Balance<T0>,
    }

    struct UserInfo has copy, drop {
        root: address,
        user: address,
        inviter: address,
    }

    struct BindInviter has copy, drop {
        index: u64,
        user: address,
        inviter: address,
    }

    struct Stake has copy, drop {
        id: u64,
        amount: u64,
        amount_gold: u64,
        sender: address,
    }

    struct Claim has copy, drop {
        stake_id: u64,
        claim_reward: u64,
        claim_amount: u64,
        subsidy: u64,
        claim_fee: u64,
        sender: address,
    }

    struct Unstake has copy, drop {
        id: u64,
        recover_amount: u64,
        sender: address,
    }

    struct UnstakeV2 has copy, drop {
        id: u64,
        recover_amount: u64,
        recover_amount_fee: u64,
        sender: address,
    }

    struct UnstakeV3 has copy, drop {
        id: u64,
        usdt_amount: u64,
        usdt_fee_amount: u64,
        usdt_hr_amount: u64,
        usdt_recover_amount: u64,
        sui_recover_amount: u64,
    }

    struct NewHashrate has copy, drop {
        id: u64,
        amount: u64,
        user: address,
        typ: u8,
    }

    struct InvtInfo has copy, drop {
        id: u64,
        amount: u64,
        fee_rate: u64,
        profit_rate: u64,
        lock_period: u64,
        claimable_reward: u64,
        claim_fee: u64,
        lock_time: u64,
        start_release_time: u64,
    }

    struct NewEco has copy, drop {
        id: u64,
        stake_id: u64,
        eco_type: u8,
        amount: u64,
        value: u64,
        v1: bool,
    }

    struct UserStateUpdate has copy, drop {
        user: address,
        black: bool,
        v1: bool,
    }

    struct TopUpSui has copy, drop {
        id: u64,
        amount: u64,
        value: u64,
        user: address,
    }

    public entry fun add_mmt_pool_liquidity<T0>(arg0: &FinanceCap, arg1: &mut Finance, arg2: &mut MMTPool<T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position), 17);
        let v0 = 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg6, 18);
        let (v1, v2) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::sell_and_add_liquidity<0x2::sui::SUI, T0>(v0, arg3, arg4, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg6), arg6, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, v1);
        0x2::balance::join<T0>(&mut arg2.balance_usdc, v2);
    }

    public entry fun add_mmt_pool_position<T0>(arg0: &FinanceCap, arg1: &mut MMTPool<T0>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 16);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position, arg2);
    }

    public fun assert_user_is_not_black(arg0: &EcoConfig, arg1: address, arg2: bool) {
        assert!(!is_black_user(arg0, arg1, arg2), 15);
    }

    public entry fun bind_inviter(arg0: &mut Finance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!valid_user(arg0, v0), 6);
        let v1 = BindInviter{
            index   : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::bind_inviter(&mut arg0.users, v0, arg1),
            user    : v0,
            inviter : arg1,
        };
        0x2::event::emit<BindInviter>(v1);
    }

    public entry fun bind_inviter_by_admin(arg0: &FinanceCap, arg1: &mut Finance, arg2: vector<address>, arg3: vector<address>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(!valid_user(arg1, v1), 6);
            let v3 = BindInviter{
                index   : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::bind_inviter(&mut arg1.users, v1, v2),
                user    : v1,
                inviter : v2,
            };
            0x2::event::emit<BindInviter>(v3);
            v0 = v0 + 1;
        };
    }

    public entry fun bind_inviter_by_admin2(arg0: &FinanceCap, arg1: &mut Finance, arg2: u64, arg3: vector<address>, arg4: vector<address>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            let v1 = *0x1::vector::borrow<address>(&arg3, v0);
            assert!(!valid_user(arg1, v1), 6);
            0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::bind_inviter(&mut arg1.users, v1, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::set_pool_size(&mut arg1.users, arg2);
    }

    public entry fun bind_inviter_by_cap(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(!valid_user(arg1, arg2), 6);
        let v0 = BindInviter{
            index   : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::bind_inviter(&mut arg1.users, arg2, arg3),
            user    : arg2,
            inviter : arg3,
        };
        0x2::event::emit<BindInviter>(v0);
    }

    fun check_suipool_version(arg0: &SUIPool) {
        assert!(arg0.version == 17, 12);
    }

    fun check_version(arg0: &Finance) {
        assert!(arg0.version == 17, 12);
    }

    public entry fun claim<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    fun claim_internal<T0>(arg0: address, arg1: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::ProfitCS, arg2: &mut 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: bool) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let (v2, v3, v4, v5, v6) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::calculate_rewards(arg2, arg1, 0x2::clock::timestamp_ms(arg3));
        let (v7, _, _, _) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::profit_config_value(v6);
        if (arg5) {
            assert!(v2 > 0, 4);
        };
        if (v2 > 0) {
            0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::claim_reward(arg2, v5);
            let v11 = v2 - v3;
            v1 = v11;
            let v12 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg4, v11, false);
            v0 = v12;
            let v13 = Claim{
                stake_id     : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::investment_id(arg2),
                claim_reward : v2,
                claim_amount : v12,
                subsidy      : v4,
                claim_fee    : v3,
                sender       : arg0,
            };
            0x2::event::emit<Claim>(v13);
        };
        (v0, v7, v1)
    }

    public entry fun claim_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun claim_v3<T0>(arg0: &mut Finance, arg1: &mut EcoConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun close_mmt_pool_position<T0>(arg0: &FinanceCap, arg1: &mut MMTPool<T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 17);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::close_position(0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position), arg2, arg3);
    }

    public entry fun create_mmt_pool<T0>(arg0: &FinanceCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MMTPool<T0>{
            id           : 0x2::object::new(arg1),
            position     : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(),
            balance_usdc : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<MMTPool<T0>>(v0);
    }

    public entry fun create_mmt_pool_position<T0>(arg0: &FinanceCap, arg1: &mut MMTPool<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u16, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 16);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::open_position<0x2::sui::SUI, T0>(arg2, arg3, arg4, arg5, arg6));
    }

    public fun eco_receipt(arg0: &EcoConfig) : address {
        arg0.eco_receipt
    }

    public entry fun fix_invt_value(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: u64, arg4: address) {
        check_version(arg1);
        assert!(valid_user(arg1, arg4), 13);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&arg1.investment_table, arg4), 2);
        let v0 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&mut arg1.investment_table, arg4);
        assert!(0x2::linked_table::contains<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v0, arg2), 7);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::fix_investment_value(0x2::linked_table::borrow_mut<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v0, arg2), arg3);
    }

    public entry fun fix_invt_value_batch(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<address>) {
        check_version(arg1);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3) && v0 == 0x1::vector::length<address>(&arg4), 5);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            let v3 = *0x1::vector::borrow<address>(&arg4, v1);
            assert!(valid_user(arg1, v3), 13);
            assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&arg1.investment_table, v3), 2);
            let v4 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&mut arg1.investment_table, v3);
            assert!(0x2::linked_table::contains<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v4, v2), 7);
            0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::fix_investment_value(0x2::linked_table::borrow_mut<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v4, v2), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    public fun get_divide_list(arg0: &SUIPool) : &vector<TopupDivideItem> {
        0x2::dynamic_field::borrow<u64, vector<TopupDivideItem>>(&arg0.id, 1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = FinanceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FinanceCap>(v1, v0);
        let v2 = Finance{
            id               : 0x2::object::new(arg0),
            pcs              : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::create_profit_cs(86400000),
            users            : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::create_user_pool(@0xcb579b13d314cf4fc1e1ea9115700ad7b5956b18c2880fbe6b9b38d168f441c6, arg0),
            balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            investment_id    : 0,
            investment_table : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(arg0),
            version          : 17,
        };
        let v3 = vector[700, 600, 500, 400, 300, 200, 200];
        let v4 = vector[50, 55, 60, 70, 85, 100, 130];
        let v5 = vector[1, 8, 16, 31, 61, 91, 181];
        let v6 = vector[7, 15, 30, 60, 90, 180, 9999999];
        let v7 = &mut v2.pcs;
        let v8 = 0;
        while (v8 < 0x1::vector::length<u64>(&v3)) {
            0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::add_profict_config(v7, *0x1::vector::borrow<u64>(&v3, v8), *0x1::vector::borrow<u64>(&v4, v8), *0x1::vector::borrow<u64>(&v5, v8), *0x1::vector::borrow<u64>(&v6, v8));
            v8 = v8 + 1;
        };
        0x2::transfer::public_share_object<Finance>(v2);
        let v9 = UnStakeConfig{
            id          : 0x2::object::new(arg0),
            hashrate_id : 0,
            hr_rate     : 2000,
        };
        0x2::transfer::public_share_object<UnStakeConfig>(v9);
        let v10 = EcoConfig{
            id           : 0x2::object::new(arg0),
            eco_sequence : 0,
            eco_receipt  : v0,
            black_list   : 0x2::table::new<address, bool>(arg0),
            black_list2  : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::public_share_object<EcoConfig>(v10);
        let v11 = SUIPool{
            id       : 0x2::object::new(arg0),
            sequence : 0,
            receipt  : v0,
            version  : 17,
        };
        0x2::transfer::public_share_object<SUIPool>(v11);
    }

    public entry fun init_investment_list(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>) {
        check_version(arg1);
        let v0 = if (0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3)) {
            if (0x1::vector::length<u64>(&arg3) == 0x1::vector::length<u64>(&arg4)) {
                0x1::vector::length<u64>(&arg4) == 0x1::vector::length<u64>(&arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 5);
        let v1 = &mut arg1.pcs;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::add_profict_config(v1, *0x1::vector::borrow<u64>(&arg2, v2), *0x1::vector::borrow<u64>(&arg3, v2), *0x1::vector::borrow<u64>(&arg4, v2), *0x1::vector::borrow<u64>(&arg5, v2));
            v2 = v2 + 1;
        };
    }

    public entry fun invt_info(arg0: &Finance, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        check_version(arg0);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&arg0.investment_table, arg1), 8);
        let v0 = 0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&arg0.investment_table, arg1);
        assert!(0x2::linked_table::contains<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v0, arg2), 9);
        let v1 = 0x2::linked_table::borrow<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v0, arg2);
        let (v2, v3, v4, v5, _) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::investment_value(v1);
        let (v7, v8, _, v10, v11) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::calculate_rewards(v1, &arg0.pcs, 0x2::clock::timestamp_ms(arg3));
        let (v12, v13, _, _) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::profit_config_value(v11);
        let v16 = InvtInfo{
            id                 : v2,
            amount             : v3,
            fee_rate           : v12,
            profit_rate        : v13,
            lock_period        : v10,
            claimable_reward   : v7,
            claim_fee          : v8,
            lock_time          : v4,
            start_release_time : v5,
        };
        0x2::event::emit<InvtInfo>(v16);
    }

    public fun is_black_user(arg0: &EcoConfig, arg1: address, arg2: bool) : bool {
        let v0 = if (arg2) {
            &arg0.black_list
        } else {
            &arg0.black_list2
        };
        0x2::table::contains<address, bool>(v0, arg1) && *0x2::table::borrow<address, bool>(v0, arg1)
    }

    public entry fun migrate(arg0: &mut FinanceCap, arg1: &mut Finance) {
        assert!(arg1.version < 17, 11);
        arg1.version = 17;
    }

    public entry fun migrate_sui_pool(arg0: &FinanceCap, arg1: &mut SUIPool) {
        assert!(arg1.version < 17, 11);
        arg1.version = 17;
    }

    public entry fun modify_black_state(arg0: &FinanceCap, arg1: &mut EcoConfig, arg2: address, arg3: bool, arg4: bool) {
        assert!(arg3 != is_black_user(arg1, arg2, arg4), 14);
        let v0 = if (arg4) {
            &mut arg1.black_list
        } else {
            &mut arg1.black_list2
        };
        if (arg3) {
            if (0x2::table::contains<address, bool>(v0, arg2)) {
                *0x2::table::borrow_mut<address, bool>(v0, arg2) = true;
            } else {
                0x2::table::add<address, bool>(v0, arg2, true);
            };
        } else if (0x2::table::contains<address, bool>(v0, arg2)) {
            0x2::table::remove<address, bool>(v0, arg2);
        };
        let v1 = UserStateUpdate{
            user  : arg2,
            black : arg3,
            v1    : arg4,
        };
        0x2::event::emit<UserStateUpdate>(v1);
    }

    public entry fun modify_eco_receipt(arg0: &FinanceCap, arg1: &mut EcoConfig, arg2: address) {
        arg1.eco_receipt = arg2;
    }

    public(friend) fun new_eco_event(arg0: &mut EcoConfig, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: bool) {
        let v0 = arg0.eco_sequence + 1;
        arg0.eco_sequence = v0;
        let v1 = NewEco{
            id       : v0,
            stake_id : arg1,
            eco_type : arg2,
            amount   : arg3,
            value    : arg4,
            v1       : arg5,
        };
        0x2::event::emit<NewEco>(v1);
    }

    public entry fun recharge_balance_pool(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public entry fun remove_mmt_pool_liquidity<T0>(arg0: &FinanceCap, arg1: &mut Finance, arg2: &mut MMTPool<T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position), 17);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::remove_liquidity_and_buy<0x2::sui::SUI, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position), arg4, (arg6 as u128), 0x2::balance::split<T0>(&mut arg2.balance_usdc, 0x2::balance::value<T0>(&arg2.balance_usdc)), arg5, arg7));
    }

    public entry fun reward(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 5);
        let v1 = 0;
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, *0x1::vector::borrow<u64>(&arg3, v1)), arg4), *0x1::vector::borrow<address>(&arg2, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun set_divide_list(arg0: &FinanceCap, arg1: &mut SUIPool, arg2: vector<address>, arg3: vector<u64>) {
        check_suipool_version(arg1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 32);
        let v0 = 1;
        if (0x2::dynamic_field::exists_<u64>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<u64, vector<TopupDivideItem>>(&mut arg1.id, v0);
            let v2 = 0x1::vector::length<TopupDivideItem>(v1);
            while (v2 > 0) {
                0x1::vector::pop_back<TopupDivideItem>(v1);
                v2 = v2 - 1;
            };
            let v3 = 0;
            while (v3 < 0x1::vector::length<address>(&arg2)) {
                let v4 = TopupDivideItem{
                    user  : *0x1::vector::borrow<address>(&arg2, v3),
                    value : *0x1::vector::borrow<u64>(&arg3, v3),
                };
                0x1::vector::push_back<TopupDivideItem>(v1, v4);
                v3 = v3 + 1;
            };
        } else {
            let v5 = 0x1::vector::empty<TopupDivideItem>();
            let v6 = 0;
            while (v6 < 0x1::vector::length<address>(&arg2)) {
                let v7 = TopupDivideItem{
                    user  : *0x1::vector::borrow<address>(&arg2, v6),
                    value : *0x1::vector::borrow<u64>(&arg3, v6),
                };
                0x1::vector::push_back<TopupDivideItem>(&mut v5, v7);
                v6 = v6 + 1;
            };
            0x2::dynamic_field::add<u64, vector<TopupDivideItem>>(&mut arg1.id, v0, v5);
        };
    }

    public entry fun stake<T0>(arg0: &mut Finance, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun stake_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun stake_v3<T0>(arg0: &mut Finance, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 444
    }

    public entry fun topup<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SUIPool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun topup_v2<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut SUIPool, arg2: &mut Finance, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        check_suipool_version(arg1);
        check_version(arg2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = get_divide_list(arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<TopupDivideItem>(v1)) {
            let v3 = 0x1::vector::borrow<TopupDivideItem>(v1, v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v0 * v3.value / 10000, arg4), v3.user);
            v2 = v2 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v4 = arg1.sequence + 1;
        arg1.sequence = v4;
        let v5 = TopUpSui{
            id     : v4,
            amount : v0,
            value  : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg0, v0, true),
            user   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TopUpSui>(v5);
    }

    public entry fun unstake<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_force<T0>(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_force_v2<T0>(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_force_v3<T0>(arg0: &mut FinanceCap, arg1: &mut Finance, arg2: &mut UnStakeConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        unstake_internal<T0>(arg1, arg2, arg3, arg4, arg5, arg7, 0x1::option::some<address>(arg6));
    }

    fun unstake_internal<T0>(arg0: &mut Finance, arg1: &mut UnStakeConfig, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg5: &mut 0x2::tx_context::TxContext, arg6: 0x1::option::Option<address>) {
        check_version(arg0);
        let v0 = if (0x1::option::is_none<address>(&arg6)) {
            0x2::tx_context::sender(arg5)
        } else {
            0x1::option::extract<address>(&mut arg6)
        };
        assert!(valid_user(arg0, v0), 13);
        assert!(0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&arg0.investment_table, v0), 3);
        let v1 = 0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>>(&mut arg0.investment_table, v0);
        assert!(0x2::linked_table::contains<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v1, arg2), 9);
        let v2 = 0x2::linked_table::borrow_mut<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v1, arg2);
        let (v3, v4, _) = claim_internal<T0>(v0, &arg0.pcs, v2, arg3, arg4, false);
        let (v6, v7, _, _, _) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::investment_value(v2);
        0x2::linked_table::remove<u64, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::investment::Investment>(v1, v6);
        let v11 = v7 * v4 / 10000;
        let v12 = (v7 - v11) * arg1.hr_rate / 10000;
        let v13 = v7 - v11 - v12;
        let v14 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg4, v13, false);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3 + v14, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v3 + v14), arg5), v0);
        let v15 = Unstake{
            id             : arg2,
            recover_amount : v14,
            sender         : v0,
        };
        0x2::event::emit<Unstake>(v15);
        let v16 = UnstakeV3{
            id                  : arg2,
            usdt_amount         : v7,
            usdt_fee_amount     : v11,
            usdt_hr_amount      : v12,
            usdt_recover_amount : v13,
            sui_recover_amount  : v14,
        };
        0x2::event::emit<UnstakeV3>(v16);
        if (v12 > 0) {
            let v17 = arg1.hashrate_id + 1;
            arg1.hashrate_id = v17;
            let v18 = NewHashrate{
                id     : v17,
                amount : v12,
                user   : v0,
                typ    : 1,
            };
            0x2::event::emit<NewHashrate>(v18);
        };
    }

    public entry fun unstake_v2<T0>(arg0: &mut Finance, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<0x2::sui::SUI, T0>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun unstake_v3<T0>(arg0: &mut Finance, arg1: &mut UnStakeConfig, arg2: &mut EcoConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg6: &mut 0x2::tx_context::TxContext) {
        abort 111
    }

    public entry fun update_topup_sui_receipt(arg0: &FinanceCap, arg1: &mut SUIPool, arg2: address) {
        arg1.receipt = arg2;
    }

    public entry fun update_topup_sui_sequence(arg0: &FinanceCap, arg1: &mut SUIPool, arg2: u64) {
        arg1.sequence = arg2;
    }

    public entry fun update_unstake_hr_rate(arg0: &FinanceCap, arg1: &mut UnStakeConfig, arg2: u64) {
        arg1.hr_rate = arg2;
    }

    public fun user_info(arg0: &Finance, arg1: address) {
        check_version(arg0);
        let v0 = UserInfo{
            root    : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::root(&arg0.users),
            user    : arg1,
            inviter : 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::find_inviter(&arg0.users, arg1),
        };
        0x2::event::emit<UserInfo>(v0);
    }

    public fun valid_user(arg0: &Finance, arg1: address) : bool {
        check_version(arg0);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::invite::valid_user(&arg0.users, arg1)
    }

    // decompiled from Move bytecode v6
}

