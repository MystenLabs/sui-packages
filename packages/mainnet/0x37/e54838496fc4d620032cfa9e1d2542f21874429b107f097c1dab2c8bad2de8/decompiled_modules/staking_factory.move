module 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_factory {
    struct EStaked<phantom T0> has copy, drop {
        owner: address,
        position: 0x2::object::ID,
        amount: u64,
        tier: u8,
    }

    struct EUnstakeRequested<phantom T0> has copy, drop {
        position: 0x2::object::ID,
        ticket: 0x2::object::ID,
        amount: u64,
        unlock_ts: u64,
        tier: u8,
    }

    struct EUnbonded<phantom T0> has copy, drop {
        owner: address,
        ticket: 0x2::object::ID,
        amount: u64,
    }

    struct EClaimed<phantom T0> has copy, drop {
        owner: address,
        amount: u64,
        tier: u8,
    }

    struct EUnbondPeriodChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct EMaxEpsChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct EMaxEpsBoostedChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct EBaseAPRChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct ELockedPeriodChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct EBoostDeltaChanged has copy, drop {
        admin: address,
        old: u64,
        new: u64,
    }

    struct FactoryTag<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct StakingFactory<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        access_control: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::AccessControl<FactoryTag<T0, T1, T2>>,
        normal_pool: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::Pool<T0, T1>,
        boosted_pool: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::Pool<T0, T2>,
        normal_admin: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::AdminCap,
        boosted_admin: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::AdminCap,
        max_eps_normal: u64,
        max_eps_boosted: u64,
        reserve_r: 0x2::balance::Balance<T0>,
        unbound_sec: u64,
        locked_period_sec: u64,
        base_apr_bps: u64,
        boost_delta_bps: u64,
        lk_token_auth: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::ToCoinCap<T2>,
    }

    struct OpenPosition<phantom T0> has store, key {
        id: 0x2::object::UID,
        tier: u8,
        shares: u64,
        unlock_ts: u64,
        pos: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position,
    }

    struct UnbondingTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        tier: u8,
        unlock_ts: u64,
        escrow: 0x2::balance::Balance<T0>,
    }

    struct MigrationStarted<phantom T0, phantom T1, phantom T2> has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationAborted<phantom T0, phantom T1, phantom T2> has copy, drop {
        compatible_versions: vector<u64>,
    }

    struct MigrationCompleted<phantom T0, phantom T1, phantom T2> has copy, drop {
        compatible_versions: vector<u64>,
    }

    public fun accept_ownership<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::accept_ownership<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1);
    }

    public(friend) fun assert_not_paused<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
    }

    public fun pause<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::pause<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1);
    }

    public fun transfer_ownership<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::transfer_ownership<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1, arg2);
    }

    public fun unpause<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::unpause<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1);
    }

    public fun fund_reserve<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x2::balance::join<T0>(&mut arg0.reserve_r, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun set_max_eps_ts<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    public fun abort_migration<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1, T2>(arg0, arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::ensure_version_data(&mut arg0.id);
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        assert!(0x1::vector::length<u64>(&v0) == 2, 7);
        let v1 = 0x1::u64::max(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1));
        assert!(v1 == 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::current_version(), 9);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::remove_version(&mut arg0.id, v1);
        let v2 = MigrationAborted<T0, T1, T2>{compatible_versions: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id)};
        0x2::event::emit<MigrationAborted<T0, T1, T2>>(v2);
    }

    public(friend) fun assert_is_compatible<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::ensure_version_data(&mut arg0.id);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::assert_object_version_is_compatible_with_package(&arg0.id);
    }

    public(friend) fun assert_owner<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::is_owner<FactoryTag<T0, T1, T2>>(&arg0.access_control, 0x2::tx_context::sender(arg1)), 5);
    }

    public(friend) fun borrow_boosted_pool_mut<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>) : &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::Pool<T0, T2> {
        &mut arg0.boosted_pool
    }

    public(friend) fun borrow_normal_pool_mut<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>) : &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::Pool<T0, T1> {
        &mut arg0.normal_pool
    }

    public(friend) fun borrow_op_from_internal_pool_mut<T0>(arg0: &mut OpenPosition<T0>) : &mut 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::Position {
        &mut arg0.pos
    }

    public(friend) fun borrow_reserve<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : &0x2::balance::Balance<T0> {
        &arg0.reserve_r
    }

    public(friend) fun borrow_reserve_mut<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.reserve_r
    }

    public fun change_owner<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    public fun change_pauser<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::update_pauser<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1, arg2);
    }

    public fun claim<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = claim_internal<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&v0),
            tier   : 0,
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        v0
    }

    public fun claim_and_transfer<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = claim_internal<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&v0),
            tier   : 0,
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public(friend) fun claim_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        0x2::coin::from_balance<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::claim_all<T0, T1>(&mut arg0.normal_pool, &mut arg1.pos), arg2)
    }

    public fun claim_locked<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = claim_locked_internal<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&v0),
            tier   : 1,
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        v0
    }

    public fun claim_locked_and_transfer<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = claim_locked_internal<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = EClaimed<T0>{
            owner  : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<T0>(&v0),
            tier   : 1,
        };
        0x2::event::emit<EClaimed<T0>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun claim_locked_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        0x2::coin::from_balance<T0>(0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::claim_all<T0, T2>(&mut arg0.boosted_pool, &mut arg1.pos), arg2)
    }

    public(friend) fun clean_and_destroy_position<T0>(arg0: OpenPosition<T0>) {
        arg0.shares = 0;
        arg0.unlock_ts = 0;
        destroy_position<T0>(arg0);
    }

    public fun compatible_versions<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : vector<u64> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id)
    }

    public fun complete_migration<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1, T2>(arg0, arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::ensure_version_data(&mut arg0.id);
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        assert!(0x1::vector::length<u64>(&v0) == 2, 7);
        assert!(0x1::u64::max(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1)) == 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::current_version(), 9);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::remove_version(&mut arg0.id, 0x1::u64::min(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1)));
        let v1 = MigrationCompleted<T0, T1, T2>{compatible_versions: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id)};
        0x2::event::emit<MigrationCompleted<T0, T1, T2>>(v1);
    }

    public fun current_active_version<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : u64 {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        if (0x1::vector::length<u64>(&v0) == 1) {
            *0x1::vector::borrow<u64>(&v0, 0)
        } else {
            0x1::u64::min(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1))
        }
    }

    public fun destroy_position<T0>(arg0: OpenPosition<T0>) {
        let OpenPosition {
            id        : v0,
            tier      : _,
            shares    : v2,
            unlock_ts : _,
            pos       : v4,
        } = arg0;
        assert!(v2 == 0, 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::accumulation_distributor::position_destroy_empty(v4);
        0x2::object::delete(v0);
    }

    public fun empty_reserve<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2::balance::value<T0>(&arg0.reserve_r);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_r, v0), arg2), arg1);
    }

    fun fund_and_poke_boosted<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::pre_accrue_need<T0, T2>(&arg0.boosted_pool, 0x2::clock::timestamp_ms(arg1) / 1000);
        if (v0 > 0) {
            assert!(v0 <= 0x2::balance::value<T0>(&arg0.reserve_r), 3);
            0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::fund_reserve<T0, T2>(&mut arg0.boosted_pool, 0x2::balance::split<T0>(&mut arg0.reserve_r, v0));
        };
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::poke<T0, T2>(&mut arg0.boosted_pool, arg1);
    }

    fun fund_and_poke_normal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::pre_accrue_need<T0, T1>(&arg0.normal_pool, 0x2::clock::timestamp_ms(arg1) / 1000);
        if (v0 > 0) {
            assert!(v0 <= 0x2::balance::value<T0>(&arg0.reserve_r), 3);
            0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::fund_reserve<T0, T1>(&mut arg0.normal_pool, 0x2::balance::split<T0>(&mut arg0.reserve_r, v0));
        };
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::poke<T0, T1>(&mut arg0.normal_pool, arg1);
    }

    public(friend) fun get_base_apr_bps<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : u64 {
        arg0.base_apr_bps
    }

    public(friend) fun get_boost_delta_bps<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : u64 {
        arg0.boost_delta_bps
    }

    public(friend) fun get_max_eps_boosted<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : u64 {
        arg0.max_eps_boosted
    }

    public(friend) fun get_op_fields<T0>(arg0: &OpenPosition<T0>) : (u64, u8, u64) {
        (arg0.shares, arg0.tier, arg0.unlock_ts)
    }

    public(friend) fun get_unbound_sec<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : u64 {
        arg0.unbound_sec
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_migration_in_progress<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : bool {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        0x1::vector::length<u64>(&v0) > 1
    }

    public fun launch_with_boosted<T0, T1, T2>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::ToCoinCap<T2>, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::create<T0, T1>(arg0, arg2, arg7);
        let (v2, v3) = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::create<T0, T2>(arg0 + arg1, arg3, arg7);
        let v4 = StakingFactory<T0, T1, T2>{
            id                : 0x2::object::new(arg7),
            access_control    : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::new<FactoryTag<T0, T1, T2>>(0x2::tx_context::sender(arg7), 0x2::tx_context::sender(arg7), arg7),
            normal_pool       : v0,
            boosted_pool      : v2,
            normal_admin      : v1,
            boosted_admin     : v3,
            max_eps_normal    : arg2,
            max_eps_boosted   : arg3,
            reserve_r         : 0x2::balance::zero<T0>(),
            unbound_sec       : arg4,
            locked_period_sec : arg5,
            base_apr_bps      : arg0,
            boost_delta_bps   : arg1,
            lk_token_auth     : arg6,
        };
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::ensure_version_data(&mut v4.id);
        0x2::transfer::share_object<StakingFactory<T0, T1, T2>>(v4);
    }

    public fun migrate_owner<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::migrate_owner_to_two_step<FactoryTag<T0, T1, T2>>(&mut arg0.access_control, arg1);
    }

    public fun pending_version<T0, T1, T2>(arg0: &StakingFactory<T0, T1, T2>) : 0x1::option::Option<u64> {
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        if (0x1::vector::length<u64>(&v0) == 2) {
            0x1::option::some<u64>(0x1::u64::max(*0x1::vector::borrow<u64>(&v0, 0), *0x1::vector::borrow<u64>(&v0, 1)))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun request_unstake<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = request_unstake_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v1 = EUnstakeRequested<T1>{
            position  : 0x2::object::id<OpenPosition<T1>>(arg1),
            ticket    : 0x2::object::id<UnbondingTicket<T1>>(&v0),
            amount    : arg2,
            unlock_ts : v0.unlock_ts,
            tier      : 0,
        };
        0x2::event::emit<EUnstakeRequested<T1>>(v1);
        0x2::transfer::transfer<UnbondingTicket<T1>>(v0, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun request_unstake_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : UnbondingTicket<T1> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        assert!(arg2 > 0 && arg2 <= arg1.shares, 11);
        assert!(arg1.tier == 0, 4);
        fund_and_poke_normal<T0, T1, T2>(arg0, arg3);
        arg1.shares = arg1.shares - arg2;
        UnbondingTicket<T1>{
            id        : 0x2::object::new(arg4),
            tier      : arg1.tier,
            unlock_ts : 0x2::clock::timestamp_ms(arg3) / 1000 + arg0.unbound_sec,
            escrow    : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::withdraw_shares<T0, T1>(&mut arg0.normal_pool, &mut arg1.pos, arg2, arg3),
        }
    }

    public fun request_unstake_locked<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = request_unstake_locked_internal<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4);
        let v1 = EUnstakeRequested<T2>{
            position  : 0x2::object::id<OpenPosition<T2>>(arg1),
            ticket    : 0x2::object::id<UnbondingTicket<T2>>(&v0),
            amount    : arg2,
            unlock_ts : v0.unlock_ts,
            tier      : v0.tier,
        };
        0x2::event::emit<EUnstakeRequested<T2>>(v1);
        0x2::transfer::transfer<UnbondingTicket<T2>>(v0, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun request_unstake_locked_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : UnbondingTicket<T2> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        assert!(arg2 > 0 && arg2 <= arg1.shares, 1);
        assert!(arg1.tier == 1, 4);
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        assert!(v0 >= arg1.unlock_ts, 2);
        fund_and_poke_boosted<T0, T1, T2>(arg0, arg3);
        arg1.shares = arg1.shares - arg2;
        UnbondingTicket<T2>{
            id        : 0x2::object::new(arg4),
            tier      : arg1.tier,
            unlock_ts : v0,
            escrow    : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::withdraw_shares<T0, T2>(&mut arg0.boosted_pool, &mut arg1.pos, arg2, arg3),
        }
    }

    public fun set_base_apr<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    public fun set_base_apr_v2<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg3);
        sync<T0, T1, T2>(arg0, arg2);
        arg0.base_apr_bps = arg1;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::set_target_apr_bps<T0, T1>(&mut arg0.normal_pool, arg1, &arg0.normal_admin);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::set_target_apr_bps<T0, T2>(&mut arg0.boosted_pool, arg1 + arg0.boost_delta_bps, &arg0.boosted_admin);
        let v0 = EBaseAPRChanged{
            admin : 0x2::tx_context::sender(arg3),
            old   : arg0.base_apr_bps,
            new   : arg1,
        };
        0x2::event::emit<EBaseAPRChanged>(v0);
    }

    public fun set_boost_delta<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 10
    }

    public fun set_boost_delta_v2<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg3);
        sync<T0, T1, T2>(arg0, arg2);
        arg0.boost_delta_bps = arg1;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::set_target_apr_bps<T0, T2>(&mut arg0.boosted_pool, arg0.base_apr_bps + arg1, &arg0.boosted_admin);
        let v0 = EBoostDeltaChanged{
            admin : 0x2::tx_context::sender(arg3),
            old   : arg0.boost_delta_bps,
            new   : arg1,
        };
        0x2::event::emit<EBoostDeltaChanged>(v0);
    }

    public fun set_locked_period<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg2);
        arg0.locked_period_sec = arg1;
        let v0 = ELockedPeriodChanged{
            admin : 0x2::tx_context::sender(arg2),
            old   : arg0.locked_period_sec,
            new   : arg1,
        };
        0x2::event::emit<ELockedPeriodChanged>(v0);
    }

    public fun set_max_eps_ts_v2<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg4);
        sync<T0, T1, T2>(arg0, arg3);
        arg0.max_eps_normal = arg1;
        arg0.max_eps_boosted = arg2;
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::set_max_eps_ts<T0, T1>(&mut arg0.normal_pool, arg1, &arg0.normal_admin);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::set_max_eps_ts<T0, T2>(&mut arg0.boosted_pool, arg2, &arg0.boosted_admin);
        let v0 = EMaxEpsChanged{
            admin : 0x2::tx_context::sender(arg4),
            old   : arg0.max_eps_normal,
            new   : arg1,
        };
        0x2::event::emit<EMaxEpsChanged>(v0);
        let v1 = EMaxEpsBoostedChanged{
            admin : 0x2::tx_context::sender(arg4),
            old   : arg0.max_eps_boosted,
            new   : arg2,
        };
        0x2::event::emit<EMaxEpsBoostedChanged>(v1);
    }

    public fun set_unbonding_ts<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        assert_owner<T0, T1, T2>(arg0, arg2);
        arg0.unbound_sec = arg1;
        let v0 = EUnbondPeriodChanged{
            admin : 0x2::tx_context::sender(arg2),
            old   : arg0.unbound_sec,
            new   : arg1,
        };
        0x2::event::emit<EUnbondPeriodChanged>(v0);
    }

    public fun stake<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = stake_internal<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v1 = EStaked<T1>{
            owner    : 0x2::tx_context::sender(arg3),
            position : 0x2::object::id<OpenPosition<T1>>(&v0),
            amount   : v0.shares,
            tier     : 0,
        };
        0x2::event::emit<EStaked<T1>>(v1);
        0x2::transfer::transfer<OpenPosition<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun stake_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : OpenPosition<T1> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        fund_and_poke_normal<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2::coin::into_balance<T1>(arg1);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 1);
        OpenPosition<T1>{
            id        : 0x2::object::new(arg3),
            tier      : 0,
            shares    : v1,
            unlock_ts : 0,
            pos       : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_new<T0, T1>(&mut arg0.normal_pool, v0, arg2),
        }
    }

    public fun stake_locked<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<T2>, arg2: 0x2::token::Token<T2>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        let v0 = 0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::to_coin<T2>(arg1, &arg0.lk_token_auth, arg2, arg4);
        let v1 = stake_locked_internal<T0, T1, T2>(arg0, v0, arg3, arg4);
        let v2 = EStaked<T2>{
            owner    : 0x2::tx_context::sender(arg4),
            position : 0x2::object::id<OpenPosition<T2>>(&v1),
            amount   : v1.shares,
            tier     : 1,
        };
        0x2::event::emit<EStaked<T2>>(v2);
        0x2::transfer::transfer<OpenPosition<T2>>(v1, 0x2::tx_context::sender(arg4));
    }

    public(friend) fun stake_locked_internal<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : OpenPosition<T2> {
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        fund_and_poke_boosted<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2::coin::into_balance<T2>(arg1);
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 > 0, 1);
        OpenPosition<T2>{
            id        : 0x2::object::new(arg3),
            tier      : 1,
            shares    : v1,
            unlock_ts : 0x2::clock::timestamp_ms(arg2) / 1000 + arg0.locked_period_sec,
            pos       : 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_new<T0, T2>(&mut arg0.boosted_pool, v0, arg2),
        }
    }

    public fun stake_more<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &mut OpenPosition<T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        assert!(arg1.tier == 0, 4);
        fund_and_poke_normal<T0, T1, T2>(arg0, arg3);
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_more<T0, T1>(&mut arg0.normal_pool, &mut arg1.pos, v0, arg3);
        arg1.shares = arg1.shares + v1;
        let v2 = EStaked<T1>{
            owner    : 0x2::tx_context::sender(arg4),
            position : 0x2::object::id<OpenPosition<T1>>(arg1),
            amount   : v1,
            tier     : 0,
        };
        0x2::event::emit<EStaked<T1>>(v2);
    }

    public fun stake_more_locked<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::Treasury<T2>, arg2: &mut OpenPosition<T2>, arg3: 0x2::token::Token<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        assert!(arg2.tier == 1, 4);
        fund_and_poke_boosted<T0, T1, T2>(arg0, arg4);
        let v0 = 0x2::coin::into_balance<T2>(0x8db9d9dc5cd5723ee55725869620073e28f88ddf3c360a512ebd73cb46f1903d::treasury::to_coin<T2>(arg1, &arg0.lk_token_auth, arg3, arg5));
        let v1 = 0x2::balance::value<T2>(&v0);
        assert!(v1 > 0, 1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::apr_pool::deposit_more<T0, T2>(&mut arg0.boosted_pool, &mut arg2.pos, v0, arg4);
        arg2.shares = arg2.shares + v1;
        let v2 = EStaked<T2>{
            owner    : 0x2::tx_context::sender(arg5),
            position : 0x2::object::id<OpenPosition<T2>>(arg2),
            amount   : v1,
            tier     : 1,
        };
        0x2::event::emit<EStaked<T2>>(v2);
    }

    public fun start_migration<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0, T1, T2>(arg0, arg1);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::ensure_version_data(&mut arg0.id);
        let v0 = 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id);
        assert!(0x1::vector::length<u64>(&v0) == 1, 6);
        assert!(*0x1::vector::borrow<u64>(&v0, 0) < 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::current_version(), 8);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::insert_current_version(&mut arg0.id);
        let v1 = MigrationStarted<T0, T1, T2>{compatible_versions: 0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::staking_version_control::compatible_versions(&arg0.id)};
        0x2::event::emit<MigrationStarted<T0, T1, T2>>(v1);
    }

    public fun sync<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        fund_and_poke_normal<T0, T1, T2>(arg0, arg1);
        fund_and_poke_boosted<T0, T1, T2>(arg0, arg1);
    }

    public fun unbond<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: UnbondingTicket<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        let v0 = unbond_internal<T1>(arg1, arg2, arg3);
        let v1 = EUnbonded<T1>{
            owner  : 0x2::tx_context::sender(arg3),
            ticket : 0x2::object::id<UnbondingTicket<T1>>(&arg1),
            amount : 0x2::coin::value<T1>(&v0),
        };
        0x2::event::emit<EUnbonded<T1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public(friend) fun unbond_internal<T0>(arg0: UnbondingTicket<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let UnbondingTicket {
            id        : v0,
            tier      : _,
            unlock_ts : v2,
            escrow    : v3,
        } = arg0;
        assert!(0x2::clock::timestamp_ms(arg1) / 1000 >= v2, 2);
        0x2::object::delete(v0);
        0x2::coin::from_balance<T0>(v3, arg2)
    }

    public fun unbond_locked<T0, T1, T2>(arg0: &mut StakingFactory<T0, T1, T2>, arg1: UnbondingTicket<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_is_compatible<T0, T1, T2>(arg0);
        0x3cc209ca80fde4e68f9abbae4776abc57de7bb3da33bdb8cbf6a66740ff81bd8::access_control::assert_not_paused<FactoryTag<T0, T1, T2>>(&arg0.access_control);
        let v0 = unbond_internal<T2>(arg1, arg2, arg3);
        let v1 = 0x2::coin::value<T2>(&v0);
        assert!(v1 <= 0x2::balance::value<T0>(&arg0.reserve_r), 3);
        let v2 = EUnbonded<T2>{
            owner  : 0x2::tx_context::sender(arg3),
            ticket : 0x2::object::id<UnbondingTicket<T2>>(&arg1),
            amount : v1,
        };
        0x2::event::emit<EUnbonded<T2>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, @0x0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_r, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

