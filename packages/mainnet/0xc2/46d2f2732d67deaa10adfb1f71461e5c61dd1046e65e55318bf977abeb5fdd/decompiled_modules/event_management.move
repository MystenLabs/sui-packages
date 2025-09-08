module 0xc246d2f2732d67deaa10adfb1f71461e5c61dd1046e65e55318bf977abeb5fdd::event_management {
    struct Event has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        location: 0x1::string::String,
        start_time: u64,
        end_time: u64,
        capacity: u64,
        current_attendees: u64,
        organizer: address,
        sponsors: vector<0x1::string::String>,
        assignee: 0x1::string::String,
        is_child: bool,
        parent_id: 0x2::object::ID,
        state: u8,
        created_at: u64,
        sponsor_conditions: SponsorConditions,
        metadata_uri: 0x1::string::String,
        fee_amount: u64,
    }

    struct SponsorConditions has copy, drop, store {
        min_attendees: u64,
        min_completion_rate: u64,
        min_avg_rating: u64,
        custom_benchmarks: vector<CustomBenchmark>,
    }

    struct CustomBenchmark has copy, drop, store {
        metric_name: 0x1::string::String,
        target_value: u64,
        comparison_type: u8,
    }

    struct Profile has store, key {
        id: 0x2::object::UID,
        address: address,
        name: 0x1::string::String,
        bio: 0x1::string::String,
        photo_url: 0x1::string::String,
        telegram_username: 0x1::string::String,
        x_username: 0x1::string::String,
        created_at: u64,
    }

    struct ProfileCap has store, key {
        id: 0x2::object::UID,
        profile_id: 0x2::object::ID,
        owner: address,
    }

    struct OrganizerProfile has store, key {
        id: 0x2::object::UID,
        address: address,
        total_events: u64,
        successful_events: u64,
        total_attendees_served: u64,
        avg_rating: u64,
        created_at: u64,
    }

    struct ProfileRegistry has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<address, 0x2::object::ID>,
        x_to_address: 0x2::table::Table<0x1::string::String, address>,
        telegram_to_address: 0x2::table::Table<0x1::string::String, address>,
    }

    struct EventRegistry has key {
        id: 0x2::object::UID,
        events: 0x2::table::Table<0x2::object::ID, EventInfo>,
        events_by_organizer: 0x2::table::Table<address, vector<0x2::object::ID>>,
        events_by_assignee: 0x2::table::Table<0x1::string::String, vector<0x2::object::ID>>,
        events_by_parent: 0x2::table::Table<0x2::object::ID, vector<0x2::object::ID>>,
    }

    struct EventInfo has copy, drop, store {
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        start_time: u64,
        organizer: address,
        state: u8,
    }

    struct OrganizerCap has store, key {
        id: 0x2::object::UID,
        profile_id: 0x2::object::ID,
    }

    struct EventCreated has copy, drop {
        event_id: 0x2::object::ID,
        name: 0x1::string::String,
        organizer: address,
        start_time: u64,
        capacity: u64,
    }

    struct EventActivated has copy, drop {
        event_id: 0x2::object::ID,
        activated_at: u64,
    }

    struct EventCompleted has copy, drop {
        event_id: 0x2::object::ID,
        total_attendees: u64,
        completed_at: u64,
    }

    public fun activate_event(arg0: &mut Event, arg1: &0x2::clock::Clock, arg2: &mut EventRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg3), 1);
        assert!(arg0.state == 0, 2);
        arg0.state = 1;
        0x2::table::borrow_mut<0x2::object::ID, EventInfo>(&mut arg2.events, 0x2::object::id<Event>(arg0)).state = 1;
        let v0 = EventActivated{
            event_id     : 0x2::object::id<Event>(arg0),
            activated_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventActivated>(v0);
    }

    public fun add_custom_benchmark(arg0: &mut Event, arg1: 0x1::string::String, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.state == 0, 2);
        let v0 = CustomBenchmark{
            metric_name     : arg1,
            target_value    : arg2,
            comparison_type : arg3,
        };
        0x1::vector::push_back<CustomBenchmark>(&mut arg0.sponsor_conditions.custom_benchmarks, v0);
    }

    public fun complete_event(arg0: &mut Event, arg1: &0x2::clock::Clock, arg2: &mut EventRegistry, arg3: &mut OrganizerProfile, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.state == 1, 2);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 3);
        arg0.state = 2;
        0x2::table::borrow_mut<0x2::object::ID, EventInfo>(&mut arg2.events, 0x2::object::id<Event>(arg0)).state = 2;
        arg3.total_attendees_served = arg3.total_attendees_served + arg0.current_attendees;
        let v0 = EventCompleted{
            event_id        : 0x2::object::id<Event>(arg0),
            total_attendees : arg0.current_attendees,
            completed_at    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventCompleted>(v0);
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: vector<0x1::string::String>, arg12: 0x1::string::String, arg13: bool, arg14: 0x2::object::ID, arg15: &0x2::clock::Clock, arg16: &mut EventRegistry, arg17: &mut OrganizerProfile, arg18: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg18);
        assert!(arg17.address == v0, 1);
        assert!(arg5 > 0, 4);
        assert!(arg3 > 0x2::clock::timestamp_ms(arg15), 5);
        assert!(arg4 > arg3, 5);
        let v1 = SponsorConditions{
            min_attendees       : arg7,
            min_completion_rate : arg8,
            min_avg_rating      : arg9,
            custom_benchmarks   : 0x1::vector::empty<CustomBenchmark>(),
        };
        let v2 = Event{
            id                 : 0x2::object::new(arg18),
            name               : arg0,
            description        : arg1,
            location           : arg2,
            start_time         : arg3,
            end_time           : arg4,
            capacity           : arg5,
            current_attendees  : 0,
            organizer          : v0,
            sponsors           : arg11,
            assignee           : arg12,
            is_child           : arg13,
            parent_id          : arg14,
            state              : 0,
            created_at         : 0x2::clock::timestamp_ms(arg15),
            sponsor_conditions : v1,
            metadata_uri       : arg10,
            fee_amount         : arg6,
        };
        let v3 = 0x2::object::id<Event>(&v2);
        if (!arg13) {
            v2.parent_id = v3;
        };
        let v4 = EventInfo{
            event_id   : v3,
            name       : v2.name,
            start_time : v2.start_time,
            organizer  : v2.organizer,
            state      : v2.state,
        };
        0x2::table::add<0x2::object::ID, EventInfo>(&mut arg16.events, v3, v4);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg16.events_by_organizer, v0)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg16.events_by_organizer, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg16.events_by_organizer, v0), v3);
        if (!0x1::string::is_empty(&arg12) && arg12 != 0x1::string::utf8(b"self")) {
            if (!0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg16.events_by_assignee, arg12)) {
                0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(&mut arg16.events_by_assignee, arg12, 0x1::vector::empty<0x2::object::ID>());
            };
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg16.events_by_assignee, arg12), v3);
        };
        if (arg13) {
            if (!0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg16.events_by_parent, arg14)) {
                0x2::table::add<0x2::object::ID, vector<0x2::object::ID>>(&mut arg16.events_by_parent, arg14, 0x1::vector::empty<0x2::object::ID>());
            };
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg16.events_by_parent, arg14), v3);
        };
        arg17.total_events = arg17.total_events + 1;
        let v5 = EventCreated{
            event_id   : v3,
            name       : v2.name,
            organizer  : v2.organizer,
            start_time : v2.start_time,
            capacity   : v2.capacity,
        };
        0x2::event::emit<EventCreated>(v5);
        0x2::transfer::share_object<Event>(v2);
        v3
    }

    public fun create_organizer_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : OrganizerCap {
        let v0 = OrganizerProfile{
            id                     : 0x2::object::new(arg1),
            address                : 0x2::tx_context::sender(arg1),
            total_events           : 0,
            successful_events      : 0,
            total_attendees_served : 0,
            avg_rating             : 0,
            created_at             : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::transfer::share_object<OrganizerProfile>(v0);
        OrganizerCap{
            id         : 0x2::object::new(arg1),
            profile_id : 0x2::object::id<OrganizerProfile>(&v0),
        }
    }

    public fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut ProfileRegistry, arg7: &mut 0x2::tx_context::TxContext) : ProfileCap {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg6.profiles, v0), 0);
        if (!0x1::string::is_empty(&arg4)) {
            assert!(!0x2::table::contains<0x1::string::String, address>(&arg6.x_to_address, arg4), 8);
        };
        if (!0x1::string::is_empty(&arg3)) {
            assert!(!0x2::table::contains<0x1::string::String, address>(&arg6.telegram_to_address, arg3), 9);
        };
        let v1 = Profile{
            id                : 0x2::object::new(arg7),
            address           : v0,
            name              : arg0,
            bio               : arg1,
            photo_url         : arg2,
            telegram_username : arg3,
            x_username        : arg4,
            created_at        : 0x2::clock::timestamp_ms(arg5),
        };
        let v2 = 0x2::object::id<Profile>(&v1);
        0x2::table::add<address, 0x2::object::ID>(&mut arg6.profiles, v0, v2);
        if (!0x1::string::is_empty(&arg4)) {
            0x2::table::add<0x1::string::String, address>(&mut arg6.x_to_address, arg4, v0);
        };
        if (!0x1::string::is_empty(&arg3)) {
            0x2::table::add<0x1::string::String, address>(&mut arg6.telegram_to_address, arg3, v0);
        };
        0x2::transfer::share_object<Profile>(v1);
        ProfileCap{
            id         : 0x2::object::new(arg7),
            profile_id : v2,
            owner      : v0,
        }
    }

    public fun delete_event(arg0: Event, arg1: &mut EventRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg2), 1);
        assert!(arg0.state == 0, 2);
        assert!(arg0.current_attendees == 0, 4);
        let v0 = 0x2::object::id<Event>(&arg0);
        0x2::table::remove<0x2::object::ID, EventInfo>(&mut arg1.events, v0);
        let v1 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg1.events_by_organizer, arg0.organizer);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(v1, &v0);
        if (v2) {
            0x1::vector::remove<0x2::object::ID>(v1, v3);
        };
        if (!0x1::string::is_empty(&arg0.assignee) && arg0.assignee != 0x1::string::utf8(b"self")) {
            if (0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg1.events_by_assignee, arg0.assignee)) {
                let v4 = 0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg1.events_by_assignee, arg0.assignee);
                let (v5, v6) = 0x1::vector::index_of<0x2::object::ID>(v4, &v0);
                if (v5) {
                    0x1::vector::remove<0x2::object::ID>(v4, v6);
                };
            };
        };
        if (arg0.is_child) {
            if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg1.events_by_parent, arg0.parent_id)) {
                let v7 = 0x2::table::borrow_mut<0x2::object::ID, vector<0x2::object::ID>>(&mut arg1.events_by_parent, arg0.parent_id);
                let (v8, v9) = 0x1::vector::index_of<0x2::object::ID>(v7, &v0);
                if (v8) {
                    0x1::vector::remove<0x2::object::ID>(v7, v9);
                };
            };
        };
        let Event {
            id                 : v10,
            name               : _,
            description        : _,
            location           : _,
            start_time         : _,
            end_time           : _,
            capacity           : _,
            current_attendees  : _,
            organizer          : _,
            sponsors           : _,
            assignee           : _,
            is_child           : _,
            parent_id          : _,
            state              : _,
            created_at         : _,
            sponsor_conditions : _,
            metadata_uri       : _,
            fee_amount         : _,
        } = arg0;
        0x2::object::delete(v10);
    }

    public fun edit_event(arg0: &mut Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut EventRegistry, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg11), 1);
        assert!(arg0.state != 2 && arg0.state != 3, 3);
        assert!(arg6 > 0, 4);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg9), 5);
        assert!(arg5 > arg4, 5);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.location = arg3;
        arg0.start_time = arg4;
        arg0.end_time = arg5;
        arg0.capacity = arg6;
        arg0.fee_amount = arg7;
        arg0.metadata_uri = arg8;
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, EventInfo>(&mut arg10.events, 0x2::object::id<Event>(arg0));
        v0.name = arg1;
        v0.start_time = arg4;
    }

    public fun event_exists(arg0: &EventRegistry, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, EventInfo>(&arg0.events, arg1)
    }

    public fun get_address_from_telegram(arg0: &ProfileRegistry, arg1: 0x1::string::String) : address {
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.telegram_to_address, arg1), 11);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.telegram_to_address, arg1)
    }

    public fun get_address_from_x(arg0: &ProfileRegistry, arg1: 0x1::string::String) : address {
        assert!(0x2::table::contains<0x1::string::String, address>(&arg0.x_to_address, arg1), 10);
        *0x2::table::borrow<0x1::string::String, address>(&arg0.x_to_address, arg1)
    }

    public fun get_benchmark_comparison_type(arg0: &CustomBenchmark) : u8 {
        arg0.comparison_type
    }

    public fun get_benchmark_metric_name(arg0: &CustomBenchmark) : 0x1::string::String {
        arg0.metric_name
    }

    public fun get_benchmark_target_value(arg0: &CustomBenchmark) : u64 {
        arg0.target_value
    }

    public fun get_child_events(arg0: &EventRegistry, arg1: 0x2::object::ID) : vector<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, vector<0x2::object::ID>>(&arg0.events_by_parent, arg1)) {
            *0x2::table::borrow<0x2::object::ID, vector<0x2::object::ID>>(&arg0.events_by_parent, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_condition_details(arg0: &SponsorConditions) : (u64, u64, u64, u64) {
        (arg0.min_attendees, arg0.min_completion_rate, arg0.min_avg_rating, 0x1::vector::length<CustomBenchmark>(&arg0.custom_benchmarks))
    }

    public fun get_current_attendees(arg0: &Event) : u64 {
        arg0.current_attendees
    }

    public fun get_custom_benchmarks(arg0: &SponsorConditions) : &vector<CustomBenchmark> {
        &arg0.custom_benchmarks
    }

    public fun get_event_assignee(arg0: &Event) : 0x1::string::String {
        arg0.assignee
    }

    public fun get_event_by_id(arg0: &EventRegistry, arg1: 0x2::object::ID) : EventInfo {
        assert!(0x2::table::contains<0x2::object::ID, EventInfo>(&arg0.events, arg1), 7);
        *0x2::table::borrow<0x2::object::ID, EventInfo>(&arg0.events, arg1)
    }

    public fun get_event_capacity(arg0: &Event) : u64 {
        arg0.capacity
    }

    public fun get_event_fee_amount(arg0: &Event) : u64 {
        arg0.fee_amount
    }

    public fun get_event_id(arg0: &Event) : 0x2::object::ID {
        0x2::object::id<Event>(arg0)
    }

    public fun get_event_info_fields(arg0: &EventRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, 0x1::string::String, u64, address, u8) {
        let v0 = 0x2::table::borrow<0x2::object::ID, EventInfo>(&arg0.events, arg1);
        (v0.event_id, v0.name, v0.start_time, v0.organizer, v0.state)
    }

    public fun get_event_location(arg0: &Event) : 0x1::string::String {
        arg0.location
    }

    public fun get_event_metadata_uri(arg0: &Event) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun get_event_organizer(arg0: &Event) : address {
        arg0.organizer
    }

    public fun get_event_sponsor_conditions(arg0: &Event) : (u64, u64, u64, u64) {
        let v0 = &arg0.sponsor_conditions;
        (v0.min_attendees, v0.min_completion_rate, v0.min_avg_rating, 0x1::vector::length<CustomBenchmark>(&v0.custom_benchmarks))
    }

    public fun get_event_state(arg0: &Event) : u8 {
        arg0.state
    }

    public fun get_event_timing(arg0: &Event) : (u64, u64, u64) {
        (arg0.start_time, arg0.end_time, arg0.created_at)
    }

    public fun get_events_assigned_to_user(arg0: &EventRegistry, arg1: 0x1::string::String) : vector<0x2::object::ID> {
        if (0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg0.events_by_assignee, arg1)) {
            *0x2::table::borrow<0x1::string::String, vector<0x2::object::ID>>(&arg0.events_by_assignee, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_organizer_event_ids(arg0: &EventRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.events_by_organizer, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.events_by_organizer, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_organizer_profile(arg0: &OrganizerProfile) : (address, u64, u64, u64, u64) {
        (arg0.address, arg0.total_events, arg0.successful_events, arg0.total_attendees_served, arg0.avg_rating)
    }

    public fun get_organizer_stats(arg0: &OrganizerProfile) : (u64, u64, u64, u64) {
        (arg0.total_events, arg0.successful_events, arg0.total_attendees_served, arg0.avg_rating)
    }

    public fun get_profile_bio(arg0: &Profile) : 0x1::string::String {
        arg0.bio
    }

    public fun get_profile_cap_details(arg0: &ProfileCap) : (0x2::object::ID, address) {
        (arg0.profile_id, arg0.owner)
    }

    public fun get_profile_details(arg0: &Profile) : (address, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, u64) {
        (arg0.address, arg0.name, arg0.bio, arg0.photo_url, arg0.telegram_username, arg0.x_username, arg0.created_at)
    }

    public fun get_profile_name(arg0: &Profile) : 0x1::string::String {
        arg0.name
    }

    public fun get_profile_photo_url(arg0: &Profile) : 0x1::string::String {
        arg0.photo_url
    }

    public fun get_profile_telegram(arg0: &Profile) : 0x1::string::String {
        arg0.telegram_username
    }

    public fun get_profile_x_username(arg0: &Profile) : 0x1::string::String {
        arg0.x_username
    }

    public fun get_sponsor_conditions(arg0: &Event) : &SponsorConditions {
        &arg0.sponsor_conditions
    }

    public fun get_user_profile_id(arg0: &ProfileRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    public fun has_profile(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.profiles, arg1)
    }

    public fun has_telegram_username(arg0: &ProfileRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.telegram_to_address, arg1)
    }

    public fun has_x_username(arg0: &ProfileRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, address>(&arg0.x_to_address, arg1)
    }

    public fun increment_attendees(arg0: &mut Event) {
        assert!(arg0.state == 1, 2);
        assert!(arg0.current_attendees < arg0.capacity, 4);
        arg0.current_attendees = arg0.current_attendees + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EventRegistry{
            id                  : 0x2::object::new(arg0),
            events              : 0x2::table::new<0x2::object::ID, EventInfo>(arg0),
            events_by_organizer : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            events_by_assignee  : 0x2::table::new<0x1::string::String, vector<0x2::object::ID>>(arg0),
            events_by_parent    : 0x2::table::new<0x2::object::ID, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<EventRegistry>(v0);
        let v1 = ProfileRegistry{
            id                  : 0x2::object::new(arg0),
            profiles            : 0x2::table::new<address, 0x2::object::ID>(arg0),
            x_to_address        : 0x2::table::new<0x1::string::String, address>(arg0),
            telegram_to_address : 0x2::table::new<0x1::string::String, address>(arg0),
        };
        0x2::transfer::share_object<ProfileRegistry>(v1);
    }

    public fun is_event_active(arg0: &Event) : bool {
        arg0.state == 1
    }

    public fun is_event_completed(arg0: &Event) : bool {
        arg0.state == 2
    }

    public fun is_event_free(arg0: &Event) : bool {
        arg0.fee_amount == 0
    }

    public fun mark_event_settled(arg0: &mut Event, arg1: bool, arg2: &mut OrganizerProfile) {
        assert!(arg0.state == 2, 3);
        arg0.state = 3;
        if (arg1) {
            arg2.successful_events = arg2.successful_events + 1;
        };
    }

    public fun transfer_profile_cap(arg0: ProfileCap, arg1: address) {
        0x2::transfer::public_transfer<ProfileCap>(arg0, arg1);
    }

    public fun update_event_assignee(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut EventRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::object::id<Event>(arg0);
        let v1 = arg0.assignee;
        if (!0x1::string::is_empty(&v1) && v1 != 0x1::string::utf8(b"self")) {
            if (0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg2.events_by_assignee, v1)) {
                let v2 = 0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg2.events_by_assignee, v1);
                let (v3, v4) = 0x1::vector::index_of<0x2::object::ID>(v2, &v0);
                if (v3) {
                    0x1::vector::remove<0x2::object::ID>(v2, v4);
                };
            };
        };
        arg0.assignee = arg1;
        if (!0x1::string::is_empty(&arg1) && arg1 != 0x1::string::utf8(b"self")) {
            if (!0x2::table::contains<0x1::string::String, vector<0x2::object::ID>>(&arg2.events_by_assignee, arg1)) {
                0x2::table::add<0x1::string::String, vector<0x2::object::ID>>(&mut arg2.events_by_assignee, arg1, 0x1::vector::empty<0x2::object::ID>());
            };
            0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<0x1::string::String, vector<0x2::object::ID>>(&mut arg2.events_by_assignee, arg1), v0);
        };
    }

    public fun update_event_details(arg0: &mut Event, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg5), 1);
        assert!(arg0.state == 0, 2);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.location = arg3;
        arg0.metadata_uri = arg4;
    }

    public fun update_event_sponsors(arg0: &mut Event, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.organizer == 0x2::tx_context::sender(arg2), 1);
        arg0.sponsors = arg1;
    }

    public fun update_organizer_rating(arg0: &mut OrganizerProfile, arg1: u64, arg2: u64) {
        if (arg2 > 0) {
            arg0.avg_rating = arg1 / arg2;
        };
    }

    public fun update_profile(arg0: &mut Profile, arg1: &ProfileCap, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg7), 6);
        assert!(arg1.profile_id == 0x2::object::id<Profile>(arg0), 6);
        arg0.name = arg2;
        arg0.bio = arg3;
        arg0.photo_url = arg4;
        arg0.telegram_username = arg5;
        arg0.x_username = arg6;
    }

    // decompiled from Move bytecode v6
}

