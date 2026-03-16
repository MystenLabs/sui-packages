module 0xc24d9c40422f4364d8b1efe1e5007e4e295518189ac548e1cadef61d3af094ed::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    struct FeeManager has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        dao_creation_fee: u64,
        proposal_creation_fee_per_outcome: u64,
        launchpad_creation_fee: u64,
        pending_dao_creation_fee: 0x1::option::Option<u64>,
        pending_dao_creation_fee_effective_ts: 0x1::option::Option<u64>,
        pending_proposal_fee: 0x1::option::Option<u64>,
        pending_proposal_fee_effective_ts: 0x1::option::Option<u64>,
        pending_launchpad_fee: 0x1::option::Option<u64>,
        pending_launchpad_fee_effective_ts: 0x1::option::Option<u64>,
        dao_fee_baseline: u64,
        proposal_fee_baseline: u64,
        launchpad_fee_baseline: u64,
        dao_baseline_reset_ts: u64,
        proposal_baseline_reset_ts: u64,
        launchpad_baseline_reset_ts: u64,
    }

    struct FeeAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CoinFeeConfig has store {
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        dao_creation_fee: u64,
        proposal_creation_fee_per_outcome: u64,
        pending_creation_fee: 0x1::option::Option<u64>,
        pending_creation_fee_effective_timestamp: 0x1::option::Option<u64>,
        pending_proposal_fee: 0x1::option::Option<u64>,
        pending_proposal_fee_effective_timestamp: 0x1::option::Option<u64>,
        creation_fee_baseline: u64,
        proposal_fee_baseline: u64,
        creation_baseline_reset_timestamp: u64,
        proposal_baseline_reset_timestamp: u64,
    }

    struct DAOCreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
        timestamp: u64,
    }

    struct ProposalCreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee_per_outcome: u64,
        admin: address,
        timestamp: u64,
    }

    struct LaunchpadCreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
        admin: address,
        timestamp: u64,
    }

    struct DAOCreationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct ProposalCreationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct LaunchpadCreationFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct LaunchpadBidFeeCollected has copy, drop {
        amount: u64,
        payer: address,
        timestamp: u64,
    }

    struct FeesCollected has copy, drop {
        amount: u64,
        coin_type: 0x1::ascii::String,
        proposal_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        coin_type: 0x1::ascii::String,
        recipient: address,
        timestamp: u64,
    }

    struct GlobalFeeIncreaseScheduled has copy, drop {
        fee_type: u8,
        current_fee: u64,
        scheduled_fee: u64,
        effective_timestamp: u64,
        admin: address,
        timestamp: u64,
    }

    struct GlobalFeesPendingApplied has copy, drop {
        dao_fee_applied: bool,
        new_dao_fee: u64,
        proposal_fee_applied: bool,
        new_proposal_fee: u64,
        launchpad_fee_applied: bool,
        new_launchpad_fee: u64,
        timestamp: u64,
    }

    struct FeeRegistry<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_coin_fee_config(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: 0x1::type_name::TypeName, arg3: u8, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        assert!(!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg2), 13);
        let v0 = CoinFeeConfig{
            coin_type                                : arg2,
            decimals                                 : arg3,
            dao_creation_fee                         : arg4,
            proposal_creation_fee_per_outcome        : arg5,
            pending_creation_fee                     : 0x1::option::none<u64>(),
            pending_creation_fee_effective_timestamp : 0x1::option::none<u64>(),
            pending_proposal_fee                     : 0x1::option::none<u64>(),
            pending_proposal_fee_effective_timestamp : 0x1::option::none<u64>(),
            creation_fee_baseline                    : arg4,
            proposal_fee_baseline                    : arg5,
            creation_baseline_reset_timestamp        : 0x2::clock::timestamp_ms(arg6),
            proposal_baseline_reset_timestamp        : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, CoinFeeConfig>(&mut arg0.id, arg2, v0);
    }

    public entry fun add_coin_fee_config_entry<T0>(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        add_coin_fee_config(arg0, arg1, 0x1::type_name::get<T0>(), arg2, arg3, arg4, arg5, arg6);
    }

    public fun apply_pending_coin_fees(arg0: &mut FeeManager, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) {
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1)) {
            return
        };
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CoinFeeConfig>(&mut arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (0x1::option::is_some<u64>(&v0.pending_creation_fee_effective_timestamp)) {
            if (v1 >= *0x1::option::borrow<u64>(&v0.pending_creation_fee_effective_timestamp)) {
                if (0x1::option::is_some<u64>(&v0.pending_creation_fee)) {
                    v0.dao_creation_fee = *0x1::option::borrow<u64>(&v0.pending_creation_fee);
                    v0.pending_creation_fee = 0x1::option::none<u64>();
                };
                v0.pending_creation_fee_effective_timestamp = 0x1::option::none<u64>();
            };
        };
        if (0x1::option::is_some<u64>(&v0.pending_proposal_fee_effective_timestamp)) {
            if (v1 >= *0x1::option::borrow<u64>(&v0.pending_proposal_fee_effective_timestamp)) {
                if (0x1::option::is_some<u64>(&v0.pending_proposal_fee)) {
                    v0.proposal_creation_fee_per_outcome = *0x1::option::borrow<u64>(&v0.pending_proposal_fee);
                    v0.pending_proposal_fee = 0x1::option::none<u64>();
                };
                v0.pending_proposal_fee_effective_timestamp = 0x1::option::none<u64>();
            };
        };
    }

    public fun apply_pending_global_fees(arg0: &mut FeeManager, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = false;
        let v2 = false;
        let v3 = false;
        if (0x1::option::is_some<u64>(&arg0.pending_dao_creation_fee_effective_ts)) {
            if (v0 >= *0x1::option::borrow<u64>(&arg0.pending_dao_creation_fee_effective_ts)) {
                if (0x1::option::is_some<u64>(&arg0.pending_dao_creation_fee)) {
                    arg0.dao_creation_fee = *0x1::option::borrow<u64>(&arg0.pending_dao_creation_fee);
                    arg0.pending_dao_creation_fee = 0x1::option::none<u64>();
                    v1 = true;
                };
                arg0.pending_dao_creation_fee_effective_ts = 0x1::option::none<u64>();
            };
        };
        if (0x1::option::is_some<u64>(&arg0.pending_proposal_fee_effective_ts)) {
            if (v0 >= *0x1::option::borrow<u64>(&arg0.pending_proposal_fee_effective_ts)) {
                if (0x1::option::is_some<u64>(&arg0.pending_proposal_fee)) {
                    arg0.proposal_creation_fee_per_outcome = *0x1::option::borrow<u64>(&arg0.pending_proposal_fee);
                    arg0.pending_proposal_fee = 0x1::option::none<u64>();
                    v2 = true;
                };
                arg0.pending_proposal_fee_effective_ts = 0x1::option::none<u64>();
            };
        };
        if (0x1::option::is_some<u64>(&arg0.pending_launchpad_fee_effective_ts)) {
            if (v0 >= *0x1::option::borrow<u64>(&arg0.pending_launchpad_fee_effective_ts)) {
                if (0x1::option::is_some<u64>(&arg0.pending_launchpad_fee)) {
                    arg0.launchpad_creation_fee = *0x1::option::borrow<u64>(&arg0.pending_launchpad_fee);
                    arg0.pending_launchpad_fee = 0x1::option::none<u64>();
                    v3 = true;
                };
                arg0.pending_launchpad_fee_effective_ts = 0x1::option::none<u64>();
            };
        };
        let v4 = if (v1) {
            true
        } else if (v2) {
            true
        } else {
            v3
        };
        if (v4) {
            let v5 = GlobalFeesPendingApplied{
                dao_fee_applied       : v1,
                new_dao_fee           : arg0.dao_creation_fee,
                proposal_fee_applied  : v2,
                new_proposal_fee      : arg0.proposal_creation_fee_per_outcome,
                launchpad_fee_applied : v3,
                new_launchpad_fee     : arg0.launchpad_creation_fee,
                timestamp             : v0,
            };
            0x2::event::emit<GlobalFeesPendingApplied>(v5);
        };
    }

    public fun assert_admin_cap(arg0: &FeeManager, arg1: &FeeAdminCap) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
    }

    public fun deposit_dao_creation_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        apply_pending_global_fees(arg0, arg2);
        let v0 = arg0.dao_creation_fee;
        let v1 = DAOCreationFeeCollected{
            amount    : deposit_payment(arg0, v0, arg1, arg2),
            payer     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DAOCreationFeeCollected>(v1);
    }

    public fun deposit_fees<T0>(arg0: &mut FeeManager, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) {
        deposit_fees_with_proposal<T0>(arg0, arg1, 0x2::object::id_from_address(@0x0), arg2);
    }

    public fun deposit_fees_with_proposal<T0>(arg0: &mut FeeManager, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = FeeRegistry<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v1)) {
            let v2 = FeeRegistry<T0>{dummy_field: false};
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v2), arg1);
        } else {
            let v3 = FeeRegistry<T0>{dummy_field: false};
            0x2::dynamic_field::add<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v3, arg1);
        };
        let v4 = FeesCollected{
            amount      : v0,
            coin_type   : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            proposal_id : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesCollected>(v4);
    }

    public fun deposit_launchpad_bid_fee(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = LaunchpadBidFeeCollected{
            amount    : deposit_payment(arg0, arg2, arg1, arg3),
            payer     : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<LaunchpadBidFeeCollected>(v0);
    }

    public fun deposit_launchpad_creation_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        apply_pending_global_fees(arg0, arg2);
        let v0 = arg0.launchpad_creation_fee;
        let v1 = LaunchpadCreationFeeCollected{
            amount    : deposit_payment(arg0, v0, arg1, arg2),
            payer     : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<LaunchpadCreationFeeCollected>(v1);
    }

    fun deposit_payment(arg0: &mut FeeManager, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 == arg1, 0);
        deposit_fees<0x2::sui::SUI>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2), arg3);
        v0
    }

    public fun deposit_proposal_creation_payment(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        apply_pending_global_fees(arg0, arg3);
        let v0 = (arg0.proposal_creation_fee_per_outcome as u128) * (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 6);
        let v1 = ProposalCreationFeeCollected{
            amount    : deposit_payment(arg0, (v0 as u64), arg1, arg3),
            payer     : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ProposalCreationFeeCollected>(v1);
    }

    public fun get_coin_fee_config(arg0: &FeeManager, arg1: 0x1::type_name::TypeName) : &CoinFeeConfig {
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg1), 1);
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, CoinFeeConfig>(&arg0.id, arg1)
    }

    public fun get_dao_creation_fee(arg0: &FeeManager) : u64 {
        arg0.dao_creation_fee
    }

    public fun get_fee_balance<T0>(arg0: &FeeManager) : u64 {
        let v0 = FeeRegistry<T0>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            let v2 = FeeRegistry<T0>{dummy_field: false};
            0x2::balance::value<T0>(0x2::dynamic_field::borrow<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun get_launchpad_creation_fee(arg0: &FeeManager) : u64 {
        arg0.launchpad_creation_fee
    }

    public fun get_proposal_creation_fee_per_outcome(arg0: &FeeManager) : u64 {
        arg0.proposal_creation_fee_per_outcome
    }

    public fun get_sui_balance(arg0: &FeeManager) : u64 {
        get_fee_balance<0x2::sui::SUI>(arg0)
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<FEE>(&arg0), 2);
        let v0 = FeeAdminCap{id: 0x2::object::new(arg1)};
        let v1 = FeeManager{
            id                                    : 0x2::object::new(arg1),
            admin_cap_id                          : 0x2::object::id<FeeAdminCap>(&v0),
            dao_creation_fee                      : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_dao_creation_fee(),
            proposal_creation_fee_per_outcome     : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_proposal_fee_per_outcome(),
            launchpad_creation_fee                : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_launchpad_creation_fee(),
            pending_dao_creation_fee              : 0x1::option::none<u64>(),
            pending_dao_creation_fee_effective_ts : 0x1::option::none<u64>(),
            pending_proposal_fee                  : 0x1::option::none<u64>(),
            pending_proposal_fee_effective_ts     : 0x1::option::none<u64>(),
            pending_launchpad_fee                 : 0x1::option::none<u64>(),
            pending_launchpad_fee_effective_ts    : 0x1::option::none<u64>(),
            dao_fee_baseline                      : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_dao_creation_fee(),
            proposal_fee_baseline                 : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_proposal_fee_per_outcome(),
            launchpad_fee_baseline                : 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::default_launchpad_creation_fee(),
            dao_baseline_reset_ts                 : 0,
            proposal_baseline_reset_ts            : 0,
            launchpad_baseline_reset_ts           : 0,
        };
        0x2::transfer::public_share_object<FeeManager>(v1);
        0x2::transfer::public_transfer<FeeAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun max_allowed_from_baseline(arg0: u64) : u64 {
        if (arg0 > 18446744073709551615 / 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::max_fee_multiplier()) {
            18446744073709551615
        } else {
            arg0 * 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::max_fee_multiplier()
        }
    }

    fun resettable_baseline(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 > 0) {
            return arg0
        };
        if (arg1 > 0) {
            return arg1
        };
        if (arg2 > 0) {
            return arg2
        };
        1
    }

    public fun update_coin_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg2), 1);
        apply_pending_coin_fees(arg0, arg2, arg4);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CoinFeeConfig>(&mut arg0.id, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (v1 >= v0.creation_baseline_reset_timestamp + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms()) {
            v0.creation_fee_baseline = resettable_baseline(v0.dao_creation_fee, 0, v0.creation_fee_baseline);
            v0.creation_baseline_reset_timestamp = v1;
        };
        assert!(arg3 <= max_allowed_from_baseline(v0.creation_fee_baseline), 12);
        if (arg3 <= v0.dao_creation_fee) {
            v0.dao_creation_fee = arg3;
            v0.pending_creation_fee = 0x1::option::none<u64>();
            v0.pending_creation_fee_effective_timestamp = 0x1::option::none<u64>();
        } else {
            v0.pending_creation_fee = 0x1::option::some<u64>(arg3);
            v0.pending_creation_fee_effective_timestamp = 0x1::option::some<u64>(v1 + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms());
        };
    }

    public fun update_coin_proposal_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, arg2), 1);
        apply_pending_coin_fees(arg0, arg2, arg4);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, CoinFeeConfig>(&mut arg0.id, arg2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        if (v1 >= v0.proposal_baseline_reset_timestamp + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms()) {
            v0.proposal_fee_baseline = resettable_baseline(v0.proposal_creation_fee_per_outcome, 0, v0.proposal_fee_baseline);
            v0.proposal_baseline_reset_timestamp = v1;
        };
        assert!(arg3 <= max_allowed_from_baseline(v0.proposal_fee_baseline), 12);
        if (arg3 <= v0.proposal_creation_fee_per_outcome) {
            v0.proposal_creation_fee_per_outcome = arg3;
            v0.pending_proposal_fee = 0x1::option::none<u64>();
            v0.pending_proposal_fee_effective_timestamp = 0x1::option::none<u64>();
        } else {
            v0.pending_proposal_fee = 0x1::option::some<u64>(arg3);
            v0.pending_proposal_fee_effective_timestamp = 0x1::option::some<u64>(v1 + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms());
        };
    }

    public entry fun update_dao_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        apply_pending_global_fees(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 >= arg0.dao_baseline_reset_ts + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms()) {
            arg0.dao_fee_baseline = resettable_baseline(arg0.dao_creation_fee, 0, arg0.dao_fee_baseline);
            arg0.dao_baseline_reset_ts = v0;
        };
        assert!(arg2 <= max_allowed_from_baseline(arg0.dao_fee_baseline), 12);
        let v1 = arg0.dao_creation_fee;
        if (arg2 <= v1) {
            arg0.dao_creation_fee = arg2;
            arg0.pending_dao_creation_fee = 0x1::option::none<u64>();
            arg0.pending_dao_creation_fee_effective_ts = 0x1::option::none<u64>();
            let v2 = DAOCreationFeeUpdated{
                old_fee   : v1,
                new_fee   : arg2,
                admin     : 0x2::tx_context::sender(arg4),
                timestamp : v0,
            };
            0x2::event::emit<DAOCreationFeeUpdated>(v2);
        } else {
            let v3 = v0 + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms();
            arg0.pending_dao_creation_fee = 0x1::option::some<u64>(arg2);
            arg0.pending_dao_creation_fee_effective_ts = 0x1::option::some<u64>(v3);
            let v4 = GlobalFeeIncreaseScheduled{
                fee_type            : 0,
                current_fee         : v1,
                scheduled_fee       : arg2,
                effective_timestamp : v3,
                admin               : 0x2::tx_context::sender(arg4),
                timestamp           : v0,
            };
            0x2::event::emit<GlobalFeeIncreaseScheduled>(v4);
        };
    }

    public entry fun update_launchpad_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        apply_pending_global_fees(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 >= arg0.launchpad_baseline_reset_ts + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms()) {
            arg0.launchpad_fee_baseline = resettable_baseline(arg0.launchpad_creation_fee, 0, arg0.launchpad_fee_baseline);
            arg0.launchpad_baseline_reset_ts = v0;
        };
        assert!(arg2 <= max_allowed_from_baseline(arg0.launchpad_fee_baseline), 12);
        let v1 = arg0.launchpad_creation_fee;
        if (arg2 <= v1) {
            arg0.launchpad_creation_fee = arg2;
            arg0.pending_launchpad_fee = 0x1::option::none<u64>();
            arg0.pending_launchpad_fee_effective_ts = 0x1::option::none<u64>();
            let v2 = LaunchpadCreationFeeUpdated{
                old_fee   : v1,
                new_fee   : arg2,
                admin     : 0x2::tx_context::sender(arg4),
                timestamp : v0,
            };
            0x2::event::emit<LaunchpadCreationFeeUpdated>(v2);
        } else {
            let v3 = v0 + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms();
            arg0.pending_launchpad_fee = 0x1::option::some<u64>(arg2);
            arg0.pending_launchpad_fee_effective_ts = 0x1::option::some<u64>(v3);
            let v4 = GlobalFeeIncreaseScheduled{
                fee_type            : 2,
                current_fee         : v1,
                scheduled_fee       : arg2,
                effective_timestamp : v3,
                admin               : 0x2::tx_context::sender(arg4),
                timestamp           : v0,
            };
            0x2::event::emit<GlobalFeeIncreaseScheduled>(v4);
        };
    }

    public entry fun update_proposal_creation_fee(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        apply_pending_global_fees(arg0, arg3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (v0 >= arg0.proposal_baseline_reset_ts + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms()) {
            arg0.proposal_fee_baseline = resettable_baseline(arg0.proposal_creation_fee_per_outcome, 0, arg0.proposal_fee_baseline);
            arg0.proposal_baseline_reset_ts = v0;
        };
        assert!(arg2 <= max_allowed_from_baseline(arg0.proposal_fee_baseline), 12);
        let v1 = arg0.proposal_creation_fee_per_outcome;
        if (arg2 <= v1) {
            arg0.proposal_creation_fee_per_outcome = arg2;
            arg0.pending_proposal_fee = 0x1::option::none<u64>();
            arg0.pending_proposal_fee_effective_ts = 0x1::option::none<u64>();
            let v2 = ProposalCreationFeeUpdated{
                old_fee             : v1,
                new_fee_per_outcome : arg2,
                admin               : 0x2::tx_context::sender(arg4),
                timestamp           : v0,
            };
            0x2::event::emit<ProposalCreationFeeUpdated>(v2);
        } else {
            let v3 = v0 + 0xcf1218ee7d7e2610b8bc7da9c1d513c230b94e470e57cf4e9260b6da64318f12::constants::six_months_ms();
            arg0.pending_proposal_fee = 0x1::option::some<u64>(arg2);
            arg0.pending_proposal_fee_effective_ts = 0x1::option::some<u64>(v3);
            let v4 = GlobalFeeIncreaseScheduled{
                fee_type            : 1,
                current_fee         : v1,
                scheduled_fee       : arg2,
                effective_timestamp : v3,
                admin               : 0x2::tx_context::sender(arg4),
                timestamp           : v0,
            };
            0x2::event::emit<GlobalFeeIncreaseScheduled>(v4);
        };
    }

    public fun withdraw_fees_as_coin<T0>(arg0: &mut FeeManager, arg1: &FeeAdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::object::id<FeeAdminCap>(arg1) == arg0.admin_cap_id, 7);
        let v0 = FeeRegistry<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&arg0.id, v0)) {
            return 0x2::coin::zero<T0>(arg4)
        };
        let v1 = FeeRegistry<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FeeRegistry<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v1);
        let v3 = if (arg2 == 0) {
            0x2::balance::value<T0>(v2)
        } else {
            arg2
        };
        if (v3 == 0) {
            return 0x2::coin::zero<T0>(arg4)
        };
        assert!(0x2::balance::value<T0>(v2) >= v3, 5);
        let v4 = FeesWithdrawn{
            amount    : v3,
            coin_type : 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()),
            recipient : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<FeesWithdrawn>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v2, v3), arg4)
    }

    // decompiled from Move bytecode v6
}

