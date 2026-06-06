module 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        creator: address,
        name: 0x1::string::String,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        mock_dex_balance: 0x2::balance::Balance<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>,
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
        is_sui: bool,
        shares_minted: u64,
    }

    struct Ragequit has copy, drop {
        vault_id: 0x2::object::ID,
        lp: address,
        shares_burned: u64,
        sui_returned: u64,
        mock_dex_returned: u64,
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

    public fun anchor_log(arg0: &mut Vault, arg1: &0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: u64, arg3: vector<u8>) {
        assert!(0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::vault_id(arg1) == 0x2::object::id<Vault>(arg0), 2);
        assert!(!0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::revoked(arg1), 1);
        if (0x2::table::contains<u64, vector<u8>>(&arg0.walrus_log_roots, arg2)) {
            0x2::table::remove<u64, vector<u8>>(&mut arg0.walrus_log_roots, arg2);
        };
        0x2::table::add<u64, vector<u8>>(&mut arg0.walrus_log_roots, arg2, arg3);
        let v0 = LogAnchored{
            vault_id : 0x2::object::id<Vault>(arg0),
            agent    : 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::agent(arg1),
            epoch    : arg2,
            blob_id  : arg3,
        };
        0x2::event::emit<LogAnchored>(v0);
    }

    public fun anchor_lp_agreement(arg0: &mut Vault, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, vector<u8>>(&arg0.lp_agreements, v0)) {
            0x2::table::remove<address, vector<u8>>(&mut arg0.lp_agreements, v0);
        };
        0x2::table::add<address, vector<u8>>(&mut arg0.lp_agreements, v0, arg1);
        let v1 = LPAgreementAnchored{
            vault_id : 0x2::object::id<Vault>(arg0),
            lp       : v0,
            blob_id  : arg1,
        };
        0x2::event::emit<LPAgreementAnchored>(v1);
    }

    public(friend) fun borrow_MOCK_DEX(arg0: &mut Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX> {
        assert!(!arg0.paused, 1);
        assert!(0x2::balance::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&arg0.mock_dex_balance) >= arg2, 5);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::verify_and_update_limits(arg1, 0x2::object::id<Vault>(arg0), arg2 * 500, arg3);
        0x2::coin::from_balance<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(0x2::balance::split<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&mut arg0.mock_dex_balance, arg2), arg3)
    }

    public(friend) fun borrow_sui(arg0: &mut Vault, arg1: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(!arg0.paused, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) >= arg2, 5);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::verify_and_update_limits(arg1, 0x2::object::id<Vault>(arg0), arg2, arg3);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg2), arg3)
    }

    public(friend) fun create_vault(arg0: 0x1::string::String, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : (Vault, CreatorCap) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = Vault{
            id                   : v0,
            creator              : v2,
            name                 : arg0,
            sui_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
            mock_dex_balance     : 0x2::balance::zero<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(),
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

    public fun current_valuation_in_sui(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) + 0x2::balance::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&arg0.mock_dex_balance) * 500
    }

    public fun deposit_MOCK_DEX(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>, arg2: &mut 0x2::tx_context::TxContext) : SyndicateShare {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::object::id<Vault>(arg0);
        let v2 = if (arg0.total_shares == 0) {
            v0 * 500
        } else {
            ((((v0 * 500) as u128) * (arg0.total_shares as u128) / (current_valuation_in_sui(arg0) as u128)) as u64)
        };
        assert!(v2 > 0, 3);
        0x2::balance::join<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&mut arg0.mock_dex_balance, 0x2::coin::into_balance<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v3 = Deposited{
            vault_id      : v1,
            lp            : 0x2::tx_context::sender(arg2),
            amount        : v0,
            is_sui        : false,
            shares_minted : v2,
        };
        0x2::event::emit<Deposited>(v3);
        SyndicateShare{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            shares   : v2,
        }
    }

    public fun deposit_sui(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) : SyndicateShare {
        assert!(!arg0.paused, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 4);
        let v1 = 0x2::object::id<Vault>(arg0);
        let v2 = if (arg0.total_shares == 0) {
            v0
        } else {
            (((v0 as u128) * (arg0.total_shares as u128) / (current_valuation_in_sui(arg0) as u128)) as u64)
        };
        assert!(v2 > 0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_shares = arg0.total_shares + v2;
        let v3 = Deposited{
            vault_id      : v1,
            lp            : 0x2::tx_context::sender(arg2),
            amount        : v0,
            is_sui        : true,
            shares_minted : v2,
        };
        0x2::event::emit<Deposited>(v3);
        SyndicateShare{
            id       : 0x2::object::new(arg2),
            vault_id : v1,
            shares   : v2,
        }
    }

    public fun issue_agent_cap(arg0: &CreatorCap, arg1: &Vault, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 2);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::create_cap(0x2::object::id<Vault>(arg1), arg2, arg3, arg4, arg5)
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

    public fun mock_dex_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&arg0.mock_dex_balance)
    }

    public fun name(arg0: &Vault) : 0x1::string::String {
        arg0.name
    }

    public fun pause(arg0: &CreatorCap, arg1: &mut Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 2);
        arg1.paused = true;
    }

    public fun paused(arg0: &Vault) : bool {
        arg0.paused
    }

    public fun ragequit(arg0: &mut Vault, arg1: SyndicateShare, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>) {
        let v0 = 0x2::object::id<Vault>(arg0);
        let SyndicateShare {
            id       : v1,
            vault_id : v2,
            shares   : v3,
        } = arg1;
        0x2::object::delete(v1);
        assert!(v2 == v0, 2);
        assert!(v3 > 0, 3);
        let v4 = arg0.total_shares;
        let v5 = (((0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance) as u128) * (v3 as u128) / (v4 as u128)) as u64);
        let v6 = (((0x2::balance::value<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&arg0.mock_dex_balance) as u128) * (v3 as u128) / (v4 as u128)) as u64);
        arg0.total_shares = v4 - v3;
        let v7 = Ragequit{
            vault_id          : v0,
            lp                : 0x2::tx_context::sender(arg2),
            shares_burned     : v3,
            sui_returned      : v5,
            mock_dex_returned : v6,
        };
        0x2::event::emit<Ragequit>(v7);
        (0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v5), arg2), 0x2::coin::from_balance<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(0x2::balance::split<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&mut arg0.mock_dex_balance, v6), arg2))
    }

    public(friend) fun return_MOCK_DEX(arg0: &mut Vault, arg1: 0x2::coin::Coin<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>) {
        0x2::balance::join<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(&mut arg0.mock_dex_balance, 0x2::coin::into_balance<0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::mock_dex::MOCK_DEX>(arg1));
    }

    public(friend) fun return_sui(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun revoke_agent_cap(arg0: &CreatorCap, arg1: &Vault, arg2: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 2);
        assert!(0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::vault_id(arg2) == 0x2::object::id<Vault>(arg1), 2);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::set_revoked(arg2, true);
    }

    public fun share_value(arg0: &SyndicateShare) : u64 {
        arg0.shares
    }

    public(friend) fun share_vault(arg0: Vault) {
        0x2::transfer::share_object<Vault>(arg0);
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

    public fun sui_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun total_shares(arg0: &Vault) : u64 {
        arg0.total_shares
    }

    public fun unpause(arg0: &CreatorCap, arg1: &mut Vault) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 2);
        arg1.paused = false;
    }

    public fun update_agent_limits(arg0: &CreatorCap, arg1: &Vault, arg2: &mut 0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::AgentCap, arg3: u64, arg4: u64) {
        assert!(arg0.vault_id == 0x2::object::id<Vault>(arg1), 2);
        assert!(0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::vault_id(arg2) == 0x2::object::id<Vault>(arg1), 2);
        0xe4795695a8baf9508250d2a964842ad19b7afccb3bc8bfabc30c8fe82b38eb10::agent_cap::set_limits(arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

