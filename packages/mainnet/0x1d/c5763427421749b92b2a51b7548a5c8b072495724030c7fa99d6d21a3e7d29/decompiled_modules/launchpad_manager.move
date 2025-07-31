module 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager {
    struct LaunchpadManager has key {
        id: 0x2::object::UID,
        whitelist: vector<address>,
        project: 0x2::table::Table<address, address>,
        launchpool_coin_type: 0x1::type_name::TypeName,
        initial_price: u128,
        tick_spacing: u32,
        tick_lower_idx: u32,
        tick_upper_idx: u32,
        target_funds: u64,
    }

    struct LaunchPool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct PayNft has key {
        id: 0x2::object::UID,
        status: u8,
        owner: address,
        count: u64,
        amount: u64,
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

    public fun change_pay_nft(arg0: &mut PayNft, arg1: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchAdmin) {
        assert!(arg0.status == 0, 4);
        arg0.status = 2;
    }

    public fun get_target_funds(arg0: &LaunchpadManager) : u64 {
        arg0.target_funds
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchpadManager{
            id                   : 0x2::object::new(arg0),
            whitelist            : 0x1::vector::empty<address>(),
            project              : 0x2::table::new<address, address>(arg0),
            launchpool_coin_type : 0x1::type_name::get<0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::ai::AI>(),
            initial_price        : 8249634742471189717580,
            tick_spacing         : 200,
            tick_lower_idx       : 4294523696,
            tick_upper_idx       : 443600,
            target_funds         : 2000000,
        };
        0x2::transfer::share_object<LaunchpadManager>(v0);
    }

    public entry fun pay_launch_fee<T0>(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchpadManagerConfig, arg1: &LaunchpadManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut LaunchPool<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        assert!(0x1::type_name::get<T0>() == arg1.launchpool_coin_type, 2);
        let v1 = 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::get_launchpad_fee(arg0);
        assert!(0x2::coin::value<T0>(&arg2) == v1, 1);
        0x2::balance::join<T0>(&mut arg4.balance, 0x2::coin::into_balance<T0>(arg2));
        let v2 = LaunchFeePaidEvent{
            nft_id : 0x2::object::uid_to_inner(&v0),
            amount : v1,
            count  : arg3,
            owner  : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LaunchFeePaidEvent>(v2);
        let v3 = PayNft{
            id     : v0,
            status : 0,
            owner  : 0x2::tx_context::sender(arg5),
            count  : arg3,
            amount : v1,
        };
        0x2::transfer::share_object<PayNft>(v3);
    }

    public entry fun project_succeed<T0, T1>(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &0x2::coin::CoinMetadata<T1>, arg2: &0x2::coin::CoinMetadata<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &LaunchpadManager, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg6: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchpadManagerConfig, arg7: &mut 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::ProjectManager<T0>, arg8: &mut 0x2::coin::Coin<T1>, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::get_project_status<T0>(arg7) == 1, 0);
        let v0 = 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::get_project_total_funds<T0>(arg7, arg11);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = (((v1 as u128) * (0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::get_add_liquidity_rate(arg6) as u128) / 100) as u64);
        assert!(v2 <= v1, 1);
        let (v3, v4, v5) = 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::cetus::cetus_add_initial_liquidity<T0, T1>(arg3, arg5, arg4.tick_spacing, arg4.initial_price, arg9, arg4.tick_lower_idx, arg4.tick_upper_idx, 0x2::coin::split<T0>(&mut v0, v2, arg11), 0x2::coin::split<T1>(arg8, (((v2 as u128) * (10000 as u128)) as u64) / 50, arg11), arg2, arg1, false, arg10, arg11);
        let v6 = v3;
        0x2::coin::join<T0>(&mut v0, v4);
        0x2::coin::join<T1>(arg8, v5);
        let v7 = 0x2::coin::value<T1>(arg8);
        let v8 = ProjectSucceededEvent{
            project_id   : 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::get_project_manager_id<T0>(arg7),
            owner        : 0x2::tx_context::sender(arg11),
            pool_id      : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v6),
            count        : 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::project_manager::get_project_count<T0>(arg7),
            wallet_id    : 0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::milestone::new_wallet<T0, T1>(0x2::coin::split<T1>(arg8, v7, arg11), v0, 0, arg7, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v6), arg11),
            token_type   : 0x1::type_name::get<T1>(),
            token_amount : v7,
            usda_amount  : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<ProjectSucceededEvent>(v8);
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v6, 0x2::tx_context::sender(arg11));
    }

    public entry fun repay_launch_fee<T0>(arg0: &mut LaunchpadManager, arg1: PayNft, arg2: &mut LaunchPool<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let PayNft {
            id     : v0,
            status : v1,
            owner  : v2,
            count  : v3,
            amount : v4,
        } = arg1;
        let v5 = v0;
        assert!(v2 == 0x2::tx_context::sender(arg3), 5);
        assert!(v1 == 2, 3);
        assert!(0x1::type_name::get<T0>() == arg0.launchpool_coin_type, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v4, arg3), 0x2::tx_context::sender(arg3));
        let v6 = LaunchFeeRepaidEvent{
            nft_id : 0x2::object::uid_to_inner(&v5),
            amount : v4,
            count  : v3,
            owner  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<LaunchFeeRepaidEvent>(v6);
        0x2::object::delete(v5);
    }

    public fun set_initial_price(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u128) {
        arg1.initial_price = arg2;
    }

    public fun set_launchpool_coin_type<T0>(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.launchpool_coin_type = 0x1::type_name::get<T0>();
        let v0 = LaunchPool<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<LaunchPool<T0>>(v0);
    }

    public fun set_tick_lower_idx(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_lower_idx = arg2;
    }

    public fun set_tick_spacing(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_spacing = arg2;
    }

    public fun set_tick_upper_idx(arg0: &0x1dc5763427421749b92b2a51b7548a5c8b072495724030c7fa99d6d21a3e7d29::launchpad_manager_config::LaunchManagerAdmin, arg1: &mut LaunchpadManager, arg2: u32) {
        arg1.tick_upper_idx = arg2;
    }

    // decompiled from Move bytecode v6
}

