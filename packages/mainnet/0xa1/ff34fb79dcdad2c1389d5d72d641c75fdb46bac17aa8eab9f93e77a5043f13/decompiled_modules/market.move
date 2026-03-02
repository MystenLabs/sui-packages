module 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        market_number: u64,
        token_symbol: 0x1::string::String,
        pyth_feed_id: vector<u8>,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
        created_at: u64,
        fee_bps: u16,
        initial_liquidity: u64,
        yes_reserves: u64,
        no_reserves: u64,
        k: u128,
        total_shares_minted: u64,
        vault: 0x2::balance::Balance<T0>,
        yes_supply: u64,
        no_supply: u64,
        fees: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>,
        resolved: bool,
        voided: bool,
        outcome: u8,
        payout_per_share: u64,
        resolved_price: u64,
        resolved_at: u64,
        voided_at: u64,
        resolver: address,
        total_volume: u64,
        trade_count: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: 0x1::string::String, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: 0x2::balance::Balance<T0>, arg8: u16, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = 0x2::balance::value<T0>(&arg7);
        let v1 = Market<T0>{
            id                  : 0x2::object::new(arg10),
            market_number       : arg0,
            token_symbol        : arg1,
            pyth_feed_id        : arg2,
            target_price        : arg3,
            duration            : arg4,
            deadline            : arg5,
            trading_cutoff      : arg6,
            created_at          : arg9,
            fee_bps             : arg8,
            initial_liquidity   : v0,
            yes_reserves        : v0,
            no_reserves         : v0,
            k                   : (v0 as u128) * (v0 as u128),
            total_shares_minted : v0,
            vault               : arg7,
            yes_supply          : 0,
            no_supply           : 0,
            fees                : 0x2::balance::zero<T0>(),
            positions           : 0x2::table::new<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(arg10),
            resolved            : false,
            voided              : false,
            outcome             : 0,
            payout_per_share    : 0,
            resolved_price      : 0,
            resolved_at         : 0,
            voided_at           : 0,
            resolver            : @0x0,
            total_volume        : 0,
            trade_count         : 0,
        };
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_market_created(0x2::object::id<Market<T0>>(&v1), arg0, arg1, arg3, arg4, arg5, arg6, v0, arg8);
        v1
    }

    public(friend) fun buy<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 8);
        assert!(!arg0.voided, 10);
        assert!(arg4 < arg0.trading_cutoff, 11);
        assert!(arg2 == 0 || arg2 == 1, 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 15);
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        let v2 = v0 - v1;
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut v3, v1));
        0x2::balance::join<T0>(&mut arg0.vault, v3);
        arg0.total_shares_minted = arg0.total_shares_minted + v2;
        arg0.yes_reserves = arg0.yes_reserves + v2;
        arg0.no_reserves = arg0.no_reserves + v2;
        let v4 = if (arg2 == 0) {
            let v5 = ((arg0.k / (arg0.no_reserves as u128)) as u64);
            let v6 = arg0.yes_reserves - v5;
            arg0.yes_reserves = v5;
            arg0.yes_supply = arg0.yes_supply + v6;
            v6
        } else {
            let v7 = ((arg0.k / (arg0.yes_reserves as u128)) as u64);
            let v8 = arg0.no_reserves - v7;
            arg0.no_reserves = v7;
            arg0.no_supply = arg0.no_supply + v8;
            v8
        };
        assert!(v4 > 0, 15);
        assert!(v4 >= arg3, 17);
        let v9 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, v9)) {
            0x2::table::add<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v9, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::new());
        };
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::credit_shares(0x2::table::borrow_mut<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v9), arg2, v4, v0);
        arg0.total_volume = arg0.total_volume + v0;
        arg0.trade_count = arg0.trade_count + 1;
        let (v10, v11) = prices<T0>(arg0);
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_shares_bought(0x2::object::id<Market<T0>>(arg0), v9, arg2, v0, v4, price_per_unit(v2, v4), v1, v10, v11, arg0.yes_reserves, arg0.no_reserves, 0x2::balance::value<T0>(&arg0.vault), arg0.yes_supply, arg0.no_supply, arg0.total_shares_minted);
    }

    public(friend) fun collect_fees<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.fees);
        if (v0 > 0) {
            0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_fees_collected(0x2::object::id<Market<T0>>(arg0), v0);
        };
        0x2::balance::split<T0>(&mut arg0.fees, v0)
    }

    public(friend) fun created_at<T0>(arg0: &Market<T0>) : u64 {
        arg0.created_at
    }

    public(friend) fun deadline<T0>(arg0: &Market<T0>) : u64 {
        arg0.deadline
    }

    public(friend) fun duration<T0>(arg0: &Market<T0>) : u8 {
        arg0.duration
    }

    public(friend) fun fee_bps<T0>(arg0: &Market<T0>) : u16 {
        arg0.fee_bps
    }

    public(friend) fun fees_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public(friend) fun has_position<T0>(arg0: &Market<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun initial_liquidity<T0>(arg0: &Market<T0>) : u64 {
        arg0.initial_liquidity
    }

    public(friend) fun k<T0>(arg0: &Market<T0>) : u128 {
        arg0.k
    }

    public(friend) fun market_number<T0>(arg0: &Market<T0>) : u64 {
        arg0.market_number
    }

    public(friend) fun no_price<T0>(arg0: &Market<T0>) : u64 {
        let (_, v1) = prices<T0>(arg0);
        v1
    }

    public(friend) fun no_reserves<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_reserves
    }

    public(friend) fun no_supply<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_supply
    }

    public(friend) fun outcome<T0>(arg0: &Market<T0>) : u8 {
        arg0.outcome
    }

    public(friend) fun payout_per_share<T0>(arg0: &Market<T0>) : u64 {
        arg0.payout_per_share
    }

    fun price_per_unit(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        (((arg0 as u128) * 1000000 / (arg1 as u128)) as u64)
    }

    fun prices<T0>(arg0: &Market<T0>) : (u64, u64) {
        let v0 = (arg0.yes_reserves as u128) + (arg0.no_reserves as u128);
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = 1000000;
        ((((arg0.no_reserves as u128) * v1 / v0) as u64), (((arg0.yes_reserves as u128) * v1 / v0) as u64))
    }

    public(friend) fun pyth_feed_id<T0>(arg0: &Market<T0>) : &vector<u8> {
        &arg0.pyth_feed_id
    }

    public(friend) fun redeem_payout<T0>(arg0: &mut Market<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.resolved, 19);
        assert!(!arg0.voided, 10);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, v0), 21);
        let v1 = 0x2::table::remove<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v0);
        let v2 = if (arg0.outcome == 1) {
            0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::yes_shares(&v1)
        } else {
            0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::no_shares(&v1)
        };
        assert!(v2 > 0, 22);
        let v3 = if (v2 > 0x2::balance::value<T0>(&arg0.vault)) {
            0x2::balance::value<T0>(&arg0.vault)
        } else {
            v2
        };
        arg0.yes_supply = arg0.yes_supply - 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::yes_shares(&v1);
        arg0.no_supply = arg0.no_supply - 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::no_shares(&v1);
        arg0.total_shares_minted = arg0.total_shares_minted - v3;
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_shares_redeemed(0x2::object::id<Market<T0>>(arg0), v0, v2, v3);
        0x2::balance::split<T0>(&mut arg0.vault, v3)
    }

    public(friend) fun refund_payout<T0>(arg0: &mut Market<T0>, arg1: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(arg0.voided, 20);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, v0), 21);
        let v1 = 0x2::table::remove<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v0);
        let v2 = 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::total_shares(&v1);
        assert!(v2 > 0, 15);
        let v3 = v2 / 2;
        let v4 = if (v3 > 0x2::balance::value<T0>(&arg0.vault)) {
            0x2::balance::value<T0>(&arg0.vault)
        } else {
            v3
        };
        arg0.yes_supply = arg0.yes_supply - 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::yes_shares(&v1);
        arg0.no_supply = arg0.no_supply - 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::no_shares(&v1);
        arg0.total_shares_minted = arg0.total_shares_minted - v4;
        let v5 = if (v4 > 0) {
            0x2::balance::split<T0>(&mut arg0.vault, v4)
        } else {
            0x2::balance::zero<T0>()
        };
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_shares_refunded(0x2::object::id<Market<T0>>(arg0), v0, v2, v4);
        v5
    }

    public(friend) fun resolve_market<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: address, arg3: u64) {
        assert!(!arg0.resolved, 8);
        assert!(!arg0.voided, 9);
        assert!(arg3 >= arg0.deadline, 12);
        if (arg0.yes_supply == 0 && arg0.no_supply == 0) {
            arg0.voided = true;
            arg0.voided_at = arg3;
            0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_market_voided(0x2::object::id<Market<T0>>(arg0), 0x1::string::utf8(b"empty"));
            return
        };
        let v0 = if (arg1 >= arg0.target_price) {
            1
        } else {
            2
        };
        let v1 = 1000000;
        arg0.resolved = true;
        arg0.outcome = v0;
        arg0.payout_per_share = v1;
        arg0.resolved_price = arg1;
        arg0.resolved_at = arg3;
        arg0.resolver = arg2;
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_market_resolved(0x2::object::id<Market<T0>>(arg0), v0, arg1, arg2, arg0.yes_supply, arg0.no_supply, 0x2::balance::value<T0>(&arg0.vault), v1);
    }

    public(friend) fun resolved<T0>(arg0: &Market<T0>) : bool {
        arg0.resolved
    }

    public(friend) fun resolved_at<T0>(arg0: &Market<T0>) : u64 {
        arg0.resolved_at
    }

    public(friend) fun resolved_price<T0>(arg0: &Market<T0>) : u64 {
        arg0.resolved_price
    }

    public(friend) fun resolver<T0>(arg0: &Market<T0>) : address {
        arg0.resolver
    }

    public(friend) fun sell<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.resolved, 8);
        assert!(!arg0.voided, 10);
        assert!(arg4 < arg0.trading_cutoff, 11);
        assert!(arg1 == 0 || arg1 == 1, 7);
        assert!(arg2 > 0, 15);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, v0), 21);
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::debit_shares(0x2::table::borrow_mut<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v0), arg1, arg2);
        if (arg1 == 0) {
            arg0.yes_reserves = arg0.yes_reserves + arg2;
            arg0.yes_supply = arg0.yes_supply - arg2;
        } else {
            arg0.no_reserves = arg0.no_reserves + arg2;
            arg0.no_supply = arg0.no_supply - arg2;
        };
        let v1 = (arg0.yes_reserves as u128);
        let v2 = (arg0.no_reserves as u128);
        let v3 = v1 + v2;
        let v4 = (((v3 - 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::math::sqrt(v3 * v3 - 4 * (v1 * v2 - arg0.k))) / 2) as u64);
        assert!(v4 > 0, 15);
        arg0.yes_reserves = arg0.yes_reserves - v4;
        arg0.no_reserves = arg0.no_reserves - v4;
        arg0.total_shares_minted = arg0.total_shares_minted - v4;
        assert!(0x2::balance::value<T0>(&arg0.vault) >= v4, 18);
        let v5 = (((v4 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        let v6 = v4 - v5;
        assert!(v6 >= arg3, 17);
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg0.vault, v5));
        if (0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::is_empty(0x2::table::borrow<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&arg0.positions, v0))) {
            0x2::table::remove<address, 0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::position::Position>(&mut arg0.positions, v0);
        };
        arg0.total_volume = arg0.total_volume + v4;
        arg0.trade_count = arg0.trade_count + 1;
        let (v7, v8) = prices<T0>(arg0);
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_shares_sold(0x2::object::id<Market<T0>>(arg0), v0, arg1, arg2, v6, price_per_unit(v4, arg2), v5, v7, v8, arg0.yes_reserves, arg0.no_reserves, 0x2::balance::value<T0>(&arg0.vault), arg0.yes_supply, arg0.no_supply, arg0.total_shares_minted);
        0x2::balance::split<T0>(&mut arg0.vault, v6)
    }

    public(friend) fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public(friend) fun sweep_unclaimed<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::value<T0>(&arg0.vault);
        if (v0 > 0) {
            0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_unclaimed_swept(0x2::object::id<Market<T0>>(arg0), v0);
        };
        0x2::balance::split<T0>(&mut arg0.vault, v0)
    }

    public(friend) fun target_price<T0>(arg0: &Market<T0>) : u64 {
        arg0.target_price
    }

    public(friend) fun token_symbol<T0>(arg0: &Market<T0>) : &0x1::string::String {
        &arg0.token_symbol
    }

    public(friend) fun total_shares_minted<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_shares_minted
    }

    public(friend) fun total_volume<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_volume
    }

    public(friend) fun trade_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.trade_count
    }

    public(friend) fun trading_cutoff<T0>(arg0: &Market<T0>) : u64 {
        arg0.trading_cutoff
    }

    public(friend) fun vault_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public(friend) fun void<T0>(arg0: &mut Market<T0>, arg1: 0x1::string::String, arg2: u64) {
        assert!(!arg0.resolved, 8);
        assert!(!arg0.voided, 9);
        arg0.voided = true;
        arg0.voided_at = arg2;
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_market_voided(0x2::object::id<Market<T0>>(arg0), arg1);
    }

    public(friend) fun voided<T0>(arg0: &Market<T0>) : bool {
        arg0.voided
    }

    public(friend) fun voided_at<T0>(arg0: &Market<T0>) : u64 {
        arg0.voided_at
    }

    public(friend) fun withdraw_pool<T0>(arg0: &mut Market<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.resolved || arg0.voided, 31);
        let v0 = arg0.yes_reserves;
        let v1 = arg0.no_reserves;
        if (v0 == 0 && v1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        let v2 = if (arg0.resolved) {
            let v3 = if (v0 < v1) {
                v0
            } else {
                v1
            };
            let v4 = if (arg0.outcome == 1) {
                v0 - v3
            } else {
                v1 - v3
            };
            0 + v3 + v4
        } else {
            let v5 = if (v0 < v1) {
                v0
            } else {
                v1
            };
            let v6 = if (v0 > v1) {
                v0 - v5
            } else {
                v1 - v5
            };
            0 + v5 + v6 / 2
        };
        if (v2 > 0x2::balance::value<T0>(&arg0.vault)) {
            v2 = 0x2::balance::value<T0>(&arg0.vault);
        };
        arg0.yes_reserves = 0;
        arg0.no_reserves = 0;
        arg0.total_shares_minted = arg0.total_shares_minted - v2;
        let v7 = if (v2 > 0) {
            0x2::balance::split<T0>(&mut arg0.vault, v2)
        } else {
            0x2::balance::zero<T0>()
        };
        0xa1ff34fb79dcdad2c1389d5d72d641c75fdb46bac17aa8eab9f93e77a5043f13::events::emit_pool_withdrawn(0x2::object::id<Market<T0>>(arg0), arg1, v2);
        v7
    }

    public(friend) fun yes_price<T0>(arg0: &Market<T0>) : u64 {
        let (v0, _) = prices<T0>(arg0);
        v0
    }

    public(friend) fun yes_reserves<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_reserves
    }

    public(friend) fun yes_supply<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_supply
    }

    // decompiled from Move bytecode v6
}

