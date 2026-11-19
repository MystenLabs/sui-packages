module 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::miner {
    struct Tier has copy, drop, store {
        amount: u64,
        multiple: u64,
        daily_rate: u64,
        enabled: bool,
    }

    struct Order has store {
        owner: address,
        tier_index: u64,
        tier_amount: u64,
        multiple: u64,
        total_quota: u64,
        released_quota: u64,
        invested_at: u64,
        last_claim_at: u64,
        claim_seq: u64,
        active: bool,
    }

    struct UserAccount has store {
        owner: address,
        claimable: u64,
        dynamic_balance: u64,
        level: u8,
        total_invested: u64,
        downline_performance: u64,
    }

    struct MinerConfig has store, key {
        id: 0x2::object::UID,
        receive_address: address,
        ecosystem_address: address,
        fee_tech: address,
        fee_market: address,
        partners: vector<address>,
        genesis_nodes: vector<address>,
        blacklist: vector<address>,
        min_withdraw: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        tiers: vector<Tier>,
        orders: 0x2::table::Table<address, Order>,
        accounts: 0x2::table::Table<address, UserAccount>,
        vault_initialized: bool,
        vault_id: 0x1::option::Option<0x2::object::ID>,
        registry_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PayoutVault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DirectPerfKey has copy, drop, store {
        owner: address,
    }

    struct LevelRulesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LevelRule has copy, drop, store {
        level: u8,
        personal: u64,
        downline: u64,
        small_area: u64,
        direct_count: u64,
        direct_level: u8,
        team_rate: u64,
        peer_rate: u64,
    }

    struct LevelRuleUpdated has copy, drop {
        rule: LevelRule,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
    }

    struct Participated has copy, drop {
        tier_index: u64,
        user: address,
        tier_amount: u64,
        multiple: u64,
        total_quota: u64,
        paid_sui: u64,
    }

    struct Claimed has copy, drop {
        user: address,
        static_amount: u64,
        dynamic_amount: u64,
        remaining_quota: u64,
        order_active: bool,
    }

    struct Withdrawn has copy, drop {
        user: address,
        amount_usdc: u64,
        sui_out: u64,
        fee_tech: u64,
        fee_market: u64,
        partner_total: u64,
        user_sui: u64,
    }

    struct DynamicSettled has copy, drop {
        to: address,
        amount: u64,
        kind: u8,
    }

    struct TierUpdated has copy, drop {
        tier_index: u64,
        amount: u64,
        multiple: u64,
        daily_rate: u64,
        enabled: bool,
    }

    struct BlacklistAdded has copy, drop {
        account: address,
    }

    struct BlacklistRemoved has copy, drop {
        account: address,
    }

    struct LevelSetByAdmin has copy, drop {
        account: address,
        level: u8,
    }

    struct VaultFunded has copy, drop {
        amount: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        admin: address,
        recipient: address,
        amount: u64,
    }

    struct AddressUpdated has copy, drop {
        receive_address: address,
        ecosystem_address: address,
        fee_tech: address,
        fee_market: address,
    }

    struct AdminMinerAdded has copy, drop {
        admin: address,
        user: address,
        tier_index: u64,
        tier_amount: u64,
    }

    public entry fun add_blacklist(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        if (!0x1::vector::contains<address>(&arg0.blacklist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.blacklist, arg2);
            let v0 = BlacklistAdded{account: arg2};
            0x2::event::emit<BlacklistAdded>(v0);
        };
    }

    public entry fun add_blacklist_batch(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: vector<address>) {
        assert_owner(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            if (!0x1::vector::contains<address>(&arg0.blacklist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.blacklist, v1);
                let v2 = BlacklistAdded{account: v1};
                0x2::event::emit<BlacklistAdded>(v2);
            };
            v0 = v0 + 1;
        };
    }

    fun add_dynamic(arg0: &mut MinerConfig, arg1: address, arg2: u64, arg3: u8) {
        upsert_account(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, arg1);
        v0.dynamic_balance = v0.dynamic_balance + arg2;
        let v1 = DynamicSettled{
            to     : arg1,
            amount : arg2,
            kind   : arg3,
        };
        0x2::event::emit<DynamicSettled>(v1);
    }

    public entry fun add_genesis(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        if (!0x1::vector::contains<address>(&arg0.genesis_nodes, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.genesis_nodes, arg2);
        };
    }

    public entry fun add_partner(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        if (!0x1::vector::contains<address>(&arg0.partners, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.partners, arg2);
        };
    }

    public entry fun admin_add_miner(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_registry(arg0, arg2);
        assert!(arg3 != @0x0, 9);
        let v0 = get_tier_by_index(arg0, arg4);
        create_order_and_settle(arg0, arg2, arg3, arg4, v0, 0x2::clock::timestamp_ms(arg5));
        let v1 = AdminMinerAdded{
            admin       : 0x2::tx_context::sender(arg6),
            user        : arg3,
            tier_index  : arg4,
            tier_amount : v0.amount,
        };
        0x2::event::emit<AdminMinerAdded>(v1);
    }

    public entry fun admin_withdraw_vault<T0>(arg0: &MinerConfig, arg1: &OwnerCap, arg2: &mut PayoutVault<T0>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert_vault<T0>(arg0, arg2);
        assert!(arg3 > 0, 20);
        assert!(arg4 != @0x0, 9);
        assert!(0x2::balance::value<T0>(&arg2.balance) >= arg3, 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, arg3, arg5), arg4);
        let v0 = VaultWithdrawn{
            vault_id  : 0x2::object::id<PayoutVault<T0>>(arg2),
            admin     : 0x2::tx_context::sender(arg5),
            recipient : arg4,
            amount    : arg3,
        };
        0x2::event::emit<VaultWithdrawn>(v0);
    }

    fun assert_owner(arg0: &MinerConfig, arg1: &OwnerCap) {
        assert!(0x2::object::id<MinerConfig>(arg0) == arg1.config_id, 4);
    }

    fun assert_registry(arg0: &MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry) {
        assert!(arg0.registry_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry>(arg1)), 22);
    }

    fun assert_vault<T0>(arg0: &MinerConfig, arg1: &PayoutVault<T0>) {
        assert!(arg0.vault_id == 0x1::option::some<0x2::object::ID>(0x2::object::id<PayoutVault<T0>>(arg1)), 21);
    }

    fun calculate_release(arg0: &Order, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = arg0.total_quota - arg0.released_quota;
        let v1 = (arg0.tier_amount as u128);
        let v2 = (100000 as u128);
        let v3 = v1 * (arg1 as u128) / v2;
        let v4 = 0;
        let v5 = 0;
        while (v5 < arg3 && v4 < v0) {
            let v6 = v1 * (3 as u128) * ((arg0.claim_seq - 1 + v5) as u128) / v2;
            if (v6 >= v3) {
                break
            };
            let v7 = ((v3 - v6) as u64);
            let v8 = v0 - v4;
            let v9 = if (v7 < v8) {
                v7
            } else {
                v8
            };
            v4 = v4 + v9;
            v5 = v5 + 1;
        };
        let v10 = v0 - v4;
        let v11 = 0;
        let v12 = 0;
        while (v12 < arg3 && v11 < v10) {
            let v13 = ((((arg2 - v11) as u128) * (arg1 as u128) / v2) as u64);
            if (v13 == 0) {
                break
            };
            let v14 = v10 - v11;
            let v15 = if (v13 < v14) {
                v13
            } else {
                v14
            };
            v11 = v11 + v15;
            v12 = v12 + 1;
        };
        (v4, v11)
    }

    public entry fun claim(arg0: &mut MinerConfig, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        claim_internal(arg0, 0x2::clock::timestamp_ms(arg1), arg2);
    }

    public fun claim_info(arg0: &MinerConfig, arg1: address, arg2: u64) : (bool, bool, u64, u64) {
        if (!0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            return (false, false, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
        if (!v0.active || is_blacklisted_internal(arg0, arg1)) {
            return (true, false, 0, 0)
        };
        let v1 = pending_periods(v0, arg2);
        if (v1 == 0) {
            return (true, false, 0, 0)
        };
        let v2 = get_tier_by_index(arg0, v0.tier_index);
        let v3 = if (0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1).dynamic_balance
        } else {
            0
        };
        let (v4, v5) = calculate_release(v0, v2.daily_rate, v3, v1);
        (true, true, v4, v5)
    }

    fun claim_internal(arg0: &mut MinerConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!is_blacklisted_internal(arg0, v0), 3);
        assert!(0x2::table::contains<address, Order>(&arg0.orders, v0), 11);
        let v1 = 0x2::table::borrow<address, Order>(&arg0.orders, v0);
        assert!(v1.active, 12);
        let v2 = pending_periods(v1, arg1);
        assert!(v2 > 0, 5);
        let v3 = get_tier_by_index(arg0, v1.tier_index);
        let v4 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, v0);
        let (v5, v6) = calculate_release(v1, v3.daily_rate, v4.dynamic_balance, v2);
        v4.claimable = v4.claimable + v5 + v6;
        v4.dynamic_balance = v4.dynamic_balance - v6;
        let v7 = 0x2::table::borrow_mut<address, Order>(&mut arg0.orders, v0);
        v7.released_quota = v7.released_quota + v5 + v6;
        v7.last_claim_at = v7.last_claim_at + v2 * 86400000;
        v7.claim_seq = v7.claim_seq + v2;
        v7.active = v7.released_quota < v7.total_quota;
        let v8 = Claimed{
            user            : v0,
            static_amount   : v5,
            dynamic_amount  : v6,
            remaining_quota : v7.total_quota - v7.released_quota,
            order_active    : v7.active,
        };
        0x2::event::emit<Claimed>(v8);
    }

    fun compute_level(arg0: &MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg2: address) : u8 {
        let v0 = get_level_rules(arg0);
        let v1 = 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::get_direct_referrals(arg1, arg2);
        let v2 = 0x1::vector::length<LevelRule>(&v0);
        while (v2 > 0) {
            v2 = v2 - 1;
            let v3 = 0x1::vector::borrow<LevelRule>(&v0, v2);
            let v4 = 0;
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&v1)) {
                if (get_level(arg0, *0x1::vector::borrow<address>(&v1, v5)) >= v3.direct_level) {
                    v4 = v4 + 1;
                };
                v5 = v5 + 1;
            };
            let v6 = if (personal_performance(arg0, arg2) >= v3.personal) {
                if (get_downline(arg0, arg2) >= v3.downline) {
                    if (get_small_area(arg0, arg1, arg2) >= v3.small_area) {
                        v4 >= v3.direct_count
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                return v3.level
            };
        };
        0
    }

    fun create_order_and_settle(arg0: &mut MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg2: address, arg3: u64, arg4: Tier, arg5: u64) {
        assert!(!is_blacklisted_internal(arg0, arg2), 3);
        assert!(!has_active_order(arg0, arg2), 0);
        assert!(arg4.enabled, 1);
        let v0 = arg4.amount;
        if (0x2::table::contains<address, Order>(&arg0.orders, arg2)) {
            let Order {
                owner          : _,
                tier_index     : _,
                tier_amount    : _,
                multiple       : _,
                total_quota    : _,
                released_quota : _,
                invested_at    : _,
                last_claim_at  : _,
                claim_seq      : _,
                active         : _,
            } = 0x2::table::remove<address, Order>(&mut arg0.orders, arg2);
        };
        let v11 = Order{
            owner          : arg2,
            tier_index     : arg3,
            tier_amount    : v0,
            multiple       : arg4.multiple,
            total_quota    : (((v0 as u128) * (arg4.multiple as u128) / (10 as u128)) as u64),
            released_quota : 0,
            invested_at    : arg5,
            last_claim_at  : arg5,
            claim_seq      : 1,
            active         : true,
        };
        0x2::table::add<address, Order>(&mut arg0.orders, arg2, v11);
        upsert_account(arg0, arg2);
        let v12 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, arg2);
        v12.total_invested = v12.total_invested + v0;
        settle_dynamic(arg0, arg1, arg2, v0);
    }

    fun default_level_rules() : vector<LevelRule> {
        let v0 = LevelRule{
            level        : 1,
            personal     : 1000000000,
            downline     : 5000000000,
            small_area   : 0,
            direct_count : 0,
            direct_level : 0,
            team_rate    : 5000,
            peer_rate    : 0,
        };
        let v1 = LevelRule{
            level        : 2,
            personal     : 1000000000,
            downline     : 20000000000,
            small_area   : 0,
            direct_count : 0,
            direct_level : 0,
            team_rate    : 10000,
            peer_rate    : 0,
        };
        let v2 = LevelRule{
            level        : 3,
            personal     : 5000000000,
            downline     : 50000000000,
            small_area   : 35000000000,
            direct_count : 2,
            direct_level : 2,
            team_rate    : 15000,
            peer_rate    : 1000,
        };
        let v3 = LevelRule{
            level        : 4,
            personal     : 5000000000,
            downline     : 120000000000,
            small_area   : 80000000000,
            direct_count : 2,
            direct_level : 3,
            team_rate    : 20000,
            peer_rate    : 1000,
        };
        let v4 = LevelRule{
            level        : 5,
            personal     : 10000000000,
            downline     : 260000000000,
            small_area   : 180000000000,
            direct_count : 3,
            direct_level : 4,
            team_rate    : 25000,
            peer_rate    : 1000,
        };
        let v5 = LevelRule{
            level        : 6,
            personal     : 10000000000,
            downline     : 1100000000000,
            small_area   : 700000000000,
            direct_count : 3,
            direct_level : 5,
            team_rate    : 30000,
            peer_rate    : 1000,
        };
        let v6 = LevelRule{
            level        : 7,
            personal     : 50000000000,
            downline     : 5000000000000,
            small_area   : 3500000000000,
            direct_count : 3,
            direct_level : 6,
            team_rate    : 35000,
            peer_rate    : 1000,
        };
        let v7 = LevelRule{
            level        : 8,
            personal     : 50000000000,
            downline     : 20000000000000,
            small_area   : 15000000000000,
            direct_count : 4,
            direct_level : 7,
            team_rate    : 40000,
            peer_rate    : 1000,
        };
        let v8 = LevelRule{
            level        : 9,
            personal     : 50000000000,
            downline     : 90000000000000,
            small_area   : 60000000000000,
            direct_count : 4,
            direct_level : 8,
            team_rate    : 45000,
            peer_rate    : 1000,
        };
        let v9 = 0x1::vector::empty<LevelRule>();
        let v10 = &mut v9;
        0x1::vector::push_back<LevelRule>(v10, v0);
        0x1::vector::push_back<LevelRule>(v10, v1);
        0x1::vector::push_back<LevelRule>(v10, v2);
        0x1::vector::push_back<LevelRule>(v10, v3);
        0x1::vector::push_back<LevelRule>(v10, v4);
        0x1::vector::push_back<LevelRule>(v10, v5);
        0x1::vector::push_back<LevelRule>(v10, v6);
        0x1::vector::push_back<LevelRule>(v10, v7);
        0x1::vector::push_back<LevelRule>(v10, v8);
        v9
    }

    fun default_tiers() : vector<Tier> {
        let v0 = Tier{
            amount     : 100000000,
            multiple   : 20,
            daily_rate : 800,
            enabled    : false,
        };
        let v1 = Tier{
            amount     : 500000000,
            multiple   : 25,
            daily_rate : 800,
            enabled    : false,
        };
        let v2 = Tier{
            amount     : 1000000000,
            multiple   : 30,
            daily_rate : 800,
            enabled    : false,
        };
        let v3 = Tier{
            amount     : 3000000000,
            multiple   : 35,
            daily_rate : 900,
            enabled    : false,
        };
        let v4 = Tier{
            amount     : 5000000000,
            multiple   : 40,
            daily_rate : 900,
            enabled    : false,
        };
        let v5 = Tier{
            amount     : 10000000000,
            multiple   : 45,
            daily_rate : 900,
            enabled    : false,
        };
        let v6 = Tier{
            amount     : 50000000000,
            multiple   : 50,
            daily_rate : 1000,
            enabled    : false,
        };
        let v7 = Tier{
            amount     : 100000000000,
            multiple   : 55,
            daily_rate : 1000,
            enabled    : false,
        };
        let v8 = Tier{
            amount     : 1000000000000,
            multiple   : 60,
            daily_rate : 1000,
            enabled    : false,
        };
        let v9 = 0x1::vector::empty<Tier>();
        let v10 = &mut v9;
        0x1::vector::push_back<Tier>(v10, v0);
        0x1::vector::push_back<Tier>(v10, v1);
        0x1::vector::push_back<Tier>(v10, v2);
        0x1::vector::push_back<Tier>(v10, v3);
        0x1::vector::push_back<Tier>(v10, v4);
        0x1::vector::push_back<Tier>(v10, v5);
        0x1::vector::push_back<Tier>(v10, v6);
        0x1::vector::push_back<Tier>(v10, v7);
        0x1::vector::push_back<Tier>(v10, v8);
        v9
    }

    public fun fork_build_version() : u64 {
        3
    }

    public entry fun fund_vault<T0>(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: &mut PayoutVault<T0>, arg3: 0x2::coin::Coin<T0>) {
        assert_owner(arg0, arg1);
        assert_vault<T0>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg2.balance, 0x2::coin::into_balance<T0>(arg3));
        let v0 = VaultFunded{amount: 0x2::coin::value<T0>(&arg3)};
        0x2::event::emit<VaultFunded>(v0);
    }

    public fun get_account(arg0: &MinerConfig, arg1: address) : (bool, u64, u64, u8, u64, u64) {
        if (0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            let v6 = 0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1);
            (true, v6.claimable, v6.dynamic_balance, v6.level, v6.total_invested, v6.downline_performance)
        } else {
            (false, 0, 0, 0, 0, 0)
        }
    }

    public fun get_blacklist(arg0: &MinerConfig) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.blacklist)) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg0.blacklist, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_bound_objects(arg0: &MinerConfig) : (0x1::option::Option<0x2::object::ID>, 0x1::option::Option<0x2::object::ID>) {
        (arg0.registry_id, arg0.vault_id)
    }

    public fun get_config(arg0: &MinerConfig) : (address, address, address, address, u64, bool, 0x1::option::Option<0x2::object::ID>) {
        (arg0.receive_address, arg0.ecosystem_address, arg0.fee_tech, arg0.fee_market, arg0.min_withdraw, arg0.vault_initialized, arg0.pool_id)
    }

    public fun get_direct_performance(arg0: &MinerConfig, arg1: address) : u64 {
        let v0 = DirectPerfKey{owner: arg1};
        if (0x2::dynamic_field::exists<DirectPerfKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<DirectPerfKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun get_downline(arg0: &MinerConfig, arg1: address) : u64 {
        if (0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1).downline_performance
        } else {
            0
        }
    }

    fun get_level(arg0: &MinerConfig, arg1: address) : u8 {
        if (0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1).level
        } else {
            0
        }
    }

    public fun get_level_rules(arg0: &MinerConfig) : vector<LevelRule> {
        let v0 = LevelRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LevelRulesKey>(&arg0.id, v0)) {
            let v2 = LevelRulesKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LevelRulesKey, vector<LevelRule>>(&arg0.id, v2)
        } else {
            default_level_rules()
        }
    }

    public fun get_order(arg0: &MinerConfig, arg1: address) : (bool, u64, u64, u64, u64, u64, u64, u64, bool, u64) {
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9) = if (0x2::table::contains<address, Order>(&arg0.orders, arg1)) {
            let v10 = 0x2::table::borrow<address, Order>(&arg0.orders, arg1);
            (true, v10.tier_index, v10.tier_amount, v10.multiple, v10.total_quota, v10.released_quota, v10.invested_at, v10.last_claim_at, v10.claim_seq, v10.active)
        } else {
            (false, 0, 0, 0, 0, 0, 0, 0, 0, false)
        };
        (v0, v2, v3, v4, v5, v6, v7, v8, v9, v1)
    }

    public fun get_small_area(arg0: &MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg2: address) : u64 {
        let v0 = 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::get_direct_referrals(arg1, arg2);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v0)) {
            let v4 = *0x1::vector::borrow<address>(&v0, v3);
            let v5 = (personal_performance(arg0, v4) as u128) + (get_downline(arg0, v4) as u128);
            if (v5 > v1) {
                v2 = v5;
            };
            v3 = v3 + 1;
        };
        let v6 = (get_downline(arg0, arg2) as u128);
        if (v2 >= v6) {
            0
        } else {
            ((v6 - v2) as u64)
        }
    }

    fun get_tier_by_index(arg0: &MinerConfig, arg1: u64) : Tier {
        assert!(arg1 < 9 && arg1 < 0x1::vector::length<Tier>(&arg0.tiers), 2);
        *0x1::vector::borrow<Tier>(&arg0.tiers, arg1)
    }

    public fun get_tiers(arg0: &MinerConfig) : vector<Tier> {
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Tier>(&arg0.tiers)) {
            0x1::vector::push_back<Tier>(&mut v0, *0x1::vector::borrow<Tier>(&arg0.tiers, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun has_active_order(arg0: &MinerConfig, arg1: address) : bool {
        0x2::table::contains<address, Order>(&arg0.orders, arg1) && 0x2::table::borrow<address, Order>(&arg0.orders, arg1).active
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MinerConfig{
            id                : 0x2::object::new(arg0),
            receive_address   : v0,
            ecosystem_address : v0,
            fee_tech          : v0,
            fee_market        : v0,
            partners          : vector[],
            genesis_nodes     : vector[],
            blacklist         : vector[],
            min_withdraw      : 0,
            pool_id           : 0x1::option::some<0x2::object::ID>(0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::momentum::pool_id()),
            tiers             : default_tiers(),
            orders            : 0x2::table::new<address, Order>(arg0),
            accounts          : 0x2::table::new<address, UserAccount>(arg0),
            vault_initialized : false,
            vault_id          : 0x1::option::none<0x2::object::ID>(),
            registry_id       : 0x1::option::none<0x2::object::ID>(),
        };
        let v2 = OwnerCap{
            id        : 0x2::object::new(arg0),
            config_id : 0x2::object::id<MinerConfig>(&v1),
        };
        0x2::transfer::share_object<MinerConfig>(v1);
        0x2::transfer::transfer<OwnerCap>(v2, v0);
    }

    public entry fun initialize_registry(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry) {
        assert_owner(arg0, arg1);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.registry_id), 23);
        arg0.registry_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry>(arg2));
    }

    public entry fun initialize_vault<T0>(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        assert!(!arg0.vault_initialized, 16);
        0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::momentum::assert_native_usdc<T0>();
        let v0 = PayoutVault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        arg0.vault_id = 0x1::option::some<0x2::object::ID>(0x2::object::id<PayoutVault<T0>>(&v0));
        arg0.vault_initialized = true;
        0x2::transfer::share_object<PayoutVault<T0>>(v0);
    }

    public fun is_blacklisted(arg0: &MinerConfig, arg1: address) : bool {
        is_blacklisted_internal(arg0, arg1)
    }

    fun is_blacklisted_internal(arg0: &MinerConfig, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.blacklist, &arg1)
    }

    public entry fun participate<T0>(arg0: &mut MinerConfig, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert_registry(arg0, arg2);
        assert!(!is_blacklisted_internal(arg0, v0), 3);
        assert!(!has_active_order(arg0, v0), 0);
        let v1 = get_tier_by_index(arg0, arg4);
        let v2 = v1.amount;
        assert!(v1.enabled, 1);
        let (v3, v4, v5) = 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::momentum::buy_exact_usdc<T0>(arg1, arg3, arg8, arg5, v2, arg6, arg7, arg9);
        let v6 = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg0.receive_address);
        if (0x2::coin::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        };
        create_order_and_settle(arg0, arg2, v0, arg4, v1, 0x2::clock::timestamp_ms(arg8));
        let v7 = Participated{
            tier_index  : arg4,
            user        : v0,
            tier_amount : v2,
            multiple    : v1.multiple,
            total_quota : (((v2 as u128) * (v1.multiple as u128) / (10 as u128)) as u64),
            paid_sui    : v5,
        };
        0x2::event::emit<Participated>(v7);
    }

    fun pending_periods(arg0: &Order, arg1: u64) : u64 {
        if (arg1 <= arg0.last_claim_at) {
            0
        } else {
            (arg1 - arg0.last_claim_at) / 86400000
        }
    }

    fun personal_performance(arg0: &MinerConfig, arg1: address) : u64 {
        if (0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            0x2::table::borrow<address, UserAccount>(&arg0.accounts, arg1).total_invested
        } else {
            0
        }
    }

    fun recompute_level(arg0: &mut MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg2: address) {
        let v0 = compute_level(arg0, arg1, arg2);
        let v1 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, arg2);
        if (v0 > v1.level) {
            v1.level = v0;
        };
    }

    public entry fun remove_blacklist(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.blacklist, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.blacklist, v1);
            let v2 = BlacklistRemoved{account: arg2};
            0x2::event::emit<BlacklistRemoved>(v2);
        };
    }

    public entry fun remove_genesis(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.genesis_nodes, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.genesis_nodes, v1);
        };
    }

    public entry fun remove_partner(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address) {
        assert_owner(arg0, arg1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.partners, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.partners, v1);
        };
    }

    fun reward_amount(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (100000 as u128)) as u64)
    }

    public entry fun set_level(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address, arg3: u8) {
        assert_owner(arg0, arg1);
        assert!(arg3 <= 9, 19);
        upsert_account(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, arg2);
        assert!(arg3 >= v0.level, 10);
        v0.level = arg3;
        let v1 = LevelSetByAdmin{
            account : arg2,
            level   : arg3,
        };
        0x2::event::emit<LevelSetByAdmin>(v1);
    }

    public entry fun set_level_rule(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64) {
        assert_owner(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= 9, 19);
        let v0 = if (arg7 < arg2) {
            if (arg8 <= 100000) {
                arg9 <= 100000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 24);
        let v1 = get_level_rules(arg0);
        let v2 = ((arg2 - 1) as u64);
        if (v2 > 0) {
            assert!(arg8 > 0x1::vector::borrow<LevelRule>(&v1, v2 - 1).team_rate, 24);
        } else {
            assert!(arg8 > 0, 24);
        };
        if (arg2 < 9) {
            assert!(arg8 < 0x1::vector::borrow<LevelRule>(&v1, v2 + 1).team_rate, 24);
        };
        let v3 = LevelRule{
            level        : arg2,
            personal     : arg3,
            downline     : arg4,
            small_area   : arg5,
            direct_count : arg6,
            direct_level : arg7,
            team_rate    : arg8,
            peer_rate    : arg9,
        };
        *0x1::vector::borrow_mut<LevelRule>(&mut v1, v2) = v3;
        let v4 = LevelRulesKey{dummy_field: false};
        if (0x2::dynamic_field::exists<LevelRulesKey>(&arg0.id, v4)) {
            let v5 = LevelRulesKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<LevelRulesKey, vector<LevelRule>>(&mut arg0.id, v5) = v1;
        } else {
            let v6 = LevelRulesKey{dummy_field: false};
            0x2::dynamic_field::add<LevelRulesKey, vector<LevelRule>>(&mut arg0.id, v6, v1);
        };
        let v7 = LevelRuleUpdated{rule: v3};
        0x2::event::emit<LevelRuleUpdated>(v7);
    }

    public entry fun set_min_withdraw(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: u64) {
        assert_owner(arg0, arg1);
        arg0.min_withdraw = arg2;
    }

    public entry fun set_tier(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) {
        assert_owner(arg0, arg1);
        get_tier_by_index(arg0, arg2);
        let v0 = if (arg3 > 0) {
            if (arg4 > 0) {
                arg5 <= 100000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 18);
        let v1 = Tier{
            amount     : arg3,
            multiple   : arg4,
            daily_rate : arg5,
            enabled    : arg6,
        };
        *0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, arg2) = v1;
        let v2 = TierUpdated{
            tier_index : arg2,
            amount     : arg3,
            multiple   : arg4,
            daily_rate : arg5,
            enabled    : arg6,
        };
        0x2::event::emit<TierUpdated>(v2);
    }

    fun settle_dynamic(arg0: &mut MinerConfig, arg1: &0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::ReferralRegistry, arg2: address, arg3: u64) {
        let v0 = vector[];
        let v1 = arg2;
        let v2 = 0;
        while (v2 < 30) {
            let (v3, v4) = 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::referral_registry::get_referrer(arg1, v1);
            if (!v3 || v4 == @0x0) {
                break
            };
            upsert_account(arg0, v4);
            let v5 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, v4);
            v5.downline_performance = v5.downline_performance + arg3;
            if (v2 == 0) {
                let v6 = DirectPerfKey{owner: v4};
                if (0x2::dynamic_field::exists<DirectPerfKey>(&arg0.id, v6)) {
                    let v7 = 0x2::dynamic_field::borrow_mut<DirectPerfKey, u64>(&mut arg0.id, v6);
                    *v7 = *v7 + arg3;
                } else {
                    0x2::dynamic_field::add<DirectPerfKey, u64>(&mut arg0.id, v6, arg3);
                };
            };
            0x1::vector::push_back<address>(&mut v0, v4);
            v1 = v4;
            v2 = v2 + 1;
        };
        recompute_level(arg0, arg1, arg2);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v0)) {
            recompute_level(arg0, arg1, *0x1::vector::borrow<address>(&v0, v8));
            v8 = v8 + 1;
        };
        let v9 = get_level_rules(arg0);
        let v10 = 0;
        let v11 = 0;
        let v12 = 0;
        while (v12 < 0x1::vector::length<address>(&v0)) {
            let v13 = *0x1::vector::borrow<address>(&v0, v12);
            if (v12 == 0) {
                settle_reward(arg0, v13, reward_amount(arg3, 7000), 1);
            };
            if (v12 == 1) {
                settle_reward(arg0, v13, reward_amount(arg3, 5000), 2);
            };
            let v14 = get_level(arg0, v13);
            if (v14 > 0) {
                let v15 = 0x1::vector::borrow<LevelRule>(&v9, ((v14 - 1) as u64));
                let v16 = reward_amount(arg3, v15.team_rate - v10);
                settle_reward(arg0, v13, v16, 3);
                v11 = v11 + v16;
                let v17 = reward_amount(arg3, v15.peer_rate);
                if (v17 > 0) {
                    if (v12 + 1 < 0x1::vector::length<address>(&v0) && get_level(arg0, *0x1::vector::borrow<address>(&v0, v12 + 1)) == v14) {
                        settle_reward(arg0, *0x1::vector::borrow<address>(&v0, v12 + 1), v17, 4);
                    } else {
                        settle_to_ecosystem(arg0, v17, 0);
                    };
                };
                v10 = v15.team_rate;
            };
            v12 = v12 + 1;
        };
        let v18 = reward_amount(arg3, 0x1::vector::borrow<LevelRule>(&v9, ((9 - 1) as u64)).team_rate) - v11;
        if (v18 > 0) {
            settle_to_ecosystem(arg0, v18, 0);
        };
    }

    fun settle_reward(arg0: &mut MinerConfig, arg1: address, arg2: u64, arg3: u8) {
        if (arg2 == 0) {
            return
        };
        if (has_active_order(arg0, arg1) && !is_blacklisted_internal(arg0, arg1)) {
            add_dynamic(arg0, arg1, arg2, arg3);
        } else {
            settle_to_ecosystem(arg0, arg2, 0);
        };
    }

    fun settle_to_ecosystem(arg0: &mut MinerConfig, arg1: u64, arg2: u8) {
        let v0 = arg0.ecosystem_address;
        upsert_account(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, v0);
        v1.claimable = v1.claimable + arg1;
        let v2 = DynamicSettled{
            to     : v0,
            amount : arg1,
            kind   : arg2,
        };
        0x2::event::emit<DynamicSettled>(v2);
    }

    public entry fun toggle_tier(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: u64, arg3: bool) {
        assert_owner(arg0, arg1);
        let v0 = get_tier_by_index(arg0, arg2);
        0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, arg2).enabled = arg3;
        let v1 = TierUpdated{
            tier_index : arg2,
            amount     : v0.amount,
            multiple   : v0.multiple,
            daily_rate : v0.daily_rate,
            enabled    : arg3,
        };
        0x2::event::emit<TierUpdated>(v1);
    }

    public entry fun update_addresses(arg0: &mut MinerConfig, arg1: &OwnerCap, arg2: address, arg3: address, arg4: address, arg5: address) {
        assert_owner(arg0, arg1);
        assert!(arg2 != @0x0, 9);
        assert!(arg3 != @0x0, 9);
        assert!(arg4 != @0x0, 9);
        assert!(arg5 != @0x0, 9);
        arg0.receive_address = arg2;
        arg0.ecosystem_address = arg3;
        arg0.fee_tech = arg4;
        arg0.fee_market = arg5;
        let v0 = AddressUpdated{
            receive_address   : arg2,
            ecosystem_address : arg3,
            fee_tech          : arg4,
            fee_market        : arg5,
        };
        0x2::event::emit<AddressUpdated>(v0);
    }

    fun upsert_account(arg0: &mut MinerConfig, arg1: address) {
        if (!0x2::table::contains<address, UserAccount>(&arg0.accounts, arg1)) {
            let v0 = UserAccount{
                owner                : arg1,
                claimable            : 0,
                dynamic_balance      : 0,
                level                : 0,
                total_invested       : 0,
                downline_performance : 0,
            };
            0x2::table::add<address, UserAccount>(&mut arg0.accounts, arg1, v0);
        };
    }

    public entry fun withdraw<T0>(arg0: &mut MinerConfig, arg1: &mut PayoutVault<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_vault<T0>(arg0, arg1);
        assert!(arg4 > 0, 20);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!is_blacklisted_internal(arg0, v0), 3);
        assert!(arg4 >= arg0.min_withdraw, 6);
        assert!(0x2::table::contains<address, UserAccount>(&arg0.accounts, v0), 13);
        let v1 = 0x2::table::borrow_mut<address, UserAccount>(&mut arg0.accounts, v0);
        assert!(v1.claimable >= arg4, 7);
        v1.claimable = v1.claimable - arg4;
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg4, 8);
        let v2 = 0x76aefc8ce3f6d0767fd1c2abbcac651ca5955488ade3ff59bd8aa223828b185c::momentum::sell_exact_usdc<T0>(arg2, arg3, arg7, 0x2::coin::take<T0>(&mut arg1.balance, arg4, arg8), arg5, arg6, arg8);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * 2 / 100;
        let v5 = v3 * 3 / 100;
        let v6 = 0x1::vector::length<address>(&arg0.partners) + 0x1::vector::length<address>(&arg0.genesis_nodes);
        let v7 = 0;
        let v8 = 0;
        if (v6 > 0) {
            let v9 = (v3 / 10 - v4 - v5) / v6;
            let v10 = 0;
            while (v10 < 0x1::vector::length<address>(&arg0.partners)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v9, arg8), *0x1::vector::borrow<address>(&arg0.partners, v10));
                v8 = v8 + v9;
                v10 = v10 + 1;
            };
            let v11 = 0;
            while (v11 < 0x1::vector::length<address>(&arg0.genesis_nodes)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v9, arg8), *0x1::vector::borrow<address>(&arg0.genesis_nodes, v11));
                v8 = v8 + v9;
                v11 = v11 + 1;
            };
            v7 = v8;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg8), arg0.fee_tech);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v5, arg8), arg0.fee_market);
        let v12 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        let v13 = Withdrawn{
            user          : v0,
            amount_usdc   : arg4,
            sui_out       : v3,
            fee_tech      : v4,
            fee_market    : v5,
            partner_total : v7,
            user_sui      : v12,
        };
        0x2::event::emit<Withdrawn>(v13);
    }

    // decompiled from Move bytecode v7
}

