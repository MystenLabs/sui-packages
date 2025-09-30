module 0x867c4a77e09e7a9a1bf73c1627bdaeea22374def79e9dda440d861e9d08ccf0b::manager {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct UserRank has drop, store {
        user: address,
        point: u64,
    }

    struct UserParticipantHistory has store {
        user: address,
        event_keys: vector<u64>,
        participated_map: 0x2::table::Table<u64, bool>,
    }

    struct UserPlayActivity has store {
        user: address,
        play_count: u64,
        bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
    }

    struct Event has store, key {
        id: 0x2::object::UID,
        key: u64,
        start_time: u64,
        end_time: u64,
        point_in_bp: u64,
        points: 0x2::table::Table<address, u64>,
        ranks: vector<UserRank>,
        total_point: u64,
        ranked_users_count: u64,
    }

    struct EventGroup has store {
        event_type: 0x1::type_name::TypeName,
        name: 0x1::string::String,
        active_events: vector<Event>,
        ended_events: 0x2::table::Table<u64, Event>,
        ended_event_keys: vector<u64>,
        current_event_key: u64,
        increment_point_with_play: bool,
        user_participation_histories: 0x2::table::Table<address, UserParticipantHistory>,
    }

    struct PlayManager has store, key {
        id: 0x2::object::UID,
        event_groups: 0x2::linked_table::LinkedTable<0x1::string::String, EventGroup>,
        authorized_contracts: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        user_play_activities: 0x2::table::Table<address, UserPlayActivity>,
        total_play_count: u64,
        total_bet_amount: u64,
        is_migrated: bool,
    }

    struct PlayHistory has copy, drop {
        game: 0x1::type_name::TypeName,
        player: 0x1::string::String,
        object_id: 0x1::string::String,
        bet_amount: u64,
        win_amount: u64,
        payout_amount: u64,
    }

    public fun get_user_point(arg0: &Event, arg1: address) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<address, u64>(&arg0.points, arg1)) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.points, arg1))
        }
    }

    entry fun add_authorized_contract<T0: drop>(arg0: &mut PlayManager, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.authorized_contracts, 0x1::type_name::get<T0>()), 13906834616725012481);
        0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.authorized_contracts, 0x1::type_name::get<T0>(), true);
    }

    public fun add_event<T0: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &AdminCap, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg7), 13906834719804489733);
        assert!(arg2 < arg3, 13906834724099457029);
        let v0 = create_event_group_key(0x1::type_name::get<T0>(), arg1);
        if (!0x2::linked_table::contains<0x1::string::String, EventGroup>(&arg0.event_groups, v0)) {
            let v1 = EventGroup{
                event_type                   : 0x1::type_name::get<T0>(),
                name                         : 0x1::string::utf8(arg1),
                active_events                : 0x1::vector::empty<Event>(),
                ended_events                 : 0x2::table::new<u64, Event>(arg8),
                ended_event_keys             : 0x1::vector::empty<u64>(),
                current_event_key            : 0,
                increment_point_with_play    : true,
                user_participation_histories : 0x2::table::new<address, UserParticipantHistory>(arg8),
            };
            0x2::linked_table::push_back<0x1::string::String, EventGroup>(&mut arg0.event_groups, v0, v1);
        };
        let v2 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, v0);
        v2.current_event_key = v2.current_event_key + 1;
        let v3 = Event{
            id                 : 0x2::object::new(arg8),
            key                : v2.current_event_key,
            start_time         : arg2,
            end_time           : arg3,
            point_in_bp        : arg4,
            points             : 0x2::table::new<address, u64>(arg8),
            ranks              : 0x1::vector::empty<UserRank>(),
            total_point        : 0,
            ranked_users_count : arg5,
        };
        0x1::vector::push_back<Event>(&mut v2.active_events, v3);
    }

    public fun add_event_dynamic_field<T0: copy + drop + store, T1: store, T2: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: u64, arg3: T0, arg4: T1, arg5: T2) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::get<T2>(), arg1));
        0x2::dynamic_field::add<T0, T1>(&mut borrow_mut_event(v0, arg2).id, arg3, arg4);
    }

    public fun borrow_event<T0: drop>(arg0: &EventGroup, arg1: u64, arg2: T0) : &Event {
        assert!(arg0.event_type == 0x1::type_name::get<T0>(), 13906836214452977667);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Event>(&arg0.active_events)) {
            let v1 = 0x1::vector::borrow<Event>(&arg0.active_events, v0);
            if (v1.key == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        0x2::table::borrow<u64, Event>(&arg0.ended_events, arg1)
    }

    public fun borrow_event_dynamic_field<T0: copy + drop + store, T1: store, T2: drop>(arg0: &PlayManager, arg1: vector<u8>, arg2: u64, arg3: T0, arg4: T2) : &T1 {
        0x2::dynamic_field::borrow<T0, T1>(&borrow_event<T2>(0x2::linked_table::borrow<0x1::string::String, EventGroup>(&arg0.event_groups, create_event_group_key(0x1::type_name::get<T2>(), arg1)), arg2, arg4).id, arg3)
    }

    public fun borrow_event_group<T0: drop>(arg0: &PlayManager, arg1: vector<u8>, arg2: T0) : &EventGroup {
        0x2::linked_table::borrow<0x1::string::String, EventGroup>(&arg0.event_groups, create_event_group_key(0x1::type_name::get<T0>(), arg1))
    }

    fun borrow_mut_active_event(arg0: &mut EventGroup, arg1: u64, arg2: &0x2::clock::Clock) : &mut Event {
        let v0 = borrow_mut_event(arg0, arg1);
        assert!(!is_ended(v0, arg2), 13906836536575787015);
        v0
    }

    fun borrow_mut_event(arg0: &mut EventGroup, arg1: u64) : &mut Event {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Event>(&arg0.active_events)) {
            let v1 = 0x1::vector::borrow_mut<Event>(&mut arg0.active_events, v0);
            if (v1.key == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        0x2::table::borrow_mut<u64, Event>(&mut arg0.ended_events, arg1)
    }

    public fun borrow_mut_event_dynamic_field<T0: copy + drop + store, T1: store, T2: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: u64, arg3: T0, arg4: T2) : &mut T1 {
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::get<T2>(), arg1));
        0x2::dynamic_field::borrow_mut<T0, T1>(&mut borrow_mut_event(v0, arg2).id, arg3)
    }

    fun check_authorized_contract<T0: drop>(arg0: &PlayManager, arg1: &T0) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.authorized_contracts, 0x1::type_name::get<T0>()), 13906836643949707267);
    }

    fun create_event_group_key(arg0: 0x1::type_name::TypeName, arg1: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"::"));
        0x1::string::append(&mut v0, 0x1::string::utf8(arg1));
        v0
    }

    public fun current_event_key(arg0: &EventGroup) : u64 {
        arg0.current_event_key
    }

    public fun emit_play_history<T0: drop>(arg0: &mut PlayManager, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: &T0) {
        check_authorized_contract<T0>(arg0, arg6);
        let v0 = PlayHistory{
            game          : 0x1::type_name::get<T0>(),
            player        : arg2,
            object_id     : arg1,
            bet_amount    : arg3,
            win_amount    : arg4,
            payout_amount : arg5,
        };
        0x2::event::emit<PlayHistory>(v0);
    }

    public fun event_keys(arg0: &UserParticipantHistory) : &vector<u64> {
        &arg0.event_keys
    }

    public fun get_user_rank(arg0: &Event, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UserRank>(&arg0.ranks)) {
            if (0x1::vector::borrow<UserRank>(&arg0.ranks, v0).user == arg1) {
                return 0x1::option::some<u64>(v0 + 1)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun increment_point<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: 0x1::type_name::TypeName, arg4: vector<u8>, arg5: &T0, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        check_authorized_contract<T0>(arg0, arg5);
        let v0 = create_event_group_key(arg3, arg4);
        if (!0x2::linked_table::contains<0x1::string::String, EventGroup>(&arg0.event_groups, v0)) {
            return
        };
        let v1 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, v0);
        let v2 = &mut v1.active_events;
        let v3 = 0x2::clock::timestamp_ms(arg6);
        let v4 = 0;
        while (v4 < 0x1::vector::length<Event>(v2)) {
            let v5 = 0x1::vector::borrow_mut<Event>(v2, v4);
            if (v5.start_time > v3) {
                v4 = v4 + 1;
                continue
            };
            if (v5.end_time < v3) {
                let v6 = 0x1::vector::remove<Event>(v2, v4);
                0x1::vector::push_back<u64>(&mut v1.ended_event_keys, v6.key);
                0x2::table::add<u64, Event>(&mut v1.ended_events, v6.key, v6);
                continue
            };
            if (!0x2::table::contains<address, u64>(&v5.points, arg2)) {
                0x2::table::add<address, u64>(&mut v5.points, arg2, 0);
            };
            let v7 = 0x2::table::borrow_mut<address, u64>(&mut v5.points, arg2);
            let v8 = arg1 / 10000 * v5.point_in_bp;
            *v7 = *v7 + v8;
            v5.total_point = v5.total_point + v8;
            let v9 = &mut v1.user_participation_histories;
            update_user_participation_history(v9, v5.key, arg2, arg7);
            let v10 = &mut v5.ranks;
            update_ranks(v10, v5.ranked_users_count, arg2, *v7);
            v4 = v4 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayManager{
            id                   : 0x2::object::new(arg0),
            event_groups         : 0x2::linked_table::new<0x1::string::String, EventGroup>(arg0),
            authorized_contracts : 0x2::table::new<0x1::type_name::TypeName, bool>(arg0),
            user_play_activities : 0x2::table::new<address, UserPlayActivity>(arg0),
            total_play_count     : 0,
            total_bet_amount     : 0,
            is_migrated          : false,
        };
        0x2::transfer::share_object<PlayManager>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_ended(arg0: &Event, arg1: &0x2::clock::Clock) : bool {
        arg0.end_time < 0x2::clock::timestamp_ms(arg1)
    }

    entry fun migrate_basic_data(arg0: &mut PlayManager, arg1: &0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: &AdminCap, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.is_migrated, 13906837021907353611);
        arg0.total_play_count = arg0.total_play_count + 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::total_play_count(arg1);
        arg0.total_bet_amount = arg0.total_bet_amount + 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::total_spent_amount(arg1);
        arg0.is_migrated = true;
    }

    entry fun migrate_user_play_activity(arg0: &mut PlayManager, arg1: &0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: address, arg3: &AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserPlayActivity>(&arg0.user_play_activities, arg2)) {
            let v0 = UserPlayActivity{
                user          : arg2,
                play_count    : 0,
                bet_amount    : 0,
                win_amount    : 0,
                payout_amount : 0,
            };
            0x2::table::add<address, UserPlayActivity>(&mut arg0.user_play_activities, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserPlayActivity>(&mut arg0.user_play_activities, arg2);
        v1.play_count = v1.play_count + *0x2::table::borrow<address, u64>(0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::user_play_count(arg1), arg2);
    }

    entry fun migrate_user_point<T0: drop, T1: drop>(arg0: &mut PlayManager, arg1: &0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::PlayManager, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: address, arg6: &AdminCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::get_user_point(0x15f9a9074a801634490cd688f66b2235d0eca971556d1e43a7ffa48c3ded2df8::play_manager::borrow_play_event<T1>(arg1, arg3), arg5);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = *0x1::option::borrow<u64>(&v0);
        let v2 = v1;
        let v3 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::get<T0>(), arg2));
        let v4 = borrow_mut_event(v3, arg4);
        v4.total_point = v4.total_point + v1;
        if (!0x2::table::contains<address, u64>(&v4.points, arg5)) {
            0x2::table::add<address, u64>(&mut v4.points, arg5, v1);
        } else {
            let v5 = 0x2::table::borrow_mut<address, u64>(&mut v4.points, arg5);
            *v5 = *v5 + v1;
            v2 = *v5;
        };
        let v6 = &mut v4.ranks;
        update_ranks(v6, v4.ranked_users_count, arg5, v2);
        let v7 = &mut v3.user_participation_histories;
        update_user_participation_history(v7, arg4, arg5, arg7);
    }

    public fun participated_map(arg0: &UserParticipantHistory) : &0x2::table::Table<u64, bool> {
        &arg0.participated_map
    }

    public fun points(arg0: &Event) : &0x2::table::Table<address, u64> {
        &arg0.points
    }

    public fun ranks(arg0: &Event) : &vector<UserRank> {
        &arg0.ranks
    }

    public fun record_play<T0: drop>(arg0: &mut PlayManager, arg1: u64, arg2: address, arg3: &T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_authorized_contract<T0>(arg0, arg3);
        record_play_activity<T0>(arg0, true, arg1, 0, 0, arg2, arg3);
        let v0 = 0x2::linked_table::front<0x1::string::String, EventGroup>(&arg0.event_groups);
        while (0x1::option::is_some<0x1::string::String>(v0)) {
            let v1 = *0x1::option::borrow<0x1::string::String>(v0);
            let v2 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, v1);
            if (v2.increment_point_with_play) {
                increment_point<T0>(arg0, arg1, arg2, v2.event_type, *0x1::string::as_bytes(&v2.name), arg3, arg4, arg5);
            };
            v0 = 0x2::linked_table::next<0x1::string::String, EventGroup>(&arg0.event_groups, v1);
        };
    }

    public fun record_play_activity<T0: drop>(arg0: &mut PlayManager, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &T0) {
        check_authorized_contract<T0>(arg0, arg6);
        if (!0x2::table::contains<address, UserPlayActivity>(&arg0.user_play_activities, arg5)) {
            let v0 = UserPlayActivity{
                user          : arg5,
                play_count    : 0,
                bet_amount    : 0,
                win_amount    : 0,
                payout_amount : 0,
            };
            0x2::table::add<address, UserPlayActivity>(&mut arg0.user_play_activities, arg5, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserPlayActivity>(&mut arg0.user_play_activities, arg5);
        if (arg1) {
            v1.play_count = v1.play_count + 1;
            arg0.total_play_count = arg0.total_play_count + 1;
        };
        v1.bet_amount = v1.bet_amount + arg2;
        v1.win_amount = v1.win_amount + arg3;
        v1.payout_amount = v1.payout_amount + arg4;
        arg0.total_bet_amount = arg0.total_bet_amount + arg2;
    }

    entry fun remove_authorized_contract<T0: drop>(arg0: &mut PlayManager, arg1: &AdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.authorized_contracts, 0x1::type_name::get<T0>()), 13906834655379849219);
        0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.authorized_contracts, 0x1::type_name::get<T0>());
    }

    entry fun remove_rank<T0: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &AdminCap, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::with_defining_ids<T0>(), arg1));
        let v1 = borrow_mut_event(v0, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<UserRank>(&v1.ranks)) {
            if (0x1::vector::borrow<UserRank>(&v1.ranks, v2).user == arg3) {
                0x1::vector::remove<UserRank>(&mut v1.ranks, v2);
                break
            };
            v2 = v2 + 1;
        };
        if (0x2::table::contains<address, u64>(&v1.points, arg3)) {
            0x2::table::remove<address, u64>(&mut v1.points, arg3);
        };
    }

    public fun total_point(arg0: &Event) : u64 {
        arg0.total_point
    }

    entry fun update_event<T0: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &AdminCap, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::with_defining_ids<T0>(), arg1));
        let v1 = borrow_mut_active_event(v0, arg2, arg8);
        if (v1.start_time < 0x2::clock::timestamp_ms(arg8)) {
            assert!(v1.start_time == arg3, 13906835016157495305);
            assert!(arg3 < arg4, 13906835020452462601);
            assert!(v1.point_in_bp == arg5, 13906835024747429897);
            assert!(v1.ranked_users_count == arg6, 13906835029042397193);
        };
        v1.start_time = arg3;
        v1.end_time = arg4;
        v1.point_in_bp = arg5;
        v1.ranked_users_count = arg6;
    }

    entry fun update_event_group<T0: drop>(arg0: &mut PlayManager, arg1: vector<u8>, arg2: bool, arg3: &AdminCap, arg4: &0x2::tx_context::TxContext) {
        0x2::linked_table::borrow_mut<0x1::string::String, EventGroup>(&mut arg0.event_groups, create_event_group_key(0x1::type_name::get<T0>(), arg1)).increment_point_with_play = arg2;
    }

    fun update_ranks(arg0: &mut vector<UserRank>, arg1: u64, arg2: address, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UserRank>(arg0)) {
            if (0x1::vector::borrow<UserRank>(arg0, v0).user == arg2) {
                0x1::vector::remove<UserRank>(arg0, v0);
                break
            };
            v0 = v0 + 1;
        };
        if (arg3 == 0) {
            return
        };
        if (0x1::vector::length<UserRank>(arg0) >= arg1) {
            if (0x1::vector::borrow<UserRank>(arg0, 0x1::vector::length<UserRank>(arg0) - 1).point >= arg3) {
                return
            };
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<UserRank>(arg0)) {
            if (arg3 > 0x1::vector::borrow<UserRank>(arg0, v1).point) {
                let v2 = UserRank{
                    user  : arg2,
                    point : arg3,
                };
                0x1::vector::insert<UserRank>(arg0, v2, v1);
                break
            };
            v1 = v1 + 1;
        };
        if (v1 == 0x1::vector::length<UserRank>(arg0)) {
            let v3 = UserRank{
                user  : arg2,
                point : arg3,
            };
            0x1::vector::push_back<UserRank>(arg0, v3);
        };
        while (0x1::vector::length<UserRank>(arg0) > arg1) {
            0x1::vector::pop_back<UserRank>(arg0);
        };
    }

    fun update_user_participation_history(arg0: &mut 0x2::table::Table<address, UserParticipantHistory>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, UserParticipantHistory>(arg0, arg2)) {
            let v0 = UserParticipantHistory{
                user             : arg2,
                event_keys       : 0x1::vector::empty<u64>(),
                participated_map : 0x2::table::new<u64, bool>(arg3),
            };
            0x2::table::add<address, UserParticipantHistory>(arg0, arg2, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, UserParticipantHistory>(arg0, arg2);
        let v2 = &mut v1.participated_map;
        if (!0x2::table::contains<u64, bool>(v2, arg1)) {
            0x2::table::add<u64, bool>(v2, arg1, true);
            0x1::vector::push_back<u64>(&mut v1.event_keys, arg1);
        };
    }

    public fun user_participation_histories(arg0: &EventGroup) : &0x2::table::Table<address, UserParticipantHistory> {
        &arg0.user_participation_histories
    }

    // decompiled from Move bytecode v6
}

