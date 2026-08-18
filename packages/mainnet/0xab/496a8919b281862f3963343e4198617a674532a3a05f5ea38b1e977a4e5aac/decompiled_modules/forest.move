module 0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::forest {
    struct Forest has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        public_deposits_enabled: bool,
        redemptions_enabled: bool,
        min_lock_ms: u64,
        max_sap_per_deposit: u64,
        max_sui_per_deposit: u64,
        sap_reserve: 0x2::balance::Balance<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>,
        sui_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        total_root_shares: u64,
        protocol_root_shares: u64,
        user_root_shares: u64,
        total_user_sap_deposited: u64,
        total_user_sui_deposited: u64,
        total_sap_deposited: u64,
        total_sui_deposited: u64,
        total_sap_withdrawn: u64,
        total_sui_withdrawn: u64,
    }

    struct ForestPosition has key {
        id: 0x2::object::UID,
        owner: address,
        root_shares: u64,
        sap_deposited: u64,
        sui_deposited: u64,
        created_ms: u64,
        locked_until_ms: u64,
    }

    struct ForestCreated has copy, drop {
        forest_id: 0x2::object::ID,
        admin: address,
        min_lock_ms: u64,
        public_deposits_enabled: bool,
        redemptions_enabled: bool,
        max_sap_per_deposit: u64,
        max_sui_per_deposit: u64,
    }

    struct ForestSettingsUpdated has copy, drop {
        admin: address,
        paused: bool,
        min_lock_ms: u64,
        public_deposits_enabled: bool,
        redemptions_enabled: bool,
        max_sap_per_deposit: u64,
        max_sui_per_deposit: u64,
    }

    struct ForestAdminUpdated has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct ForestSeeded has copy, drop {
        forest_id: 0x2::object::ID,
        admin: address,
        sap_amount: u64,
        sui_amount: u64,
        root_shares: u64,
    }

    struct ForestDeposited has copy, drop {
        forest_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        sap_amount: u64,
        sui_amount: u64,
        root_shares: u64,
        locked_until_ms: u64,
    }

    struct ForestRedeemed has copy, drop {
        forest_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        owner: address,
        root_shares: u64,
        sap_amount: u64,
        sui_amount: u64,
    }

    struct ForestFunded has copy, drop {
        forest_id: 0x2::object::ID,
        funder: address,
        sap_amount: u64,
        sui_amount: u64,
    }

    fun assert_admin(arg0: &Forest, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 9);
    }

    fun assert_deposit_caps(arg0: &Forest, arg1: u64, arg2: u64) {
        assert!(cap_allows(arg1, arg0.max_sap_per_deposit), 11);
        assert!(cap_allows(arg2, arg0.max_sui_per_deposit), 11);
    }

    fun assert_min_root_shares(arg0: u64, arg1: u64) {
        assert!(arg0 >= arg1, 12);
    }

    fun cap_allows(arg0: u64, arg1: u64) : bool {
        arg1 == 0 || arg0 <= arg1
    }

    entry fun create_forest(arg0: &0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::AdminCap, arg1: u64, arg2: bool, arg3: bool, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = Forest{
            id                       : 0x2::object::new(arg6),
            admin                    : v0,
            paused                   : false,
            public_deposits_enabled  : arg2,
            redemptions_enabled      : arg3,
            min_lock_ms              : arg1,
            max_sap_per_deposit      : arg4,
            max_sui_per_deposit      : arg5,
            sap_reserve              : 0x2::balance::zero<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(),
            sui_reserve              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_root_shares        : 0,
            protocol_root_shares     : 0,
            user_root_shares         : 0,
            total_user_sap_deposited : 0,
            total_user_sui_deposited : 0,
            total_sap_deposited      : 0,
            total_sui_deposited      : 0,
            total_sap_withdrawn      : 0,
            total_sui_withdrawn      : 0,
        };
        let v2 = ForestCreated{
            forest_id               : 0x2::object::id<Forest>(&v1),
            admin                   : v0,
            min_lock_ms             : arg1,
            public_deposits_enabled : arg2,
            redemptions_enabled     : arg3,
            max_sap_per_deposit     : arg4,
            max_sui_per_deposit     : arg5,
        };
        0x2::event::emit<ForestCreated>(v2);
        0x2::transfer::share_object<Forest>(v1);
    }

    entry fun deposit(arg0: &mut Forest, arg1: 0x2::coin::Coin<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.public_deposits_enabled, 10);
        assert!(is_seeded(arg0), 4);
        assert!(arg4 >= arg0.min_lock_ms, 2);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg1);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert_deposit_caps(arg0, v1, v2);
        let v3 = root_shares_for_deposit(arg0, v1, v2);
        assert_min_root_shares(v3, arg3);
        0x2::balance::join<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&mut arg0.sap_reserve, 0x2::coin::into_balance<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.total_root_shares = arg0.total_root_shares + v3;
        arg0.user_root_shares = arg0.user_root_shares + v3;
        arg0.total_user_sap_deposited = arg0.total_user_sap_deposited + v1;
        arg0.total_user_sui_deposited = arg0.total_user_sui_deposited + v2;
        arg0.total_sap_deposited = arg0.total_sap_deposited + v1;
        arg0.total_sui_deposited = arg0.total_sui_deposited + v2;
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = ForestPosition{
            id              : 0x2::object::new(arg6),
            owner           : v0,
            root_shares     : v3,
            sap_deposited   : v1,
            sui_deposited   : v2,
            created_ms      : v4,
            locked_until_ms : v4 + arg4,
        };
        let v6 = ForestDeposited{
            forest_id       : 0x2::object::id<Forest>(arg0),
            position_id     : 0x2::object::id<ForestPosition>(&v5),
            owner           : v0,
            sap_amount      : v1,
            sui_amount      : v2,
            root_shares     : v3,
            locked_until_ms : v4 + arg4,
        };
        0x2::event::emit<ForestDeposited>(v6);
        0x2::transfer::transfer<ForestPosition>(v5, v0);
    }

    entry fun fund_sap_reserve(arg0: &mut Forest, arg1: 0x2::coin::Coin<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&mut arg0.sap_reserve, 0x2::coin::into_balance<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(arg1));
        let v1 = ForestFunded{
            forest_id  : 0x2::object::id<Forest>(arg0),
            funder     : 0x2::tx_context::sender(arg2),
            sap_amount : v0,
            sui_amount : 0,
        };
        0x2::event::emit<ForestFunded>(v1);
    }

    entry fun fund_sui_reserve(arg0: &mut Forest, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = ForestFunded{
            forest_id  : 0x2::object::id<Forest>(arg0),
            funder     : 0x2::tx_context::sender(arg2),
            sap_amount : 0,
            sui_amount : v0,
        };
        0x2::event::emit<ForestFunded>(v1);
    }

    fun initial_root_shares(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 > 0 && arg1 > 0, 3);
        min_u64(arg0, arg1)
    }

    public fun is_paused(arg0: &Forest) : bool {
        arg0.paused
    }

    public fun is_seeded(arg0: &Forest) : bool {
        if (arg0.total_root_shares > 0) {
            if (0x2::balance::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg0.sap_reserve) > 0) {
                0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve) > 0
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun max_sap_per_deposit(arg0: &Forest) : u64 {
        arg0.max_sap_per_deposit
    }

    public fun max_sui_per_deposit(arg0: &Forest) : u64 {
        arg0.max_sui_per_deposit
    }

    public fun min_lock_ms(arg0: &Forest) : u64 {
        arg0.min_lock_ms
    }

    fun min_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun position_locked_until_ms(arg0: &ForestPosition) : u64 {
        arg0.locked_until_ms
    }

    public fun position_owner(arg0: &ForestPosition) : address {
        arg0.owner
    }

    public fun position_root_shares(arg0: &ForestPosition) : u64 {
        arg0.root_shares
    }

    fun proportional_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0 && arg1 > 0, 3);
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun protocol_root_shares(arg0: &Forest) : u64 {
        arg0.protocol_root_shares
    }

    public fun public_deposits_enabled(arg0: &Forest) : bool {
        arg0.public_deposits_enabled
    }

    public fun quote_deposit(arg0: &Forest, arg1: u64, arg2: u64) : u64 {
        assert!(is_seeded(arg0), 4);
        root_shares_for_deposit(arg0, arg1, arg2)
    }

    public fun quote_position_redemption(arg0: &Forest, arg1: &ForestPosition) : (u64, u64) {
        (proportional_amount(0x2::balance::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg0.sap_reserve), arg1.root_shares, arg0.total_root_shares), proportional_amount(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg1.root_shares, arg0.total_root_shares))
    }

    entry fun redeem(arg0: &mut Forest, arg1: ForestPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        assert!(arg0.redemptions_enabled, 5);
        let ForestPosition {
            id              : v0,
            owner           : v1,
            root_shares     : v2,
            sap_deposited   : _,
            sui_deposited   : _,
            created_ms      : _,
            locked_until_ms : v6,
        } = arg1;
        let v7 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg3), 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= v6, 7);
        let v8 = proportional_amount(0x2::balance::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg0.sap_reserve), v2, arg0.total_root_shares);
        let v9 = proportional_amount(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), v2, arg0.total_root_shares);
        assert!(v8 > 0 && v9 > 0, 8);
        0x2::object::delete(v7);
        arg0.total_root_shares = arg0.total_root_shares - v2;
        arg0.user_root_shares = arg0.user_root_shares - v2;
        arg0.total_sap_withdrawn = arg0.total_sap_withdrawn + v8;
        arg0.total_sui_withdrawn = arg0.total_sui_withdrawn + v9;
        let v10 = ForestRedeemed{
            forest_id   : 0x2::object::id<Forest>(arg0),
            position_id : 0x2::object::uid_to_inner(&v7),
            owner       : v1,
            root_shares : v2,
            sap_amount  : v8,
            sui_amount  : v9,
        };
        0x2::event::emit<ForestRedeemed>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>>(0x2::coin::from_balance<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(0x2::balance::split<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&mut arg0.sap_reserve, v8), arg3), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_reserve, v9), arg3), v1);
    }

    public fun redemptions_enabled(arg0: &Forest) : bool {
        arg0.redemptions_enabled
    }

    fun root_shares_for_deposit(arg0: &Forest, arg1: u64, arg2: u64) : u64 {
        if (arg0.total_root_shares == 0) {
            return initial_root_shares(arg1, arg2)
        };
        root_shares_from_values(arg0.total_root_shares, 0x2::balance::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg0.sap_reserve), 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve), arg1, arg2)
    }

    fun root_shares_from_values(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg0 > 0) {
            if (arg1 > 0) {
                arg2 > 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
        assert!(arg3 > 0 && arg4 > 0, 3);
        let v1 = min_u64((((arg3 as u128) * (arg0 as u128) / (arg1 as u128)) as u64), (((arg4 as u128) * (arg0 as u128) / (arg2 as u128)) as u64));
        assert!(v1 > 0, 3);
        v1
    }

    public fun sap_reserve(arg0: &Forest) : u64 {
        0x2::balance::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg0.sap_reserve)
    }

    entry fun seed_protocol_liquidity(arg0: &0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::AdminCap, arg1: &mut Forest, arg2: 0x2::coin::Coin<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg4);
        assert!(!arg1.paused, 1);
        let v0 = 0x2::coin::value<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = root_shares_for_deposit(arg1, v0, v1);
        0x2::balance::join<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(&mut arg1.sap_reserve, 0x2::coin::into_balance<0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::SAP>(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui_reserve, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        arg1.total_root_shares = arg1.total_root_shares + v2;
        arg1.protocol_root_shares = arg1.protocol_root_shares + v2;
        arg1.total_sap_deposited = arg1.total_sap_deposited + v0;
        arg1.total_sui_deposited = arg1.total_sui_deposited + v1;
        let v3 = ForestSeeded{
            forest_id   : 0x2::object::id<Forest>(arg1),
            admin       : 0x2::tx_context::sender(arg4),
            sap_amount  : v0,
            sui_amount  : v1,
            root_shares : v2,
        };
        0x2::event::emit<ForestSeeded>(v3);
    }

    public fun sui_reserve(arg0: &Forest) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_reserve)
    }

    public fun total_root_shares(arg0: &Forest) : u64 {
        arg0.total_root_shares
    }

    public fun total_sap_deposited(arg0: &Forest) : u64 {
        arg0.total_sap_deposited
    }

    public fun total_sap_withdrawn(arg0: &Forest) : u64 {
        arg0.total_sap_withdrawn
    }

    public fun total_sui_deposited(arg0: &Forest) : u64 {
        arg0.total_sui_deposited
    }

    public fun total_sui_withdrawn(arg0: &Forest) : u64 {
        arg0.total_sui_withdrawn
    }

    public fun total_user_sap_deposited(arg0: &Forest) : u64 {
        arg0.total_user_sap_deposited
    }

    public fun total_user_sui_deposited(arg0: &Forest) : u64 {
        arg0.total_user_sui_deposited
    }

    entry fun update_forest_admin(arg0: &0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::AdminCap, arg1: &mut Forest, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg3);
        assert!(arg2 != @0x0, 9);
        arg1.admin = arg2;
        let v0 = ForestAdminUpdated{
            old_admin : arg1.admin,
            new_admin : arg2,
        };
        0x2::event::emit<ForestAdminUpdated>(v0);
    }

    entry fun update_forest_settings(arg0: &0x60b2d436499019ffa0a9e029d488851bcc82dd745f9ff85c502f8be75145934b::sap::AdminCap, arg1: &mut Forest, arg2: bool, arg3: u64, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        assert_admin(arg1, arg8);
        assert!(arg3 > 0, 2);
        arg1.paused = arg2;
        arg1.min_lock_ms = arg3;
        arg1.public_deposits_enabled = arg4;
        arg1.redemptions_enabled = arg5;
        arg1.max_sap_per_deposit = arg6;
        arg1.max_sui_per_deposit = arg7;
        let v0 = ForestSettingsUpdated{
            admin                   : 0x2::tx_context::sender(arg8),
            paused                  : arg2,
            min_lock_ms             : arg3,
            public_deposits_enabled : arg4,
            redemptions_enabled     : arg5,
            max_sap_per_deposit     : arg6,
            max_sui_per_deposit     : arg7,
        };
        0x2::event::emit<ForestSettingsUpdated>(v0);
    }

    public fun user_root_shares(arg0: &Forest) : u64 {
        arg0.user_root_shares
    }

    // decompiled from Move bytecode v7
}

