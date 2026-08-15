module 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_vault {
    struct Position has store {
        principal: u64,
        rebate_debt: u128,
        pending: u64,
    }

    struct StakeCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct StakeVault has key {
        id: 0x2::object::UID,
        version: u64,
        platform: 0x2::object::ID,
        creator: address,
        creator_account: 0x2::object::ID,
        fee_bps_snapshot: u64,
        rebate_bps: u64,
        validator: address,
        total_principal: u64,
        positions: 0x2::table::Table<address, Position>,
        tranches: vector<0x3::staking_pool::StakedSui>,
        liquid: 0x2::balance::Balance<0x2::sui::SUI>,
        creator_yield: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_yield: 0x2::balance::Balance<0x2::sui::SUI>,
        rebate_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        acc_rebate_per_unit: u128,
        accepting: bool,
        lifetime_yield: u64,
        harvests: u64,
    }

    struct StakeVaultOpened has copy, drop {
        vault: 0x2::object::ID,
        platform: 0x2::object::ID,
        creator: address,
        validator: address,
        fee_bps_snapshot: u64,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        depositor: address,
        amount: u64,
        principal_after: u64,
        total_principal_after: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        depositor: address,
        amount: u64,
        principal_after: u64,
        tranches_unwound: u64,
    }

    struct Harvested has copy, drop {
        vault: 0x2::object::ID,
        gross_yield: u64,
        creator_cut: u64,
        platform_cut: u64,
        rebate_cut: u64,
        principal_restaked: u64,
        tranches_after: u64,
    }

    struct RebateClaimed has copy, drop {
        vault: 0x2::object::ID,
        depositor: address,
        amount: u64,
    }

    struct YieldClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        recipient: address,
        is_platform: bool,
    }

    struct RebateSet has copy, drop {
        vault: 0x2::object::ID,
        rebate_bps: u64,
    }

    public fun staked_principal(arg0: &StakeVault) : u64 {
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::staked_principal(&arg0.tranches)
    }

    public fun acc_scale() : u128 {
        1000000000000
    }

    public fun accepting(arg0: &StakeVault) : bool {
        arg0.accepting
    }

    fun accrue(arg0: &mut Position, arg1: u128) {
        let v0 = (arg0.principal as u128) * arg1 / 1000000000000;
        arg0.pending = arg0.pending + ((v0 - arg0.rebate_debt) as u64);
        arg0.rebate_debt = v0;
    }

    fun assert_cap(arg0: &StakeVault, arg1: &StakeCap) {
        assert!(arg1.vault == 0x2::object::id<StakeVault>(arg0), 2);
    }

    fun assert_solvent(arg0: &StakeVault) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.liquid) + 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::staked_principal(&arg0.tranches) >= arg0.total_principal, 10);
    }

    fun assert_version(arg0: &StakeVault) {
        assert!(arg0.version == 1, 1);
    }

    public fun backing(arg0: &StakeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.liquid) + 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::staked_principal(&arg0.tranches)
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun cap_vault_id(arg0: &StakeCap) : 0x2::object::ID {
        arg0.vault
    }

    public fun claim_creator_yield(arg0: &mut StakeVault, arg1: &StakeCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.creator_yield) >= arg2, 8);
        let v0 = YieldClaimed{
            vault       : 0x2::object::id<StakeVault>(arg0),
            amount      : arg2,
            recipient   : 0x2::tx_context::sender(arg3),
            is_platform : false,
        };
        0x2::event::emit<YieldClaimed>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.creator_yield, arg2), arg3)
    }

    public fun claim_platform_yield(arg0: &mut StakeVault, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::PlatformCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        assert!(0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::cap_platform_id(arg1) == arg0.platform, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.platform_yield) >= arg2, 8);
        let v0 = YieldClaimed{
            vault       : 0x2::object::id<StakeVault>(arg0),
            amount      : arg2,
            recipient   : 0x2::tx_context::sender(arg3),
            is_platform : true,
        };
        0x2::event::emit<YieldClaimed>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.platform_yield, arg2), arg3)
    }

    public fun claim_rebate(arg0: &mut StakeVault, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg1, v0, arg0.platform);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 6);
        let v1 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        accrue(v1, arg0.acc_rebate_per_unit);
        let v2 = v1.pending;
        v1.pending = 0;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.rebate_pool) >= v2, 8);
        let v3 = RebateClaimed{
            vault     : 0x2::object::id<StakeVault>(arg0),
            depositor : v0,
            amount    : v2,
        };
        0x2::event::emit<RebateClaimed>(v3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.rebate_pool, v2), arg2)
    }

    public fun claimable_rebate(arg0: &StakeVault, arg1: address) : u64 {
        if (!0x2::table::contains<address, Position>(&arg0.positions, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Position>(&arg0.positions, arg1);
        v0.pending + (((v0.principal as u128) * arg0.acc_rebate_per_unit / 1000000000000 - v0.rebate_debt) as u64)
    }

    public fun compute_yield_split(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = arg0 - v0;
        let v2 = (((v1 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (v1 - v2, v0, v2)
    }

    public fun creator(arg0: &StakeVault) : address {
        arg0.creator
    }

    public fun creator_yield_value(arg0: &StakeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.creator_yield)
    }

    fun credit_proceeds(arg0: &mut StakeVault, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.liquid, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, arg2));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            return
        };
        let (_, v2, v3) = compute_yield_split(v0, arg0.fee_bps_snapshot, arg0.rebate_bps);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_yield, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v2));
        if (v3 > 0 && arg0.total_principal > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.rebate_pool, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, v3));
            arg0.acc_rebate_per_unit = arg0.acc_rebate_per_unit + (v3 as u128) * 1000000000000 / (arg0.total_principal as u128);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.creator_yield, arg1);
        arg0.lifetime_yield = arg0.lifetime_yield + v0;
    }

    public fun deposit(arg0: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &mut StakeVault, arg2: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::assert_can_pay(arg0);
        assert!(arg1.platform == 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0), 3);
        assert!(arg1.accepting, 4);
        let v0 = 0x2::tx_context::sender(arg4);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg2, v0, arg1.platform);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 >= 1000000000, 5);
        let v2 = arg1.acc_rebate_per_unit;
        if (!0x2::table::contains<address, Position>(&arg1.positions, v0)) {
            let v3 = Position{
                principal   : 0,
                rebate_debt : 0,
                pending     : 0,
            };
            0x2::table::add<address, Position>(&mut arg1.positions, v0, v3);
        };
        let v4 = 0x2::table::borrow_mut<address, Position>(&mut arg1.positions, v0);
        accrue(v4, v2);
        v4.principal = v4.principal + v1;
        resync_debt(v4, v2);
        arg1.total_principal = arg1.total_principal + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.liquid, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        assert_solvent(arg1);
        let v5 = Deposited{
            vault                 : 0x2::object::id<StakeVault>(arg1),
            depositor             : v0,
            amount                : v1,
            principal_after       : v4.principal,
            total_principal_after : arg1.total_principal,
        };
        0x2::event::emit<Deposited>(v5);
    }

    public fun fee_bps_snapshot(arg0: &StakeVault) : u64 {
        arg0.fee_bps_snapshot
    }

    public fun harvest(arg0: &mut StakeVault, arg1: &mut 0x3::sui_system::SuiSystemState, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_yield);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_yield);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.rebate_pool);
        let (v3, v4) = 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::harvest_matured(&mut arg0.tranches, arg1, arg2);
        credit_proceeds(arg0, v3, v4);
        arg0.harvests = arg0.harvests + 1;
        assert_solvent(arg0);
        let v5 = Harvested{
            vault              : 0x2::object::id<StakeVault>(arg0),
            gross_yield        : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_yield) - v0 + 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_yield) - v1 + 0x2::balance::value<0x2::sui::SUI>(&arg0.rebate_pool) - v2,
            creator_cut        : 0x2::balance::value<0x2::sui::SUI>(&arg0.creator_yield) - v0,
            platform_cut       : 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_yield) - v1,
            rebate_cut         : 0x2::balance::value<0x2::sui::SUI>(&arg0.rebate_pool) - v2,
            principal_restaked : 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::stake_one_rung(&mut arg0.tranches, arg1, &mut arg0.liquid, 0x2::balance::value<0x2::sui::SUI>(&arg0.liquid), arg0.total_principal, arg0.validator, arg2),
            tranches_after     : 0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.tranches),
        };
        0x2::event::emit<Harvested>(v5);
    }

    public fun harvests(arg0: &StakeVault) : u64 {
        arg0.harvests
    }

    public fun has_position(arg0: &StakeVault, arg1: address) : bool {
        0x2::table::contains<address, Position>(&arg0.positions, arg1)
    }

    public fun is_solvent(arg0: &StakeVault) : bool {
        backing(arg0) >= arg0.total_principal
    }

    public fun lifetime_yield(arg0: &StakeVault) : u64 {
        arg0.lifetime_yield
    }

    public fun liquid_value(arg0: &StakeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.liquid)
    }

    public fun migrate(arg0: &mut StakeVault, arg1: &StakeCap) {
        assert_cap(arg0, arg1);
        assert!(arg0.version < 1, 12);
        arg0.version = 1;
    }

    public fun min_deposit_mist() : u64 {
        1000000000
    }

    public fun open(arg0: &mut 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : StakeCap {
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::assert_can_create(arg0);
        let v0 = 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::Platform>(arg0);
        let v1 = 0x2::tx_context::sender(arg3);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg1, v1, v0);
        let v2 = StakeVault{
            id                  : 0x2::object::new(arg3),
            version             : 1,
            platform            : v0,
            creator             : v1,
            creator_account     : 0x2::object::id<0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount>(arg1),
            fee_bps_snapshot    : 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::fee_bps(arg0),
            rebate_bps          : 0,
            validator           : arg2,
            total_principal     : 0,
            positions           : 0x2::table::new<address, Position>(arg3),
            tranches            : 0x1::vector::empty<0x3::staking_pool::StakedSui>(),
            liquid              : 0x2::balance::zero<0x2::sui::SUI>(),
            creator_yield       : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_yield      : 0x2::balance::zero<0x2::sui::SUI>(),
            rebate_pool         : 0x2::balance::zero<0x2::sui::SUI>(),
            acc_rebate_per_unit : 0,
            accepting           : true,
            lifetime_yield      : 0,
            harvests            : 0,
        };
        let v3 = 0x2::object::id<StakeVault>(&v2);
        let v4 = StakeVaultOpened{
            vault            : v3,
            platform         : v0,
            creator          : v1,
            validator        : arg2,
            fee_bps_snapshot : v2.fee_bps_snapshot,
        };
        0x2::event::emit<StakeVaultOpened>(v4);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::platform::record_vault_created(arg0);
        0x2::transfer::share_object<StakeVault>(v2);
        StakeCap{
            id    : 0x2::object::new(arg3),
            vault : v3,
        }
    }

    public fun platform_yield_value(arg0: &StakeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_yield)
    }

    public fun principal_of(arg0: &StakeVault, arg1: address) : u64 {
        assert!(0x2::table::contains<address, Position>(&arg0.positions, arg1), 6);
        0x2::table::borrow<address, Position>(&arg0.positions, arg1).principal
    }

    public fun rebate_bps(arg0: &StakeVault) : u64 {
        arg0.rebate_bps
    }

    public fun rebate_pool_value(arg0: &StakeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.rebate_pool)
    }

    fun resync_debt(arg0: &mut Position, arg1: u128) {
        arg0.rebate_debt = (arg0.principal as u128) * arg1 / 1000000000000;
    }

    public fun set_accepting(arg0: &mut StakeVault, arg1: &StakeCap, arg2: bool) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        arg0.accepting = arg2;
    }

    public fun set_rebate_bps(arg0: &mut StakeVault, arg1: &StakeCap, arg2: u64) {
        assert_version(arg0);
        assert_cap(arg0, arg1);
        assert!(arg2 <= 10000, 9);
        arg0.rebate_bps = arg2;
        let v0 = RebateSet{
            vault      : 0x2::object::id<StakeVault>(arg0),
            rebate_bps : arg2,
        };
        0x2::event::emit<RebateSet>(v0);
    }

    public fun total_principal(arg0: &StakeVault) : u64 {
        arg0.total_principal
    }

    public fun tranche_count(arg0: &StakeVault) : u64 {
        0x1::vector::length<0x3::staking_pool::StakedSui>(&arg0.tranches)
    }

    public fun validator(arg0: &StakeVault) : address {
        arg0.validator
    }

    public fun version(arg0: &StakeVault) : u64 {
        arg0.version
    }

    public fun withdraw(arg0: &mut StakeVault, arg1: &0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::SocialAccount, arg2: u64, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::account::assert_authenticates(arg1, v0, arg0.platform);
        assert!(0x2::table::contains<address, Position>(&arg0.positions, v0), 6);
        let v1 = arg0.acc_rebate_per_unit;
        let v2 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        accrue(v2, v1);
        assert!(v2.principal >= arg2, 7);
        let v3 = 0;
        while (0x2::balance::value<0x2::sui::SUI>(&arg0.liquid) < arg2) {
            assert!(!0x1::vector::is_empty<0x3::staking_pool::StakedSui>(&arg0.tranches), 11);
            let (v4, v5) = 0xc5c833991ed1123d70b1001c0bcdb01ec5728b09f25dfc42a0edaf16005d404d::stake_ladder::unwind_newest(&mut arg0.tranches, arg3, arg4);
            v3 = v3 + 1;
            credit_proceeds(arg0, v4, v5);
        };
        let v6 = 0x2::table::borrow_mut<address, Position>(&mut arg0.positions, v0);
        v6.principal = v6.principal - arg2;
        resync_debt(v6, v1);
        arg0.total_principal = arg0.total_principal - arg2;
        assert_solvent(arg0);
        let v7 = Withdrawn{
            vault            : 0x2::object::id<StakeVault>(arg0),
            depositor        : v0,
            amount           : arg2,
            principal_after  : v6.principal,
            tranches_unwound : v3,
        };
        0x2::event::emit<Withdrawn>(v7);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.liquid, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

