module 0xacd753e6ac4211b194c4d05bfb03333055835c858210964c6afc01e5f8383219::vault {
    struct VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        treasury: address,
        agent_spends_enabled: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        liquid: 0x2::balance::Balance<T1>,
        ctokens: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>,
        principal: u64,
        approved: 0x2::vec_set::VecSet<address>,
        next_grant_id: u64,
        paused: bool,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct GrantKey has copy, drop, store {
        id: u64,
    }

    struct Grant has drop, store {
        spender: address,
        limit: u64,
        period_ms: u64,
        window_start_ms: u64,
        spent: u64,
        expires_at_ms: u64,
    }

    struct SweepReceipt {
        vault_id: 0x2::object::ID,
        amount: u64,
    }

    struct PayReceipt {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        fee: u64,
        all: bool,
        grant_id: 0x1::option::Option<u64>,
        value_before: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner: address,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        source: u8,
        principal_after: u64,
    }

    struct Swept has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        ctokens: u64,
        principal_after: u64,
        savings_value_after: u64,
    }

    struct Paid has copy, drop {
        vault_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        fee: u64,
        grant_id: 0x1::option::Option<u64>,
        principal_after: u64,
        savings_value_after: u64,
        liquid_after: u64,
    }

    struct ApprovalSet has copy, drop {
        vault_id: 0x2::object::ID,
        account: address,
        approved: bool,
    }

    struct GrantAdded has copy, drop {
        vault_id: 0x2::object::ID,
        grant_id: u64,
        spender: address,
        limit: u64,
        period_ms: u64,
        expires_at_ms: u64,
    }

    struct GrantUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        grant_id: u64,
        limit: u64,
        period_ms: u64,
        expires_at_ms: u64,
    }

    struct GrantRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        grant_id: u64,
    }

    struct PausedSet has copy, drop {
        vault_id: 0x2::object::ID,
        paused: bool,
    }

    struct FeeSet has copy, drop {
        fee_bps: u64,
    }

    struct TreasurySet has copy, drop {
        treasury: address,
    }

    struct AgentSpendsSet has copy, drop {
        enabled: bool,
    }

    struct ConfigMigrated has copy, drop {
        version: u64,
    }

    struct VaultMigrated has copy, drop {
        vault_id: 0x2::object::ID,
        version: u64,
    }

    struct CTokensWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        ctokens: u64,
        fee_ctokens: u64,
        principal_after: u64,
        savings_value_after: u64,
    }

    public fun new<T0, T1>(arg0: &Config, arg1: &mut Registry, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, OwnerCap) {
        assert!(arg0.version == 1, 13835059236398563335);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Vault<T0, T1>{
            id            : 0x2::derived_object::claim<address>(&mut arg1.id, v0),
            version       : 1,
            liquid        : 0x2::balance::zero<T1>(),
            ctokens       : 0x2::balance::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(),
            principal     : 0,
            approved      : 0x2::vec_set::empty<address>(),
            next_grant_id : 0,
            paused        : false,
        };
        let v2 = 0x2::object::id<Vault<T0, T1>>(&v1);
        let v3 = VaultCreated{
            vault_id : v2,
            owner    : v0,
        };
        0x2::event::emit<VaultCreated>(v3);
        let v4 = OwnerCap{
            id       : 0x2::object::new(arg2),
            vault_id : v2,
        };
        (v1, v4)
    }

    public(friend) fun accept_sweep<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: SweepReceipt, arg2: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        let SweepReceipt {
            vault_id : v0,
            amount   : v1,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg0), 13835624260821450763);
        let v2 = 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg2);
        assert!(ctoken_value(sat_add(v2, 1), arg3) >= v1, 13836187227955003407);
        0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, arg2);
        let v3 = Swept{
            vault_id            : v0,
            amount              : v1,
            ctokens             : v2,
            principal_after     : arg0.principal,
            savings_value_after : ctoken_value(0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens), arg3),
        };
        0x2::event::emit<Swept>(v3);
    }

    public fun add_grant<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : u64 {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(arg5 > 0, 13839282177094975525);
        assert!(arg6 == 0 || arg6 > v0, 13839563656366784551);
        let v1 = arg2.next_grant_id;
        arg2.next_grant_id = v1 + 1;
        let v2 = GrantKey{id: v1};
        let v3 = Grant{
            spender         : arg3,
            limit           : arg4,
            period_ms       : arg5,
            window_start_ms : v0,
            spent           : 0,
            expires_at_ms   : arg6,
        };
        0x2::dynamic_field::add<GrantKey, Grant>(&mut arg2.id, v2, v3);
        let v4 = GrantAdded{
            vault_id      : 0x2::object::id<Vault<T0, T1>>(arg2),
            grant_id      : v1,
            spender       : arg3,
            limit         : arg4,
            period_ms     : arg5,
            expires_at_ms : arg6,
        };
        0x2::event::emit<GrantAdded>(v4);
        v1
    }

    public fun approve<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: address) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        if (0x2::vec_set::contains<address>(&arg2.approved, &arg3)) {
            return
        };
        assert!(0x2::vec_set::length<address>(&arg2.approved) < 100, 13839000586154016803);
        0x2::vec_set::insert<address>(&mut arg2.approved, arg3);
        let v0 = ApprovalSet{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            account  : arg3,
            approved : true,
        };
        0x2::event::emit<ApprovalSet>(v0);
    }

    fun assert_owner<T0, T1>(arg0: &OwnerCap, arg1: &Vault<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 13835342064290103305);
    }

    fun assert_version<T0, T1>(arg0: &Config, arg1: &Vault<T0, T1>) {
        assert!(arg0.version == 1 && arg1.version == 1, 13835060572133392391);
    }

    public fun begin_grant_pay<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        let (v0, v1) = begin_grant_pay_at<T0, T1>(arg0, arg1, ratio_of<T0, T1>(arg2, arg3), 0x2::clock::timestamp_ms(arg3), 0x2::tx_context::sender(arg7), arg4, arg5, arg6);
        (0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v0, arg7), v1)
    }

    public(friend) fun begin_grant_pay_at<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg3: u64, arg4: address, arg5: u64, arg6: address, arg7: u64) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        assert_version<T0, T1>(arg0, arg1);
        assert!(arg0.agent_spends_enabled, 13837312981833482263);
        charge_grant<T0, T1>(arg1, arg5, arg6, arg7, arg3, arg4);
        release_for_pay<T0, T1>(arg1, arg2, arg6, arg7, 0x1::option::some<u64>(arg5), arg0.fee_bps)
    }

    public fun begin_owner_pay<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: address, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        let (v0, v1) = begin_owner_pay_at<T0, T1>(arg0, arg1, arg2, ratio_of<T0, T1>(arg3, arg4), arg5, arg6);
        (0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v0, arg7), v1)
    }

    public(friend) fun begin_owner_pay_at<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: address, arg5: u64) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        release_for_pay<T0, T1>(arg2, arg3, arg4, arg5, 0x1::option::none<u64>(), arg1.fee_bps)
    }

    public fun begin_pay_all<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        let (v0, v1) = begin_pay_all_at<T0, T1>(arg0, arg1, arg2, ratio_of<T0, T1>(arg3, arg4), arg5);
        (0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v0, arg6), v1)
    }

    public(friend) fun begin_pay_all_at<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: address) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        release_all<T0, T1>(arg2, arg3, arg4)
    }

    public fun begin_sweep<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, SweepReceipt) {
        assert_version<T0, T1>(arg0, arg1);
        let v0 = 0x2::balance::settled_funds_value<T1>(arg2, 0x2::object::id_address<Vault<T0, T1>>(arg1));
        if (v0 > 0) {
            0x2::balance::join<T1>(&mut arg1.liquid, 0x2::balance::redeem_funds<T1>(0x2::balance::withdraw_funds_from_object<T1>(&mut arg1.id, v0)));
            note_deposit<T0, T1>(arg1, v0, 0);
        };
        let (v1, v2) = release_for_sweep<T0, T1>(arg1);
        (0x2::coin::from_balance<T1>(v1, arg3), v2)
    }

    public(friend) fun charge_grant<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: address) {
        assert!(!arg0.paused, 13837031223388798997);
        assert!(arg3 > 0, 13836468277730082833);
        assert!(0x2::vec_set::contains<address>(&arg0.approved, &arg2), 13838720081839783969);
        let v0 = GrantKey{id: arg1};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg0.id, v0), 13837594186227384345);
        let v1 = GrantKey{id: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant>(&mut arg0.id, v1);
        assert!(arg5 == v2.spender, 13837875669794160667);
        assert!(v2.expires_at_ms == 0 || arg4 < v2.expires_at_ms, 13838157149065969693);
        let v3 = rolled_window_start(v2.window_start_ms, v2.period_ms, arg4);
        if (v3 != v2.window_start_ms) {
            v2.window_start_ms = v3;
            v2.spent = 0;
        };
        assert!(arg3 <= v2.limit && v2.spent <= v2.limit - arg3, 13838438649812615199);
        v2.spent = v2.spent + arg3;
    }

    public(friend) fun ctoken_value(arg0: u64, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u64 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::saturating_floor(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::mul(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), arg1))
    }

    public(friend) fun ctokens_for(arg0: u64, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u64 {
        sat_add(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::ceil(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::div(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from(arg0), arg1)), 1)
    }

    public fun earned<T0, T1>(arg0: &Config, arg1: &Vault<T0, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock) : u64 {
        earned_net(total_value<T0, T1>(arg1, arg2, arg3), arg1.principal, arg0.fee_bps)
    }

    public(friend) fun earned_net(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 <= arg1) {
            return 0
        };
        let v0 = arg0 - arg1;
        v0 - (((v0 as u128) * (arg2 as u128) / 10000) as u64)
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun finish_pay<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: PayReceipt, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = finish_pay_at<T0, T1>(arg0, arg1, arg4, 0x2::coin::into_balance<T1>(arg5), ratio_of<T0, T1>(arg2, arg3));
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg6), v2);
        if (0x2::balance::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v3, arg6), arg0.treasury);
        } else {
            0x2::balance::destroy_zero<T1>(v3);
        };
    }

    public(friend) fun finish_pay_at<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: PayReceipt, arg3: 0x2::balance::Balance<T1>, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, address) {
        assert_version<T0, T1>(arg0, arg1);
        settle_pay<T0, T1>(arg1, arg2, arg3, arg4, arg0.fee_bps)
    }

    public fun finish_sweep<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &0x2::clock::Clock, arg4: SweepReceipt, arg5: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>) {
        finish_sweep_at<T0, T1>(arg0, arg1, arg4, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg5), ratio_of<T0, T1>(arg2, arg3));
    }

    public(friend) fun finish_sweep_at<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: SweepReceipt, arg3: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg4: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) {
        assert_version<T0, T1>(arg0, arg1);
        accept_sweep<T0, T1>(arg1, arg2, arg3, arg4);
    }

    public fun grant_info<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : (address, u64, u64, u64, u64, u64) {
        let v0 = GrantKey{id: arg1};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg0.id, v0), 13837593786795425817);
        let v1 = GrantKey{id: arg1};
        let v2 = 0x2::dynamic_field::borrow<GrantKey, Grant>(&arg0.id, v1);
        (v2.spender, v2.limit, v2.period_ms, v2.window_start_ms, v2.spent, v2.expires_at_ms)
    }

    fun init(arg0: VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<VAULT>(arg0, arg1);
        let v0 = Config{
            id                   : 0x2::object::new(arg1),
            version              : 1,
            fee_bps              : 0,
            treasury             : 0x2::tx_context::sender(arg1),
            agent_spends_enabled : true,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = Registry{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Registry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_approved<T0, T1>(arg0: &Vault<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.approved, &arg1)
    }

    public fun is_paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 13840126915558113323);
        arg1.version = 1;
        let v0 = ConfigMigrated{version: 1};
        0x2::event::emit<ConfigMigrated>(v0);
    }

    public fun migrate_vault<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>) {
        assert!(arg0.version == 1, 13835060400334700551);
        assert!(arg1.version < arg0.version, 13840126954212818987);
        arg1.version = 1;
        let v0 = VaultMigrated{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg1),
            version  : 1,
        };
        0x2::event::emit<VaultMigrated>(v0);
    }

    fun note_deposit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: u64, arg2: u8) {
        arg0.principal = sat_add(arg0.principal, arg1);
        let v0 = Deposited{
            vault_id        : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount          : arg1,
            source          : arg2,
            principal_after : arg0.principal,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun principal_after_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 >= arg1) {
            return 0
        };
        arg0 - (((arg0 as u128) * (arg2 as u128) / (arg1 as u128)) as u64)
    }

    fun ratio_of<T0, T1>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: &0x2::clock::Clock) : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve<T0, T1>(arg0), arg1)
    }

    public fun receive_coin<T0, T1>(arg0: &Config, arg1: &mut Vault<T0, T1>, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T1>>) {
        assert_version<T0, T1>(arg0, arg1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T1>>(&mut arg1.id, arg2);
        0x2::balance::join<T1>(&mut arg1.liquid, 0x2::coin::into_balance<T1>(v0));
        note_deposit<T0, T1>(arg1, 0x2::coin::value<T1>(&v0), 1);
    }

    public(friend) fun release_all<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: address) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        let v0 = PayReceipt{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            recipient    : arg2,
            amount       : 0,
            fee          : 0,
            all          : true,
            grant_id     : 0x1::option::none<u64>(),
            value_before : total_value_at<T0, T1>(arg0, arg1),
        };
        (0x2::balance::withdraw_all<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens), v0)
    }

    public(friend) fun release_for_pay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg2: address, arg3: u64, arg4: 0x1::option::Option<u64>, arg5: u64) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, PayReceipt) {
        assert!(arg3 > 0, 13836468771651321873);
        let v0 = total_value_at<T0, T1>(arg0, arg1);
        let v1 = yield_fee(arg3, v0, arg0.principal, arg5);
        let v2 = sat_add(arg3, v1);
        assert!(v2 <= v0, 13836750263808032787);
        let v3 = 0x2::balance::value<T1>(&arg0.liquid);
        let v4 = if (v2 <= v3) {
            0
        } else {
            0x1::u64::min(ctokens_for(v2 - v3, arg1), 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens))
        };
        let v5 = PayReceipt{
            vault_id     : 0x2::object::id<Vault<T0, T1>>(arg0),
            recipient    : arg2,
            amount       : arg3,
            fee          : v1,
            all          : false,
            grant_id     : arg4,
            value_before : v0,
        };
        (0x2::balance::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, v4), v5)
    }

    public(friend) fun release_for_sweep<T0, T1>(arg0: &mut Vault<T0, T1>) : (0x2::balance::Balance<T1>, SweepReceipt) {
        let v0 = 0x2::balance::value<T1>(&arg0.liquid);
        assert!(v0 > 0, 13835905688553652237);
        let v1 = SweepReceipt{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            amount   : v0,
        };
        (0x2::balance::withdraw_all<T1>(&mut arg0.liquid), v1)
    }

    public fun remove_grant<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: u64) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        let v0 = GrantKey{id: arg3};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg2.id, v0), 13837593486147715097);
        let v1 = GrantKey{id: arg3};
        0x2::dynamic_field::remove<GrantKey, Grant>(&mut arg2.id, v1);
        let v2 = GrantRemoved{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            grant_id : arg3,
        };
        0x2::event::emit<GrantRemoved>(v2);
    }

    public(friend) fun rolled_window_start(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0 || arg2 < arg0) {
            return arg0
        };
        arg0 + (arg2 - arg0) / arg1 * arg1
    }

    public(friend) fun sat_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun set_agent_spends(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        assert!(arg1.version == 1, 13835060335910191111);
        arg1.agent_spends_enabled = arg2;
        let v0 = AgentSpendsSet{enabled: arg2};
        0x2::event::emit<AgentSpendsSet>(v0);
    }

    public fun set_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg1.version == 1, 13835060280075616263);
        assert!(arg2 <= 2000, 13839845358976892969);
        arg1.fee_bps = arg2;
        let v0 = FeeSet{fee_bps: arg2};
        0x2::event::emit<FeeSet>(v0);
    }

    public fun set_grant<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        assert!(arg5 > 0, 13839282280174190629);
        assert!(arg6 == 0 || arg6 > 0x2::clock::timestamp_ms(arg7), 13839563759445999655);
        let v0 = GrantKey{id: arg3};
        assert!(0x2::dynamic_field::exists<GrantKey>(&arg2.id, v0), 13837593438903074841);
        let v1 = GrantKey{id: arg3};
        let v2 = 0x2::dynamic_field::borrow_mut<GrantKey, Grant>(&mut arg2.id, v1);
        v2.limit = arg4;
        v2.period_ms = arg5;
        v2.expires_at_ms = arg6;
        let v3 = GrantUpdated{
            vault_id      : 0x2::object::id<Vault<T0, T1>>(arg2),
            grant_id      : arg3,
            limit         : arg4,
            period_ms     : arg5,
            expires_at_ms : arg6,
        };
        0x2::event::emit<GrantUpdated>(v3);
    }

    public fun set_paused<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: bool) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        arg2.paused = arg3;
        let v0 = PausedSet{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            paused   : arg3,
        };
        0x2::event::emit<PausedSet>(v0);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        assert!(arg1.version == 1, 13835060310140387335);
        arg1.treasury = arg2;
        let v0 = TreasurySet{treasury: arg2};
        0x2::event::emit<TreasurySet>(v0);
    }

    public(friend) fun settle_pay<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: PayReceipt, arg2: 0x2::balance::Balance<T1>, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: u64) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T1>, address) {
        let PayReceipt {
            vault_id     : v0,
            recipient    : v1,
            amount       : v2,
            fee          : v3,
            all          : v4,
            grant_id     : v5,
            value_before : v6,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0, T1>>(arg0), 13835624630188638219);
        0x2::balance::join<T1>(&mut arg0.liquid, arg2);
        let (v7, v8) = if (v4) {
            let v9 = 0x2::balance::value<T1>(&arg0.liquid);
            let v10 = yield_fee(v9, v9, arg0.principal, arg4);
            (v9 - v10, v10)
        } else {
            (v2, v3)
        };
        assert!(0x2::balance::value<T1>(&arg0.liquid) >= v7 + v8, 13836750564455743507);
        let v11 = if (v4) {
            0
        } else {
            principal_after_out(arg0.principal, v6, v7 + v8)
        };
        arg0.principal = v11;
        let v12 = Paid{
            vault_id            : v0,
            recipient           : v1,
            amount              : v7,
            fee                 : v8,
            grant_id            : v5,
            principal_after     : arg0.principal,
            savings_value_after : ctoken_value(0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens), arg3),
            liquid_after        : 0x2::balance::value<T1>(&arg0.liquid),
        };
        0x2::event::emit<Paid>(v12);
        (0x2::balance::split<T1>(&mut arg0.liquid, v7), 0x2::balance::split<T1>(&mut arg0.liquid, v8), v1)
    }

    public fun share<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public fun total_value<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        total_value_at<T0, T1>(arg0, ratio_of<T0, T1>(arg1, arg2))
    }

    public(friend) fun total_value_at<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal) : u64 {
        sat_add(0x2::balance::value<T1>(&arg0.liquid), ctoken_value(0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens), arg1))
    }

    public fun unapprove<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: address) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg2.approved, &arg3)) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg2.approved, &arg3);
        let v0 = ApprovalSet{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg2),
            account  : arg3,
            approved : false,
        };
        0x2::event::emit<ApprovalSet>(v0);
    }

    public fun vault_address_for(arg0: &Registry, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::id<Registry>(arg0), arg1)
    }

    public fun withdraw_ctokens<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>> {
        let (v0, v1) = withdraw_ctokens_at<T0, T1>(arg0, arg1, arg2, ratio_of<T0, T1>(arg3, arg4), arg5);
        let v2 = v1;
        if (0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>>(0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v2, arg6), arg1.treasury);
        } else {
            0x2::balance::destroy_zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v2);
        };
        0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(v0, arg6)
    }

    public(friend) fun withdraw_ctokens_at<T0, T1>(arg0: &OwnerCap, arg1: &Config, arg2: &mut Vault<T0, T1>, arg3: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::Decimal, arg4: u64) : (0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>) {
        assert_version<T0, T1>(arg1, arg2);
        assert_owner<T0, T1>(arg0, arg2);
        assert!(arg4 > 0, 13836468939155046417);
        assert!(arg4 <= 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg2.ctokens), 13836750418426855443);
        let v0 = total_value_at<T0, T1>(arg2, arg3);
        let v1 = yield_fee(arg4, v0, arg2.principal, arg1.fee_bps);
        arg2.principal = principal_after_out(arg2.principal, v0, ctoken_value(arg4, arg3));
        let v2 = 0x2::balance::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg2.ctokens, arg4);
        let v3 = CTokensWithdrawn{
            vault_id            : 0x2::object::id<Vault<T0, T1>>(arg2),
            ctokens             : arg4,
            fee_ctokens         : v1,
            principal_after     : arg2.principal,
            savings_value_after : ctoken_value(0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg2.ctokens), arg3),
        };
        0x2::event::emit<CTokensWithdrawn>(v3);
        (v2, 0x2::balance::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut v2, v1))
    }

    public(friend) fun yield_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 == 0) {
            true
        } else if (arg1 <= arg2) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        (((arg0 as u256) * ((arg1 - arg2) as u256) * (arg3 as u256) / (arg1 as u256) * (10000 as u256)) as u64)
    }

    // decompiled from Move bytecode v7
}

