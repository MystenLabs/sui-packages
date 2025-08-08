module 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager {
    struct LaunchpadManager has key {
        id: 0x2::object::UID,
        whitelist: vector<address>,
        launchpool_coin_type: 0x1::type_name::TypeName,
        initial_price: 0x2::table::Table<u8, u128>,
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
        usda_amount: u64,
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

    public fun get_target_funds(arg0: &LaunchpadManager) : u64 {
        arg0.target_funds
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<u8, u128>(arg0);
        0x2::table::add<u8, u128>(&mut v0, 0, 4518511039629792451);
        0x2::table::add<u8, u128>(&mut v0, 1, 4518511039629792451);
        0x2::table::add<u8, u128>(&mut v0, 2, 4518511039629792451);
        let v1 = LaunchpadManager{
            id                   : 0x2::object::new(arg0),
            whitelist            : 0x1::vector::empty<address>(),
            launchpool_coin_type : 0x1::type_name::get<0x2::sui::SUI>(),
            initial_price        : v0,
            tick_spacing         : 200,
            tick_lower_idx       : 4294523696,
            tick_upper_idx       : 443600,
            target_funds         : 54000,
        };
        0x2::transfer::share_object<LaunchpadManager>(v1);
    }

    public entry fun pay_launch_fee<T0>(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchpadManagerConfig, arg1: &LaunchpadManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut LaunchPool<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() == arg1.launchpool_coin_type, 2);
        let v0 = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::get_launchpad_fee(arg0);
        assert!(0x2::coin::value<T0>(&arg2) == v0, 1);
        0x2::balance::join<T0>(&mut arg4.balance, 0x2::coin::into_balance<T0>(arg2));
        let v1 = LaunchFeePaidEvent{
            nft_id : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::share_pay_nft(0, 0x2::tx_context::sender(arg5), arg3, v0, arg5),
            amount : v0,
            count  : arg3,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LaunchFeePaidEvent>(v1);
    }

    public entry fun project_succeed<T0, T1>(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &LaunchpadManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchpadManagerConfig, arg7: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::VestingConfig, arg8: &mut 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::ProjectManager<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::get_project_status<T0>(arg8) == 1, 0);
        let v0 = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::get_project_total_funds<T0>(arg8, arg12);
        let v1 = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::get_project_manager_level<T0>(arg8);
        let (v2, _, _) = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::get_lanch_config_by_level(v1, arg6);
        let (v5, v6, v7) = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::cetus::cetus_add_initial_liquidity<T1, T0>(arg3, arg5, arg4.tick_spacing, *0x2::table::borrow<u8, u128>(&arg4.initial_price, v1), arg10, arg4.tick_lower_idx, arg4.tick_upper_idx, 0x2::coin::split<T1>(arg9, (((0x2::coin::value<T1>(arg9) as u128) * (v2 as u128) / 100) as u64), arg12), v0, arg1, arg2, true, arg11, arg12);
        let v8 = v5;
        0x2::coin::join<T1>(arg9, v6);
        let v9 = 0x2::coin::value<T1>(arg9);
        let v10 = ProjectSucceededEvent{
            project_id               : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::get_project_manager_id<T0>(arg8),
            owner                    : 0x2::tx_context::sender(arg12),
            pool_id                  : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v8),
            count                    : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::get_project_count<T0>(arg8),
            wallet_id                : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::new_wallet<T0, T1>(0x2::coin::split<T1>(arg9, v9, arg12), v7, 0, arg8, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v8), arg12),
            token_type               : 0x1::type_name::get<T1>(),
            token_amount             : v9,
            usda_amount              : 0x2::coin::value<T0>(&v0),
            milestone_round          : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::get_rounds(v1, arg7),
            milestone_prices         : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::get_milestone_prices(v1, arg7),
            milestone_total_unlocked : 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::milestone::get_milestone_total_unlocked(v1, arg7),
        };
        0x2::event::emit<ProjectSucceededEvent>(v10);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v8, 0x2::tx_context::sender(arg12));
    }

    public entry fun repay_launch_fee<T0>(arg0: &mut LaunchpadManager, arg1: 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::PayNft, arg2: &mut LaunchPool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3, v4) = 0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::project_manager::burn_pay_nft(arg1);
        assert!(v2 == 0x2::tx_context::sender(arg3), 5);
        assert!(v1 == 1, 3);
        assert!(0x1::type_name::get<T0>() == arg0.launchpool_coin_type, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v3, arg3), 0x2::tx_context::sender(arg3));
        let v5 = LaunchFeeRepaidEvent{
            nft_id : v0,
            amount : v3,
            count  : v4,
            owner  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LaunchFeeRepaidEvent>(v5);
    }

    public fun set_initial_price(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u8, arg3: u128) {
        *0x2::table::borrow_mut<u8, u128>(&mut arg1.initial_price, arg2) = arg3;
    }

    public fun set_launchpool_coin_type<T0>(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.launchpool_coin_type = 0x1::type_name::get<T0>();
        let v0 = LaunchPool<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<LaunchPool<T0>>(v0);
    }

    public fun set_tick_lower_idx(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_lower_idx = arg2;
    }

    public fun set_tick_spacing(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_spacing = arg2;
    }

    public fun set_tick_upper_idx(arg0: &0xc715de3c5a5f899b7e1bfc796ea8bc244711d17710cadcf860fdfaebe98ec3f9::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_upper_idx = arg2;
    }

    // decompiled from Move bytecode v6
}

