module 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::py_state {
    struct PyState<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        expiry: u64,
        interest_fee_rate: u128,
        expiry_divisor: u64,
        treasury: address,
        pt_supply: u64,
        yt_supply: u64,
        sy_balance: 0x2::balance::Balance<T0>,
        py_index_stored: u128,
        py_index_last_updated: u64,
        last_collect_interest_index: u128,
        total_treasury_interest: u128,
        last_interest_timestamp: u64,
        global_interest_index: u128,
        is_settled: bool,
        settled_py_index: u128,
    }

    struct PyStateCreatedEvent has copy, drop {
        state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        expiry: u64,
    }

    struct InterestCollectedEvent has copy, drop {
        state_id: 0x2::object::ID,
        user_interest_raw: u128,
        treasury_interest_raw: u128,
        py_index_raw: u128,
    }

    struct SettledEvent has copy, drop {
        state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        settled_py_index: u128,
        treasury_interest_collected_raw: u128,
        settled_at_ms: u64,
    }

    struct MintPyEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount_in: u64,
        pt_amount: u64,
        yt_amount: u64,
        expiry: u64,
    }

    struct RedeemPyEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        pt_amount: u64,
        yt_amount: u64,
        sy_amount_out: u64,
        expiry: u64,
        redeemer: address,
    }

    struct InterestClaimedEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        sy_amount: u64,
        receiver: address,
    }

    struct SettlementEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        settled_py_index: u128,
    }

    struct ExternalPtRedeemReceipt {
        state_id: 0x2::object::ID,
        pt_amount: u64,
    }

    struct YtRewardRequiredKey has copy, drop, store {
        dummy_field: bool,
    }

    struct YtRewardGateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct YtRewardRequired has store {
        distributor_id: 0x2::object::ID,
    }

    struct YtRewardMutation {
        state_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    struct TreasuryInterestCollectedEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        amount: u64,
        dust_remainder_raw: u128,
        collected_by: address,
    }

    struct YtRewardDistributorRequiredEvent has copy, drop {
        py_state_id: 0x2::object::ID,
        distributor_id: 0x2::object::ID,
    }

    public fun id<T0: drop>(arg0: &PyState<T0>) : 0x2::object::ID {
        0x2::object::id<PyState<T0>>(arg0)
    }

    public fun expiry<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.expiry
    }

    fun assert_yt_reward_mutation_allowed<T0: drop>(arg0: &PyState<T0>) {
        if (yt_reward_distributor_required<T0>(arg0)) {
            assert!(yt_reward_gate_open<T0>(arg0), 1205);
        };
    }

    public(friend) fun asset_to_sy(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 > 0, 704);
        (((arg1 as u256) * (18446744073709551616 as u256) / (arg0 as u256)) as u128)
    }

    public(friend) fun begin_yt_reward_mutation<T0: drop>(arg0: &mut PyState<T0>, arg1: 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::RewardSettlement, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64) : YtRewardMutation {
        assert!(yt_reward_distributor_required<T0>(arg0), 1205);
        assert!(!yt_reward_gate_open<T0>(arg0), 1206);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_scope(&arg1, 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::yt_scope());
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_profile_matches(&arg1, market_id<T0>(arg0));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_subject(&arg1, arg3);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_owner(&arg1, arg2);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_previous_exposure(&arg1, arg4);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::assert_settlement_guard(&arg1, arg5);
        let v0 = YtRewardGateKey{dummy_field: false};
        0x2::dynamic_field::add<YtRewardGateKey, bool>(&mut arg0.id, v0, true);
        YtRewardMutation{
            state_id       : state_id<T0>(arg0),
            distributor_id : 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::reward_distributor::consume_yt_settlement(arg1, yt_reward_distributor_id<T0>(arg0), arg3, arg2),
        }
    }

    public(friend) fun burn_py<T0: drop>(arg0: &mut PyState<T0>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: u64, arg3: u64) {
        assert!(arg0.pt_supply >= arg2, 702);
        assert!(arg0.yt_supply >= arg3, 703);
        if (arg3 > 0) {
            assert_yt_reward_mutation_allowed<T0>(arg0);
        };
        arg0.pt_supply = arg0.pt_supply - arg2;
        arg0.yt_supply = arg0.yt_supply - arg3;
        if (arg2 > 0) {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::sub_pt(arg1, arg2);
        };
        if (arg3 > 0) {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::sub_yt(arg1, arg3);
        };
    }

    public(friend) fun calc_interest(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 == 0 || arg2 == 0) {
            return 0
        };
        if (arg2 <= arg1) {
            return 0
        };
        let v0 = (arg1 as u256) * (arg2 as u256);
        assert!(v0 > 0, 704);
        (((arg0 as u256) * ((arg2 - arg1) as u256) * (18446744073709551616 as u256) / v0) as u128)
    }

    public(friend) fun calc_py_amount_for_sy<T0: drop>(arg0: u64, arg1: u128, arg2: &PyState<T0>) : u64 {
        if (arg0 == 0) {
            return 0
        };
        ((sy_to_asset(current_py_index(arg1, py_index_stored<T0>(arg2)), (arg0 as u128) * 18446744073709551616) / 18446744073709551616) as u64)
    }

    public(friend) fun calc_sy_amount_for_py<T0: drop>(arg0: u64, arg1: u128, arg2: &PyState<T0>) : u64 {
        (((asset_to_sy(current_py_index(arg1, py_index_stored<T0>(arg2)), (arg0 as u128) * 18446744073709551616) + 18446744073709551616 - 1) / 18446744073709551616) as u64)
    }

    public(friend) fun calc_user_accrued(arg0: u128, arg1: u64, arg2: u128, arg3: u128) : u128 {
        if (arg3 == 0 || arg2 <= arg3) {
            return arg0
        };
        arg0 + (arg1 as u128) * (arg2 - arg3)
    }

    public fun claim_interest<T0: drop>(arg0: 0x1::option::Option<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: &mut PyState<T0>, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg3, state_id<T0>(arg2));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg1, state_id<T0>(arg2));
        let v0 = arg2.interest_fee_rate;
        let v1 = if (is_expired(expiry<T0>(arg2), 0x2::clock::timestamp_ms(arg4))) {
            assert!(is_settled<T0>(arg2), 1213);
            if (0x1::option::is_some<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>(&arg0)) {
                0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::destroy<T0>(0x1::option::destroy_some<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>(arg0));
            } else {
                0x1::option::destroy_none<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>(arg0);
            };
            settled_py_index<T0>(arg2)
        } else {
            0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(0x1::option::destroy_some<0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>>(arg0), market_id<T0>(arg2), arg4)
        };
        update_user_interest<T0>(arg2, arg1, v0, v1, arg4);
        let v2 = redeem_due_interest<T0>(arg2, arg1, arg5);
        let v3 = InterestClaimedEvent{
            py_state_id : state_id<T0>(arg2),
            position_id : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg1),
            sy_amount   : 0x2::coin::value<T0>(&v2),
            receiver    : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<InterestClaimedEvent>(v3);
        v2
    }

    public fun collect_treasury_interest_by_acl<T0: drop>(arg0: &mut PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg1, state_id<T0>(arg0));
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg2, 0x2::tx_context::sender(arg3), 0x1::string::utf8(b"treasury.collect"));
        let v0 = arg0.total_treasury_interest;
        let v1 = ((v0 / 18446744073709551616) as u64);
        if (v1 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        };
        arg0.total_treasury_interest = v0 - (v1 as u128) * 18446744073709551616;
        let v2 = TreasuryInterestCollectedEvent{
            py_state_id        : 0x2::object::id<PyState<T0>>(arg0),
            market_id          : arg0.market_id,
            amount             : v1,
            dust_remainder_raw : arg0.total_treasury_interest,
            collected_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryInterestCollectedEvent>(v2);
        split_sy<T0>(arg0, v1, arg3)
    }

    public fun collect_treasury_interest_by_admin<T0: drop>(arg0: &mut PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg1, state_id<T0>(arg0));
        let v0 = arg0.total_treasury_interest;
        let v1 = ((v0 / 18446744073709551616) as u64);
        if (v1 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg3)
        };
        arg0.total_treasury_interest = v0 - (v1 as u128) * 18446744073709551616;
        let v2 = TreasuryInterestCollectedEvent{
            py_state_id        : 0x2::object::id<PyState<T0>>(arg0),
            market_id          : arg0.market_id,
            amount             : v1,
            dust_remainder_raw : arg0.total_treasury_interest,
            collected_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryInterestCollectedEvent>(v2);
        split_sy<T0>(arg0, v1, arg3)
    }

    public fun create_py_state_by_admin_cap<T0: drop, T1: drop, T2: drop>(arg0: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::Market<T0, T1, T2>, arg3: u128, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : PyState<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_current(arg1);
        create_py_state_internal<T0>(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::id<T0, T1, T2>(arg2), 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::market::expiry<T0, T1, T2>(arg2), arg3, arg4, arg5, arg6)
    }

    public(friend) fun create_py_state_internal<T0: drop>(arg0: 0x2::object::ID, arg1: u64, arg2: u128, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : PyState<T0> {
        assert!(arg2 <= 3689348814741910323, 1210);
        assert!(arg3 > 0, 1211);
        assert!(arg1 % arg3 == 0, 1212);
        let v0 = PyState<T0>{
            id                          : 0x2::object::new(arg5),
            market_id                   : arg0,
            expiry                      : arg1,
            interest_fee_rate           : arg2,
            expiry_divisor              : arg3,
            treasury                    : arg4,
            pt_supply                   : 0,
            yt_supply                   : 0,
            sy_balance                  : 0x2::balance::zero<T0>(),
            py_index_stored             : 0,
            py_index_last_updated       : 0,
            last_collect_interest_index : 0,
            total_treasury_interest     : 0,
            last_interest_timestamp     : 0,
            global_interest_index       : 0,
            is_settled                  : false,
            settled_py_index            : 0,
        };
        let v1 = PyStateCreatedEvent{
            state_id  : 0x2::object::id<PyState<T0>>(&v0),
            market_id : arg0,
            expiry    : arg1,
        };
        0x2::event::emit<PyStateCreatedEvent>(v1);
        v0
    }

    public(friend) fun current_py_index(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    public(friend) fun end_yt_reward_mutation<T0: drop>(arg0: &mut PyState<T0>, arg1: YtRewardMutation) {
        let YtRewardMutation {
            state_id       : v0,
            distributor_id : v1,
        } = arg1;
        assert!(v0 == state_id<T0>(arg0), 1204);
        assert!(yt_reward_distributor_id<T0>(arg0) == v1, 1208);
        assert!(yt_reward_gate_open<T0>(arg0), 1207);
        let v2 = YtRewardGateKey{dummy_field: false};
        assert!(0x2::dynamic_field::remove<YtRewardGateKey, bool>(&mut arg0.id, v2), 1207);
    }

    public fun expiry_divisor<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.expiry_divisor
    }

    public fun global_interest_index<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.global_interest_index
    }

    public fun interest_fee_rate<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.interest_fee_rate
    }

    public(friend) fun is_expired(arg0: u64, arg1: u64) : bool {
        arg1 >= arg0
    }

    public fun is_expired_state<T0: drop>(arg0: &PyState<T0>, arg1: &0x2::clock::Clock) : bool {
        is_expired(arg0.expiry, 0x2::clock::timestamp_ms(arg1))
    }

    public fun is_settled<T0: drop>(arg0: &PyState<T0>) : bool {
        arg0.is_settled
    }

    public(friend) fun join_sy<T0: drop>(arg0: &mut PyState<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.sy_balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun last_collect_interest_index<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.last_collect_interest_index
    }

    public fun last_interest_timestamp<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.last_interest_timestamp
    }

    public fun market_id<T0: drop>(arg0: &PyState<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun mint_py<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &mut PyState<T0>, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg5: &0x2::clock::Clock) : u64 {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg4, state_id<T0>(arg3));
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg1, market_id<T0>(arg3), arg5);
        mint_py_with_sy_index<T0>(arg0, v0, arg2, arg3, arg5)
    }

    public(friend) fun mint_py_supply<T0: drop>(arg0: &mut PyState<T0>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: u64) {
        assert!(arg2 > 0, 704);
        assert_yt_reward_mutation_allowed<T0>(arg0);
        arg0.pt_supply = arg0.pt_supply + arg2;
        arg0.yt_supply = arg0.yt_supply + arg2;
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::add_pt(arg1, arg2);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::add_yt(arg1, arg2);
    }

    public(friend) fun mint_py_with_sy_index<T0: drop>(arg0: 0x2::coin::Coin<T0>, arg1: u128, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &mut PyState<T0>, arg4: &0x2::clock::Clock) : u64 {
        assert!(!is_expired(expiry<T0>(arg3), 0x2::clock::timestamp_ms(arg4)), 1100);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg2, state_id<T0>(arg3));
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 704);
        let v1 = ((sy_to_asset(current_py_index(arg1, py_index_stored<T0>(arg3)), (v0 as u128) * 18446744073709551616) / 18446744073709551616) as u64);
        assert!(v1 > 0, 704);
        let v2 = arg3.interest_fee_rate;
        join_sy<T0>(arg3, arg0);
        update_user_interest<T0>(arg3, arg2, v2, arg1, arg4);
        mint_py_supply<T0>(arg3, arg2, v1);
        let v3 = MintPyEvent{
            py_state_id  : state_id<T0>(arg3),
            position_id  : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg2),
            sy_amount_in : v0,
            pt_amount    : v1,
            yt_amount    : v1,
            expiry       : expiry<T0>(arg3),
        };
        0x2::event::emit<MintPyEvent>(v3);
        v1
    }

    public fun pt_supply<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.pt_supply
    }

    public fun py_index_last_updated<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.py_index_last_updated
    }

    public fun py_index_stored<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.py_index_stored
    }

    public(friend) fun redeem_due_interest<T0: drop>(arg0: &mut PyState<T0>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::clear_accrued(arg1);
        let v0 = ((0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::accrued(arg1) / 18446744073709551616) as u64);
        if (v0 == 0) {
            return 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg2)
        };
        split_sy<T0>(arg0, v0, arg2)
    }

    public fun redeem_py_after_expiry<T0: drop>(arg0: u64, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: &mut PyState<T0>, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg3, state_id<T0>(arg2));
        assert!(is_expired(expiry<T0>(arg2), 0x2::clock::timestamp_ms(arg4)), 701);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg1, state_id<T0>(arg2));
        assert!(arg0 > 0, 704);
        let v0 = arg2.interest_fee_rate;
        assert!(is_settled<T0>(arg2), 1213);
        let v1 = settled_py_index<T0>(arg2);
        update_user_interest<T0>(arg2, arg1, v0, v1, arg4);
        burn_py<T0>(arg2, arg1, arg0, 0);
        let v2 = ((asset_to_sy(v1, (arg0 as u128) * 18446744073709551616) / 18446744073709551616) as u64);
        let v3 = split_sy<T0>(arg2, v2, arg5);
        let v4 = RedeemPyEvent{
            py_state_id   : state_id<T0>(arg2),
            position_id   : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg1),
            pt_amount     : arg0,
            yt_amount     : 0,
            sy_amount_out : v2,
            expiry        : expiry<T0>(arg2),
            redeemer      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RedeemPyEvent>(v4);
        v3
    }

    public fun redeem_py_before_expiry<T0: drop>(arg0: u64, arg1: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &mut PyState<T0>, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg4, state_id<T0>(arg3));
        assert!(!is_expired(expiry<T0>(arg3), 0x2::clock::timestamp_ms(arg5)), 1201);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg2, state_id<T0>(arg3));
        assert!(arg0 > 0, 704);
        if (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_balance(arg2) < arg0) {
            abort 1202
        };
        if (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::pt_balance(arg2) < arg0) {
            abort 1203
        };
        assert_yt_reward_mutation_allowed<T0>(arg3);
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg1, market_id<T0>(arg3), arg5);
        let v1 = arg3.interest_fee_rate;
        update_user_interest<T0>(arg3, arg2, v1, v0, arg5);
        burn_py<T0>(arg3, arg2, arg0, arg0);
        let v2 = ((asset_to_sy(current_py_index(v0, py_index_stored<T0>(arg3)), (arg0 as u128) * 18446744073709551616) / 18446744073709551616) as u64);
        let v3 = split_sy<T0>(arg3, v2, arg6);
        let v4 = RedeemPyEvent{
            py_state_id   : state_id<T0>(arg3),
            position_id   : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg2),
            pt_amount     : arg0,
            yt_amount     : arg0,
            sy_amount_out : v2,
            expiry        : expiry<T0>(arg3),
            redeemer      : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<RedeemPyEvent>(v4);
        v3
    }

    public(friend) fun redeem_yt_with_external_pt_before_expiry<T0: drop>(arg0: u64, arg1: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &mut PyState<T0>, arg4: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExternalPtRedeemReceipt) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg4, state_id<T0>(arg3));
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg1, market_id<T0>(arg3), arg5);
        redeem_yt_with_external_pt_before_expiry_with_sy_index<T0>(arg0, v0, arg2, arg3, arg5, arg6)
    }

    public(friend) fun redeem_yt_with_external_pt_before_expiry_with_sy_index<T0: drop>(arg0: u64, arg1: u128, arg2: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg3: &mut PyState<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, ExternalPtRedeemReceipt) {
        assert!(!is_expired(expiry<T0>(arg3), 0x2::clock::timestamp_ms(arg4)), 1201);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg2, state_id<T0>(arg3));
        assert!(arg0 > 0, 704);
        if (0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_balance(arg2) < arg0) {
            abort 1202
        };
        assert_yt_reward_mutation_allowed<T0>(arg3);
        let v0 = arg3.interest_fee_rate;
        update_user_interest<T0>(arg3, arg2, v0, arg1, arg4);
        assert!(arg3.pt_supply >= arg0, 702);
        assert!(arg3.yt_supply >= arg0, 703);
        arg3.pt_supply = arg3.pt_supply - arg0;
        arg3.yt_supply = arg3.yt_supply - arg0;
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::sub_yt(arg2, arg0);
        let v1 = ((asset_to_sy(current_py_index(arg1, py_index_stored<T0>(arg3)), (arg0 as u128) * 18446744073709551616) / 18446744073709551616) as u64);
        let v2 = split_sy<T0>(arg3, v1, arg5);
        let v3 = RedeemPyEvent{
            py_state_id   : state_id<T0>(arg3),
            position_id   : 0x2::object::id<0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition>(arg2),
            pt_amount     : arg0,
            yt_amount     : arg0,
            sy_amount_out : v1,
            expiry        : expiry<T0>(arg3),
            redeemer      : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<RedeemPyEvent>(v3);
        let v4 = ExternalPtRedeemReceipt{
            state_id  : state_id<T0>(arg3),
            pt_amount : arg0,
        };
        (v2, v4)
    }

    fun require_yt_reward_distributor<T0: drop>(arg0: &mut PyState<T0>, arg1: 0x2::object::ID) {
        assert!(!yt_reward_gate_open<T0>(arg0), 1206);
        if (!yt_reward_distributor_required<T0>(arg0)) {
            let v0 = YtRewardRequiredKey{dummy_field: false};
            let v1 = YtRewardRequired{distributor_id: arg1};
            0x2::dynamic_field::add<YtRewardRequiredKey, YtRewardRequired>(&mut arg0.id, v0, v1);
        } else {
            let v2 = YtRewardRequiredKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<YtRewardRequiredKey, YtRewardRequired>(&mut arg0.id, v2).distributor_id = arg1;
        };
        let v3 = YtRewardDistributorRequiredEvent{
            py_state_id    : state_id<T0>(arg0),
            distributor_id : arg1,
        };
        0x2::event::emit<YtRewardDistributorRequiredEvent>(v3);
    }

    public fun require_yt_reward_distributor_by_admin<T0: drop>(arg0: &mut PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg1, state_id<T0>(arg0));
        require_yt_reward_distributor<T0>(arg0, arg2);
    }

    public(friend) fun settle<T0: drop>(arg0: &mut PyState<T0>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock) : u128 {
        assert!(!arg0.is_settled, 700);
        assert!(is_expired(arg0.expiry, 0x2::clock::timestamp_ms(arg3)), 701);
        let (_, v1, v2) = update_interest_index<T0>(arg0, arg1, arg2, arg3);
        arg0.is_settled = true;
        arg0.settled_py_index = v1;
        let v3 = SettledEvent{
            state_id                        : 0x2::object::id<PyState<T0>>(arg0),
            market_id                       : arg0.market_id,
            settled_py_index                : v1,
            treasury_interest_collected_raw : v2,
            settled_at_ms                   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SettledEvent>(v3);
        v2
    }

    public fun settle_expired_market_by_acl<T0: drop>(arg0: &mut PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::ACL, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg1, state_id<T0>(arg0));
        0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::acl::assert_has_role(arg3, 0x2::tx_context::sender(arg5), 0x1::string::utf8(b"py_state.settle"));
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg2, arg0.market_id, arg4);
        let v1 = arg0.interest_fee_rate;
        settle<T0>(arg0, v1, v0, arg4);
        let v2 = SettlementEvent{
            py_state_id      : 0x2::object::id<PyState<T0>>(arg0),
            settled_py_index : arg0.settled_py_index,
        };
        0x2::event::emit<SettlementEvent>(v2);
    }

    public fun settle_expired_market_by_admin<T0: drop>(arg0: &mut PyState<T0>, arg1: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg2: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg3: &0xc59bf9a81ec34872a3c47e0e84a4fc65ab280f319e2df61db4f860e90b32572c::admin::AdminCap, arg4: &0x2::clock::Clock) {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg1, state_id<T0>(arg0));
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg2, arg0.market_id, arg4);
        let v1 = arg0.interest_fee_rate;
        settle<T0>(arg0, v1, v0, arg4);
        let v2 = SettlementEvent{
            py_state_id      : 0x2::object::id<PyState<T0>>(arg0),
            settled_py_index : arg0.settled_py_index,
        };
        0x2::event::emit<SettlementEvent>(v2);
    }

    public(friend) fun settle_external_pt_redeem<T0: drop>(arg0: &PyState<T0>, arg1: ExternalPtRedeemReceipt, arg2: u64) {
        let ExternalPtRedeemReceipt {
            state_id  : v0,
            pt_amount : v1,
        } = arg1;
        assert!(v0 == state_id<T0>(arg0), 1204);
        assert!(v1 == arg2, 702);
    }

    public fun settled_py_index<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.settled_py_index
    }

    public(friend) fun split_interest_fee(arg0: u128, arg1: u128) : (u128, u128) {
        if (arg0 == 0) {
            return (0, 0)
        };
        let v0 = (((arg0 as u256) * (arg1 as u256) / (18446744073709551616 as u256)) as u128);
        (arg0 - v0, v0)
    }

    public(friend) fun split_sy<T0: drop>(arg0: &mut PyState<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.sy_balance) >= arg1, 705);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.sy_balance, arg1), arg2)
    }

    public fun state_id<T0: drop>(arg0: &PyState<T0>) : 0x2::object::ID {
        0x2::object::id<PyState<T0>>(arg0)
    }

    public fun sy_balance_value<T0: drop>(arg0: &PyState<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.sy_balance)
    }

    public(friend) fun sy_to_asset(arg0: u128, arg1: u128) : u128 {
        (((arg1 as u256) * (arg0 as u256) / (18446744073709551616 as u256)) as u128)
    }

    public fun total_treasury_interest<T0: drop>(arg0: &PyState<T0>) : u128 {
        arg0.total_treasury_interest
    }

    public fun treasury<T0: drop>(arg0: &PyState<T0>) : address {
        arg0.treasury
    }

    public(friend) fun update_global_interest_index(arg0: u128, arg1: u128, arg2: u64) : u128 {
        let v0 = arg0;
        if (arg0 == 0) {
            v0 = 18446744073709551616;
        };
        if (arg2 == 0 || arg1 == 0) {
            return v0
        };
        v0 + (((arg1 as u256) * (18446744073709551616 as u256) / (((arg2 as u128) * 18446744073709551616) as u256)) as u128)
    }

    public(friend) fun update_interest_index<T0: drop>(arg0: &mut PyState<T0>, arg1: u128, arg2: u128, arg3: &0x2::clock::Clock) : (u128, u128, u128) {
        if (arg0.is_settled) {
            let v0 = if (arg0.global_interest_index == 0) {
                18446744073709551616
            } else {
                arg0.global_interest_index
            };
            return (v0, arg0.settled_py_index, 0)
        };
        arg0.last_interest_timestamp = 0x2::clock::timestamp_ms(arg3);
        let v1 = update_py_index<T0>(arg0, arg2, arg3);
        let v2 = arg0.last_collect_interest_index;
        let v3 = 0;
        let v4 = 0;
        if (v2 > 0 && v1 > v2) {
            let (v5, v6) = split_interest_fee(calc_interest((arg0.yt_supply as u128) * 18446744073709551616, v2, v1), arg1);
            v3 = v5;
            v4 = v6;
            arg0.total_treasury_interest = arg0.total_treasury_interest + v6;
        };
        arg0.last_collect_interest_index = v1;
        let v7 = update_global_interest_index(arg0.global_interest_index, v3, arg0.yt_supply);
        arg0.global_interest_index = v7;
        let v8 = InterestCollectedEvent{
            state_id              : 0x2::object::id<PyState<T0>>(arg0),
            user_interest_raw     : v3,
            treasury_interest_raw : v4,
            py_index_raw          : v1,
        };
        0x2::event::emit<InterestCollectedEvent>(v8);
        (v7, v1, v4)
    }

    public(friend) fun update_py_index<T0: drop>(arg0: &mut PyState<T0>, arg1: u128, arg2: &0x2::clock::Clock) : u128 {
        let v0 = current_py_index(arg1, arg0.py_index_stored);
        arg0.py_index_stored = v0;
        arg0.py_index_last_updated = 0x2::clock::timestamp_ms(arg2);
        v0
    }

    public(friend) fun update_user_interest<T0: drop>(arg0: &mut PyState<T0>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: u128, arg3: u128, arg4: &0x2::clock::Clock) : u128 {
        let (v0, v1, v2) = update_interest_index<T0>(arg0, arg2, arg3, arg4);
        let v3 = 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::index(arg1);
        if (v3 == 0) {
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::set_index(arg1, v0);
            0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::set_py_index(arg1, v1);
            return v2
        };
        if (v3 == v0) {
            return v2
        };
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::set_accrued(arg1, calc_user_accrued(0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::accrued(arg1), 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::yt_balance(arg1), v0, v3));
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::set_index(arg1, v0);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::set_py_index(arg1, v1);
        v2
    }

    public(friend) fun update_user_interest_before_expiry<T0: drop>(arg0: 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::PriceInfo<T0>, arg1: &mut 0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::JitterPosition, arg2: &mut PyState<T0>, arg3: &0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::GlobalConfig, arg4: &0x2::clock::Clock) : u128 {
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::global_config::assert_py_state_active(arg3, state_id<T0>(arg2));
        assert!(!is_expired(expiry<T0>(arg2), 0x2::clock::timestamp_ms(arg4)), 1201);
        0xf1fd761493f6011ba6be55012fac15443a10115eaf158109a52c231cc2c684d::jitter_position::assert_state_match(arg1, state_id<T0>(arg2));
        let v0 = 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::price_info::consume<T0>(arg0, market_id<T0>(arg2), arg4);
        let v1 = arg2.interest_fee_rate;
        update_user_interest<T0>(arg2, arg1, v1, v0, arg4)
    }

    public fun yt_reward_distributor_id<T0: drop>(arg0: &PyState<T0>) : 0x2::object::ID {
        assert!(yt_reward_distributor_required<T0>(arg0), 1205);
        let v0 = YtRewardRequiredKey{dummy_field: false};
        0x2::dynamic_field::borrow<YtRewardRequiredKey, YtRewardRequired>(&arg0.id, v0).distributor_id
    }

    public fun yt_reward_distributor_required<T0: drop>(arg0: &PyState<T0>) : bool {
        let v0 = YtRewardRequiredKey{dummy_field: false};
        0x2::dynamic_field::exists_<YtRewardRequiredKey>(&arg0.id, v0)
    }

    public fun yt_reward_gate_open<T0: drop>(arg0: &PyState<T0>) : bool {
        let v0 = YtRewardGateKey{dummy_field: false};
        0x2::dynamic_field::exists_<YtRewardGateKey>(&arg0.id, v0)
    }

    public fun yt_supply<T0: drop>(arg0: &PyState<T0>) : u64 {
        arg0.yt_supply
    }

    // decompiled from Move bytecode v7
}

