module 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::boost {
    struct BTC has drop {
        dummy_field: bool,
    }

    struct USDT has drop {
        dummy_field: bool,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct SUI has drop {
        dummy_field: bool,
    }

    struct ETH has drop {
        dummy_field: bool,
    }

    struct MATIC has drop {
        dummy_field: bool,
    }

    struct ARB has drop {
        dummy_field: bool,
    }

    struct OP has drop {
        dummy_field: bool,
    }

    struct WormholeUSDC has drop {
        dummy_field: bool,
    }

    struct AVAX has drop {
        dummy_field: bool,
    }

    struct BNB has drop {
        dummy_field: bool,
    }

    struct BoostReserves has key {
        id: 0x2::object::UID,
        caps: 0x2::bag::Bag,
        reserves: 0x2::bag::Bag,
    }

    struct UserRewardInfo has drop, store {
        last_update_reward_index: u256,
        unclaimed_balance: u256,
        claimed_balance: u256,
    }

    struct RewardPoolInfo has store, key {
        id: 0x2::object::UID,
        escrow_fund: 0x2::object::ID,
        start_time: u256,
        end_time: u256,
        reward_index: u256,
        reward_action: u8,
        total_reward: u64,
        dola_pool_id: u16,
        last_update_time: u256,
        reward_per_second: u256,
        user_reward: 0x2::table::Table<u64, UserRewardInfo>,
    }

    struct RewardPoolInfos has store {
        info: vector<RewardPoolInfo>,
        catalog: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct RewardPool<phantom T0> has key {
        id: 0x2::object::UID,
        associate_pool: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct RewardPoolId has copy, drop, store {
        dola_pool_id: u16,
    }

    struct UpdatePoolRewardEvent has copy, drop {
        dola_pool_id: u16,
        old_timestamp: u256,
        new_timestamp: u256,
        old_reward_index: u256,
        new_reward_index: u256,
    }

    struct UpdateUserRewardEvent has copy, drop {
        dola_pool_id: u16,
        dola_user_id: u64,
        old_unclaimed_balance: u256,
        new_unclaimed_balance: u256,
        old_reward_index: u256,
        new_reward_index: u256,
    }

    struct ClaimRewardEvent has copy, drop {
        token: 0x1::ascii::String,
        dola_pool_id: u16,
        dola_user_id: u64,
        reward_action: u8,
        amount: u64,
        sender: address,
    }

    struct MintBoostCoinEvent has copy, drop {
        dola_pool_id: u16,
        total_supply: u64,
        mint_amount: u64,
    }

    struct BurnBoostCoinEvent has copy, drop {
        dola_pool_id: u16,
        total_supply: u64,
        burn_amount: u64,
    }

    struct DepositBoostCoinEvent has copy, drop {
        dola_pool_id: u16,
        reserve: u64,
        deposit_amount: u64,
    }

    struct WithdrawBoostCoinEvent has copy, drop {
        dola_pool_id: u16,
        reserve: u64,
        withdraw_amount: u64,
    }

    public(friend) fun boost_pool(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8, arg4: &0x2::clock::Clock) {
        let v0 = arg3;
        if (arg3 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_withdraw_type()) {
            v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_supply_type();
        } else if (arg3 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_repay_type()) {
            v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_borrow_type();
        };
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_storage_id(arg0);
        let v2 = RewardPoolId{dola_pool_id: arg1};
        if (0x2::dynamic_field::exists_<RewardPoolId>(v1, v2)) {
            let v3 = 0x2::dynamic_field::borrow_mut<RewardPoolId, RewardPoolInfos>(v1, v2);
            let v4 = 0;
            while (v4 < 0x1::vector::length<RewardPoolInfo>(&v3.info)) {
                let v5 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut v3.info, v4);
                assert!(arg1 == v5.dola_pool_id, 3);
                if (v0 == v5.reward_action) {
                    update_pool_reward(v5, get_total_scaled_balance(arg0, arg1, v0), arg4);
                    update_user_reward(v5, get_user_scaled_balance(arg0, arg1, arg2, v0), arg2);
                };
                v4 = v4 + 1;
            };
        };
    }

    public(friend) fun burn_boost_coin<T0>(arg0: &mut BoostReserves, arg1: u16, arg2: 0x2::coin::Coin<T0>) {
        let v0 = BurnBoostCoinEvent{
            dola_pool_id : arg1,
            total_supply : 0x2::balance::decrease_supply<T0>(0x2::bag::borrow_mut<u16, 0x2::balance::Supply<T0>>(&mut arg0.caps, arg1), 0x2::coin::into_balance<T0>(arg2)),
            burn_amount  : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<BurnBoostCoinEvent>(v0);
    }

    public(friend) fun check_pool_coin_type<T0>(arg0: &mut BoostReserves, arg1: u16) : bool {
        assert!(0x2::bag::contains<u16>(&arg0.reserves, arg1), 7);
        0x2::bag::contains_with_type<u16, 0x2::balance::Balance<T0>>(&arg0.reserves, arg1)
    }

    public(friend) fun claim<T0>(arg0: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8, arg4: &mut RewardPool<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_storage_id(arg0);
        let v1 = 0x2::coin::zero<T0>(arg6);
        let v2 = RewardPoolId{dola_pool_id: arg1};
        if (0x2::dynamic_field::exists_<RewardPoolId>(v0, v2)) {
            let v3 = 0x2::dynamic_field::borrow_mut<RewardPoolId, RewardPoolInfos>(v0, v2);
            if (0x2::table::contains<0x2::object::ID, u64>(&v3.catalog, arg4.associate_pool)) {
                let v4 = 0x1::vector::borrow_mut<RewardPoolInfo>(&mut v3.info, *0x2::table::borrow<0x2::object::ID, u64>(&v3.catalog, arg4.associate_pool));
                update_pool_reward(v4, get_total_scaled_balance(arg0, arg1, arg3), arg5);
                update_user_reward(v4, get_user_scaled_balance(arg0, arg1, arg2, arg3), arg2);
                let v5 = claim_reward<T0>(v4, arg4, arg2, arg6);
                0x2::coin::join<T0>(&mut v1, v5);
            };
        };
        let v6 = ClaimRewardEvent{
            token         : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            dola_pool_id  : arg1,
            dola_user_id  : arg2,
            reward_action : arg3,
            amount        : 0x2::coin::value<T0>(&v1),
            sender        : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ClaimRewardEvent>(v6);
        v1
    }

    public(friend) fun claim_reward<T0>(arg0: &mut RewardPoolInfo, arg1: &mut RewardPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.escrow_fund == 0x2::object::id<RewardPool<T0>>(arg1), 4);
        assert!(arg1.associate_pool == 0x2::object::id<RewardPoolInfo>(arg0), 4);
        let v0 = 0x2::table::borrow_mut<u64, UserRewardInfo>(&mut arg0.user_reward, arg2);
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::min(v0.unclaimed_balance, (0x2::balance::value<T0>(&arg1.balance) as u256));
        v0.unclaimed_balance = v0.unclaimed_balance - v1;
        v0.claimed_balance = v0.claimed_balance + v1;
        let v2 = UpdateUserRewardEvent{
            dola_pool_id          : arg0.dola_pool_id,
            dola_user_id          : arg2,
            old_unclaimed_balance : v0.unclaimed_balance,
            new_unclaimed_balance : v0.unclaimed_balance,
            old_reward_index      : v0.last_update_reward_index,
            new_reward_index      : v0.last_update_reward_index,
        };
        0x2::event::emit<UpdateUserRewardEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, (v1 as u64)), arg3)
    }

    public fun create_and_init_boost_coins(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bag::new(arg1);
        let v1 = 0x2::bag::new(arg1);
        let v2 = BTC{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<BTC>>(&mut v0, 0, 0x2::balance::create_supply<BTC>(v2));
        let v3 = USDT{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<USDT>>(&mut v0, 1, 0x2::balance::create_supply<USDT>(v3));
        let v4 = USDC{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<USDC>>(&mut v0, 2, 0x2::balance::create_supply<USDC>(v4));
        let v5 = SUI{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<SUI>>(&mut v0, 3, 0x2::balance::create_supply<SUI>(v5));
        let v6 = ETH{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<ETH>>(&mut v0, 4, 0x2::balance::create_supply<ETH>(v6));
        let v7 = MATIC{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<MATIC>>(&mut v0, 5, 0x2::balance::create_supply<MATIC>(v7));
        let v8 = ARB{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<ARB>>(&mut v0, 6, 0x2::balance::create_supply<ARB>(v8));
        let v9 = OP{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<OP>>(&mut v0, 7, 0x2::balance::create_supply<OP>(v9));
        let v10 = WormholeUSDC{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<WormholeUSDC>>(&mut v0, 8, 0x2::balance::create_supply<WormholeUSDC>(v10));
        let v11 = AVAX{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<AVAX>>(&mut v0, 9, 0x2::balance::create_supply<AVAX>(v11));
        let v12 = BNB{dummy_field: false};
        0x2::bag::add<u16, 0x2::balance::Supply<BNB>>(&mut v0, 10, 0x2::balance::create_supply<BNB>(v12));
        0x2::bag::add<u16, 0x2::balance::Balance<BTC>>(&mut v1, 0, 0x2::balance::zero<BTC>());
        0x2::bag::add<u16, 0x2::balance::Balance<USDT>>(&mut v1, 1, 0x2::balance::zero<USDT>());
        0x2::bag::add<u16, 0x2::balance::Balance<USDC>>(&mut v1, 2, 0x2::balance::zero<USDC>());
        0x2::bag::add<u16, 0x2::balance::Balance<SUI>>(&mut v1, 3, 0x2::balance::zero<SUI>());
        0x2::bag::add<u16, 0x2::balance::Balance<ETH>>(&mut v1, 4, 0x2::balance::zero<ETH>());
        0x2::bag::add<u16, 0x2::balance::Balance<MATIC>>(&mut v1, 5, 0x2::balance::zero<MATIC>());
        0x2::bag::add<u16, 0x2::balance::Balance<ARB>>(&mut v1, 6, 0x2::balance::zero<ARB>());
        0x2::bag::add<u16, 0x2::balance::Balance<OP>>(&mut v1, 7, 0x2::balance::zero<OP>());
        0x2::bag::add<u16, 0x2::balance::Balance<WormholeUSDC>>(&mut v1, 8, 0x2::balance::zero<WormholeUSDC>());
        0x2::bag::add<u16, 0x2::balance::Balance<AVAX>>(&mut v1, 9, 0x2::balance::zero<AVAX>());
        0x2::bag::add<u16, 0x2::balance::Balance<BNB>>(&mut v1, 10, 0x2::balance::zero<BNB>());
        let v13 = BoostReserves{
            id       : 0x2::object::new(arg1),
            caps     : v0,
            reserves : v1,
        };
        0x2::transfer::share_object<BoostReserves>(v13);
    }

    public fun create_reward_pool<T0>(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg2: u256, arg3: u256, arg4: 0x2::coin::Coin<T0>, arg5: u16, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = create_reward_pool_inner<T0>(arg2, arg3, arg4, arg5, arg6, arg7);
        let v1 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_storage_id(arg1);
        let v2 = RewardPoolId{dola_pool_id: arg5};
        if (!0x2::dynamic_field::exists_<RewardPoolId>(v1, v2)) {
            let v3 = RewardPoolInfos{
                info    : 0x1::vector::empty<RewardPoolInfo>(),
                catalog : 0x2::table::new<0x2::object::ID, u64>(arg7),
            };
            0x2::dynamic_field::add<RewardPoolId, RewardPoolInfos>(v1, v2, v3);
        };
        let v4 = 0x2::dynamic_field::borrow_mut<RewardPoolId, RewardPoolInfos>(v1, v2);
        0x2::table::add<0x2::object::ID, u64>(&mut v4.catalog, 0x2::object::id<RewardPoolInfo>(&v0), 0x1::vector::length<RewardPoolInfo>(&v4.info));
        0x1::vector::push_back<RewardPoolInfo>(&mut v4.info, v0);
    }

    fun create_reward_pool_inner<T0>(arg0: u256, arg1: u256, arg2: 0x2::coin::Coin<T0>, arg3: u16, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : RewardPoolInfo {
        assert!(arg1 > arg0, 0);
        assert!(arg4 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_borrow_type() || arg4 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_supply_type(), 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = RewardPool<T0>{
            id             : v2,
            associate_pool : 0x2::object::uid_to_inner(&v1),
            balance        : 0x2::coin::into_balance<T0>(arg2),
        };
        0x2::transfer::share_object<RewardPool<T0>>(v3);
        RewardPoolInfo{
            id                : v1,
            escrow_fund       : 0x2::object::uid_to_inner(&v2),
            start_time        : arg0,
            end_time          : arg1,
            reward_index      : 0,
            reward_action     : arg4,
            total_reward      : v0,
            dola_pool_id      : arg3,
            last_update_time  : arg0,
            reward_per_second : 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_div((v0 as u256), arg1 - arg0),
            user_reward       : 0x2::table::new<u64, UserRewardInfo>(arg5),
        }
    }

    public fun create_reward_pool_with_boost_coin<T0>(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg2: &mut BoostReserves, arg3: u256, arg4: u256, arg5: u16, arg6: u8, arg7: u16, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_boost_coin<T0>(arg2, arg7, arg8, arg9);
        create_reward_pool<T0>(arg0, arg1, arg3, arg4, v0, arg5, arg6, arg9);
    }

    public(friend) fun deposit_boost_coin<T0>(arg0: &mut BoostReserves, arg1: u16, arg2: 0x2::coin::Coin<T0>) {
        let v0 = DepositBoostCoinEvent{
            dola_pool_id   : arg1,
            reserve        : 0x2::balance::join<T0>(0x2::bag::borrow_mut<u16, 0x2::balance::Balance<T0>>(&mut arg0.reserves, arg1), 0x2::coin::into_balance<T0>(arg2)),
            deposit_amount : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<DepositBoostCoinEvent>(v0);
    }

    public(friend) fun destory_reward_pool<T0>(arg0: RewardPoolInfo, arg1: &mut RewardPool<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.escrow_fund == 0x2::object::id<RewardPool<T0>>(arg1), 4);
        assert!(arg1.associate_pool == 0x2::object::id<RewardPoolInfo>(&arg0), 4);
        let RewardPoolInfo {
            id                : v0,
            escrow_fund       : _,
            start_time        : _,
            end_time          : _,
            reward_index      : _,
            reward_action     : _,
            total_reward      : _,
            dola_pool_id      : _,
            last_update_time  : _,
            reward_per_second : _,
            user_reward       : v10,
        } = arg0;
        0x2::object::delete(v0);
        0x2::table::drop<u64, UserRewardInfo>(v10);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.balance), arg2)
    }

    public fun get_dola_pool_id(arg0: &RewardPoolInfo) : u16 {
        arg0.dola_pool_id
    }

    public fun get_end_time(arg0: &RewardPoolInfo) : u256 {
        arg0.end_time
    }

    public fun get_escrow_fund(arg0: &RewardPoolInfo) : &0x2::object::ID {
        &arg0.escrow_fund
    }

    public fun get_last_update_time(arg0: &RewardPoolInfo) : u256 {
        arg0.last_update_time
    }

    public fun get_reward_action(arg0: &RewardPoolInfo) : u8 {
        arg0.reward_action
    }

    public fun get_reward_index(arg0: &RewardPoolInfo) : u256 {
        arg0.reward_index
    }

    public fun get_reward_per_second(arg0: &RewardPoolInfo) : u256 {
        arg0.reward_per_second
    }

    public fun get_reward_pool(arg0: &RewardPoolInfos, arg1: 0x2::object::ID) : &RewardPoolInfo {
        0x1::vector::borrow<RewardPoolInfo>(&arg0.info, *0x2::table::borrow<0x2::object::ID, u64>(&arg0.catalog, arg1))
    }

    public fun get_reward_pool_infos(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg1: u16) : &RewardPoolInfos {
        let v0 = RewardPoolId{dola_pool_id: arg1};
        0x2::dynamic_field::borrow<RewardPoolId, RewardPoolInfos>(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::borrow_storage_id(arg0), v0)
    }

    public fun get_start_time(arg0: &RewardPoolInfo) : u256 {
        arg0.start_time
    }

    public fun get_total_reward(arg0: &RewardPoolInfo) : u64 {
        arg0.total_reward
    }

    public fun get_total_scaled_balance(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg1: u16, arg2: u8) : u256 {
        if (arg2 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_supply_type()) {
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_otoken_scaled_total_supply_v2(arg0, arg1)
        } else {
            assert!(arg2 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_borrow_type(), 2);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_dtoken_scaled_total_supply_v2(arg0, arg1)
        }
    }

    public fun get_user_reward_info(arg0: &RewardPoolInfo, arg1: u64) : (u256, u256, u256) {
        assert!(0x2::table::contains<u64, UserRewardInfo>(&arg0.user_reward, arg1), 6);
        let v0 = 0x2::table::borrow<u64, UserRewardInfo>(&arg0.user_reward, arg1);
        (v0.unclaimed_balance, v0.claimed_balance, v0.last_update_reward_index)
    }

    public fun get_user_scaled_balance(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg1: u16, arg2: u64, arg3: u8) : u256 {
        if (arg3 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_supply_type()) {
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_user_scaled_otoken_v2(arg0, arg2, arg1)
        } else {
            assert!(arg3 == 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_codec::get_borrow_type(), 2);
            0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_user_scaled_dtoken_v2(arg0, arg2, arg1)
        }
    }

    public fun is_exist_user_reward(arg0: &RewardPoolInfo, arg1: u64) : bool {
        0x2::table::contains<u64, UserRewardInfo>(&arg0.user_reward, arg1)
    }

    public fun migrate_reward_pool(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg2: u16) {
        let v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_storage_id(arg1);
        assert!(0x2::dynamic_field::exists_<u16>(v0, arg2), 5);
        let v1 = RewardPoolId{dola_pool_id: arg2};
        0x2::dynamic_field::add<RewardPoolId, RewardPoolInfos>(v0, v1, 0x2::dynamic_field::remove<u16, RewardPoolInfos>(v0, arg2));
    }

    public(friend) fun mint_boost_coin<T0>(arg0: &mut BoostReserves, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::borrow_mut<u16, 0x2::balance::Supply<T0>>(&mut arg0.caps, arg1);
        let v1 = MintBoostCoinEvent{
            dola_pool_id : arg1,
            total_supply : 0x2::balance::supply_value<T0>(v0),
            mint_amount  : arg2,
        };
        0x2::event::emit<MintBoostCoinEvent>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::increase_supply<T0>(v0, arg2), arg3)
    }

    public fun remove_reward_pool<T0>(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg2: &mut RewardPool<T0>, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_storage_id(arg1);
        let v1 = RewardPoolId{dola_pool_id: arg3};
        assert!(0x2::dynamic_field::exists_<RewardPoolId>(v0, v1), 5);
        let v2 = 0x2::dynamic_field::borrow_mut<RewardPoolId, RewardPoolInfos>(v0, v1);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&v2.catalog, arg2.associate_pool), 5);
        let v3 = 0x2::table::remove<0x2::object::ID, u64>(&mut v2.catalog, arg2.associate_pool);
        let v4 = 0x1::vector::length<RewardPoolInfo>(&v2.info) - 1;
        if (v3 != v4) {
            let v5 = 0x2::object::id<RewardPoolInfo>(0x1::vector::borrow<RewardPoolInfo>(&v2.info, v4));
            0x2::table::remove<0x2::object::ID, u64>(&mut v2.catalog, v5);
            0x2::table::add<0x2::object::ID, u64>(&mut v2.catalog, v5, v3);
        };
        destory_reward_pool<T0>(0x1::vector::swap_remove<RewardPoolInfo>(&mut v2.info, v3), arg2, arg4)
    }

    public fun remove_reward_pool_with_boost_coin<T0>(arg0: &0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::genesis::GovernanceCap, arg1: &mut 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::Storage, arg2: &mut BoostReserves, arg3: &mut RewardPool<T0>, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        deposit_boost_coin<T0>(arg2, arg4, remove_reward_pool<T0>(arg0, arg1, arg3, arg4, arg5));
    }

    fun update_pool_reward(arg0: &mut RewardPoolInfo, arg1: u256, arg2: &0x2::clock::Clock) {
        let v0 = 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::min(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::max(0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::lending_core_storage::get_timestamp(arg2), arg0.start_time), arg0.end_time);
        if (arg1 == 0) {
            arg0.reward_index = 0;
        } else {
            arg0.reward_index = arg0.reward_index + arg0.reward_per_second * (v0 - arg0.last_update_time) / arg1;
        };
        arg0.last_update_time = v0;
        let v1 = UpdatePoolRewardEvent{
            dola_pool_id     : arg0.dola_pool_id,
            old_timestamp    : arg0.last_update_time,
            new_timestamp    : arg0.last_update_time,
            old_reward_index : arg0.reward_index,
            new_reward_index : arg0.reward_index,
        };
        0x2::event::emit<UpdatePoolRewardEvent>(v1);
    }

    fun update_user_reward(arg0: &mut RewardPoolInfo, arg1: u256, arg2: u64) {
        if (!0x2::table::contains<u64, UserRewardInfo>(&arg0.user_reward, arg2)) {
            let v0 = UserRewardInfo{
                last_update_reward_index : 0,
                unclaimed_balance        : 0,
                claimed_balance          : 0,
            };
            0x2::table::add<u64, UserRewardInfo>(&mut arg0.user_reward, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<u64, UserRewardInfo>(&mut arg0.user_reward, arg2);
        v1.unclaimed_balance = v1.unclaimed_balance + 0xbc7259cfb37020c8c4d32e516498acaa1b02ef960ca8b45db22a5cf74dc2973f::ray_math::ray_mul(arg0.reward_index - v1.last_update_reward_index, arg1);
        v1.last_update_reward_index = arg0.reward_index;
        let v2 = UpdateUserRewardEvent{
            dola_pool_id          : arg0.dola_pool_id,
            dola_user_id          : arg2,
            old_unclaimed_balance : v1.unclaimed_balance,
            new_unclaimed_balance : v1.unclaimed_balance,
            old_reward_index      : v1.last_update_reward_index,
            new_reward_index      : v1.last_update_reward_index,
        };
        0x2::event::emit<UpdateUserRewardEvent>(v2);
    }

    public(friend) fun withdraw_boost_coin<T0>(arg0: &mut BoostReserves, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::borrow_mut<u16, 0x2::balance::Balance<T0>>(&mut arg0.reserves, arg1);
        let v1 = WithdrawBoostCoinEvent{
            dola_pool_id    : arg1,
            reserve         : 0x2::balance::value<T0>(v0),
            withdraw_amount : arg2,
        };
        0x2::event::emit<WithdrawBoostCoinEvent>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

