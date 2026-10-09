module 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::terms {
    struct Terms has copy, drop, store {
        split: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Split,
        virtual_shares: u64,
        launch_fee_sui: u64,
        max_dev_buy_bps: u64,
        snipe_min_ms: u64,
        snipe_max_ms: u64,
        snipe_start_fee_bps: u64,
        snipe_tx_cap_bps: u64,
        arb_move_bps: u64,
        margin_bps: u64,
    }

    public fun check(arg0: &Terms) {
        0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::check(&arg0.split);
        assert!(arg0.virtual_shares >= 100000000 && arg0.virtual_shares <= 1000000000000, 1200);
        assert!(arg0.launch_fee_sui <= 100000000000, 1200);
        assert!(arg0.max_dev_buy_bps <= 2000, 1200);
        let v0 = if (arg0.snipe_min_ms > 0) {
            if (arg0.snipe_min_ms <= arg0.snipe_max_ms) {
                arg0.snipe_max_ms <= 120000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1200);
        assert!(arg0.snipe_start_fee_bps >= 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::trade_fee_bps(&arg0.split) && arg0.snipe_start_fee_bps < 10000, 1200);
        assert!(arg0.snipe_tx_cap_bps > 0 && arg0.snipe_tx_cap_bps <= 1000, 1200);
        assert!(arg0.arb_move_bps <= 200, 1200);
        assert!(arg0.margin_bps >= 5000 && arg0.margin_bps <= 9000, 1200);
    }

    public fun arb_move_bps(arg0: &Terms) : u64 {
        arg0.arb_move_bps
    }

    public fun default() : Terms {
        Terms{
            split               : 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::default_split(),
            virtual_shares      : 5000000000,
            launch_fee_sui      : 1000000000,
            max_dev_buy_bps     : 1000,
            snipe_min_ms        : 15000,
            snipe_max_ms        : 60000,
            snipe_start_fee_bps : 9900,
            snipe_tx_cap_bps    : 100,
            arb_move_bps        : 20,
            margin_bps          : 8000,
        }
    }

    public fun launch_fee_sui(arg0: &Terms) : u64 {
        arg0.launch_fee_sui
    }

    public fun margin_bps(arg0: &Terms) : u64 {
        arg0.margin_bps
    }

    public fun max_dev_buy_bps(arg0: &Terms) : u64 {
        arg0.max_dev_buy_bps
    }

    public fun new(arg0: 0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Split, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) : Terms {
        let v0 = Terms{
            split               : arg0,
            virtual_shares      : arg1,
            launch_fee_sui      : arg2,
            max_dev_buy_bps     : arg3,
            snipe_min_ms        : arg4,
            snipe_max_ms        : arg5,
            snipe_start_fee_bps : arg6,
            snipe_tx_cap_bps    : arg7,
            arb_move_bps        : arg8,
            margin_bps          : arg9,
        };
        check(&v0);
        v0
    }

    public fun snipe(arg0: &Terms) : (u64, u64, u64, u64) {
        (arg0.snipe_min_ms, arg0.snipe_max_ms, arg0.snipe_start_fee_bps, arg0.snipe_tx_cap_bps)
    }

    public fun split(arg0: &Terms) : &0xf98c2ec95a27986e3d44f6a7d7e61ecc537f46f3d73ecb69fb8bb8d2fdd40618::fees::Split {
        &arg0.split
    }

    public fun virtual_shares(arg0: &Terms) : u64 {
        arg0.virtual_shares
    }

    // decompiled from Move bytecode v7
}

