module 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager {
    struct LaunchpadManager has key {
        id: 0x2::object::UID,
        version: u64,
        whitelist: vector<address>,
        launchpool_coin_type: vector<0x1::type_name::TypeName>,
        initial_price: 0x2::table::Table<u8, u128>,
        project_counts: vector<u64>,
        tick_spacing: u32,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
        target_funds: u64,
    }

    struct LaunchPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ProjectSucceededEvent has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        pool_id: 0x2::object::ID,
        count: u64,
        wallet_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        token_amount: u64,
        base_amount: u64,
        total_supply: u64,
        milestone_round: u8,
        milestone_prices: vector<u64>,
        milestone_total_unlocked: vector<u64>,
    }

    struct LaunchFeePaidEvent has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        count: u64,
        owner: address,
    }

    struct LaunchFeeRepaidEvent has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        count: u64,
        owner: address,
    }

    struct TickSpacingChangedEvent has copy, drop {
        last_tick_spacing: u32,
        current_tick_spacing: u32,
    }

    struct TickLowerIdxChangedEvent has copy, drop {
        last_tick_lower_idx: u32,
        current_tick_lower_idx: u32,
    }

    struct TickUpperIdxChangedEvent has copy, drop {
        last_tick_upper_idx: u32,
        current_tick_upper_idx: u32,
    }

    struct LaunchpoolCoinTypeSetEvent has copy, drop {
        current_launchpool_coin_type: vector<0x1::type_name::TypeName>,
    }

    struct InitialPriceChangedEvent has copy, drop {
        last_initial_price: u128,
        current_initial_price: u128,
    }

    struct VersionUpdatedEvent has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public(friend) fun assert_version(arg0: &LaunchpadManager) {
        assert!(arg0.version == 1, 9);
    }

    public fun get_target_funds(arg0: &LaunchpadManager) : u64 {
        arg0.target_funds
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, u128>(arg0);
        0x2::table::add<u8, u128>(&mut v0, 1, 4518511039629792451);
        0x2::table::add<u8, u128>(&mut v0, 0, 4518511039629792451);
        0x2::table::add<u8, u128>(&mut v0, 2, 4518511039629792451);
        let v1 = LaunchpadManager{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            whitelist            : 0x1::vector::empty<address>(),
            launchpool_coin_type : 0x1::vector::empty<0x1::type_name::TypeName>(),
            initial_price        : v0,
            project_counts       : 0x1::vector::empty<u64>(),
            tick_spacing         : 2,
            tick_lower_idx       : 4294523696,
            tick_upper_idx       : 443600,
            target_funds         : 540000000,
        };
        0x2::transfer::share_object<LaunchpadManager>(v1);
    }

    public(friend) fun migrate(arg0: &mut LaunchpadManager) {
        assert!(arg0.version < 1, 9);
        let v0 = VersionUpdatedEvent{
            old_version : arg0.version,
            new_version : 1,
        };
        0x2::event::emit<VersionUpdatedEvent>(v0);
        arg0.version = 1;
    }

    public entry fun pay_launch_fee<T0>(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchpadManagerConfig, arg1: &mut LaunchpadManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut LaunchPool<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert_version(arg1);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.launchpool_coin_type, &v0), 2);
        assert!(!0x1::vector::contains<u64>(&arg1.project_counts, &arg3), 7);
        0x1::vector::push_back<u64>(&mut arg1.project_counts, arg3);
        let v1 = 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::get_launchpad_fee(arg0);
        assert!(0x2::coin::value<T0>(&arg2) == v1, 1);
        0x2::balance::join<T0>(&mut arg4.balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = LaunchFeePaidEvent{
            nft_id : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::share_pay_nft<T0>(0, 0x2::tx_context::sender(arg5), arg3, v1, arg5),
            amount : v1,
            count  : arg3,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LaunchFeePaidEvent>(v2);
    }

    public fun project_succeed<T0, T1>(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchAdmin, arg1: &mut 0x12d73de9a6bc3cb658ec9dc0fe7de2662be1cea5c76c092fcc3606048cdbac27::lp_burn::BurnManager, arg2: &0x2::coin::CoinMetadata<T1>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &LaunchpadManager, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchpadManagerConfig, arg8: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::VestingConfig, arg9: &mut 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::ProjectManager<T0>, arg10: &mut 0x2::coin::Coin<T1>, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert_version(arg5);
        assert!(0x2::coin::value<T1>(arg10) > 0, 10);
        assert!(0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_status<T0>(arg9) == 1, 0);
        let v0 = 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_manager_level<T0>(arg9);
        let (v1, _, _) = 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::get_launch_config_by_level(v0, arg7);
        let v4 = 0x2::table::borrow<u8, u128>(&arg5.initial_price, v0);
        let v5 = 0x2::coin::value<T1>(arg10);
        assert!(v5 == 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_total_supply<T0>(arg9), 10);
        let (v6, v7, v8) = 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::cetus::cetus_add_initial_liquidity<T1, T0>(arg4, arg6, arg5.tick_spacing, *v4, arg11, arg5.tick_lower_idx, arg5.tick_upper_idx, 0x2::coin::split<T1>(arg10, (((v5 as u128) * (v1 as u128) / 100) as u64), arg13), 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_total_funds<T0>(arg9, arg13), arg2, arg3, true, arg12, arg13);
        let v9 = v8;
        let v10 = v6;
        0x2::coin::join<T1>(arg10, v7);
        let v11 = 0x2::coin::value<T1>(arg10);
        let v12 = ProjectSucceededEvent{
            project_id               : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_manager_id<T0>(arg9),
            owner                    : 0x2::tx_context::sender(arg13),
            pool_id                  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v10),
            count                    : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::get_project_count<T0>(arg9),
            wallet_id                : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::new_wallet<T0, T1>(0x2::coin::split<T1>(arg10, v11, arg13), v9, 0, arg9, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v10), arg13),
            token_type               : 0x1::type_name::get<T1>(),
            token_amount             : v11,
            base_amount              : 0x2::coin::value<T0>(&v9),
            total_supply             : v5,
            milestone_round          : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::get_rounds(v0, arg8),
            milestone_prices         : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::get_milestone_prices(v0, arg8),
            milestone_total_unlocked : 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::milestone::get_milestone_total_unlocked(v0, arg8),
        };
        0x2::event::emit<ProjectSucceededEvent>(v12);
        0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::cetus::burn_lp_token(arg1, v10, arg13);
    }

    public entry fun repay_launch_fee<T0>(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::PayNft, arg3: &mut LaunchPool<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4, v5) = 0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::project_manager::burn_pay_nft(arg2);
        let v6 = 0x1::type_name::get<T0>();
        assert_version(arg1);
        assert!(v1 == 1, 3);
        assert!(v5 == v6, 8);
        assert!(0x1::vector::contains<0x1::type_name::TypeName>(&arg1.launchpool_coin_type, &v6), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg3.balance, v4, arg4), v2);
        let v7 = LaunchFeeRepaidEvent{
            nft_id : v0,
            amount : v4,
            count  : v3,
            owner  : v2,
        };
        0x2::event::emit<LaunchFeeRepaidEvent>(v7);
    }

    public fun set_initial_price(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u8, arg3: u128) {
        let v0 = 0x2::table::borrow_mut<u8, u128>(&mut arg1.initial_price, arg2);
        let v1 = InitialPriceChangedEvent{
            last_initial_price    : *v0,
            current_initial_price : arg3,
        };
        0x2::event::emit<InitialPriceChangedEvent>(v1);
        *v0 = arg3;
    }

    public fun set_launchpool_coin_type<T0>(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg1.launchpool_coin_type, &v0), 6);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.launchpool_coin_type, 0x1::type_name::get<T0>());
        let v1 = LaunchPool<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<LaunchPool<T0>>(v1);
        let v2 = LaunchpoolCoinTypeSetEvent{current_launchpool_coin_type: arg1.launchpool_coin_type};
        0x2::event::emit<LaunchpoolCoinTypeSetEvent>(v2);
    }

    public fun set_tick_lower_idx(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        let v0 = TickLowerIdxChangedEvent{
            last_tick_lower_idx    : arg1.tick_lower_idx,
            current_tick_lower_idx : arg2,
        };
        0x2::event::emit<TickLowerIdxChangedEvent>(v0);
        arg1.tick_lower_idx = arg2;
    }

    public fun set_tick_spacing(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        let v0 = TickSpacingChangedEvent{
            last_tick_spacing    : arg1.tick_spacing,
            current_tick_spacing : arg2,
        };
        0x2::event::emit<TickSpacingChangedEvent>(v0);
        arg1.tick_spacing = arg2;
    }

    public fun set_tick_upper_idx(arg0: &0x754291c8585850ddff95fffd799aa97ae9c38c553e792bf6fa352335b5b7e476::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        let v0 = TickUpperIdxChangedEvent{
            last_tick_upper_idx    : arg1.tick_upper_idx,
            current_tick_upper_idx : arg2,
        };
        0x2::event::emit<TickUpperIdxChangedEvent>(v0);
        arg1.tick_upper_idx = arg2;
    }

    // decompiled from Move bytecode v6
}

