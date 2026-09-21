module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_payout_tree {
    struct StrikePayoutTree has store {
        root: 0x1::option::Option<u64>,
        nodes: 0x2::table::Table<u64, PayoutNode>,
        node_count: u64,
        base: u64,
        snapshot_seq: u64,
        snapshot_active: bool,
        snapshot_base: u64,
    }

    struct PayoutSummary has copy, drop, store {
        start: u64,
        end: u64,
        max_payout_prefix_gain: u64,
    }

    struct PayoutNode has copy, drop, store {
        height: u64,
        left: 0x1::option::Option<u64>,
        right: 0x1::option::Option<u64>,
        local_start: u64,
        local_end: u64,
        snapshot_local_start: u64,
        snapshot_local_end: u64,
        snapshot_seq: u64,
        summary: PayoutSummary,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : StrikePayoutTree {
        StrikePayoutTree{
            root            : 0x1::option::none<u64>(),
            nodes           : 0x2::table::new<u64, PayoutNode>(arg0),
            node_count      : 0,
            base            : 0,
            snapshot_seq    : 0,
            snapshot_active : false,
            snapshot_base   : 0,
        }
    }

    public(friend) fun activate_snapshot(arg0: &mut StrikePayoutTree, arg1: u64) {
        assert!(arg1 > arg0.snapshot_seq, 4);
        arg0.snapshot_seq = arg1;
        arg0.snapshot_active = true;
        arg0.snapshot_base = arg0.base;
    }

    fun apply_at(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64, arg4: bool, arg5: bool, arg6: u64) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<u64>(&arg1)) {
            assert!(arg5, 0);
            0x2::table::add<u64, PayoutNode>(arg0, arg2, new_leaf(arg3, arg4, arg6));
            return 0x1::option::some<u64>(arg2)
        };
        let v0 = *0x1::option::borrow<u64>(&arg1);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        if (arg2 == v0) {
            let v2 = &mut v1;
            capture_snapshot_if_stale(v2, arg6);
            if (arg4) {
                let v3 = &mut v1.local_start;
                apply_net_delta(v3, arg3, arg5);
            } else {
                let v4 = &mut v1.local_end;
                apply_net_delta(v4, arg3, arg5);
            };
            if (is_empty_node(v1) && !retains_snapshot(&v1, arg6)) {
                0x2::table::remove<u64, PayoutNode>(arg0, v0);
                return join_subtrees(arg0, v1.left, v1.right)
            };
            resummarize(arg0, v0, v1);
            return 0x1::option::some<u64>(v0)
        };
        if (arg2 < v0) {
            let v5 = apply_at(arg0, v1.left, arg2, arg3, arg4, arg5, arg6);
            v1.left = v5;
        } else {
            let v6 = apply_at(arg0, v1.right, arg2, arg3, arg4, arg5, arg6);
            v1.right = v6;
        };
        0x1::option::some<u64>(rebalance(arg0, v0, v1))
    }

    fun apply_boundary_delta(arg0: &mut StrikePayoutTree, arg1: u64, arg2: u64, arg3: bool, arg4: bool) {
        let v0 = 0x2::table::contains<u64, PayoutNode>(&arg0.nodes, arg1);
        let v1 = if (arg0.snapshot_active) {
            arg0.snapshot_seq
        } else {
            0
        };
        let v2 = &mut arg0.nodes;
        arg0.root = apply_at(v2, arg0.root, arg1, arg2, arg3, arg4, v1);
        let v3 = 0x2::table::contains<u64, PayoutNode>(&arg0.nodes, arg1);
        if (!v0 && v3) {
            arg0.node_count = arg0.node_count + 1;
        } else if (v0 && !v3) {
            arg0.node_count = arg0.node_count - 1;
        };
    }

    fun apply_net_delta(arg0: &mut u64, arg1: u64, arg2: bool) {
        if (arg2) {
            *arg0 = *arg0 + arg1;
        } else {
            assert!(*arg0 >= arg1, 0);
            *arg0 = *arg0 - arg1;
        };
    }

    fun apply_range(arg0: &mut StrikePayoutTree, arg1: u64, arg2: u64, arg3: u64, arg4: bool) {
        if (arg3 == 0) {
            return
        };
        if (arg1 == 0) {
            let v0 = &mut arg0.base;
            apply_net_delta(v0, arg3, arg4);
            apply_boundary_delta(arg0, arg2, arg3, false, arg4);
        } else {
            apply_boundary_delta(arg0, arg1, arg3, true, arg4);
            if (arg2 != 1073741823) {
                apply_boundary_delta(arg0, arg2, arg3, false, arg4);
            };
        };
    }

    fun boundary_summary(arg0: u64, arg1: u64) : PayoutSummary {
        PayoutSummary{
            start                  : arg0,
            end                    : arg1,
            max_payout_prefix_gain : positive_net_delta(arg0, arg1, 0),
        }
    }

    fun capture_snapshot_if_stale(arg0: &mut PayoutNode, arg1: u64) {
        if (arg1 == 0 || arg0.snapshot_seq == arg1) {
            return
        };
        arg0.snapshot_local_start = arg0.local_start;
        arg0.snapshot_local_end = arg0.local_end;
        arg0.snapshot_seq = arg1;
    }

    fun collect_husks(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: &mut vector<u64>) {
        if (0x1::option::is_none<u64>(&arg1)) {
            return
        };
        let v0 = *0x2::table::borrow<u64, PayoutNode>(arg0, *0x1::option::borrow<u64>(&arg1));
        collect_husks(arg0, v0.left, arg2);
        if (is_empty_node(v0)) {
            0x1::vector::push_back<u64>(arg2, *0x1::option::borrow<u64>(&arg1));
        };
        collect_husks(arg0, v0.right, arg2);
    }

    fun combine_summaries(arg0: PayoutSummary, arg1: PayoutSummary) : PayoutSummary {
        PayoutSummary{
            start                  : arg0.start + arg1.start,
            end                    : arg0.end + arg1.end,
            max_payout_prefix_gain : 0x1::u64::max(arg0.max_payout_prefix_gain, positive_net_delta(arg0.start, arg0.end, arg1.max_payout_prefix_gain)),
        }
    }

    public(friend) fun complement_max_payout(arg0: &StrikePayoutTree, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg1 == 0) {
            0
        } else {
            range_max_payout(arg0, 0, arg1)
        };
        let v1 = if (arg2 == 1073741823) {
            0
        } else {
            range_max_payout(arg0, arg2, 1073741823)
        };
        0x1::u64::max(v0, v1)
    }

    public(friend) fun deactivate_snapshot(arg0: &mut StrikePayoutTree) {
        arg0.snapshot_active = false;
    }

    fun detach_tick(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = *0x1::option::borrow<u64>(&arg1);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        if (arg2 == v0) {
            0x2::table::remove<u64, PayoutNode>(arg0, v0);
            return join_subtrees(arg0, v1.left, v1.right)
        };
        if (arg2 < v0) {
            let v2 = detach_tick(arg0, v1.left, arg2);
            v1.left = v2;
        } else {
            let v3 = detach_tick(arg0, v1.right, arg2);
            v1.right = v3;
        };
        0x1::option::some<u64>(rebalance(arg0, v0, v1))
    }

    public(friend) fun insert_range(arg0: &mut StrikePayoutTree, arg1: u64, arg2: u64, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = 0;
        let v1 = v0;
        if (arg1 != 0 && !0x2::table::contains<u64, PayoutNode>(&arg0.nodes, arg1)) {
            v1 = v0 + 1;
        };
        let v2 = if (arg2 != 1073741823) {
            if (arg2 != arg1) {
                !0x2::table::contains<u64, PayoutNode>(&arg0.nodes, arg2)
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            v1 = v1 + 1;
        };
        assert!(arg0.node_count + v1 <= 960, 1);
        apply_range(arg0, arg1, arg2, arg3, true);
    }

    fun is_empty_node(arg0: PayoutNode) : bool {
        arg0.local_start == 0 && arg0.local_end == 0
    }

    fun join_subtrees(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: 0x1::option::Option<u64>) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<u64>(&arg1)) {
            return arg2
        };
        if (0x1::option::is_none<u64>(&arg2)) {
            return arg1
        };
        let (v0, v1) = take_min(arg0, *0x1::option::borrow<u64>(&arg2));
        let v2 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        v2.left = arg1;
        v2.right = v1;
        0x1::option::some<u64>(rebalance(arg0, v0, v2))
    }

    fun new_leaf(arg0: u64, arg1: bool, arg2: u64) : PayoutNode {
        let (v0, v1) = if (arg1) {
            (arg0, 0)
        } else {
            (0, arg0)
        };
        PayoutNode{
            height               : 1,
            left                 : 0x1::option::none<u64>(),
            right                : 0x1::option::none<u64>(),
            local_start          : v0,
            local_end            : v1,
            snapshot_local_start : 0,
            snapshot_local_end   : 0,
            snapshot_seq         : arg2,
            summary              : boundary_summary(v0, v1),
        }
    }

    public(friend) fun payout_reserve_terms(arg0: &StrikePayoutTree) : (u64, u64) {
        let v0 = arg0.base;
        let v1 = v0;
        let v2 = arg0.base;
        let v3 = v2;
        if (0x1::option::is_some<u64>(&arg0.root)) {
            let v4 = 0x2::table::borrow<u64, PayoutNode>(&arg0.nodes, *0x1::option::borrow<u64>(&arg0.root)).summary;
            v1 = v0 + v4.max_payout_prefix_gain;
            v3 = v2 + v4.start;
        };
        (v1, v3)
    }

    fun positive_net_delta(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x1::u64::saturating_sub(arg0 + arg2, arg1)
    }

    public(friend) fun range_max_payout(arg0: &StrikePayoutTree, arg1: u64, arg2: u64) : u64 {
        let v0 = window_summary(&arg0.nodes, arg0.root, arg1, arg2, 0, 1073741823);
        settlement_prefix_payout(&arg0.nodes, arg0.root, arg1 + 1, arg0.base) + v0.max_payout_prefix_gain
    }

    fun rebalance(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: u64, arg2: PayoutNode) : u64 {
        let v0 = subtree_height(arg0, arg2.left);
        let v1 = subtree_height(arg0, arg2.right);
        if (v0 > v1 + 1) {
            let v3 = *0x1::option::borrow<u64>(&arg2.left);
            let v4 = *0x2::table::borrow<u64, PayoutNode>(arg0, v3);
            if (subtree_height(arg0, v4.right) > subtree_height(arg0, v4.left)) {
                let v5 = rotate_left(arg0, v3, v4);
                arg2.left = 0x1::option::some<u64>(v5);
            };
            rotate_right(arg0, arg1, arg2)
        } else if (v1 > v0 + 1) {
            let v6 = *0x1::option::borrow<u64>(&arg2.right);
            let v7 = *0x2::table::borrow<u64, PayoutNode>(arg0, v6);
            if (subtree_height(arg0, v7.left) > subtree_height(arg0, v7.right)) {
                let v8 = rotate_right(arg0, v6, v7);
                arg2.right = 0x1::option::some<u64>(v8);
            };
            rotate_left(arg0, arg1, arg2)
        } else {
            resummarize(arg0, arg1, arg2);
            arg1
        }
    }

    public(friend) fun release_snapshot(arg0: &mut StrikePayoutTree) {
        arg0.snapshot_active = false;
        let v0 = vector[];
        let v1 = &mut v0;
        collect_husks(&arg0.nodes, arg0.root, v1);
        0x1::vector::reverse<u64>(&mut v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            let v3 = &mut arg0.nodes;
            arg0.root = detach_tick(v3, arg0.root, 0x1::vector::pop_back<u64>(&mut v0));
            arg0.node_count = arg0.node_count - 1;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<u64>(v0);
    }

    public(friend) fun remove_range(arg0: &mut StrikePayoutTree, arg1: u64, arg2: u64, arg3: u64) {
        apply_range(arg0, arg1, arg2, arg3, false);
    }

    fun resummarize(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: u64, arg2: PayoutNode) {
        let (v0, v1) = subtree_facts(arg0, arg2.left);
        let (v2, v3) = subtree_facts(arg0, arg2.right);
        arg2.summary = combine_summaries(combine_summaries(v0, boundary_summary(arg2.local_start, arg2.local_end)), v2);
        arg2.height = 1 + 0x1::u64::max(v1, v3);
        *0x2::table::borrow_mut<u64, PayoutNode>(arg0, arg1) = arg2;
    }

    fun retains_snapshot(arg0: &PayoutNode, arg1: u64) : bool {
        if (arg1 != 0) {
            if (arg0.snapshot_seq == arg1) {
                arg0.snapshot_local_start != 0 || arg0.snapshot_local_end != 0
            } else {
                false
            }
        } else {
            false
        }
    }

    fun rotate_left(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: u64, arg2: PayoutNode) : u64 {
        let v0 = *0x1::option::borrow<u64>(&arg2.right);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        arg2.right = v1.left;
        resummarize(arg0, arg1, arg2);
        v1.left = 0x1::option::some<u64>(arg1);
        resummarize(arg0, v0, v1);
        v0
    }

    fun rotate_right(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: u64, arg2: PayoutNode) : u64 {
        let v0 = *0x1::option::borrow<u64>(&arg2.left);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        arg2.left = v1.right;
        resummarize(arg0, arg1, arg2);
        v1.right = 0x1::option::some<u64>(arg1);
        resummarize(arg0, v0, v1);
        v0
    }

    public(friend) fun settled_payout_liability(arg0: &StrikePayoutTree, arg1: u64, arg2: u64) : u64 {
        settlement_prefix_payout(&arg0.nodes, arg0.root, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::prefix_limit_tick(arg1, arg2), arg0.base)
    }

    fun settlement_prefix_payout(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64) : u64 {
        if (0x1::option::is_none<u64>(&arg1)) {
            return arg3
        };
        let v0 = *0x1::option::borrow<u64>(&arg1);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        if (arg2 <= v0) {
            return settlement_prefix_payout(arg0, v1.left, arg2, arg3)
        };
        let v2 = subtree_summary(arg0, v1.left);
        let v3 = &mut arg3;
        apply_net_delta(v3, v2.start, true);
        let v4 = &mut arg3;
        apply_net_delta(v4, v2.end, false);
        let v5 = &mut arg3;
        apply_net_delta(v5, v1.local_start, true);
        let v6 = &mut arg3;
        apply_net_delta(v6, v1.local_end, false);
        settlement_prefix_payout(arg0, v1.right, arg2, arg3)
    }

    fun subtree_facts(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>) : (PayoutSummary, u64) {
        if (0x1::option::is_none<u64>(&arg1)) {
            return (zero_summary(), 0)
        };
        let v0 = *0x2::table::borrow<u64, PayoutNode>(arg0, *0x1::option::borrow<u64>(&arg1));
        (v0.summary, v0.height)
    }

    fun subtree_height(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>) : u64 {
        if (0x1::option::is_none<u64>(&arg1)) {
            return 0
        };
        0x2::table::borrow<u64, PayoutNode>(arg0, *0x1::option::borrow<u64>(&arg1)).height
    }

    fun subtree_summary(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>) : PayoutSummary {
        if (0x1::option::is_none<u64>(&arg1)) {
            return zero_summary()
        };
        0x2::table::borrow<u64, PayoutNode>(arg0, *0x1::option::borrow<u64>(&arg1)).summary
    }

    fun take_min(arg0: &mut 0x2::table::Table<u64, PayoutNode>, arg1: u64) : (u64, 0x1::option::Option<u64>) {
        let v0 = *0x2::table::borrow<u64, PayoutNode>(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0.left)) {
            return (arg1, v0.right)
        };
        let (v1, v2) = take_min(arg0, *0x1::option::borrow<u64>(&v0.left));
        v0.left = v2;
        (v1, 0x1::option::some<u64>(rebalance(arg0, arg1, v0)))
    }

    public(friend) fun walk_linear(arg0: &StrikePayoutTree, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u64) : u64 {
        let v0 = 0x1::option::none<u64>();
        let v1 = &mut v0;
        let (v2, v3) = walk_linear_subtree(&arg0.nodes, arg0.root, arg1, arg2, 0, v1);
        0x1::u64::saturating_sub(arg0.base + v2, v3)
    }

    public(friend) fun walk_linear_frozen(arg0: &StrikePayoutTree, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg0.snapshot_active) {
            if (arg0.snapshot_seq == arg3) {
                arg3 != 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = 0x1::option::none<u64>();
        let v2 = &mut v1;
        let (v3, v4) = walk_linear_subtree(&arg0.nodes, arg0.root, arg1, arg2, arg3, v2);
        0x1::u64::saturating_sub(arg0.snapshot_base + v3, v4)
    }

    fun walk_linear_subtree(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::Pricer, arg3: u64, arg4: u64, arg5: &mut 0x1::option::Option<u64>) : (u64, u64) {
        if (0x1::option::is_none<u64>(&arg1)) {
            return (0, 0)
        };
        let v0 = *0x1::option::borrow<u64>(&arg1);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        let (v2, v3) = walk_linear_subtree(arg0, v1.left, arg2, arg3, arg4, arg5);
        let (v4, v5) = if (arg4 != 0 && v1.snapshot_seq == arg4) {
            (v1.snapshot_local_start, v1.snapshot_local_end)
        } else {
            (v1.local_start, v1.local_end)
        };
        let v6 = 0;
        let v7 = 0;
        if (v4 != 0 || v5 != 0) {
            let v8 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::up_price(arg2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::range_codec::strike_from_tick(v0, arg3));
            if (0x1::option::is_some<u64>(arg5)) {
                assert!(v8 <= *0x1::option::borrow<u64>(arg5), 2);
            };
            *arg5 = 0x1::option::some<u64>(v8);
            if (v4 != v5) {
                v6 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v8, v4);
                v7 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v8, v5);
            };
        };
        let (v9, v10) = walk_linear_subtree(arg0, v1.right, arg2, arg3, arg4, arg5);
        (v6 + v2 + v9, v7 + v3 + v10)
    }

    fun window_summary(arg0: &0x2::table::Table<u64, PayoutNode>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : PayoutSummary {
        if (0x1::option::is_none<u64>(&arg1)) {
            return zero_summary()
        };
        if (arg4 >= arg2 && arg5 <= arg3) {
            return subtree_summary(arg0, arg1)
        };
        let v0 = *0x1::option::borrow<u64>(&arg1);
        let v1 = *0x2::table::borrow<u64, PayoutNode>(arg0, v0);
        if (v0 <= arg2) {
            return window_summary(arg0, v1.right, arg2, arg3, v0, arg5)
        };
        if (v0 >= arg3) {
            return window_summary(arg0, v1.left, arg2, arg3, arg4, v0)
        };
        combine_summaries(combine_summaries(window_summary(arg0, v1.left, arg2, arg3, arg4, v0), boundary_summary(v1.local_start, v1.local_end)), window_summary(arg0, v1.right, arg2, arg3, v0, arg5))
    }

    fun zero_summary() : PayoutSummary {
        PayoutSummary{
            start                  : 0,
            end                    : 0,
            max_payout_prefix_gain : 0,
        }
    }

    // decompiled from Move bytecode v7
}

