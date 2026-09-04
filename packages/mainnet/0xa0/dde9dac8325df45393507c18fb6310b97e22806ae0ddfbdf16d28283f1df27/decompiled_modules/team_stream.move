module 0xcff874d3702572ea373053304c7d384aeaa4fb041905b355471a624331954c7c::team_stream {
    struct TeamStreamRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        paused: bool,
        streams_total: u64,
    }

    struct TeamStreamAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TeamStream<phantom T0> has key {
        id: 0x2::object::UID,
        creator: address,
        members: vector<address>,
        pot: 0x2::balance::Balance<T0>,
        per_member: u64,
        tranche_total: u64,
        num_tranches: u64,
        tranches_done: u64,
        interval_ms: u64,
        next_due_ms: u64,
        released_total: u64,
        cancelled: bool,
    }

    struct StreamCreated has copy, drop {
        stream_id: 0x2::object::ID,
        creator: address,
        members: vector<address>,
        per_member: u64,
        tranche_total: u64,
        num_tranches: u64,
        interval_ms: u64,
        first_due_ms: u64,
        funded: u64,
        dust: u64,
    }

    struct TrancheReleased has copy, drop {
        stream_id: 0x2::object::ID,
        tranche_index: u64,
        per_member: u64,
        total: u64,
        member_count: u64,
        caller: address,
        next_due_ms: u64,
        ts_ms: u64,
    }

    struct StreamCancelled has copy, drop {
        stream_id: 0x2::object::ID,
        refunded: u64,
        released_total: u64,
        tranches_done: u64,
    }

    struct PauseSet has copy, drop {
        paused: bool,
    }

    struct StreamSettled has copy, drop {
        stream_id: 0x2::object::ID,
        refunded: u64,
        reserved: u64,
        due_tranches: u64,
        num_tranches: u64,
        tranches_done: u64,
        released_total: u64,
        cancelled: bool,
        ts_ms: u64,
    }

    public fun cancel<T0>(arg0: &mut TeamStream<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 871);
        assert!(!arg0.cancelled, 872);
        arg0.cancelled = true;
        let v0 = StreamCancelled{
            stream_id      : 0x2::object::id<TeamStream<T0>>(arg0),
            refunded       : 0x2::balance::value<T0>(&arg0.pot),
            released_total : arg0.released_total,
            tranches_done  : arg0.tranches_done,
        };
        0x2::event::emit<StreamCancelled>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.pot), arg1)
    }

    public fun cancel_v2<T0>(arg0: &mut TeamStream<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 871);
        assert!(!arg0.cancelled, 872);
        let v0 = due_tranches<T0>(arg0, arg1);
        let v1 = arg0.tranche_total * v0;
        let v2 = 0x2::balance::value<T0>(&arg0.pot);
        assert!(v2 >= v1, 876);
        let v3 = v2 - v1;
        if (v0 == 0) {
            arg0.cancelled = true;
        } else {
            arg0.num_tranches = arg0.tranches_done + v0;
        };
        let v4 = StreamSettled{
            stream_id      : 0x2::object::uid_to_inner(&arg0.id),
            refunded       : v3,
            reserved       : v1,
            due_tranches   : v0,
            num_tranches   : arg0.num_tranches,
            tranches_done  : arg0.tranches_done,
            released_total : arg0.released_total,
            cancelled      : arg0.cancelled,
            ts_ms          : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<StreamSettled>(v4);
        if (arg0.cancelled) {
            let v5 = StreamCancelled{
                stream_id      : 0x2::object::uid_to_inner(&arg0.id),
                refunded       : v3,
                released_total : arg0.released_total,
                tranches_done  : arg0.tranches_done,
            };
            0x2::event::emit<StreamCancelled>(v5);
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.pot, v3), arg2)
    }

    public fun create<T0>(arg0: &mut TeamStreamRegistry, arg1: 0x2::balance::Balance<T0>, arg2: vector<address>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg4 > 0, 873);
        new_stream<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun create_v2<T0>(arg0: &mut TeamStreamRegistry, arg1: 0x2::balance::Balance<T0>, arg2: vector<address>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg5 >= 0x2::clock::timestamp_ms(arg6), 883);
        assert!(arg4 >= 3600000, 884);
        assert!(arg4 <= 31536000000, 884);
        new_stream<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    public fun creator<T0>(arg0: &TeamStream<T0>) : address {
        arg0.creator
    }

    public fun destroy<T0>(arg0: TeamStream<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 871);
        assert!(arg0.cancelled, 886);
        assert!(0x2::balance::value<T0>(&arg0.pot) == 0, 886);
        let TeamStream {
            id             : v0,
            creator        : _,
            members        : _,
            pot            : v3,
            per_member     : _,
            tranche_total  : _,
            num_tranches   : _,
            tranches_done  : _,
            interval_ms    : _,
            next_due_ms    : _,
            released_total : _,
            cancelled      : _,
        } = arg0;
        0x2::balance::destroy_zero<T0>(v3);
        0x2::object::delete(v0);
    }

    public fun due_tranches<T0>(arg0: &TeamStream<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = arg0.num_tranches - arg0.tranches_done;
        if (arg0.cancelled || v0 == 0) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        if (v1 < arg0.next_due_ms) {
            return 0
        };
        let v2 = (v1 - arg0.next_due_ms) / arg0.interval_ms;
        if (v2 >= v0 - 1) {
            v0
        } else {
            v2 + 1
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TeamStreamRegistry{
            id            : 0x2::object::new(arg0),
            admin         : 0x2::tx_context::sender(arg0),
            paused        : false,
            streams_total : 0,
        };
        0x2::transfer::share_object<TeamStreamRegistry>(v0);
        let v1 = TeamStreamAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TeamStreamAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun interval_ms<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.interval_ms
    }

    public fun is_cancelled<T0>(arg0: &TeamStream<T0>) : bool {
        arg0.cancelled
    }

    public fun is_due<T0>(arg0: &TeamStream<T0>, arg1: &0x2::clock::Clock) : bool {
        if (!arg0.cancelled) {
            if (arg0.tranches_done < arg0.num_tranches) {
                if (0x2::clock::timestamp_ms(arg1) >= arg0.next_due_ms) {
                    0x2::balance::value<T0>(&arg0.pot) >= arg0.tranche_total
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_paused(arg0: &TeamStreamRegistry) : bool {
        arg0.paused
    }

    public fun member_at<T0>(arg0: &TeamStream<T0>, arg1: u64) : address {
        *0x1::vector::borrow<address>(&arg0.members, arg1)
    }

    public fun member_count<T0>(arg0: &TeamStream<T0>) : u64 {
        0x1::vector::length<address>(&arg0.members)
    }

    fun new_stream<T0>(arg0: &mut TeamStreamRegistry, arg1: 0x2::balance::Balance<T0>, arg2: vector<address>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 870);
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 > 0, 877);
        assert!(v0 <= 50, 878);
        assert!(arg3 > 0, 873);
        assert!(arg3 <= 365, 873);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<address>(&arg2, v2);
            assert!(v3 != @0x0, 882);
            assert!(v3 != v1, 881);
            let v4 = v2 + 1;
            while (v4 < v0) {
                assert!(*0x1::vector::borrow<address>(&arg2, v4) != v3, 880);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v5 = 0x2::balance::value<T0>(&arg1);
        let v6 = v5 / arg3 / v0;
        assert!(v6 > 0, 879);
        let v7 = v6 * v0;
        let v8 = v7 * arg3;
        assert!(v5 >= v8, 876);
        let v9 = TeamStream<T0>{
            id             : 0x2::object::new(arg6),
            creator        : v1,
            members        : arg2,
            pot            : arg1,
            per_member     : v6,
            tranche_total  : v7,
            num_tranches   : arg3,
            tranches_done  : 0,
            interval_ms    : arg4,
            next_due_ms    : arg5,
            released_total : 0,
            cancelled      : false,
        };
        let v10 = 0x2::object::id<TeamStream<T0>>(&v9);
        arg0.streams_total = arg0.streams_total + 1;
        let v11 = StreamCreated{
            stream_id     : v10,
            creator       : v1,
            members       : v9.members,
            per_member    : v6,
            tranche_total : v7,
            num_tranches  : arg3,
            interval_ms   : arg4,
            first_due_ms  : arg5,
            funded        : v5,
            dust          : v5 - v8,
        };
        0x2::event::emit<StreamCreated>(v11);
        0x2::transfer::share_object<TeamStream<T0>>(v9);
        v10
    }

    public fun next_due_ms<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.next_due_ms
    }

    public fun num_tranches<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.num_tranches
    }

    public fun per_member<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.per_member
    }

    public fun pot_value<T0>(arg0: &TeamStream<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.pot)
    }

    public fun reclaimable_dust<T0>(arg0: &TeamStream<T0>) : u64 {
        let v0 = 0x2::balance::value<T0>(&arg0.pot);
        let v1 = remaining_obligation<T0>(arg0);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun release_due_tranche<T0>(arg0: &TeamStreamRegistry, arg1: &mut TeamStream<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 870);
        assert!(!arg1.cancelled, 872);
        assert!(arg1.tranches_done < arg1.num_tranches, 875);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.next_due_ms, 874);
        assert!(0x2::balance::value<T0>(&arg1.pot) >= arg1.tranche_total, 876);
        let v1 = arg1.tranches_done;
        arg1.tranches_done = v1 + 1;
        arg1.next_due_ms = arg1.next_due_ms + arg1.interval_ms;
        arg1.released_total = arg1.released_total + arg1.tranche_total;
        let v2 = arg1.per_member;
        let v3 = 0x1::vector::length<address>(&arg1.members);
        let v4 = 0;
        while (v4 < v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.pot, v2), arg3), *0x1::vector::borrow<address>(&arg1.members, v4));
            v4 = v4 + 1;
        };
        let v5 = TrancheReleased{
            stream_id     : 0x2::object::id<TeamStream<T0>>(arg1),
            tranche_index : v1,
            per_member    : v2,
            total         : arg1.tranche_total,
            member_count  : v3,
            caller        : 0x2::tx_context::sender(arg3),
            next_due_ms   : arg1.next_due_ms,
            ts_ms         : v0,
        };
        0x2::event::emit<TrancheReleased>(v5);
    }

    public fun released_total<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.released_total
    }

    public fun remaining_obligation<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.tranche_total * (arg0.num_tranches - arg0.tranches_done)
    }

    public fun set_paused(arg0: &mut TeamStreamRegistry, arg1: &TeamStreamAdminCap, arg2: bool) {
        assert!(arg0.paused != arg2, 885);
        arg0.paused = arg2;
        let v0 = PauseSet{paused: arg2};
        0x2::event::emit<PauseSet>(v0);
    }

    public fun streams_total(arg0: &TeamStreamRegistry) : u64 {
        arg0.streams_total
    }

    public fun tranche_total<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.tranche_total
    }

    public fun tranches_done<T0>(arg0: &TeamStream<T0>) : u64 {
        arg0.tranches_done
    }

    // decompiled from Move bytecode v7
}

