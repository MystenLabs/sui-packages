module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        total_shares: u64,
        depositor_share_bps: u16,
        protocol_share_bps: u16,
        ops_wallet: address,
        seed_per_side: u64,
        paused: bool,
        total_deposited: u64,
        total_withdrawn: u64,
        total_fees_earned: u64,
        total_seed_cost: u64,
        total_claim_revenue: u64,
        total_refund_revenue: u64,
        markets_seeded: u64,
    }

    struct VaultReceipt has store, key {
        id: 0x2::object::UID,
        shares: u64,
        deposited_amount: u64,
        deposited_at: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        initial_amount: u64,
        ops_wallet: address,
    }

    struct VaultDeposited has copy, drop {
        depositor: address,
        amount: u64,
        shares: u64,
        nav_per_share: u64,
    }

    struct VaultWithdrawn has copy, drop {
        depositor: address,
        shares_burned: u64,
        amount_received: u64,
        nav_per_share: u64,
    }

    struct MarketSeeded has copy, drop {
        market_id: 0x2::object::ID,
        amount_per_side: u64,
        total_amount: u64,
    }

    struct FundsReturned has copy, drop {
        amount: u64,
        is_refund: bool,
    }

    struct TreasuryDistributed has copy, drop {
        vault_amount: u64,
        protocol_amount: u64,
        ops_amount: u64,
    }

    public fun admin_emergency_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.paused, 32);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg2)
    }

    public fun admin_pause<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = true;
    }

    public fun admin_unpause<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = false;
    }

    public fun admin_update_fee_split<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u16, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        assert!((arg2 as u64) + (arg3 as u64) <= 10000, 31);
        arg0.depositor_share_bps = arg2;
        arg0.protocol_share_bps = arg3;
    }

    public fun admin_update_ops_wallet<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.ops_wallet = arg2;
    }

    public fun admin_update_seed<T0>(arg0: &mut Vault<T0>, arg1: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.seed_per_side = arg2;
    }

    fun calc_nav_per_share<T0>(arg0: &Vault<T0>) : u64 {
        if (arg0.total_shares == 0) {
            return 1000000
        };
        (((0x2::balance::value<T0>(&arg0.balance) as u128) * (1000000 as u128) / (arg0.total_shares as u128)) as u64)
    }

    public fun create_and_share<T0>(arg0: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000, 13);
        let v1 = Vault<T0>{
            id                   : 0x2::object::new(arg3),
            balance              : 0x2::coin::into_balance<T0>(arg1),
            total_shares         : v0,
            depositor_share_bps  : 5000,
            protocol_share_bps   : 3000,
            ops_wallet           : arg2,
            seed_per_side        : 1000000,
            paused               : false,
            total_deposited      : v0,
            total_withdrawn      : 0,
            total_fees_earned    : 0,
            total_seed_cost      : 0,
            total_claim_revenue  : 0,
            total_refund_revenue : 0,
            markets_seeded       : 0,
        };
        let v2 = VaultCreated{
            vault_id       : 0x2::object::id<Vault<T0>>(&v1),
            initial_amount : v0,
            ops_wallet     : arg2,
        };
        0x2::event::emit<VaultCreated>(v2);
        let v3 = VaultReceipt{
            id               : 0x2::object::new(arg3),
            shares           : v0,
            deposited_amount : v0,
            deposited_at     : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v1);
        0x2::transfer::public_transfer<VaultReceipt>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 26);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 >= 10000000, 13);
        let v1 = if (arg0.total_shares == 0) {
            v0
        } else {
            let v2 = 0x2::balance::value<T0>(&arg0.balance);
            assert!(v2 > 0, 29);
            (((v0 as u128) * (arg0.total_shares as u128) / (v2 as u128)) as u64)
        };
        assert!(v1 > 0, 30);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v1;
        arg0.total_deposited = arg0.total_deposited + v0;
        let v3 = VaultDeposited{
            depositor     : 0x2::tx_context::sender(arg3),
            amount        : v0,
            shares        : v1,
            nav_per_share : calc_nav_per_share<T0>(arg0),
        };
        0x2::event::emit<VaultDeposited>(v3);
        let v4 = VaultReceipt{
            id               : 0x2::object::new(arg3),
            shares           : v1,
            deposited_amount : v0,
            deposited_at     : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::public_transfer<VaultReceipt>(v4, 0x2::tx_context::sender(arg3));
    }

    public fun depositor_share_bps<T0>(arg0: &Vault<T0>) : u16 {
        arg0.depositor_share_bps
    }

    public fun distribute_treasury<T0>(arg0: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry::MarketRegistry<T0>, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry::treasury_balance<T0>(arg0);
        if (v0 == 0) {
            return
        };
        let v1 = v0 * (arg1.depositor_share_bps as u64) / 10000;
        let v2 = v0 * (arg1.protocol_share_bps as u64) / 10000;
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg1.balance, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry::split_treasury<T0>(arg0, v1));
            arg1.total_fees_earned = arg1.total_fees_earned + v1;
        };
        let v3 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry::treasury_balance<T0>(arg0) - v2;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::registry::split_treasury<T0>(arg0, v3), arg2), arg1.ops_wallet);
        };
        let v4 = TreasuryDistributed{
            vault_amount    : v1,
            protocol_amount : v2,
            ops_amount      : v3,
        };
        0x2::event::emit<TreasuryDistributed>(v4);
    }

    public fun is_paused<T0>(arg0: &Vault<T0>) : bool {
        arg0.paused
    }

    public fun markets_seeded<T0>(arg0: &Vault<T0>) : u64 {
        arg0.markets_seeded
    }

    public fun nav_per_share<T0>(arg0: &Vault<T0>) : u64 {
        calc_nav_per_share<T0>(arg0)
    }

    public fun ops_wallet<T0>(arg0: &Vault<T0>) : address {
        arg0.ops_wallet
    }

    public fun protocol_share_bps<T0>(arg0: &Vault<T0>) : u16 {
        arg0.protocol_share_bps
    }

    public fun receipt_deposited_amount(arg0: &VaultReceipt) : u64 {
        arg0.deposited_amount
    }

    public fun receipt_deposited_at(arg0: &VaultReceipt) : u64 {
        arg0.deposited_at
    }

    public fun receipt_shares(arg0: &VaultReceipt) : u64 {
        arg0.shares
    }

    public fun return_funds<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool, arg3: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (arg2) {
            arg0.total_refund_revenue = arg0.total_refund_revenue + v0;
        } else {
            arg0.total_claim_revenue = arg0.total_claim_revenue + v0;
        };
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = FundsReturned{
            amount    : v0,
            is_refund : arg2,
        };
        0x2::event::emit<FundsReturned>(v1);
    }

    public fun seed_market<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>, arg2: &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::admin::AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 26);
        let v0 = arg0.seed_per_side;
        assert!(v0 > 0, 15);
        let v1 = v0 * 2;
        assert!(0x2::balance::value<T0>(&arg0.balance) >= v1, 27);
        assert!(0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::is_trading_open<T0>(arg1, 0x2::clock::timestamp_ms(arg3)), 11);
        let (_, _) = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_deposit<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, v0), 0, 0x2::tx_context::sender(arg4), 0);
        let (_, _) = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::execute_deposit<T0>(arg1, 0x2::balance::split<T0>(&mut arg0.balance, v0), 1, 0x2::tx_context::sender(arg4), 0);
        arg0.total_seed_cost = arg0.total_seed_cost + v1;
        arg0.markets_seeded = arg0.markets_seeded + 1;
        let v6 = MarketSeeded{
            market_id       : 0x2::object::id<0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market::Market<T0>>(arg1),
            amount_per_side : v0,
            total_amount    : v1,
        };
        0x2::event::emit<MarketSeeded>(v6);
    }

    public fun seed_per_side<T0>(arg0: &Vault<T0>) : u64 {
        arg0.seed_per_side
    }

    public fun total_claim_revenue<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_claim_revenue
    }

    public fun total_deposited<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_deposited
    }

    public fun total_fees_earned<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_fees_earned
    }

    public fun total_refund_revenue<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_refund_revenue
    }

    public fun total_seed_cost<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_seed_cost
    }

    public fun total_shares<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_shares
    }

    public fun total_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun total_withdrawn<T0>(arg0: &Vault<T0>) : u64 {
        arg0.total_withdrawn
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: VaultReceipt, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let VaultReceipt {
            id               : v0,
            shares           : v1,
            deposited_amount : _,
            deposited_at     : v3,
        } = arg1;
        0x2::object::delete(v0);
        if (v3 > 0) {
            assert!(0x2::clock::timestamp_ms(arg2) >= v3 + 86400000, 28);
        };
        let v4 = (((v1 as u128) * (0x2::balance::value<T0>(&arg0.balance) as u128) / (arg0.total_shares as u128)) as u64);
        assert!(v4 > 0, 15);
        arg0.total_shares = arg0.total_shares - v1;
        arg0.total_withdrawn = arg0.total_withdrawn + v4;
        let v5 = VaultWithdrawn{
            depositor       : 0x2::tx_context::sender(arg3),
            shares_burned   : v1,
            amount_received : v4,
            nav_per_share   : calc_nav_per_share<T0>(arg0),
        };
        0x2::event::emit<VaultWithdrawn>(v5);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4), arg3)
    }

    // decompiled from Move bytecode v6
}

