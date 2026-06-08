module 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        total_shares: u64,
        walrus_strategy_blob: vector<u8>,
        walrus_metadata_blob: vector<u8>,
        walrus_log_roots: 0x2::table::Table<u64, vector<u8>>,
        lp_agreements: 0x2::table::Table<address, vector<u8>>,
        paused: bool,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SyndicateShare has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        shares: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        lp: address,
        amount: u64,
        is_asset_a: bool,
        shares_minted: u64,
    }

    struct Ragequit has copy, drop {
        vault_id: 0x2::object::ID,
        lp: address,
        shares_burned: u64,
        amount_a_returned: u64,
        amount_b_returned: u64,
    }

    struct LogAnchored has copy, drop {
        vault_id: 0x2::object::ID,
        agent: address,
        epoch: u64,
        blob_id: vector<u8>,
    }

    struct LPAgreementAnchored has copy, drop {
        vault_id: 0x2::object::ID,
        lp: address,
        blob_id: vector<u8>,
    }

    public fun anchor_log<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg2: u64, arg3: vector<u8>) {
        assert!(0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::vault_id(arg1) == 0x2::object::id<Vault<T0, T1>>(arg0), 2);
        assert!(!0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::revoked(arg1), 1);
        if (0x2::table::contains<u64, vector<u8>>(&arg0.walrus_log_roots, arg2)) {
            0x2::table::remove<u64, vector<u8>>(&mut arg0.walrus_log_roots, arg2);
        };
        0x2::table::add<u64, vector<u8>>(&mut arg0.walrus_log_roots, arg2, arg3);
        let v0 = LogAnchored{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            agent    : 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::agent(arg1),
            epoch    : arg2,
            blob_id  : arg3,
        };
        0x2::event::emit<LogAnchored>(v0);
    }

    public fun anchor_lp_agreement<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, vector<u8>>(&arg0.lp_agreements, v0)) {
            0x2::table::remove<address, vector<u8>>(&mut arg0.lp_agreements, v0);
        };
        0x2::table::add<address, vector<u8>>(&mut arg0.lp_agreements, v0, arg1);
        let v1 = LPAgreementAnchored{
            vault_id : 0x2::object::id<Vault<T0, T1>>(arg0),
            lp       : v0,
            blob_id  : arg1,
        };
        0x2::event::emit<LPAgreementAnchored>(v1);
    }

    public fun balance_a<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_a)
    }

    public fun balance_b<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_b)
    }

    public(friend) fun borrow_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!arg0.paused, 1);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) >= arg2, 5);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::verify_and_update_limits(arg1, 0x2::object::id<Vault<T0, T1>>(arg0), arg2, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, arg2), arg3)
    }

    public(friend) fun borrow_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.paused, 1);
        assert!(0x2::balance::value<T1>(&arg0.balance_b) >= arg2, 5);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::verify_and_update_limits(arg1, 0x2::object::id<Vault<T0, T1>>(arg0), arg2, arg3);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, arg2), arg3)
    }

    public(friend) fun create_vault<T0, T1>(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (Vault<T0, T1>, CreatorCap) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = Vault<T0, T1>{
            id                   : v0,
            creator              : v2,
            name                 : arg0,
            balance_a            : 0x2::balance::zero<T0>(),
            balance_b            : 0x2::balance::zero<T1>(),
            total_shares         : 0,
            walrus_strategy_blob : arg1,
            walrus_metadata_blob : arg2,
            walrus_log_roots     : 0x2::table::new<u64, vector<u8>>(arg3),
            lp_agreements        : 0x2::table::new<address, vector<u8>>(arg3),
            paused               : false,
        };
        let v4 = CreatorCap{
            id       : 0x2::object::new(arg3),
            vault_id : v1,
        };
        let v5 = VaultCreated{
            vault_id : v1,
            creator  : v2,
            name     : arg0,
        };
        0x2::event::emit<VaultCreated>(v5);
        (v3, v4)
    }

    public fun deposit_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : SyndicateShare {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::object::id<Vault<T0, T1>>(arg0);
        let v2 = if (arg0.total_shares == 0) {
            v0
        } else {
            let v3 = 0x2::balance::value<T0>(&arg0.balance_a);
            if (v3 == 0) {
                v0
            } else {
                (((v0 as u128) * (arg0.total_shares as u128) / (v3 as u128)) as u64)
            }
        };
        assert!(v2 > 0, 3);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v4 = Deposited{
            vault_id      : v1,
            lp            : 0x2::tx_context::sender(arg2),
            amount        : v0,
            is_asset_a    : true,
            shares_minted : v2,
        };
        0x2::event::emit<Deposited>(v4);
        SyndicateShare{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            shares   : v2,
        }
    }

    public fun deposit_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : SyndicateShare {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::object::id<Vault<T0, T1>>(arg0);
        let v2 = if (arg0.total_shares == 0) {
            v0
        } else {
            let v3 = 0x2::balance::value<T1>(&arg0.balance_b);
            if (v3 == 0) {
                v0
            } else {
                (((v0 as u128) * (arg0.total_shares as u128) / (v3 as u128)) as u64)
            }
        };
        assert!(v2 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v4 = Deposited{
            vault_id      : v1,
            lp            : 0x2::tx_context::sender(arg2),
            amount        : v0,
            is_asset_a    : false,
            shares_minted : v2,
        };
        0x2::event::emit<Deposited>(v4);
        SyndicateShare{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            shares   : v2,
        }
    }

    public fun issue_agent_cap<T0, T1>(arg0: &CreatorCap, arg1: &Vault<T0, T1>, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::create_cap(0x2::object::id<Vault<T0, T1>>(arg1), arg2, arg3, arg4, arg5)
    }

    public fun join_share(arg0: &mut SyndicateShare, arg1: SyndicateShare) {
        let SyndicateShare {
            id       : v0,
            vault_id : v1,
            shares   : v2,
        } = arg1;
        assert!(arg0.vault_id == v1, 2);
        arg0.shares = arg0.shares + v2;
        0x2::object::delete(v0);
    }

    public fun name<T0, T1>(arg0: &Vault<T0, T1>) : 0x1::string::String {
        arg0.name
    }

    public fun pause<T0, T1>(arg0: &CreatorCap, arg1: &mut Vault<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        arg1.paused = true;
    }

    public fun paused<T0, T1>(arg0: &Vault<T0, T1>) : bool {
        arg0.paused
    }

    public fun ragequit<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: SyndicateShare, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::object::id<Vault<T0, T1>>(arg0);
        let SyndicateShare {
            id       : v1,
            vault_id : v2,
            shares   : v3,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == v0, 2);
        assert!(v3 > 0, 3);
        let v4 = arg0.total_shares;
        let v5 = (((0x2::balance::value<T0>(&arg0.balance_a) as u128) * (v3 as u128) / (v4 as u128)) as u64);
        let v6 = (((0x2::balance::value<T1>(&arg0.balance_b) as u128) * (v3 as u128) / (v4 as u128)) as u64);
        arg0.total_shares = v4 - v3;
        let v7 = Ragequit{
            vault_id          : v0,
            lp                : 0x2::tx_context::sender(arg2),
            shares_burned     : v3,
            amount_a_returned : v5,
            amount_b_returned : v6,
        };
        0x2::event::emit<Ragequit>(v7);
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_a, v5), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_b, v6), arg2))
    }

    public(friend) fun return_a<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun return_b<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun revoke_agent_cap<T0, T1>(arg0: &CreatorCap, arg1: &Vault<T0, T1>, arg2: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        assert!(0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::vault_id(arg2) == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::set_revoked(arg2, true);
    }

    public fun share_value(arg0: &SyndicateShare) : u64 {
        arg0.shares
    }

    public(friend) fun share_vault<T0, T1>(arg0: Vault<T0, T1>) {
        0x2::transfer::share_object<Vault<T0, T1>>(arg0);
    }

    public fun split_share(arg0: &mut SyndicateShare, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SyndicateShare {
        assert!(arg0.shares > arg1, 3);
        arg0.shares = arg0.shares - arg1;
        SyndicateShare{
            id       : 0x2::object::new(arg2),
            vault_id : arg0.vault_id,
            shares   : arg1,
        }
    }

    public fun total_shares<T0, T1>(arg0: &Vault<T0, T1>) : u64 {
        arg0.total_shares
    }

    public fun unpause<T0, T1>(arg0: &CreatorCap, arg1: &mut Vault<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        arg1.paused = false;
    }

    public fun update_agent_limits<T0, T1>(arg0: &CreatorCap, arg1: &Vault<T0, T1>, arg2: &mut 0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::AgentCap, arg3: u64, arg4: u64) {
        assert!(arg0.vault_id == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        assert!(0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::vault_id(arg2) == 0x2::object::id<Vault<T0, T1>>(arg1), 2);
        0xe0c325e1990708cc0e0398a4e3678b4a65b8a3c00cc5da3ab595266f1c5460e9::agent_cap::set_limits(arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

