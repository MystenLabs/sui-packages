module 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::rebate_manager {
    struct RebateData has drop, store {
        amount_for_player: u64,
        referrer: 0x1::option::Option<address>,
        amount_for_referrer: u64,
    }

    struct RebateManager has store {
        player_rate: u64,
        referrer_rate: u64,
        rebate_table: 0x2::table::Table<address, RebateData>,
    }

    public fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : RebateManager {
        RebateManager{
            player_rate   : arg0,
            referrer_rate : arg1,
            rebate_table  : 0x2::table::new<address, RebateData>(arg2),
        }
    }

    public fun add_volume(arg0: &mut RebateManager, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1)) {
            register(arg0, arg1, 0x1::option::none<address>());
        };
        let v0 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, arg1);
        v0.amount_for_player = v0.amount_for_player + 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::math::unsafe_mul(arg2, arg0.player_rate);
        v0.amount_for_referrer = v0.amount_for_referrer + 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::math::unsafe_mul(arg2, arg0.referrer_rate);
    }

    public fun claim_rebate(arg0: &mut RebateManager, arg1: address) : (u64, 0x1::option::Option<address>, u64) {
        assert!(0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1), 1);
        let v0 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, arg1);
        v0.amount_for_player = 0;
        v0.amount_for_referrer = 0;
        (v0.amount_for_player, v0.referrer, v0.amount_for_referrer)
    }

    public fun register(arg0: &mut RebateManager, arg1: address, arg2: 0x1::option::Option<address>) {
        let v0 = &mut arg0.rebate_table;
        if (0x2::table::contains<address, RebateData>(v0, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, RebateData>(v0, arg1);
            assert!(0x1::option::is_none<address>(&v1.referrer), 0);
            v1.referrer = arg2;
        } else {
            let v2 = RebateData{
                amount_for_player   : 0,
                referrer            : arg2,
                amount_for_referrer : 0,
            };
            0x2::table::add<address, RebateData>(v0, arg1, v2);
        };
    }

    public fun update_rate(arg0: &mut RebateManager, arg1: u64, arg2: u64) {
        arg0.player_rate = arg1;
        arg0.referrer_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

