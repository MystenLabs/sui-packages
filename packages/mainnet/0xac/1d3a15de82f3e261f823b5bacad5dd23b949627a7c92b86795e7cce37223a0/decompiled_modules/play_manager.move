module 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PlayEventRank has drop, store {
        user: address,
        point: u64,
    }

    struct PlayEvent has store, key {
        id: 0x2::object::UID,
        key: u64,
        start_time: u64,
        end_time: u64,
        point_in_bp: u64,
        points: 0x2::table::Table<address, u64>,
        ranks: vector<PlayEventRank>,
        total_point: u64,
        rank_tracking_count: u64,
    }

    struct PlayManager has store, key {
        id: 0x2::object::UID,
        play_events: 0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<PlayEvent>>,
        ended_play_events: 0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>,
        current_event_key: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        approved_contracts: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        user_play_count: 0x2::table::Table<address, u64>,
        total_play_count: u64,
        total_spent_amount: u64,
    }

    struct WinPlayHistory has copy, drop {
        game: 0x1::type_name::TypeName,
        user: address,
        spend_amount: u64,
        win_amount: u64,
    }

    entry fun add_approved_contract<T0: drop>(arg0: &mut PlayManager, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.approved_contracts, 0x1::type_name::get<T0>()), 13906834500760895489);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.approved_contracts, 0x1::type_name::get<T0>(), true);
    }

    public fun add_play_event<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &AdminCap, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg6), 13906834599545405445);
        assert!(arg1 < arg2, 13906834603840372741);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.current_event_key, v0)) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.current_event_key, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg0.current_event_key, v0);
        *v1 = *v1 + 1;
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v0)) {
            0x2::linked_table::push_back<0x1::type_name::TypeName, vector<PlayEvent>>(&mut arg0.play_events, v0, 0x1::vector::empty<PlayEvent>());
        };
        let v2 = PlayEvent{
            id                  : 0x2::object::new(arg7),
            key                 : *v1,
            start_time          : arg1,
            end_time            : arg2,
            point_in_bp         : arg3,
            points              : 0x2::table::new<address, u64>(arg7),
            ranks               : 0x1::vector::empty<PlayEventRank>(),
            total_point         : 0,
            rank_tracking_count : arg4,
        };
        0x1::vector::push_back<PlayEvent>(0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<PlayEvent>>(&mut arg0.play_events, v0), v2);
    }

    public fun add_play_event_dynamic_field<T0: copy + drop + store, T1: store, T2: drop>(arg0: &mut PlayManager, arg1: u64, arg2: T0, arg3: T1, arg4: T2) {
        0x2::dynamic_field::add<T0, T1>(&mut borrow_mut_play_event<T2>(arg0, arg1).id, arg2, arg3);
    }

    public fun approved_contracts(arg0: &PlayManager) : &0x2::table::Table<0x1::type_name::TypeName, bool> {
        &arg0.approved_contracts
    }

    fun borrow_mut_play_event<T0: drop>(arg0: &mut PlayManager, arg1: u64) : &mut PlayEvent {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::linked_table::contains<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v0)) {
            let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<PlayEvent>>(&mut arg0.play_events, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<PlayEvent>(v1)) {
                let v3 = 0x1::vector::borrow_mut<PlayEvent>(v1, v2);
                if (v3.key == arg1) {
                    return v3
                };
                v2 = v2 + 1;
            };
        };
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&arg0.ended_play_events, v0), 13906836390546505727);
        let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&mut arg0.ended_play_events, v0);
        assert!(0x2::table::contains<u64, PlayEvent>(v4, arg1), 13906836403431407615);
        0x2::table::borrow_mut<u64, PlayEvent>(v4, arg1)
    }

    public fun borrow_mut_play_event_dynamic_field<T0: copy + drop + store, T1: store, T2: drop>(arg0: &mut PlayManager, arg1: u64, arg2: T0, arg3: T2) : &mut T1 {
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut borrow_mut_play_event<T2>(arg0, arg1).id, arg2)
    }

    public fun borrow_play_event<T0: drop>(arg0: &PlayManager, arg1: u64) : &PlayEvent {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::linked_table::contains<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v0)) {
            let v1 = 0x2::linked_table::borrow<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<PlayEvent>(v1)) {
                let v3 = 0x1::vector::borrow<PlayEvent>(v1, v2);
                if (v3.key == arg1) {
                    return v3
                };
                v2 = v2 + 1;
            };
        };
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&arg0.ended_play_events, v0), 13906835913805135871);
        let v4 = 0x2::table::borrow<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&arg0.ended_play_events, v0);
        assert!(0x2::table::contains<u64, PlayEvent>(v4, arg1), 13906835922395463687);
        0x2::table::borrow<u64, PlayEvent>(v4, arg1)
    }

    public fun cancel_play<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: &T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg3);
        cancel_play_count<T0>(arg0, arg1, arg2, arg3, arg5);
        let v0 = 0x2::linked_table::front<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
            let v1 = *0x1::option::borrow<0x1::type_name::TypeName>(v0);
            decrement_point<T0>(arg0, arg1, arg2, v1, arg3, arg4, arg5);
            v0 = 0x2::linked_table::next<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v1);
        };
    }

    public fun cancel_play_count<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: &T0, arg4: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg3);
        if (arg0.total_play_count > 0) {
            arg0.total_play_count = arg0.total_play_count - 1;
        };
        if (arg0.total_spent_amount >= arg1) {
            arg0.total_spent_amount = arg0.total_spent_amount - arg1;
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_play_count, arg2)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_play_count, arg2);
        *v0 = *v0 - 1;
        if (*v0 == 0) {
            0x2::table::remove<address, u64>(&mut arg0.user_play_count, arg2);
        };
    }

    fun check_approved_contract<T0: drop>(arg0: &PlayManager, arg1: &T0) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.approved_contracts, 0x1::type_name::get<T0>()), 13906836437791277059);
    }

    public fun current_event_key<T0: drop>(arg0: &PlayManager) : 0x1::option::Option<u64> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.current_event_key, v0)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(*0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.current_event_key, v0))
        }
    }

    public fun decrement_point<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: 0x1::type_name::TypeName, arg4: &T0, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg4);
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, arg3)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<PlayEvent>>(&mut arg0.play_events, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<PlayEvent>(v1)) {
            let v3 = 0x1::vector::borrow_mut<PlayEvent>(v1, v2);
            if (v3.start_time > v0) {
                v2 = v2 + 1;
                continue
            };
            if (v3.end_time < v0) {
                let v4 = 0x1::vector::remove<PlayEvent>(v1, v2);
                if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&arg0.ended_play_events, arg3)) {
                    0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&mut arg0.ended_play_events, arg3, 0x2::table::new<u64, PlayEvent>(arg6));
                };
                0x2::table::add<u64, PlayEvent>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&mut arg0.ended_play_events, arg3), v4.key, v4);
                continue
            };
            if (!0x2::table::contains<address, u64>(&v3.points, arg2)) {
                v2 = v2 + 1;
                continue
            };
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut v3.points, arg2);
            let v6 = arg1 / 10000 * v3.point_in_bp;
            *v5 = *v5 - v6;
            let v7 = &mut v3.ranks;
            update_ranks(v7, v3.rank_tracking_count, arg2, *v5);
            if (*v5 == 0) {
                0x2::table::remove<address, u64>(&mut v3.points, arg2);
            };
            v3.total_point = v3.total_point - v6;
            v2 = v2 + 1;
        };
    }

    public fun emit_win_play_history<T0: drop>(arg0: &PlayManager, arg1: address, arg2: u64, arg3: u64, arg4: &T0) {
        check_approved_contract<T0>(arg0, arg4);
        let v0 = WinPlayHistory{
            game         : 0x1::type_name::get<T0>(),
            user         : arg1,
            spend_amount : arg2,
            win_amount   : arg3,
        };
        0x2::event::emit<WinPlayHistory>(v0);
    }

    public fun end_time(arg0: &PlayEvent) : u64 {
        arg0.end_time
    }

    public fun ended_play_events(arg0: &PlayManager) : &0x2::table::Table<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>> {
        &arg0.ended_play_events
    }

    public fun get_user_point(arg0: &PlayEvent, arg1: address) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<address, u64>(&arg0.points, arg1)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.points, arg1))
        }
    }

    public fun get_user_rank(arg0: &PlayEvent, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PlayEventRank>(&arg0.ranks)) {
            if (0x1::vector::borrow<PlayEventRank>(&arg0.ranks, v0).user == arg1) {
                return 0x1::option::some<u64>(v0 + 1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun increment_point<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: 0x1::type_name::TypeName, arg4: &T0, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg4);
        if (!0x2::linked_table::contains<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, arg3)) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::linked_table::borrow_mut<0x1::type_name::TypeName, vector<PlayEvent>>(&mut arg0.play_events, arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<PlayEvent>(v1)) {
            let v3 = 0x1::vector::borrow_mut<PlayEvent>(v1, v2);
            if (v3.start_time > v0) {
                v2 = v2 + 1;
                continue
            };
            if (v3.end_time < v0) {
                let v4 = 0x1::vector::remove<PlayEvent>(v1, v2);
                if (!0x2::table::contains<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&arg0.ended_play_events, arg3)) {
                    0x2::table::add<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&mut arg0.ended_play_events, arg3, 0x2::table::new<u64, PlayEvent>(arg6));
                };
                0x2::table::add<u64, PlayEvent>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(&mut arg0.ended_play_events, arg3), v4.key, v4);
                continue
            };
            if (!0x2::table::contains<address, u64>(&v3.points, arg2)) {
                0x2::table::add<address, u64>(&mut v3.points, arg2, 0);
            };
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut v3.points, arg2);
            let v6 = arg1 / 10000 * v3.point_in_bp;
            *v5 = *v5 + v6;
            v3.total_point = v3.total_point + v6;
            let v7 = &mut v3.ranks;
            update_ranks(v7, v3.rank_tracking_count, arg2, *v5);
            v2 = v2 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayManager{
            id                 : 0x2::object::new(arg0),
            play_events        : 0x2::linked_table::new<0x1::type_name::TypeName, vector<PlayEvent>>(arg0),
            ended_play_events  : 0x2::table::new<0x1::type_name::TypeName, 0x2::table::Table<u64, PlayEvent>>(arg0),
            current_event_key  : 0x2::table::new<0x1::type_name::TypeName, u64>(arg0),
            approved_contracts : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            user_play_count    : 0x2::table::new<address, u64>(arg0),
            total_play_count   : 0,
            total_spent_amount : 0,
        };
        0x2::transfer::share_object<PlayManager>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_ended(arg0: &PlayEvent, arg1: &0x2::clock::Clock) : bool {
        arg0.end_time < 0x2::clock::timestamp_ms(arg1)
    }

    public fun play_events(arg0: &PlayManager) : &0x2::linked_table::LinkedTable<0x1::type_name::TypeName, vector<PlayEvent>> {
        &arg0.play_events
    }

    public fun point_in_bp(arg0: &PlayEvent) : u64 {
        arg0.point_in_bp
    }

    public fun points(arg0: &PlayEvent) : &0x2::table::Table<address, u64> {
        &arg0.points
    }

    public fun rank_point(arg0: &PlayEventRank) : u64 {
        arg0.point
    }

    public fun rank_tracking_count(arg0: &PlayEvent) : u64 {
        arg0.rank_tracking_count
    }

    public fun rank_user(arg0: &PlayEventRank) : address {
        arg0.user
    }

    public fun ranks(arg0: &PlayEvent) : &vector<PlayEventRank> {
        &arg0.ranks
    }

    public fun record_play<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: &T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg3);
        record_play_count<T0>(arg0, arg1, arg2, arg3, arg5);
        let v0 = 0x2::linked_table::front<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events);
        while (0x1::option::is_some<0x1::type_name::TypeName>(v0)) {
            let v1 = *0x1::option::borrow<0x1::type_name::TypeName>(v0);
            increment_point<T0>(arg0, arg1, arg2, v1, arg3, arg4, arg5);
            v0 = 0x2::linked_table::next<0x1::type_name::TypeName, vector<PlayEvent>>(&arg0.play_events, v1);
        };
    }

    public fun record_play_count<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: &T0, arg4: &mut 0x2::tx_context::TxContext) {
        check_approved_contract<T0>(arg0, arg3);
        if (!0x2::table::contains<address, u64>(&arg0.user_play_count, arg2)) {
            0x2::table::add<address, u64>(&mut arg0.user_play_count, arg2, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_play_count, arg2);
        *v0 = *v0 + 1;
        arg0.total_play_count = arg0.total_play_count + 1;
        arg0.total_spent_amount = arg0.total_spent_amount + arg1;
    }

    entry fun remove_approved_contract<T0: drop>(arg0: &mut PlayManager, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.approved_contracts, 0x1::type_name::get<T0>()), 13906834539415732227);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.approved_contracts, 0x1::type_name::get<T0>());
    }

    public fun start_time(arg0: &PlayEvent) : u64 {
        arg0.start_time
    }

    public fun total_play_count(arg0: &PlayManager) : u64 {
        arg0.total_play_count
    }

    public fun total_point(arg0: &PlayEvent) : u64 {
        arg0.total_point
    }

    public fun total_spent_amount(arg0: &PlayManager) : u64 {
        arg0.total_spent_amount
    }

    public fun update_play_event<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &AdminCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_mut_play_event<T0>(arg0, arg1);
        assert!(!is_ended(v0, arg7), 13906834771344359433);
        if (v0.start_time < 0x2::clock::timestamp_ms(arg7)) {
            assert!(v0.start_time == arg2, 13906834788524228617);
            assert!(arg2 < arg3, 13906834792819195913);
            assert!(v0.point_in_bp == arg4, 13906834797114163209);
            assert!(v0.rank_tracking_count == arg5, 13906834801409130505);
        };
        v0.start_time = arg2;
        v0.end_time = arg3;
        v0.point_in_bp = arg4;
        v0.rank_tracking_count = arg5;
    }

    fun update_ranks(arg0: &mut vector<PlayEventRank>, arg1: u64, arg2: address, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PlayEventRank>(arg0)) {
            if (0x1::vector::borrow<PlayEventRank>(arg0, v0).user == arg2) {
                0x1::vector::remove<PlayEventRank>(arg0, v0);
                break
            };
            v0 = v0 + 1;
        };
        if (arg3 == 0) {
            return
        };
        if (0x1::vector::length<PlayEventRank>(arg0) >= arg1) {
            if (0x1::vector::borrow<PlayEventRank>(arg0, 0x1::vector::length<PlayEventRank>(arg0) - 1).point >= arg3) {
                return
            };
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<PlayEventRank>(arg0)) {
            if (arg3 > 0x1::vector::borrow<PlayEventRank>(arg0, v1).point) {
                let v2 = PlayEventRank{
                    user  : arg2,
                    point : arg3,
                };
                0x1::vector::insert<PlayEventRank>(arg0, v2, v1);
                break
            };
            v1 = v1 + 1;
        };
        if (v1 == 0x1::vector::length<PlayEventRank>(arg0)) {
            let v3 = PlayEventRank{
                user  : arg2,
                point : arg3,
            };
            0x1::vector::push_back<PlayEventRank>(arg0, v3);
        };
        while (0x1::vector::length<PlayEventRank>(arg0) > arg1) {
            0x1::vector::pop_back<PlayEventRank>(arg0);
        };
    }

    public fun user_play_count(arg0: &PlayManager) : &0x2::table::Table<address, u64> {
        &arg0.user_play_count
    }

    // decompiled from Move bytecode v6
}

