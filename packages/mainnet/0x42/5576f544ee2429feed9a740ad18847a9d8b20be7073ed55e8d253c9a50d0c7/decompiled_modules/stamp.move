module 0x352919f09a96e8bca46cd2a9015c5651aed4aa3ca270f8c09c96ef670c8ede59::stamp {
    struct STAMP has drop {
        dummy_field: bool,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminSet has key {
        id: 0x2::object::UID,
        admin: 0x2::vec_set::VecSet<address>,
    }

    struct EventRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct Event has key {
        id: 0x2::object::UID,
        event: 0x1::string::String,
        description: 0x1::string::String,
        stamp_type: vector<0x1::string::String>,
    }

    struct StampMintInfo has store {
        name: 0x1::string::String,
        count: u32,
        image_url: 0x1::string::String,
        points: u64,
        description: 0x1::string::String,
    }

    struct Stamp has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        points: u64,
        event: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct SetEventStamp has copy, drop {
        event: 0x2::object::ID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        points: u64,
        description: 0x1::string::String,
    }

    public fun event(arg0: &Stamp) : 0x1::string::String {
        arg0.event
    }

    public(friend) fun new(arg0: &mut Event, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Stamp {
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.stamp_type, &arg1), 13906835127826120703);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, StampMintInfo>(&mut arg0.id, arg1);
        v0.count = v0.count + 1;
        0x1::string::append(&mut arg1, 0x1::string::utf8(b"#"));
        0x1::string::append(&mut arg1, 0x1::u32::to_string(v0.count));
        Stamp{
            id          : 0x2::object::new(arg2),
            name        : arg1,
            image_url   : v0.image_url,
            points      : v0.points,
            event       : arg0.event,
            description : v0.description,
        }
    }

    public(friend) fun check_admin(arg0: &AdminSet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admin, &v0), 13906834681149521919);
    }

    public fun create_event(arg0: &AdminSet, arg1: &mut EventRecord, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Event {
        check_admin(arg0, arg4);
        let v0 = Event{
            id          : 0x2::object::new(arg4),
            event       : arg2,
            description : arg3,
            stamp_type  : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.record, arg2, 0x2::object::id<Event>(&v0));
        v0
    }

    public fun description(arg0: &Stamp) : 0x1::string::String {
        arg0.description
    }

    public fun event_name(arg0: &Event) : 0x1::string::String {
        arg0.event
    }

    public fun event_stamp_type(arg0: &Event) : vector<0x1::string::String> {
        arg0.stamp_type
    }

    public fun image_url(arg0: &Stamp) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: STAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SuperAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<SuperAdminCap>(v1, v0);
        let v2 = AdminSet{
            id    : 0x2::object::new(arg1),
            admin : 0x2::vec_set::empty<address>(),
        };
        0x2::transfer::share_object<AdminSet>(v2);
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"event"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{event}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        let v7 = 0x2::package::claim<STAMP>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<Stamp>(&v7, v3, v5, arg1);
        0x2::display::update_version<Stamp>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Stamp>>(v8, v0);
        let v9 = EventRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<EventRecord>(v9);
    }

    public fun name(arg0: &Stamp) : 0x1::string::String {
        arg0.name
    }

    public fun points(arg0: &Stamp) : u64 {
        arg0.points
    }

    public fun remove_admin(arg0: &SuperAdminCap, arg1: &mut AdminSet, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.admin, &arg2);
    }

    public fun remove_event_stamp(arg0: &AdminSet, arg1: &mut Event, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        abort 13906835359754354687
    }

    public fun remove_event_stamp_v2(arg0: &AdminSet, arg1: &mut EventRecord, arg2: Event, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg4);
        assert!(0x2::dynamic_field::borrow<0x1::string::String, StampMintInfo>(&arg2.id, arg3).count == 0, 13906835050516709375);
        0x2::table::remove<0x1::string::String, 0x2::object::ID>(&mut arg1.record, arg2.event);
        let Event {
            id          : v0,
            event       : _,
            description : _,
            stamp_type  : _,
        } = arg2;
        0x2::object::delete(v0);
    }

    public fun set_admin(arg0: &SuperAdminCap, arg1: &mut AdminSet, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.admin, arg2);
    }

    public fun set_event_description(arg0: &AdminSet, arg1: &mut Event, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg3);
        arg1.description = arg2;
    }

    public fun set_event_name(arg0: &AdminSet, arg1: &mut Event, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg3);
        arg1.event = arg2;
    }

    public fun set_event_stamp(arg0: &AdminSet, arg1: &mut Event, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg6);
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.stamp_type, &arg2), 13906834925962657791);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.stamp_type, arg2);
        let v0 = StampMintInfo{
            name        : arg2,
            count       : 0,
            image_url   : arg3,
            points      : arg4,
            description : arg5,
        };
        0x2::dynamic_field::add<0x1::string::String, StampMintInfo>(&mut arg1.id, arg2, v0);
        let v1 = SetEventStamp{
            event       : 0x2::object::id<Event>(arg1),
            name        : arg2,
            image_url   : arg3,
            points      : arg4,
            description : arg5,
        };
        0x2::event::emit<SetEventStamp>(v1);
    }

    public fun share_event(arg0: Event) {
        0x2::transfer::share_object<Event>(arg0);
    }

    public(friend) fun transfer_stamp(arg0: Stamp, arg1: address) {
        0x2::transfer::transfer<Stamp>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

