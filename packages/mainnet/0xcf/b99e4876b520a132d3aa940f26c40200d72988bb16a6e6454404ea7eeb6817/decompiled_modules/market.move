module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        market_number: u64,
        pyth_feed_id: vector<u8>,
        token_symbol: 0x1::string::String,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
        created_at: u64,
        fee_bps: u16,
        yes_reserves: u64,
        no_reserves: u64,
        total_shares_minted: u64,
        vault: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        positions: 0x2::table::Table<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>,
        resolved: bool,
        voided: bool,
        outcome: u8,
        resolved_price: u64,
        resolved_at: u64,
        resolver: address,
        total_volume: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: 0x2::balance::Balance<T0>, arg10: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let v0 = 0x2::balance::value<T0>(&arg9);
        Market<T0>{
            id                  : 0x2::object::new(arg10),
            market_number       : arg0,
            pyth_feed_id        : arg1,
            token_symbol        : arg2,
            target_price        : arg3,
            duration            : arg4,
            deadline            : arg5,
            trading_cutoff      : arg6,
            created_at          : arg7,
            fee_bps             : arg8,
            yes_reserves        : v0,
            no_reserves         : v0,
            total_shares_minted : v0,
            vault               : arg9,
            fees                : 0x2::balance::zero<T0>(),
            positions           : 0x2::table::new<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(arg10),
            resolved            : false,
            voided              : false,
            outcome             : 0,
            resolved_price      : 0,
            resolved_at         : 0,
            resolver            : @0x0,
            total_volume        : 0,
        }
    }

    public(friend) fun add_fees<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.fees, arg1);
    }

    public(friend) fun collect_fees<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.fees)
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

    fun ensure_position<T0>(arg0: &mut Market<T0>, arg1: address) {
        if (!0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg1)) {
            0x2::table::add<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg1, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::empty());
        };
    }

    public(friend) fun execute_buy<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u8, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 17);
        assert!(arg0.yes_reserves + arg0.no_reserves > 0, 25);
        0x2::balance::join<T0>(&mut arg0.vault, arg1);
        arg0.total_shares_minted = arg0.total_shares_minted + v0;
        arg0.yes_reserves = arg0.yes_reserves + v0;
        arg0.no_reserves = arg0.no_reserves + v0;
        let v1 = if (arg2 == 0) {
            let v2 = (0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::math::ceil_div((arg0.yes_reserves as u128) * (arg0.no_reserves as u128), (arg0.no_reserves as u128)) as u64);
            arg0.yes_reserves = v2;
            arg0.yes_reserves - v2
        } else {
            let v3 = (0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::math::ceil_div((arg0.yes_reserves as u128) * (arg0.no_reserves as u128), (arg0.yes_reserves as u128)) as u64);
            arg0.no_reserves = v3;
            arg0.no_reserves - v3
        };
        ensure_position<T0>(arg0, arg3);
        if (arg2 == 0) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::add_yes(0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg3), v1, arg4);
        } else {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::add_no(0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg3), v1, arg4);
        };
        arg0.total_volume = arg0.total_volume + arg4;
        v1
    }

    public(friend) fun execute_merge<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: address) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 17);
        assert!(0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg2), 15);
        let v0 = 0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg2);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::yes_shares(v0) >= arg1, 16);
        assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::no_shares(v0) >= arg1, 16);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::remove_yes(v0, arg1);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::remove_no(v0, arg1);
        arg0.total_shares_minted = arg0.total_shares_minted - arg1;
        0x2::balance::split<T0>(&mut arg0.vault, arg1)
    }

    public(friend) fun execute_mint<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 17);
        0x2::balance::join<T0>(&mut arg0.vault, arg1);
        arg0.total_shares_minted = arg0.total_shares_minted + v0;
        ensure_position<T0>(arg0, arg2);
        let v1 = 0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg2);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::add_yes(v1, v0, v0);
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::add_no(v1, v0, v0);
    }

    public(friend) fun execute_redeem<T0>(arg0: &mut Market<T0>, arg1: address) : (u64, 0x2::balance::Balance<T0>) {
        assert!(arg0.resolved, 13);
        assert!(0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg1), 15);
        let v0 = 0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg1);
        let v1 = if (arg0.outcome == 1) {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::yes_shares(v0)
        } else {
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::no_shares(v0)
        };
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::zero(v0);
        if (v1 == 0) {
            return (0, 0x2::balance::zero<T0>())
        };
        arg0.total_shares_minted = arg0.total_shares_minted - v1;
        (v1, 0x2::balance::split<T0>(&mut arg0.vault, v1))
    }

    public(friend) fun execute_refund<T0>(arg0: &mut Market<T0>, arg1: address) : (u64, 0x2::balance::Balance<T0>) {
        assert!(arg0.voided, 14);
        assert!(0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg1), 15);
        let v0 = 0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg1);
        let v1 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::total_shares(v0);
        let v2 = v1 / 2;
        0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::zero(v0);
        if (v2 == 0) {
            return (v1, 0x2::balance::zero<T0>())
        };
        arg0.total_shares_minted = arg0.total_shares_minted - v2;
        (v1, 0x2::balance::split<T0>(&mut arg0.vault, v2))
    }

    public(friend) fun execute_sell<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: address) : 0x2::balance::Balance<T0> {
        assert!(arg2 > 0, 17);
        assert!(0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg3), 15);
        let v0 = 0x2::table::borrow_mut<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&mut arg0.positions, arg3);
        if (arg1 == 0) {
            assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::yes_shares(v0) >= arg2, 16);
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::remove_yes(v0, arg2);
        } else {
            assert!(0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::no_shares(v0) >= arg2, 16);
            0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::remove_no(v0, arg2);
        };
        if (arg1 == 0) {
            arg0.yes_reserves = arg0.yes_reserves + arg2;
        } else {
            arg0.no_reserves = arg0.no_reserves + arg2;
        };
        let v1 = 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::math::compute_merge_pairs(arg0.yes_reserves, arg0.no_reserves, (arg0.yes_reserves as u128) * (arg0.no_reserves as u128));
        assert!(v1 > 0, 17);
        arg0.yes_reserves = arg0.yes_reserves - v1;
        arg0.no_reserves = arg0.no_reserves - v1;
        arg0.total_shares_minted = arg0.total_shares_minted - v1;
        arg0.total_volume = arg0.total_volume + v1;
        0x2::balance::split<T0>(&mut arg0.vault, v1)
    }

    public(friend) fun fee_bps<T0>(arg0: &Market<T0>) : u16 {
        arg0.fee_bps
    }

    public(friend) fun fees_balance<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public(friend) fun has_position<T0>(arg0: &Market<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun is_resolvable<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        if (!arg0.resolved) {
            if (!arg0.voided) {
                arg1 >= arg0.deadline
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_trading_open<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        if (!arg0.resolved) {
            if (!arg0.voided) {
                arg1 < arg0.trading_cutoff
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun mark_resolved<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: address, arg4: u64) {
        arg0.resolved = true;
        arg0.outcome = arg1;
        arg0.resolved_price = arg2;
        arg0.resolved_at = arg4;
        arg0.resolver = arg3;
    }

    public(friend) fun mark_voided<T0>(arg0: &mut Market<T0>) {
        arg0.voided = true;
    }

    public(friend) fun market_number<T0>(arg0: &Market<T0>) : u64 {
        arg0.market_number
    }

    public(friend) fun no_reserves<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_reserves
    }

    public(friend) fun outcome<T0>(arg0: &Market<T0>) : u8 {
        arg0.outcome
    }

    public(friend) fun position<T0>(arg0: &Market<T0>, arg1: address) : &0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position {
        0x2::table::borrow<address, 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun pyth_feed_id<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.pyth_feed_id
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

    public(friend) fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public(friend) fun sweep_remaining<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        arg0.total_shares_minted = 0;
        arg0.yes_reserves = 0;
        arg0.no_reserves = 0;
        0x2::balance::withdraw_all<T0>(&mut arg0.vault)
    }

    public(friend) fun target_price<T0>(arg0: &Market<T0>) : u64 {
        arg0.target_price
    }

    public(friend) fun token_symbol<T0>(arg0: &Market<T0>) : 0x1::string::String {
        arg0.token_symbol
    }

    public(friend) fun total_shares_minted<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_shares_minted
    }

    public(friend) fun total_volume<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_volume
    }

    public(friend) fun trading_cutoff<T0>(arg0: &Market<T0>) : u64 {
        arg0.trading_cutoff
    }

    public(friend) fun uid<T0>(arg0: &Market<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun vault_balance<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public(friend) fun voided<T0>(arg0: &Market<T0>) : bool {
        arg0.voided
    }

    public(friend) fun withdraw_pool<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        if (arg0.resolved) {
            let v1 = if (arg0.outcome == 1) {
                arg0.yes_reserves
            } else {
                arg0.no_reserves
            };
            arg0.yes_reserves = 0;
            arg0.no_reserves = 0;
            if (v1 == 0) {
                return 0x2::balance::zero<T0>()
            };
            arg0.total_shares_minted = arg0.total_shares_minted - v1;
            0x2::balance::split<T0>(&mut arg0.vault, v1)
        } else if (arg0.voided) {
            let v2 = (arg0.yes_reserves + arg0.no_reserves) / 2;
            arg0.yes_reserves = 0;
            arg0.no_reserves = 0;
            if (v2 == 0) {
                return 0x2::balance::zero<T0>()
            };
            arg0.total_shares_minted = arg0.total_shares_minted - v2;
            0x2::balance::split<T0>(&mut arg0.vault, v2)
        } else {
            let v3 = if (arg0.yes_reserves < arg0.no_reserves) {
                arg0.yes_reserves
            } else {
                arg0.no_reserves
            };
            if (v3 == 0) {
                return 0x2::balance::zero<T0>()
            };
            arg0.yes_reserves = arg0.yes_reserves - v3;
            arg0.no_reserves = arg0.no_reserves - v3;
            arg0.total_shares_minted = arg0.total_shares_minted - v3;
            0x2::balance::split<T0>(&mut arg0.vault, v3)
        }
    }

    public(friend) fun yes_reserves<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_reserves
    }

    // decompiled from Move bytecode v6
}

