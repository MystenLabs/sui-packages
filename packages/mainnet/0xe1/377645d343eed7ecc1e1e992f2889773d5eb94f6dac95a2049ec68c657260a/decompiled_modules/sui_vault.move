module 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_vault {
    struct SuiLeaderCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultShare has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        amount: u64,
        entry_nav: u64,
        acquired_at: u64,
    }

    struct SuiVault<phantom T0> has key {
        id: 0x2::object::UID,
        leader: address,
        admin: address,
        factory_id: 0x2::object::ID,
        total_supply: u64,
        usdc_reserve: 0x2::balance::Balance<T0>,
        virtual_base: u64,
        virtual_tokens: u64,
        initial_assets: u64,
        twap_nav: u64,
        twap_nav_time: u64,
        twap_half_life: u64,
        total_deposits: u64,
        total_volume: u64,
        total_ps_usdc: u64,
        user_purchase_info: 0x2::table::Table<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>,
        entry_records: 0x2::table::Table<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>,
        pending_sells: 0x2::table::Table<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>,
        performance_fee_bps: u64,
        paused: bool,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        metadata_uri: 0x1::string::String,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        leader: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        performance_fee_bps: u64,
    }

    struct TokenBought has copy, drop {
        vault_id: 0x2::object::ID,
        buyer: address,
        usdc_in: u64,
        tokens_out: u64,
        price: u64,
        nav: u64,
    }

    struct TokenSold has copy, drop {
        vault_id: 0x2::object::ID,
        seller: address,
        tokens_in: u64,
        usdc_out: u64,
        price: u64,
        nav: u64,
        exit_fee: u64,
        performance_fee_tokens: u64,
    }

    struct PendingSellCreated has copy, drop {
        vault_id: 0x2::object::ID,
        seller: address,
        usdc_amount: u64,
        fee_amount: u64,
    }

    struct PendingSellClaimed has copy, drop {
        vault_id: 0x2::object::ID,
        claimer: address,
        usdc_amount: u64,
    }

    struct PerformanceFeeMinted has copy, drop {
        vault_id: 0x2::object::ID,
        leader: address,
        fee_tokens: u64,
        seller: address,
    }

    struct NavUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        instant_nav: u64,
        twap_nav: u64,
        total_assets: u64,
        total_supply: u64,
    }

    struct ExternalAssetsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun id<T0>(arg0: &SuiVault<T0>) : 0x2::object::ID {
        0x2::object::id<SuiVault<T0>>(arg0)
    }

    fun get_exit_fee_bps<T0>(arg0: &SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: address, arg3: u64) : u64 {
        if (!0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&arg0.user_purchase_info, arg2)) {
            return 0
        };
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::get_exit_fee_bps(arg1, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_days_held(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::purchase_weighted_timestamp(0x2::table::borrow<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&arg0.user_purchase_info, arg2)), arg3))
    }

    public fun is_paused<T0>(arg0: &SuiVault<T0>) : bool {
        arg0.paused
    }

    fun update_entry_record<T0>(arg0: &mut SuiVault<T0>, arg1: address, arg2: u64, arg3: u64) {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::update_entry_record(0x2::table::borrow_mut<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&mut arg0.entry_records, arg1), arg2, arg3);
        } else {
            0x2::table::add<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&mut arg0.entry_records, arg1, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::new_entry_record(arg3, arg2));
        };
    }

    public fun admin<T0>(arg0: &SuiVault<T0>) : address {
        arg0.admin
    }

    public fun available_usdc_for_trading<T0>(arg0: &SuiVault<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.usdc_reserve);
        if (v0 > arg0.total_ps_usdc) {
            v0 - arg0.total_ps_usdc
        } else {
            0
        }
    }

    public fun buy<T0>(arg0: &mut SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::settings(arg1);
        assert!(v0 >= 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_min_deposit_usdc(v1), 9);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v4 = get_total_assets<T0>(arg0);
        let v5 = calculate_nav_internal<T0>(arg0, arg1, v4);
        update_twap_internal<T0>(arg0, v5, v3);
        let v6 = get_smoothed_nav_internal<T0>(arg0, v5, v3);
        let v7 = v0 - 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v0, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_trading_fee_bps(v1), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps());
        let (v8, v9) = get_effective_virtuals<T0>(arg0, arg1, v4);
        let v10 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_tokens_out(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_virtual_base_usdc(v8, v6), v9, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::usdc_to_internal(v7));
        assert!(v10 > 0, 7);
        assert!(v10 >= arg3, 4);
        0x2::balance::join<T0>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_supply = arg0.total_supply + v10;
        arg0.total_deposits = arg0.total_deposits + v0;
        arg0.total_volume = arg0.total_volume + v0;
        update_user_purchase_info<T0>(arg0, v2, v10, v3);
        update_entry_record<T0>(arg0, v2, v10, v6);
        let v11 = TokenBought{
            vault_id   : 0x2::object::id<SuiVault<T0>>(arg0),
            buyer      : v2,
            usdc_in    : v0,
            tokens_out : v10,
            price      : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::usdc_to_internal(v7), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), v10),
            nav        : v6,
        };
        0x2::event::emit<TokenBought>(v11);
        let v12 = VaultShare{
            id          : 0x2::object::new(arg5),
            vault_id    : 0x2::object::id<SuiVault<T0>>(arg0),
            amount      : v10,
            entry_nav   : v6,
            acquired_at : v3,
        };
        0x2::transfer::transfer<VaultShare>(v12, v2);
    }

    fun calculate_nav_internal<T0>(arg0: &SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: u64) : u64 {
        let (_, _, v2, v3, _) = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::get_tier_for_assets(arg1, arg2);
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_nav(arg2, arg0.total_supply, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_tiered_nav_virtual(arg2, arg0.initial_assets, v2, v3, arg0.initial_assets))
    }

    fun calculate_performance_fee_internal<T0>(arg0: &SuiVault<T0>, arg1: address, arg2: u64, arg3: u64) : u64 {
        if (!0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)) {
            return 0
        };
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_performance_fee(arg2, arg3, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::entry_weighted_nav(0x2::table::borrow<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)), arg0.performance_fee_bps)
    }

    public fun claim_pending_sell<T0>(arg0: &mut SuiVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&arg0.pending_sells, v0), 6);
        let v1 = 0x2::table::remove<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&mut arg0.pending_sells, v0);
        let v2 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::ps_usdc_amount(&v1);
        assert!(0x2::balance::value<T0>(&arg0.usdc_reserve) >= v2, 8);
        arg0.total_ps_usdc = arg0.total_ps_usdc - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.usdc_reserve, v2, arg1), v0);
        let v3 = PendingSellClaimed{
            vault_id    : 0x2::object::id<SuiVault<T0>>(arg0),
            claimer     : v0,
            usdc_amount : v2,
        };
        0x2::event::emit<PendingSellClaimed>(v3);
    }

    public fun create_vault<T0>(arg0: &mut 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::is_paused(arg0), 2);
        assert!(arg3 <= 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::max_performance_fee_bps(), 13);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3) = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::default_bc_params(arg0);
        let v4 = SuiVault<T0>{
            id                  : 0x2::object::new(arg5),
            leader              : v0,
            admin               : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::treasury(arg0),
            factory_id          : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::id(arg0),
            total_supply        : 0,
            usdc_reserve        : 0x2::balance::zero<T0>(),
            virtual_base        : v1,
            virtual_tokens      : v2,
            initial_assets      : v3,
            twap_nav            : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(),
            twap_nav_time       : 0x2::clock::timestamp_ms(arg4) / 1000,
            twap_half_life      : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::default_twap_half_life(),
            total_deposits      : 0,
            total_volume        : 0,
            total_ps_usdc       : 0,
            user_purchase_info  : 0x2::table::new<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(arg5),
            entry_records       : 0x2::table::new<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(arg5),
            pending_sells       : 0x2::table::new<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(arg5),
            performance_fee_bps : arg3,
            paused              : false,
            name                : 0x1::string::utf8(arg1),
            symbol              : 0x1::string::utf8(arg2),
            metadata_uri        : 0x1::string::utf8(b""),
        };
        let v5 = 0x2::object::id<SuiVault<T0>>(&v4);
        let v6 = SuiLeaderCap{
            id       : 0x2::object::new(arg5),
            vault_id : v5,
        };
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::register_vault(arg0, v5, v0, arg1, arg2, arg3, arg4, arg5);
        let v7 = VaultCreated{
            vault_id            : v5,
            leader              : v0,
            name                : 0x1::string::utf8(arg1),
            symbol              : 0x1::string::utf8(arg2),
            performance_fee_bps : arg3,
        };
        0x2::event::emit<VaultCreated>(v7);
        0x2::transfer::transfer<SuiLeaderCap>(v6, v0);
        0x2::transfer::share_object<SuiVault<T0>>(v4);
    }

    public(friend) fun deposit_usdc_from_trading<T0>(arg0: &mut SuiVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.usdc_reserve, 0x2::coin::into_balance<T0>(arg1));
        let v1 = get_external_assets_value<T0>(arg0);
        if (v1 >= v0) {
            set_external_assets_value<T0>(arg0, v1 - v0);
        } else {
            set_external_assets_value<T0>(arg0, 0);
        };
    }

    public fun emergency_pause<T0>(arg0: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiAdminCap, arg1: &mut SuiVault<T0>) {
        arg1.paused = true;
    }

    public(friend) fun extract_usdc_for_trading<T0>(arg0: &mut SuiVault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::balance::value<T0>(&arg0.usdc_reserve) >= arg1, 8);
        let v0 = 0x2::balance::split<T0>(&mut arg0.usdc_reserve, arg1);
        let v1 = get_external_assets_value<T0>(arg0) + arg1;
        set_external_assets_value<T0>(arg0, v1);
        0x2::coin::from_balance<T0>(v0, arg2)
    }

    fun get_effective_virtuals<T0>(arg0: &SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: u64) : (u64, u64) {
        let (v0, v1, _, _, v4) = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::get_tier_for_assets(arg1, arg2);
        let v5 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_effective_bc_virtual(arg2, v1, v0, v4);
        (v5, v5)
    }

    public fun get_external_assets_value<T0>(arg0: &SuiVault<T0>) : u64 {
        let v0 = ExternalAssetsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ExternalAssetsKey>(&arg0.id, v0)) {
            let v2 = ExternalAssetsKey{dummy_field: false};
            *0x2::dynamic_field::borrow<ExternalAssetsKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun get_max_buy_usdc<T0>(arg0: &SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory) : u64 {
        let v0 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::settings(arg1);
        let v1 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_min_deposit_usdc(v0);
        let v2 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_max_buy_bps(v0);
        let v3 = get_total_assets<T0>(arg0);
        if (v3 == 0 || v2 == 0) {
            return v1
        };
        let v4 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::internal_to_usdc(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v3, v2, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps()));
        if (v4 > v1) {
            v4
        } else {
            v1
        }
    }

    fun get_smoothed_nav_internal<T0>(arg0: &SuiVault<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg2 > arg0.twap_nav_time) {
            arg2 - arg0.twap_nav_time
        } else {
            0
        };
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_smoothed_nav(arg1, arg0.twap_nav, v0, arg0.twap_half_life)
    }

    fun get_total_assets<T0>(arg0: &SuiVault<T0>) : u64 {
        0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::usdc_to_internal(0x2::balance::value<T0>(&arg0.usdc_reserve) + get_external_assets_value<T0>(arg0))
    }

    public fun leader<T0>(arg0: &SuiVault<T0>) : address {
        arg0.leader
    }

    public fun leader_cap_vault_id(arg0: &SuiLeaderCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun max_sellable_usdc<T0>(arg0: &SuiVault<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.usdc_reserve);
        let v1 = arg0.total_ps_usdc;
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun merge_shares(arg0: &mut VaultShare, arg1: VaultShare) {
        assert!(arg0.vault_id == arg1.vault_id, 1);
        let VaultShare {
            id          : v0,
            vault_id    : _,
            amount      : v2,
            entry_nav   : v3,
            acquired_at : v4,
        } = arg1;
        0x2::object::delete(v0);
        let v5 = arg0.amount + v2;
        if (v5 > 0) {
            arg0.entry_nav = ((((arg0.entry_nav as u128) * (arg0.amount as u128) + (v3 as u128) * (v2 as u128)) / (v5 as u128)) as u64);
            if (v4 < arg0.acquired_at) {
                arg0.acquired_at = v4;
            };
        };
        arg0.amount = v5;
    }

    public fun name<T0>(arg0: &SuiVault<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun pending_sell_amount<T0>(arg0: &SuiVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&arg0.pending_sells, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::ps_usdc_amount(0x2::table::borrow<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&arg0.pending_sells, arg1))
        } else {
            0
        }
    }

    public fun performance_fee_bps<T0>(arg0: &SuiVault<T0>) : u64 {
        arg0.performance_fee_bps
    }

    fun reduce_entry_record<T0>(arg0: &mut SuiVault<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::reduce_entry_tokens(0x2::table::borrow_mut<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&mut arg0.entry_records, arg1), arg2);
        };
    }

    fun reduce_user_purchase_info<T0>(arg0: &mut SuiVault<T0>, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&arg0.user_purchase_info, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::reduce_purchase_tokens(0x2::table::borrow_mut<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&mut arg0.user_purchase_info, arg1), arg2);
        };
    }

    public fun reset_external_assets<T0>(arg0: &mut SuiVault<T0>, arg1: &SuiLeaderCap, arg2: u64) {
        assert!(leader_cap_vault_id(arg1) == 0x2::object::id<SuiVault<T0>>(arg0), 1);
        set_external_assets_value<T0>(arg0, arg2);
    }

    public fun sell<T0>(arg0: &mut SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg2 > 0, 3);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(!0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&arg0.pending_sells, v0), 5);
        let v2 = get_total_assets<T0>(arg0);
        let v3 = calculate_nav_internal<T0>(arg0, arg1, v2);
        update_twap_internal<T0>(arg0, v3, v1);
        let v4 = get_smoothed_nav_internal<T0>(arg0, v3, v1);
        let v5 = calculate_performance_fee_internal<T0>(arg0, v0, arg2, v4);
        let (v6, v7) = get_effective_virtuals<T0>(arg0, arg1, v2);
        let v8 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_usdc_out(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_virtual_base_usdc(v6, v4), v7, arg2);
        let v9 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::internal_to_usdc(v8);
        let v10 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v9, get_exit_fee_bps<T0>(arg0, arg1, v0, v1), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps());
        let v11 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v9, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_trading_fee_bps(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::settings(arg1)), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps());
        let v12 = v9 - v10 - v11;
        assert!(v12 >= arg3, 4);
        arg0.total_supply = arg0.total_supply - arg2;
        reduce_user_purchase_info<T0>(arg0, v0, arg2);
        reduce_entry_record<T0>(arg0, v0, arg2);
        if (v5 > 0) {
            let v13 = arg0.leader;
            arg0.total_supply = arg0.total_supply + v5;
            update_entry_record<T0>(arg0, v13, v5, v4);
            update_user_purchase_info<T0>(arg0, v13, v5, v1);
            let v14 = PerformanceFeeMinted{
                vault_id   : 0x2::object::id<SuiVault<T0>>(arg0),
                leader     : v13,
                fee_tokens : v5,
                seller     : v0,
            };
            0x2::event::emit<PerformanceFeeMinted>(v14);
        };
        arg0.total_volume = arg0.total_volume + v9;
        let v15 = 0x2::balance::value<T0>(&arg0.usdc_reserve);
        let v16 = if (v15 > arg0.total_ps_usdc) {
            v15 - arg0.total_ps_usdc
        } else {
            0
        };
        if (v12 <= v16) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.usdc_reserve, v12, arg5), v0);
            let v17 = TokenSold{
                vault_id               : 0x2::object::id<SuiVault<T0>>(arg0),
                seller                 : v0,
                tokens_in              : arg2,
                usdc_out               : v12,
                price                  : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v8, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), arg2),
                nav                    : v4,
                exit_fee               : v10,
                performance_fee_tokens : v5,
            };
            0x2::event::emit<TokenSold>(v17);
        } else {
            0x2::table::add<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&mut arg0.pending_sells, v0, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::new_pending_sell(v12, v10 + v11, v1));
            arg0.total_ps_usdc = arg0.total_ps_usdc + v12;
            let v18 = PendingSellCreated{
                vault_id    : 0x2::object::id<SuiVault<T0>>(arg0),
                seller      : v0,
                usdc_amount : v12,
                fee_amount  : v10 + v11,
            };
            0x2::event::emit<PendingSellCreated>(v18);
            let v19 = TokenSold{
                vault_id               : 0x2::object::id<SuiVault<T0>>(arg0),
                seller                 : v0,
                tokens_in              : arg2,
                usdc_out               : 0,
                price                  : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v8, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), arg2),
                nav                    : v4,
                exit_fee               : v10,
                performance_fee_tokens : v5,
            };
            0x2::event::emit<TokenSold>(v19);
        };
    }

    public fun sell_shares<T0>(arg0: &mut SuiVault<T0>, arg1: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiFactory, arg2: VaultShare, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg2.vault_id == 0x2::object::id<SuiVault<T0>>(arg0), 1);
        let VaultShare {
            id          : v0,
            vault_id    : _,
            amount      : v2,
            entry_nav   : v3,
            acquired_at : v4,
        } = arg2;
        0x2::object::delete(v0);
        assert!(v2 > 0, 3);
        let v5 = 0x2::tx_context::sender(arg5);
        let v6 = 0x2::clock::timestamp_ms(arg4) / 1000;
        assert!(!0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&arg0.pending_sells, v5), 5);
        let v7 = get_total_assets<T0>(arg0);
        let v8 = calculate_nav_internal<T0>(arg0, arg1, v7);
        update_twap_internal<T0>(arg0, v8, v6);
        let v9 = get_smoothed_nav_internal<T0>(arg0, v8, v6);
        let v10 = if (v9 > v3 && arg0.performance_fee_bps > 0) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v2, v9 - v3, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision()), arg0.performance_fee_bps, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps()), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), v9)
        } else {
            0
        };
        let (v11, v12) = get_effective_virtuals<T0>(arg0, arg1, v7);
        let v13 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_usdc_out(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_virtual_base_usdc(v11, v9), v12, v2);
        let v14 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::internal_to_usdc(v13);
        let v15 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v14, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::get_exit_fee_bps(arg1, (v6 - v4) / 86400), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps());
        let v16 = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v14, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::settings_trading_fee_bps(0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::settings(arg1)), 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::bps());
        let v17 = v14 - v15 - v16;
        assert!(v17 >= arg3, 4);
        arg0.total_supply = arg0.total_supply - v2;
        if (v10 > 0) {
            let v18 = arg0.leader;
            arg0.total_supply = arg0.total_supply + v10;
            let v19 = VaultShare{
                id          : 0x2::object::new(arg5),
                vault_id    : 0x2::object::id<SuiVault<T0>>(arg0),
                amount      : v10,
                entry_nav   : v9,
                acquired_at : v6,
            };
            0x2::transfer::transfer<VaultShare>(v19, v18);
            let v20 = PerformanceFeeMinted{
                vault_id   : 0x2::object::id<SuiVault<T0>>(arg0),
                leader     : v18,
                fee_tokens : v10,
                seller     : v5,
            };
            0x2::event::emit<PerformanceFeeMinted>(v20);
        };
        arg0.total_volume = arg0.total_volume + v14;
        let v21 = 0x2::balance::value<T0>(&arg0.usdc_reserve);
        let v22 = if (v21 > arg0.total_ps_usdc) {
            v21 - arg0.total_ps_usdc
        } else {
            0
        };
        if (v17 <= v22) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.usdc_reserve, v17, arg5), v5);
            let v23 = TokenSold{
                vault_id               : 0x2::object::id<SuiVault<T0>>(arg0),
                seller                 : v5,
                tokens_in              : v2,
                usdc_out               : v17,
                price                  : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v13, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), v2),
                nav                    : v9,
                exit_fee               : v15,
                performance_fee_tokens : v10,
            };
            0x2::event::emit<TokenSold>(v23);
        } else {
            0x2::table::add<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::PendingSell>(&mut arg0.pending_sells, v5, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::new_pending_sell(v17, v15 + v16, v6));
            arg0.total_ps_usdc = arg0.total_ps_usdc + v17;
            let v24 = PendingSellCreated{
                vault_id    : 0x2::object::id<SuiVault<T0>>(arg0),
                seller      : v5,
                usdc_amount : v17,
                fee_amount  : v15 + v16,
            };
            0x2::event::emit<PendingSellCreated>(v24);
            let v25 = TokenSold{
                vault_id               : 0x2::object::id<SuiVault<T0>>(arg0),
                seller                 : v5,
                tokens_in              : v2,
                usdc_out               : 0,
                price                  : 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::mul_div(v13, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision(), v2),
                nav                    : v9,
                exit_fee               : v15,
                performance_fee_tokens : v10,
            };
            0x2::event::emit<TokenSold>(v25);
        };
    }

    public fun set_admin<T0>(arg0: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiAdminCap, arg1: &mut SuiVault<T0>, arg2: address) {
        arg1.admin = arg2;
    }

    fun set_external_assets_value<T0>(arg0: &mut SuiVault<T0>, arg1: u64) {
        let v0 = ExternalAssetsKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ExternalAssetsKey>(&arg0.id, v0)) {
            let v1 = ExternalAssetsKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<ExternalAssetsKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = ExternalAssetsKey{dummy_field: false};
            0x2::dynamic_field::add<ExternalAssetsKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public fun set_metadata_uri<T0>(arg0: &SuiLeaderCap, arg1: &mut SuiVault<T0>, arg2: vector<u8>) {
        assert!(arg0.vault_id == 0x2::object::id<SuiVault<T0>>(arg1), 1);
        arg1.metadata_uri = 0x1::string::utf8(arg2);
    }

    public fun set_paused<T0>(arg0: &SuiLeaderCap, arg1: &mut SuiVault<T0>, arg2: bool) {
        assert!(arg0.vault_id == 0x2::object::id<SuiVault<T0>>(arg1), 1);
        arg1.paused = arg2;
    }

    public fun set_twap_half_life<T0>(arg0: &0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_factory::SuiAdminCap, arg1: &mut SuiVault<T0>, arg2: u64) {
        arg1.twap_half_life = arg2;
    }

    public fun share_acquired_at(arg0: &VaultShare) : u64 {
        arg0.acquired_at
    }

    public fun share_amount(arg0: &VaultShare) : u64 {
        arg0.amount
    }

    public fun share_entry_nav(arg0: &VaultShare) : u64 {
        arg0.entry_nav
    }

    public fun share_vault_id(arg0: &VaultShare) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun split_share(arg0: &mut VaultShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VaultShare {
        assert!(arg0.amount >= arg1, 3);
        arg0.amount = arg0.amount - arg1;
        VaultShare{
            id          : 0x2::object::new(arg2),
            vault_id    : arg0.vault_id,
            amount      : arg1,
            entry_nav   : arg0.entry_nav,
            acquired_at : arg0.acquired_at,
        }
    }

    public fun symbol<T0>(arg0: &SuiVault<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public fun total_deposits<T0>(arg0: &SuiVault<T0>) : u64 {
        arg0.total_deposits
    }

    public fun total_supply<T0>(arg0: &SuiVault<T0>) : u64 {
        arg0.total_supply
    }

    public fun total_volume<T0>(arg0: &SuiVault<T0>) : u64 {
        arg0.total_volume
    }

    public fun twap_nav<T0>(arg0: &SuiVault<T0>) : u64 {
        arg0.twap_nav
    }

    fun update_twap_internal<T0>(arg0: &mut SuiVault<T0>, arg1: u64, arg2: u64) {
        let v0 = if (arg2 > arg0.twap_nav_time) {
            arg2 - arg0.twap_nav_time
        } else {
            0
        };
        if (arg1 >= arg0.twap_nav) {
            arg0.twap_nav = arg1;
        } else if (v0 > 0) {
            arg0.twap_nav = 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_math::calculate_smoothed_nav(arg1, arg0.twap_nav, v0, arg0.twap_half_life);
        };
        arg0.twap_nav_time = arg2;
        let v1 = NavUpdated{
            vault_id     : 0x2::object::id<SuiVault<T0>>(arg0),
            instant_nav  : arg1,
            twap_nav     : arg0.twap_nav,
            total_assets : get_total_assets<T0>(arg0),
            total_supply : arg0.total_supply,
        };
        0x2::event::emit<NavUpdated>(v1);
    }

    fun update_user_purchase_info<T0>(arg0: &mut SuiVault<T0>, arg1: address, arg2: u64, arg3: u64) {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&arg0.user_purchase_info, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::update_purchase_info(0x2::table::borrow_mut<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&mut arg0.user_purchase_info, arg1), arg2, arg3);
        } else {
            0x2::table::add<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::UserPurchaseInfo>(&mut arg0.user_purchase_info, arg1, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::new_user_purchase_info(arg2, arg3, arg3));
        };
    }

    public fun usdc_reserve<T0>(arg0: &SuiVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.usdc_reserve)
    }

    public fun user_entry_nav<T0>(arg0: &SuiVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::entry_weighted_nav(0x2::table::borrow<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1))
        } else {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::precision()
        }
    }

    public fun user_entry_tokens<T0>(arg0: &SuiVault<T0>, arg1: address) : u64 {
        if (0x2::table::contains<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1)) {
            0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::entry_total_tokens(0x2::table::borrow<address, 0xe1377645d343eed7ecc1e1e992f2889773d5eb94f6dac95a2049ec68c657260a::sui_types::EntryRecord>(&arg0.entry_records, arg1))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

