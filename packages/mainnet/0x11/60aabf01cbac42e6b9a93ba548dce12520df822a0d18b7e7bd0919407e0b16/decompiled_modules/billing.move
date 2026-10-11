module 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::billing {
    struct USD has drop {
        dummy_field: bool,
    }

    struct Money has copy, drop, store {
        amount: u64,
        currency: 0x1::type_name::TypeName,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
    }

    struct RoleKey has copy, drop, store {
        financial_owner: address,
        role: u8,
    }

    struct VaultRole has key {
        id: 0x2::object::UID,
        financial_owner: address,
        role: u8,
        vault_id: 0x2::object::ID,
    }

    struct CurrencyRegistry has key {
        id: 0x2::object::UID,
        currencies: 0x2::table::Table<0x1::type_name::TypeName, CurrencyInfo>,
        rates: 0x2::table::Table<RateKey, RateEntry>,
    }

    struct CurrencyInfo has copy, drop, store {
        decimals: u8,
        symbol: vector<u8>,
    }

    struct RateKey has copy, drop, store {
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RateEntry has copy, drop, store {
        rate: u64,
        rate_decimals: u8,
        coin_decimals: u8,
        updated_at_ms: u64,
        max_age_ms: u64,
        source: address,
        accepting: bool,
    }

    struct CurrencyAdminCap has store, key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
    }

    struct RateSnapshot has copy, drop, store {
        rate: u64,
        rate_decimals: u8,
        updated_at_ms: u64,
        source: address,
    }

    struct VaultRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct CurrencyRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct CurrencyRegistered has copy, drop {
        registry_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        decimals: u8,
        symbol: vector<u8>,
        by: address,
    }

    struct RateSet has copy, drop {
        registry_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        rate: u64,
        rate_decimals: u8,
        coin_decimals: u8,
        max_age_ms: u64,
        accepting: bool,
        by: address,
    }

    struct CoinAcceptanceSet has copy, drop {
        registry_id: 0x2::object::ID,
        currency: 0x1::type_name::TypeName,
        coin_type: 0x1::type_name::TypeName,
        accepting: bool,
        by: address,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        financial_owner: address,
        role: u8,
        role_binding_id: 0x2::object::ID,
        child_manager: 0x1::type_name::TypeName,
    }

    struct VaultFunded has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct WithdrawnToAddress has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        by: address,
    }

    fun add_currency(arg0: &mut CurrencyRegistry, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(arg2 <= 18, 13838720365307101209);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, arg1), 13838157419648385045);
        let v0 = CurrencyInfo{
            decimals : arg2,
            symbol   : arg3,
        };
        0x2::table::add<0x1::type_name::TypeName, CurrencyInfo>(&mut arg0.currencies, arg1, v0);
        let v1 = CurrencyRegistered{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            currency    : arg1,
            decimals    : arg2,
            symbol      : arg3,
            by          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CurrencyRegistered>(v1);
    }

    fun assert_admin(arg0: &CurrencyRegistry, arg1: &CurrencyAdminCap) {
        assert!(arg1.registry_id == 0x2::object::id<CurrencyRegistry>(arg0), 13836468531132629001);
    }

    public fun assert_currency(arg0: &CurrencyRegistry, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, arg1), 13837875678383570963);
    }

    public fun assert_role(arg0: &VaultRole, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: address, arg3: u8) {
        let v0 = if (arg0.vault_id == 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg1)) {
            if (arg0.financial_owner == arg2) {
                arg0.role == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13836185320988999687);
    }

    public fun available_allowance<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u64 {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::available_allowance<T0>(arg0, arg1, arg2)
    }

    public fun binding_financial_owner(arg0: &VaultRole) : address {
        arg0.financial_owner
    }

    public fun binding_role(arg0: &VaultRole) : u8 {
        arg0.role
    }

    public fun binding_vault_id(arg0: &VaultRole) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun calendar_allowance_anchor_ms<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::object::ID) : u64 {
        0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::rate_limiter::original_anchor_ms(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::rate_limiter<T0>(arg0, arg1))
    }

    public fun create_vault<T0: drop>(arg0: &mut VaultRegistry, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 == 0 || arg1 == 1, 13835340754324553729);
        assert!(arg2 == 0x2::tx_context::sender(arg3), 13835622233596362755);
        let v0 = RoleKey{
            financial_owner : arg2,
            role            : arg1,
        };
        let (v1, v2) = 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::new(arg3);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(&v4);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::set_child_manager<T0>(&mut v4, &v3, arg3);
        let v6 = VaultRole{
            id              : 0x2::derived_object::claim<RoleKey>(&mut arg0.id, v0),
            financial_owner : arg2,
            role            : arg1,
            vault_id        : v5,
        };
        0x2::transfer::freeze_object<VaultRole>(v6);
        let v7 = VaultCreated{
            vault_id        : v5,
            owner_cap_id    : 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap>(&v3),
            financial_owner : arg2,
            role            : arg1,
            role_binding_id : 0x2::object::id<VaultRole>(&v6),
            child_manager   : 0x1::type_name::with_defining_ids<T0>(),
        };
        0x2::event::emit<VaultCreated>(v7);
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::share(v4);
        0x2::transfer::public_transfer<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap>(v3, arg2);
        v5
    }

    public fun creator_role() : u8 {
        1
    }

    public fun currency_decimals(arg0: &CurrencyInfo) : u8 {
        arg0.decimals
    }

    public fun currency_info<T0>(arg0: &CurrencyRegistry) : CurrencyInfo {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, v0), 13837875734218145811);
        *0x2::table::borrow<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, v0)
    }

    public fun currency_symbol(arg0: &CurrencyInfo) : vector<u8> {
        arg0.symbol
    }

    public fun deposit<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::deposit<T0>(arg0, arg1, arg2);
    }

    public fun deposit_balance<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::deposit_balance<T0>(arg0, arg1, arg2);
    }

    public fun deposit_from_vault<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg2: 0x2::transfer::Receiving<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::deposit_from_vault<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun entry_accepting(arg0: &RateEntry) : bool {
        arg0.accepting
    }

    public fun entry_coin_decimals(arg0: &RateEntry) : u8 {
        arg0.coin_decimals
    }

    public fun entry_max_age_ms(arg0: &RateEntry) : u64 {
        arg0.max_age_ms
    }

    public fun entry_rate(arg0: &RateEntry) : u64 {
        arg0.rate
    }

    public fun entry_rate_decimals(arg0: &RateEntry) : u8 {
        arg0.rate_decimals
    }

    public fun entry_source(arg0: &RateEntry) : address {
        arg0.source
    }

    public fun entry_updated_at_ms(arg0: &RateEntry) : u64 {
        arg0.updated_at_ms
    }

    public fun fan_role() : u8 {
        0
    }

    public fun fund_vault<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 13839000281210814491);
        0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(arg1), 0x2::object::id_to_address(&arg0));
        let v1 = VaultFunded{
            vault_id  : arg0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultFunded>(v1);
    }

    public fun has_currency<T0>(arg0: &CurrencyRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun has_rate<T0, T1>(arg0: &CurrencyRegistry) : bool {
        0x2::table::contains<RateKey, RateEntry>(&arg0.rates, rate_key<T0, T1>())
    }

    public fun has_role(arg0: &VaultRegistry, arg1: address, arg2: u8) : bool {
        let v0 = RoleKey{
            financial_owner : arg1,
            role            : arg2,
        };
        0x2::derived_object::exists<RoleKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{id: 0x2::object::new(arg0)};
        let v1 = VaultRegistryCreated{registry_id: 0x2::object::id<VaultRegistry>(&v0)};
        0x2::event::emit<VaultRegistryCreated>(v1);
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v2 = CurrencyRegistry{
            id         : 0x2::object::new(arg0),
            currencies : 0x2::table::new<0x1::type_name::TypeName, CurrencyInfo>(arg0),
            rates      : 0x2::table::new<RateKey, RateEntry>(arg0),
        };
        let v3 = CurrencyAdminCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x2::object::id<CurrencyRegistry>(&v2),
        };
        let v4 = CurrencyRegistryCreated{
            registry_id  : 0x2::object::id<CurrencyRegistry>(&v2),
            admin_cap_id : 0x2::object::id<CurrencyAdminCap>(&v3),
        };
        0x2::event::emit<CurrencyRegistryCreated>(v4);
        let v5 = &mut v2;
        add_currency(v5, 0x1::type_name::with_defining_ids<USD>(), 2, b"USD", arg0);
        0x2::transfer::share_object<CurrencyRegistry>(v2);
        0x2::transfer::public_transfer<CurrencyAdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun is_accepting<T0, T1>(arg0: &CurrencyRegistry) : bool {
        let v0 = rate_key<T0, T1>();
        0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0) && 0x2::table::borrow<RateKey, RateEntry>(&arg0.rates, v0).accepting
    }

    public fun is_currency(arg0: &CurrencyRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, arg1)
    }

    public fun mint_spender_cap(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::SpenderCap {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::mint_cap(arg0, arg1, arg2)
    }

    public fun money<T0>(arg0: u64) : Money {
        Money{
            amount   : arg0,
            currency : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun money_amount(arg0: &Money) : u64 {
        arg0.amount
    }

    public fun money_currency(arg0: &Money) : 0x1::type_name::TypeName {
        arg0.currency
    }

    public fun money_from_parts(arg0: u64, arg1: 0x1::type_name::TypeName) : Money {
        Money{
            amount   : arg0,
            currency : arg1,
        }
    }

    fun pow10(arg0: u64) : u128 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun rate_entry<T0, T1>(arg0: &CurrencyRegistry) : RateEntry {
        let v0 = rate_key<T0, T1>();
        assert!(0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0), 13837031395186966541);
        *0x2::table::borrow<RateKey, RateEntry>(&arg0.rates, v0)
    }

    fun rate_key<T0, T1>() : RateKey {
        RateKey{
            currency  : 0x1::type_name::with_defining_ids<T0>(),
            coin_type : 0x1::type_name::with_defining_ids<T1>(),
        }
    }

    public fun register_currency<T0>(arg0: &mut CurrencyRegistry, arg1: &CurrencyAdminCap, arg2: u8, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        add_currency(arg0, 0x1::type_name::with_defining_ids<T0>(), arg2, arg3, arg4);
    }

    public fun revoke_all_allowances(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::revoke_all(arg0, arg1, arg2, arg3);
    }

    public fun revoke_allowance<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : bool {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::revoke<T0>(arg0, arg1, arg2, arg3)
    }

    public fun role_binding_address(arg0: 0x2::object::ID, arg1: address, arg2: u8) : address {
        let v0 = RoleKey{
            financial_owner : arg1,
            role            : arg2,
        };
        0x2::derived_object::derive_address<RoleKey>(arg0, v0)
    }

    public fun set_accepting<T0, T1>(arg0: &mut CurrencyRegistry, arg1: &CurrencyAdminCap, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = rate_key<T0, T1>();
        assert!(0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0), 13837031047294615565);
        0x2::table::borrow_mut<RateKey, RateEntry>(&mut arg0.rates, v0).accepting = arg2;
        let v1 = CoinAcceptanceSet{
            registry_id : 0x2::object::id<CurrencyRegistry>(arg0),
            currency    : v0.currency,
            coin_type   : v0.coin_type,
            accepting   : arg2,
            by          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CoinAcceptanceSet>(v1);
    }

    public fun set_allowance<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::set_allowance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_calendar_allowance<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::CalendarPeriod, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::period_unit(arg4);
        let v1 = if (v0 == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::day_unit()) {
            0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::calendar::days(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::period_count(arg4))
        } else if (v0 == 0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::month_unit()) {
            0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::calendar::months(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::period_count(arg4))
        } else {
            0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::calendar::years(0x1160aabf01cbac42e6b9a93ba548dce12520df822a0d18b7e7bd0919407e0b16::calendar::period_count(arg4))
        };
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::create_rate_limited_allowance<T0>(arg0, arg1, arg2, 0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::rate_limiter::new_calendar_window(arg3, v1, arg5, arg3, arg7), arg6, arg7, arg8);
    }

    public fun set_rate<T0, T1>(arg0: &mut CurrencyRegistry, arg1: &CurrencyAdminCap, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        let v0 = rate_key<T0, T1>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CurrencyInfo>(&arg0.currencies, v0.currency), 13837875274656645139);
        assert!(arg2 > 0, 13836749379044245515);
        assert!(arg4 <= 18 && arg3 <= 18 - arg4, 13836749383339212811);
        let v1 = 0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0) && 0x2::table::borrow<RateKey, RateEntry>(&arg0.rates, v0).accepting || true;
        let v2 = RateEntry{
            rate          : arg2,
            rate_decimals : arg3,
            coin_decimals : arg4,
            updated_at_ms : 0x2::clock::timestamp_ms(arg6),
            max_age_ms    : arg5,
            source        : 0x2::tx_context::sender(arg7),
            accepting     : v1,
        };
        if (0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0)) {
            *0x2::table::borrow_mut<RateKey, RateEntry>(&mut arg0.rates, v0) = v2;
        } else {
            0x2::table::add<RateKey, RateEntry>(&mut arg0.rates, v0, v2);
        };
        let v3 = RateSet{
            registry_id   : 0x2::object::id<CurrencyRegistry>(arg0),
            currency      : v0.currency,
            coin_type     : v0.coin_type,
            rate          : arg2,
            rate_decimals : arg3,
            coin_decimals : arg4,
            max_age_ms    : arg5,
            accepting     : v1,
            by            : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<RateSet>(v3);
    }

    public fun set_rate_limited_allowance<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: 0x2::object::ID, arg3: 0x396b292af7a456193f27e1db01ba5badb776ce8315d3b190f8ab0066fd9ce0d4::rate_limiter::RateLimiter, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::create_rate_limited_allowance<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun settled_balance<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::balance_value<T0>(arg0, arg1)
    }

    public fun snapshot_rate(arg0: &RateSnapshot) : u64 {
        arg0.rate
    }

    public fun snapshot_rate_decimals(arg0: &RateSnapshot) : u8 {
        arg0.rate_decimals
    }

    public fun snapshot_source(arg0: &RateSnapshot) : address {
        arg0.source
    }

    public fun snapshot_updated_at_ms(arg0: &RateSnapshot) : u64 {
        arg0.updated_at_ms
    }

    public fun spendable_now<T0>(arg0: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x2::accumulator::AccumulatorRoot, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::spendable_now<T0>(arg0, arg1, arg2, arg3)
    }

    public fun squash<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::squash<T0>(arg0, arg1, arg2);
    }

    public fun to_coin_units<T0>(arg0: &CurrencyRegistry, arg1: Money, arg2: &0x2::clock::Clock) : (u64, RateSnapshot) {
        let v0 = RateKey{
            currency  : arg1.currency,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
        };
        assert!(0x2::table::contains<RateKey, RateEntry>(&arg0.rates, v0), 13837031137488928781);
        let v1 = 0x2::table::borrow<RateKey, RateEntry>(&arg0.rates, v0);
        assert!(v1.accepting, 13838438520963072023);
        let v2 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1.max_age_ms == 18446744073709551615 || v2 >= v1.updated_at_ms && v2 - v1.updated_at_ms <= v1.max_age_ms, 13837312646825508879);
        let v3 = (arg1.amount as u128) * pow10((v1.coin_decimals as u64) + (v1.rate_decimals as u64)) / (v1.rate as u128);
        assert!(v3 <= 18446744073709551615, 13837594138982219793);
        let v4 = RateSnapshot{
            rate          : v1.rate,
            rate_decimals : v1.rate_decimals,
            updated_at_ms : v1.updated_at_ms,
            source        : v1.source,
        };
        ((v3 as u64), v4)
    }

    public fun usd_decimals() : u8 {
        2
    }

    public fun withdraw_to_address<T0>(arg0: &mut 0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault, arg1: &0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::OwnerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 != @0x0, 13835904168134705157);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::withdraw<T0>(arg0, arg1, arg2, arg4), arg4), arg3);
        let v0 = WithdrawnToAddress{
            vault_id  : 0x2::object::id<0x377bc54538b72e3b59a367c2231f7dd352f5b98e3dc0c61cf11c40c723b1e8ba::spend_vault::Vault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
            recipient : arg3,
            by        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<WithdrawnToAddress>(v0);
    }

    // decompiled from Move bytecode v7
}

