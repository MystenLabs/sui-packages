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

    struct SetReferrer has copy, drop {
        player: address,
        referrer: address,
    }

    struct PlayerRebate has copy, drop {
        player: address,
        amount: u64,
    }

    struct ReferrerRebate has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct Claim has copy, drop {
        user: address,
        amount: u64,
    }

    struct SetReferrerV4<phantom T0> has copy, drop {
        player: address,
        referrer: address,
    }

    struct PlayerRebateV4<phantom T0> has copy, drop {
        player: address,
        amount: u64,
    }

    struct ReferrerRebateV4<phantom T0> has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct ClaimV4<phantom T0> has copy, drop {
        user: address,
        amount: u64,
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

    public(friend) fun add_volume_v4<T0>(arg0: &mut RebateManager, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1)) {
            register(arg0, arg1, 0x1::option::none<address>());
        };
        let v0 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, arg1);
        let v1 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::math::unsafe_mul(arg2, arg0.player_rate);
        v0.amount_for_player = v0.amount_for_player + v1;
        if (v1 > 0) {
            let v2 = PlayerRebateV4<T0>{
                player : arg1,
                amount : v1,
            };
            0x2::event::emit<PlayerRebateV4<T0>>(v2);
        };
        if (0x1::option::is_none<address>(&v0.referrer)) {
            return
        };
        let v3 = *0x1::option::borrow<address>(&v0.referrer);
        if (!0x2::table::contains<address, RebateData>(&arg0.rebate_table, v3)) {
            register(arg0, v3, 0x1::option::none<address>());
        };
        let v4 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, v3);
        let v5 = 0xc0bfc90b3a663357d63878cef0ec80b623624eb0127300f3accda005cf155a73::math::unsafe_mul(arg2, arg0.referrer_rate);
        v4.amount_for_player = v4.amount_for_player + v5;
        if (v5 > 0) {
            let v6 = ReferrerRebateV4<T0>{
                referrer : v3,
                amount   : v1,
            };
            0x2::event::emit<ReferrerRebateV4<T0>>(v6);
        };
    }

    public fun claim_rebate(arg0: &mut RebateManager, arg1: address) : (u64, 0x1::option::Option<address>, u64) {
        assert!(0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1), 1);
        let v0 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, arg1);
        v0.amount_for_player = 0;
        v0.amount_for_referrer = 0;
        (v0.amount_for_player, v0.referrer, v0.amount_for_referrer)
    }

    public(friend) fun claim_rebate_v4<T0>(arg0: &mut RebateManager, arg1: address) : (u64, 0x1::option::Option<address>, u64) {
        assert!(0x2::table::contains<address, RebateData>(&arg0.rebate_table, arg1), 1);
        let v0 = 0x2::table::borrow_mut<address, RebateData>(&mut arg0.rebate_table, arg1);
        let v1 = v0.amount_for_player;
        v0.amount_for_player = 0;
        v0.amount_for_referrer = 0;
        if (v1 > 0) {
            let v2 = ClaimV4<T0>{
                user   : arg1,
                amount : v1,
            };
            0x2::event::emit<ClaimV4<T0>>(v2);
        };
        (v1, v0.referrer, v0.amount_for_referrer)
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

    public(friend) fun register_v4<T0>(arg0: &mut RebateManager, arg1: address, arg2: 0x1::option::Option<address>) {
        let v0 = &mut arg0.rebate_table;
        if (0x2::table::contains<address, RebateData>(v0, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, RebateData>(v0, arg1);
            if (0x1::option::is_some<address>(&v1.referrer)) {
                return
            };
            v1.referrer = arg2;
        } else {
            let v2 = RebateData{
                amount_for_player   : 0,
                referrer            : arg2,
                amount_for_referrer : 0,
            };
            0x2::table::add<address, RebateData>(v0, arg1, v2);
        };
        if (0x1::option::is_some<address>(&arg2)) {
            let v3 = SetReferrerV4<T0>{
                player   : arg1,
                referrer : 0x1::option::destroy_some<address>(arg2),
            };
            0x2::event::emit<SetReferrerV4<T0>>(v3);
        };
    }

    public fun update_rate(arg0: &mut RebateManager, arg1: u64, arg2: u64) {
        arg0.player_rate = arg1;
        arg0.referrer_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

