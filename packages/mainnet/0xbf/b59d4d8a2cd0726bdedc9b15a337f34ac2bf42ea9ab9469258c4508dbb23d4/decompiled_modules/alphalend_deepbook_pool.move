module 0xbfb59d4d8a2cd0726bdedc9b15a337f34ac2bf42ea9ab9469258c4508dbb23d4::alphalend_deepbook_pool {
    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        lst_treasury_cap: 0x2::coin::TreasuryCap<DEEPBOOK_STAKED<T0>>,
        total_deposited: u64,
        total_lst_supply: u64,
        is_paused: bool,
        is_deposit_paused: bool,
        deposit_limit: u64,
        min_deposit_amount: u64,
        withdrawal_fee_bps: u64,
        spread_fee_bps: u64,
        disabled_admin_caps: 0x2::vec_set::VecSet<0x2::object::ID>,
        supplier_cap: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap,
        referrer: 0x2::object::ID,
        collected_fees: u64,
        version: u64,
        last_refreshed_at: u64,
    }

    struct PoolAdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct DEEPBOOK_STAKED<phantom T0> has key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        amount: u64,
        lst_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        pool_id: 0x2::object::ID,
        amount: u64,
        fee: u64,
        lst_burned: u64,
    }

    struct AutoCompoundingEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        profit: u64,
        fee_collected: u64,
        total_deposited: u64,
        user_assets: u64,
        total_lst_supply: u64,
    }

    struct FeesClaimedEvent has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        claim_amount: u64,
        recipient: 0x1::option::Option<address>,
    }

    struct PoolXTokenRatio has copy, drop, store {
        pool_id: 0x2::object::ID,
        ratio: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        lst_type: 0x1::type_name::TypeName,
        base_type: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    public fun withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: 0x2::coin::Coin<DEEPBOOK_STAKED<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_and_upgrade_version<T0>(arg0);
        assert!(!arg0.is_paused, 7);
        refresh_total_deposited<T0>(arg0, arg1, arg4);
        let v0 = 0x2::coin::value<DEEPBOOK_STAKED<T0>>(&arg3);
        if (v0 == 0) {
            0x2::coin::destroy_zero<DEEPBOOK_STAKED<T0>>(arg3);
            return 0x2::coin::zero<T0>(arg5)
        };
        let v1 = compute_withdraw_amount<T0>(arg0, v0);
        let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::bps_round_up(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), arg0.withdrawal_fee_bps));
        let v3 = v1 - v2;
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::ge(get_user_assets<T0>(arg0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1)), 2);
        0x2::coin::burn<DEEPBOOK_STAKED<T0>>(&mut arg0.lst_treasury_cap, arg3);
        arg0.collected_fees = arg0.collected_fees + v2;
        arg0.total_deposited = arg0.total_deposited - v3;
        arg0.total_lst_supply = arg0.total_lst_supply - v0;
        let v4 = WithdrawEvent{
            user       : 0x2::tx_context::sender(arg5),
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : 0x2::object::id<Pool<T0>>(arg0),
            amount     : v3,
            fee        : v2,
            lst_burned : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg1, arg2, &arg0.supplier_cap, 0x1::option::some<u64>(v3), arg4, arg5)
    }

    public(friend) fun assert_version<T0>(arg0: &Pool<T0>) {
        assert!(arg0.version == 1, 9);
    }

    public(friend) fun check_and_upgrade_version<T0>(arg0: &mut Pool<T0>) {
        assert!(arg0.version <= 1, 9);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun claim_fees<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &mut PoolAdminCap<T0>, arg4: u64, arg5: 0x1::option::Option<address>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg3);
        refresh_total_deposited<T0>(arg0, arg1, arg6);
        let v0 = if (arg4 == 0) {
            arg0.collected_fees
        } else {
            0x1::u64::min(arg4, arg0.collected_fees)
        };
        assert!(v0 > 0, 3);
        arg0.collected_fees = arg0.collected_fees - v0;
        arg0.total_deposited = arg0.total_deposited - v0;
        let v1 = FeesClaimedEvent{
            pool_id      : 0x2::object::id<Pool<T0>>(arg0),
            coin_type    : 0x1::type_name::with_defining_ids<T0>(),
            claim_amount : v0,
            recipient    : arg5,
        };
        0x2::event::emit<FeesClaimedEvent>(v1);
        if (0x1::option::is_some<address>(&arg5)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg1, arg2, &arg0.supplier_cap, 0x1::option::some<u64>(v0), arg6, arg7), 0x1::option::extract<address>(&mut arg5));
            0x1::option::destroy_some<address>(arg5);
            0x2::coin::zero<T0>(arg7)
        } else {
            0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg1, arg2, &arg0.supplier_cap, 0x1::option::some<u64>(v0), arg6, arg7)
        }
    }

    fun compute_lst_to_mint<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg1), get_exchange_rate<T0>(arg0)))
    }

    fun compute_withdraw_amount<T0>(arg0: &Pool<T0>, arg1: u64) : u64 {
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg1), get_exchange_rate<T0>(arg0)))
    }

    public(friend) fun create<T0>(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &0x2::clock::Clock, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Pool<T0> {
        let (v0, v1) = 0x2::coin_registry::new_currency<DEEPBOOK_STAKED<T0>>(arg0, arg4, 0x1::string::utf8(b"DEEPBOOK_STAKED"), 0x1::string::utf8(b"DeepBook Staked Token by Alphalend"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg5);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DEEPBOOK_STAKED<T0>>>(0x2::coin_registry::finalize<DEEPBOOK_STAKED<T0>>(v0, arg5), 0x2::tx_context::sender(arg5));
        Pool<T0>{
            id                  : 0x2::object::new(arg5),
            lst_treasury_cap    : v1,
            total_deposited     : 0,
            total_lst_supply    : 0,
            is_paused           : false,
            is_deposit_paused   : false,
            deposit_limit       : 0,
            min_deposit_amount  : 0,
            withdrawal_fee_bps  : 0,
            spread_fee_bps      : 0,
            disabled_admin_caps : 0x2::vec_set::empty<0x2::object::ID>(),
            supplier_cap        : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg2, arg3, arg5),
            referrer            : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg1, arg2, arg3, arg5),
            collected_fees      : 0,
            version             : 1,
            last_refreshed_at   : 0x2::clock::timestamp_ms(arg3),
        }
    }

    public(friend) fun create_pool_admin_cap<T0>(arg0: &Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : PoolAdminCap<T0> {
        assert_version<T0>(arg0);
        PoolAdminCap<T0>{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::id<Pool<T0>>(arg0),
        }
    }

    public fun deposit<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<DEEPBOOK_STAKED<T0>> {
        check_and_upgrade_version<T0>(arg0);
        refresh_total_deposited<T0>(arg0, arg1, arg4);
        assert!(!arg0.is_paused, 7);
        assert!(!arg0.is_deposit_paused, 7);
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 3);
        assert!(v0 >= arg0.min_deposit_amount, 8);
        assert!(arg0.total_deposited + v0 <= arg0.deposit_limit, 6);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg1, arg2, &arg0.supplier_cap, arg3, 0x1::option::some<0x2::object::ID>(arg0.referrer), arg4);
        let v1 = compute_lst_to_mint<T0>(arg0, v0);
        arg0.total_deposited = arg0.total_deposited + v0;
        arg0.total_lst_supply = arg0.total_lst_supply + v1;
        let v2 = DepositEvent{
            user       : 0x2::tx_context::sender(arg5),
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            pool_id    : 0x2::object::id<Pool<T0>>(arg0),
            amount     : v0,
            lst_minted : v1,
        };
        0x2::event::emit<DepositEvent>(v2);
        0x2::coin::mint<DEEPBOOK_STAKED<T0>>(&mut arg0.lst_treasury_cap, v1, arg5)
    }

    public(friend) fun disable_pool_admin_cap<T0>(arg0: &mut Pool<T0>, arg1: 0x2::object::ID) {
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.disabled_admin_caps, arg1);
    }

    public fun get_deposit_limit<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.deposit_limit
    }

    public fun get_exchange_rate<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        assert_version<T0>(arg0);
        if (arg0.total_lst_supply == 0) {
            return 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1)
        };
        0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(get_user_assets<T0>(arg0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.total_lst_supply))
    }

    public fun get_min_deposit_amount<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.min_deposit_amount
    }

    public fun get_pool_xtoken_ratio<T0>(arg0: &Pool<T0>) : PoolXTokenRatio {
        assert_version<T0>(arg0);
        PoolXTokenRatio{
            pool_id   : 0x2::object::id<Pool<T0>>(arg0),
            ratio     : get_exchange_rate<T0>(arg0),
            lst_type  : 0x1::type_name::with_defining_ids<DEEPBOOK_STAKED<T0>>(),
            base_type : 0x1::type_name::with_defining_ids<T0>(),
            timestamp : arg0.last_refreshed_at,
        }
    }

    public fun get_spread_fee_bps<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.spread_fee_bps
    }

    public(friend) fun get_supplier_cap<T0>(arg0: &mut Pool<T0>) : &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap {
        &mut arg0.supplier_cap
    }

    public fun get_total_deposited<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_deposited
    }

    public fun get_total_lst_supply<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.total_lst_supply
    }

    fun get_user_assets<T0>(arg0: &Pool<T0>) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        if (arg0.total_deposited <= arg0.collected_fees) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.total_deposited - arg0.collected_fees)
        }
    }

    public fun get_withdrawal_fee_bps<T0>(arg0: &Pool<T0>) : u64 {
        assert_version<T0>(arg0);
        arg0.withdrawal_fee_bps
    }

    public fun is_paused<T0>(arg0: &Pool<T0>) : bool {
        assert_version<T0>(arg0);
        arg0.is_paused
    }

    public fun pool_xtoken_ratio_base_type(arg0: &PoolXTokenRatio) : 0x1::type_name::TypeName {
        arg0.base_type
    }

    public fun pool_xtoken_ratio_lst_type(arg0: &PoolXTokenRatio) : 0x1::type_name::TypeName {
        arg0.lst_type
    }

    public fun pool_xtoken_ratio_pool_id(arg0: &PoolXTokenRatio) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_xtoken_ratio_ratio(arg0: &PoolXTokenRatio) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.ratio
    }

    public fun pool_xtoken_ratio_timestamp(arg0: &PoolXTokenRatio) : u64 {
        arg0.timestamp
    }

    fun refresh_total_deposited<T0>(arg0: &mut Pool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) {
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg0.supplier_cap), arg2);
        if (v0 > arg0.total_deposited) {
            let v1 = v0 - arg0.total_deposited;
            let v2 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::bps_round_up(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), arg0.spread_fee_bps));
            if (v2 > 0) {
                arg0.collected_fees = arg0.collected_fees + v2;
                let v3 = AutoCompoundingEvent{
                    pool_id          : 0x2::object::id<Pool<T0>>(arg0),
                    coin_type        : 0x1::type_name::with_defining_ids<T0>(),
                    profit           : v1,
                    fee_collected    : v2,
                    total_deposited  : v0,
                    user_assets      : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(get_user_assets<T0>(arg0)),
                    total_lst_supply : arg0.total_lst_supply,
                };
                0x2::event::emit<AutoCompoundingEvent>(v3);
            };
        };
        arg0.total_deposited = v0;
        arg0.last_refreshed_at = 0x2::clock::timestamp_ms(arg2);
    }

    public fun set_deposit_limit<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>, arg2: u64) {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg1);
        arg0.deposit_limit = arg2;
    }

    public fun set_is_deposit_paused<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>, arg2: bool) {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg1);
        arg0.is_deposit_paused = arg2;
    }

    public fun set_is_paused<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>, arg2: bool) {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg1);
        arg0.is_paused = arg2;
    }

    public fun set_spread_fee_bps<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>, arg2: u64, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x2::clock::Clock) {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg1);
        refresh_total_deposited<T0>(arg0, arg3, arg4);
        assert!(arg2 <= 10000, 3);
        arg0.spread_fee_bps = arg2;
    }

    public fun set_withdrawal_fee_bps<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>, arg2: u64) {
        check_and_upgrade_version<T0>(arg0);
        validate_pool_admin_cap<T0>(arg0, arg1);
        assert!(arg2 <= 10000, 3);
        arg0.withdrawal_fee_bps = arg2;
    }

    public(friend) fun share_pool<T0>(arg0: Pool<T0>) {
        0x2::transfer::share_object<Pool<T0>>(arg0);
    }

    public entry fun try_deposit<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = deposit<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DEEPBOOK_STAKED<T0>>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun try_withdraw<T0>(arg0: &mut Pool<T0>, arg1: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: 0x2::coin::Coin<DEEPBOOK_STAKED<T0>>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 > 0) {
            assert!(arg4 <= 0x2::coin::value<DEEPBOOK_STAKED<T0>>(&arg3), 3);
            if (0x2::coin::value<DEEPBOOK_STAKED<T0>>(&arg3) == 0) {
                0x2::coin::destroy_zero<DEEPBOOK_STAKED<T0>>(arg3);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<DEEPBOOK_STAKED<T0>>>(arg3, 0x2::tx_context::sender(arg6));
            };
            0x2::coin::split<DEEPBOOK_STAKED<T0>>(&mut arg3, arg4, arg6)
        } else {
            arg3
        };
        let v1 = withdraw<T0>(arg0, arg1, arg2, v0, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg6));
    }

    public fun update_and_get_pool_xtoken_ratio<T0>(arg0: &mut Pool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : PoolXTokenRatio {
        check_and_upgrade_version<T0>(arg0);
        refresh_total_deposited<T0>(arg0, arg1, arg2);
        get_pool_xtoken_ratio<T0>(arg0)
    }

    public fun validate_pool_admin_cap<T0>(arg0: &mut Pool<T0>, arg1: &mut PoolAdminCap<T0>) {
        check_and_upgrade_version<T0>(arg0);
        let v0 = 0x2::object::id<PoolAdminCap<T0>>(arg1);
        if (0x2::vec_set::contains<0x2::object::ID>(&arg0.disabled_admin_caps, &v0)) {
            abort 4
        };
        assert!(arg1.pool_id == 0x2::object::id<Pool<T0>>(arg0), 5);
    }

    // decompiled from Move bytecode v6
}

