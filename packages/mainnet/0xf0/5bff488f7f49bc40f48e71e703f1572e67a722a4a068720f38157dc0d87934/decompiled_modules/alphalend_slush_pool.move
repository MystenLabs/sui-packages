module 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_pool {
    struct SupplyToken<phantom T0> has drop {
        dummy_field: bool,
    }

    struct PositionCap has store, key {
        id: 0x2::object::UID,
        position_pool_map: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        client_address: address,
        image_url: 0x1::string::String,
    }

    struct Position<phantom T0> has store, key {
        id: 0x2::object::UID,
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        principal: u64,
        xtokens: 0x2::balance::Balance<SupplyToken<T0>>,
    }

    struct TimeBasedReward<phantom T0> has store {
        reward_balance: 0x2::balance::Balance<T0>,
        start_time: u64,
        end_time: u64,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated_timestamp: u64,
    }

    struct InterestBasedReward<phantom T0> has store {
        reward_balance: 0x2::balance::Balance<T0>,
        last_updated_timestamp: u64,
        reward_share_from_interest_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct InterestBasedFees<phantom T0> has store {
        fee_balance: 0x2::balance::Balance<T0>,
        fee_bps: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        all_time_collected: u64,
        pending: u64,
        fee_address: address,
    }

    struct Pool<phantom T0> has store, key {
        id: 0x2::object::UID,
        xTokenSupply: 0x2::balance::Supply<SupplyToken<T0>>,
        tokensInvested: u64,
        interest_based_rewards_data: InterestBasedReward<T0>,
        time_based_rewards_data: TimeBasedReward<T0>,
        positions: 0x2::object_table::ObjectTable<0x2::object::ID, Position<T0>>,
        fee_collected: 0x2::balance::Balance<T0>,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        fee_address: address,
        paused: bool,
        investor: 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::Investor<T0>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ALPHALEND_SLUSH_POOL has drop {
        dummy_field: bool,
    }

    struct CollectInterestBasedFeesEvent has copy, drop {
        pending: u64,
        all_time: u64,
        collected: u64,
    }

    struct TimeBasedRewardAddEvent has copy, drop {
        total_balance: u64,
        effective_start_time: u64,
        end_time: u64,
        current_time: u64,
    }

    struct LessTimeBasedRewardsEvent has copy, drop {
        rewards_to_split: u64,
        reward_balance: u64,
        reward_per_ms: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct LiquidityChangeEvent has copy, drop {
        position_cap_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        event_type: u8,
        fee_collected: u64,
        amount: u64,
        current_total_xtoken_balance_in_position: u64,
        principal: u64,
        x_token_supply: u64,
        tokens_invested: u64,
        sender: address,
    }

    public fun add_or_remove_coin_type_for_swap<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: 0x1::type_name::TypeName, arg4: u8) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::add_or_remove_coin_type_for_swap<T0>(&mut arg2.investor, arg3, arg4);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::collect_reward_and_swap_bluefin<T0, T1, T2>(&mut arg1.investor, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun set_minimum_swap_amount<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::set_minimum_swap_amount<T0>(&mut arg2.investor, arg3);
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun add_interest_based_reward<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        collect_interest_based_reward<T0>(arg1, arg3, arg4);
        0x2::balance::join<T0>(&mut arg1.interest_based_rewards_data.reward_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun add_time_based_reward<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(arg3 >= 0x2::clock::timestamp_ms(arg5), 1003);
        assert!(arg3 < arg4, 1004);
        assert!(arg4 >= arg1.time_based_rewards_data.end_time, 1005);
        collect_time_based_reward<T0>(arg1, arg5);
        0x2::balance::join<T0>(&mut arg1.time_based_rewards_data.reward_balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = if (arg1.time_based_rewards_data.last_updated_timestamp == arg1.time_based_rewards_data.end_time) {
            arg3
        } else {
            arg1.time_based_rewards_data.last_updated_timestamp
        };
        arg1.time_based_rewards_data.start_time = v0;
        arg1.time_based_rewards_data.end_time = arg4;
        arg1.time_based_rewards_data.reward_per_ms = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::value<T0>(&arg1.time_based_rewards_data.reward_balance)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg4 - arg1.time_based_rewards_data.start_time));
        let v1 = TimeBasedRewardAddEvent{
            total_balance        : 0x2::balance::value<T0>(&arg1.time_based_rewards_data.reward_balance),
            effective_start_time : arg1.time_based_rewards_data.start_time,
            end_time             : arg4,
            current_time         : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<TimeBasedRewardAddEvent>(v1);
    }

    entry fun change_fee_address<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.fee_address = arg3;
    }

    entry fun collect_fee<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fee_collected), arg2), arg1.fee_address);
    }

    public fun collect_interest_based_fees<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        collect_interest_based_reward<T0>(arg1, arg2, arg3);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, InterestBasedFees<T0>>(&mut arg1.id, interest_based_fees_key());
        let v1 = 0x1::u64::min(0x2::balance::value<T0>(&v0.fee_balance), v0.pending);
        v0.pending = v0.pending - v1;
        v0.all_time_collected = v0.all_time_collected + v1;
        let v2 = CollectInterestBasedFeesEvent{
            pending   : v0.pending,
            all_time  : v0.all_time_collected,
            collected : v1,
        };
        0x2::event::emit<CollectInterestBasedFeesEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.fee_balance, v1), arg4), v0.fee_address);
    }

    fun collect_interest_based_reward<T0>(arg0: &mut Pool<T0>, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: &0x2::clock::Clock) {
        let v0 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::split_interest_based_reward<T0>(&mut arg0.investor, &mut arg0.interest_based_rewards_data.reward_balance, arg0.interest_based_rewards_data.reward_share_from_interest_bps, interest_based_fees_bps<T0>(arg0), arg1, 0x2::object::id<Pool<T0>>(arg0), arg2);
        increase_pending_interest_based_fees<T0>(arg0, v0);
        arg0.interest_based_rewards_data.last_updated_timestamp = 0x2::clock::timestamp_ms(arg2);
    }

    fun collect_time_based_reward<T0>(arg0: &mut Pool<T0>, arg1: &0x2::clock::Clock) {
        let v0 = &mut arg0.time_based_rewards_data;
        let v1 = 0x1::u64::max(v0.start_time, v0.last_updated_timestamp);
        let v2 = 0x1::u64::min(v0.end_time, 0x2::clock::timestamp_ms(arg1));
        if (v2 <= v1) {
            return
        };
        let v3 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v2 - v1), v0.reward_per_ms));
        let v4 = v3;
        if (v3 > 0x2::balance::value<T0>(&v0.reward_balance)) {
            let v5 = LessTimeBasedRewardsEvent{
                rewards_to_split : v3,
                reward_balance   : 0x2::balance::value<T0>(&v0.reward_balance),
                reward_per_ms    : v0.reward_per_ms,
            };
            0x2::event::emit<LessTimeBasedRewardsEvent>(v5);
            v4 = 0x2::balance::value<T0>(&v0.reward_balance);
        };
        if (v4 == 0) {
            return
        };
        v0.last_updated_timestamp = v2;
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::update_free_rewards<T0, T0>(&mut arg0.investor, 0x2::balance::split<T0>(&mut v0.reward_balance, v4));
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        let v0 = SupplyToken<T0>{dummy_field: false};
        let v1 = InterestBasedReward<T0>{
            reward_balance                 : 0x2::balance::zero<T0>(),
            last_updated_timestamp         : 0,
            reward_share_from_interest_bps : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg2), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000)),
        };
        let v2 = TimeBasedReward<T0>{
            reward_balance         : 0x2::balance::zero<T0>(),
            start_time             : 0,
            end_time               : 0,
            reward_per_ms          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            last_updated_timestamp : 0,
        };
        let v3 = Pool<T0>{
            id                          : 0x2::object::new(arg7),
            xTokenSupply                : 0x2::balance::create_supply<SupplyToken<T0>>(v0),
            tokensInvested              : 0,
            interest_based_rewards_data : v1,
            time_based_rewards_data     : v2,
            positions                   : 0x2::object_table::new<0x2::object::ID, Position<T0>>(arg7),
            fee_collected               : 0x2::balance::zero<T0>(),
            deposit_fee                 : 0,
            deposit_fee_max_cap         : 100,
            withdrawal_fee              : 0,
            withdraw_fee_max_cap        : 100,
            fee_address                 : arg6,
            paused                      : false,
            investor                    : 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::create_investor<T0>(arg3, arg4, arg5, arg7),
        };
        0x2::transfer::public_share_object<Pool<T0>>(v3);
    }

    fun create_position<T0>(arg0: &mut PositionCap, arg1: &mut Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg1.positions, 0x2::object::id<PositionCap>(arg0)), 1001);
        let v0 = 0x2::object::new(arg2);
        let v1 = 0x2::object::id<Pool<T0>>(arg1);
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg0.position_pool_map, 0x2::object::uid_to_inner(&v0), v1);
        let v2 = Position<T0>{
            id              : v0,
            position_cap_id : 0x2::object::id<PositionCap>(arg0),
            pool_id         : v1,
            coin_type       : 0x1::type_name::with_defining_ids<T0>(),
            principal       : 0,
            xtokens         : 0x2::balance::zero<SupplyToken<T0>>(),
        };
        0x2::object_table::add<0x2::object::ID, Position<T0>>(&mut arg1.positions, 0x2::object::id<PositionCap>(arg0), v2);
    }

    public fun create_position_cap(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : PositionCap {
        PositionCap{
            id                : 0x2::object::new(arg1),
            position_pool_map : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            client_address    : 0x2::tx_context::sender(arg1),
            image_url         : 0x1::string::utf8(arg0),
        }
    }

    fun exchange_rate<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.tokensInvested == 0 || 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply) == 0) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply)))
        }
    }

    fun increase_pending_interest_based_fees<T0>(arg0: &mut Pool<T0>, arg1: u64) {
        if (arg1 == 0) {
            return
        };
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, interest_based_fees_key()), 1016);
        let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, InterestBasedFees<T0>>(&mut arg0.id, interest_based_fees_key());
        v0.pending = v0.pending + arg1;
    }

    fun init(arg0: ALPHALEND_SLUSH_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaLend-Slush Position Cap"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaLend-Slush Protocol Postion Capability"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AlphaLend-Slush"));
        let v4 = 0x2::package::claim<ALPHALEND_SLUSH_POOL>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PositionCap>(&v4, v0, v2, arg1);
        0x2::display::update_version<PositionCap>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PositionCap>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    entry fun initialize_interest_based_fees<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64, arg4: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        let v0 = InterestBasedFees<T0>{
            fee_balance        : 0x2::balance::zero<T0>(),
            fee_bps            : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg3),
            all_time_collected : 0,
            pending            : 0,
            fee_address        : arg4,
        };
        0x2::dynamic_field::add<vector<u8>, InterestBasedFees<T0>>(&mut arg2.id, interest_based_fees_key(), v0);
    }

    fun interest_based_fees_bps<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, interest_based_fees_key())) {
            return 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
        };
        0x2::dynamic_field::borrow<vector<u8>, InterestBasedFees<T0>>(&arg0.id, interest_based_fees_key()).fee_bps
    }

    fun interest_based_fees_key() : vector<u8> {
        b"interest_based_fees"
    }

    fun internal_deposit<T0>(arg0: &mut Pool<T0>, arg1: &PositionCap, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T0>(&arg2) as u128) * (arg0.deposit_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg0.fee_collected, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, (v0 as u64), arg5)));
        let v1 = 0x2::coin::value<T0>(&arg2);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::deposit<T0>(&mut arg0.investor, arg3, arg2, arg4, arg5);
        arg0.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::get_total_invested<T0>(&arg0.investor, arg3, arg4);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.tokensInvested - arg0.tokensInvested), exchange_rate<T0>(arg0)));
        assert!(v2 > 0, 1012);
        0x2::balance::join<SupplyToken<T0>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg0.positions, 0x2::object::id<PositionCap>(arg1)).xtokens, 0x2::balance::increase_supply<SupplyToken<T0>>(&mut arg0.xTokenSupply, (v2 as u64)));
        let v3 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg0.positions, 0x2::object::id<PositionCap>(arg1)).principal;
        *v3 = *v3 + v1;
        let v4 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position<T0>>(0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg0.positions, 0x2::object::id<PositionCap>(arg1))),
            event_type                               : 0,
            fee_collected                            : (v0 as u64),
            amount                                   : v1,
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<T0>>(&0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg0.positions, 0x2::object::id<PositionCap>(arg1)).xtokens),
            principal                                : *v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<LiquidityChangeEvent>(v4);
    }

    fun internal_withdraw<T0>(arg0: &mut Pool<T0>, arg1: &PositionCap, arg2: u64, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<SupplyToken<T0>>(&0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg0.positions, 0x2::object::id<PositionCap>(arg1)).xtokens);
        assert!(v0 >= arg2, 1014);
        assert!(arg2 > 0, 1015);
        let v1 = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::withdraw_from_alphalend<T0>(&mut arg0.investor, arg3, arg2, 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply), arg4, arg5, arg6);
        let v2 = &mut 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg0.positions, 0x2::object::id<PositionCap>(arg1)).principal;
        assert!(arg2 <= v0, 1017);
        *v2 = (((*v2 as u256) - (*v2 as u256) * (arg2 as u256) / (v0 as u256)) as u64);
        let v3 = *v2;
        0x2::balance::decrease_supply<SupplyToken<T0>>(&mut arg0.xTokenSupply, 0x2::balance::split<SupplyToken<T0>>(&mut 0x2::object_table::borrow_mut<0x2::object::ID, Position<T0>>(&mut arg0.positions, 0x2::object::id<PositionCap>(arg1)).xtokens, arg2));
        arg0.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::get_total_invested<T0>(&arg0.investor, arg3, arg5);
        let v4 = (0x2::balance::value<T0>(&v1) as u128) * (arg0.withdrawal_fee as u128) / 10000;
        0x2::balance::join<T0>(&mut arg0.fee_collected, 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, (v4 as u64)), arg6)));
        let v5 = LiquidityChangeEvent{
            position_cap_id                          : 0x2::object::id<PositionCap>(arg1),
            pool_id                                  : 0x2::object::uid_to_inner(&arg0.id),
            position_id                              : 0x2::object::id<Position<T0>>(0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg0.positions, 0x2::object::id<PositionCap>(arg1))),
            event_type                               : 1,
            fee_collected                            : (v4 as u64),
            amount                                   : 0x2::balance::value<T0>(&v1),
            current_total_xtoken_balance_in_position : 0x2::balance::value<SupplyToken<T0>>(&0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg0.positions, 0x2::object::id<PositionCap>(arg1)).xtokens),
            principal                                : v3,
            x_token_supply                           : 0x2::balance::supply_value<SupplyToken<T0>>(&arg0.xTokenSupply),
            tokens_invested                          : arg0.tokensInvested,
            sender                                   : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<LiquidityChangeEvent>(v5);
        0x2::coin::from_balance<T0>(v1, arg6)
    }

    entry fun set_deposit_fee<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 1002);
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: bool) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.paused = arg3;
    }

    entry fun set_reward_share_from_interest_bps<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        arg2.interest_based_rewards_data.reward_share_from_interest_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg3), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000));
    }

    entry fun set_withdrawal_fee<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: u64) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 1002);
        arg2.withdrawal_fee = arg3;
    }

    public fun update_interest_based_fees_address<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: address) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, interest_based_fees_key()), 1016);
        0x2::dynamic_field::borrow_mut<vector<u8>, InterestBasedFees<T0>>(&mut arg2.id, interest_based_fees_key()).fee_address = arg3;
    }

    public fun update_interest_based_fees_balance<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, interest_based_fees_key()), 1016);
        0x2::balance::join<T0>(&mut 0x2::dynamic_field::borrow_mut<vector<u8>, InterestBasedFees<T0>>(&mut arg1.id, interest_based_fees_key()).fee_balance, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun update_interest_based_fees_bps<T0>(arg0: &AdminCap, arg1: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg2: &mut Pool<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg1);
        collect_interest_based_reward<T0>(arg2, arg3, arg5);
        0x2::dynamic_field::borrow_mut<vector<u8>, InterestBasedFees<T0>>(&mut arg2.id, interest_based_fees_key()).fee_bps = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_bps(arg4);
    }

    public fun update_pool<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut Pool<T0>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        collect_interest_based_reward<T0>(arg1, arg2, arg4);
        collect_time_based_reward<T0>(arg1, arg4);
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::autocompound<T0>(&mut arg1.investor, arg2, arg3, arg4, arg5);
        arg1.tokensInvested = 0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::alphalend_slush_investor::get_total_invested<T0>(&arg1.investor, arg2, arg4);
    }

    public fun user_deposit<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut PositionCap, arg2: &mut Pool<T0>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        if (!0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, 0x2::object::id<PositionCap>(arg1))) {
            create_position<T0>(arg1, arg2, arg7);
        };
        assert!(0x2::coin::value<T0>(&arg3) > 0, 1012);
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6, arg7);
        internal_deposit<T0>(arg2, arg1, arg3, arg4, arg6, arg7);
    }

    public fun user_withdraw<T0>(arg0: &0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::Version, arg1: &mut PositionCap, arg2: &mut Pool<T0>, arg3: u64, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0x3::sui_system::SuiSystemState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x41b1def47b6259cd7306e049d6500eabb1a984e25558b56eefa9b6c000a038c3::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 1011);
        update_pool<T0>(arg0, arg2, arg4, arg5, arg6, arg7);
        assert!(0x2::object_table::contains<0x2::object::ID, Position<T0>>(&arg2.positions, 0x2::object::id<PositionCap>(arg1)), 1013);
        let v0 = internal_withdraw<T0>(arg2, arg1, arg3, arg4, arg5, arg6, arg7);
        if (0x2::balance::value<SupplyToken<T0>>(&0x2::object_table::borrow<0x2::object::ID, Position<T0>>(&arg2.positions, 0x2::object::id<PositionCap>(arg1)).xtokens) == 0) {
            let Position {
                id              : v1,
                position_cap_id : _,
                pool_id         : _,
                coin_type       : _,
                principal       : _,
                xtokens         : v6,
            } = 0x2::object_table::remove<0x2::object::ID, Position<T0>>(&mut arg2.positions, 0x2::object::id<PositionCap>(arg1));
            let v7 = v1;
            let (_, _) = 0x2::vec_map::remove<0x2::object::ID, 0x2::object::ID>(&mut arg1.position_pool_map, 0x2::object::uid_as_inner(&v7));
            0x2::object::delete(v7);
            0x2::balance::destroy_zero<SupplyToken<T0>>(v6);
        };
        v0
    }

    // decompiled from Move bytecode v6
}

