module 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp {
    struct STAMP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
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
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.stamp_type, &arg1), 9223372861488496639);
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

    public fun create_event(arg0: &AdminCap, arg1: &mut EventRecord, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Event {
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
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"event"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{event}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        let v6 = 0x2::package::claim<STAMP>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<Stamp>(&v6, v2, v4, arg1);
        0x2::display::update_version<Stamp>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Stamp>>(v7, v0);
        let v8 = EventRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<EventRecord>(v8);
    }

    public fun name(arg0: &Stamp) : 0x1::string::String {
        arg0.name
    }

    public fun points(arg0: &Stamp) : u64 {
        arg0.points
    }

    public fun remove_event_stamp(arg0: &AdminCap, arg1: &mut Event, arg2: 0x1::string::String) {
        assert!(0x2::dynamic_field::borrow<0x1::string::String, StampMintInfo>(&arg1.id, arg2).count == 0, 9223372792769019903);
        let StampMintInfo {
            name        : _,
            count       : _,
            image_url   : _,
            points      : _,
            description : _,
        } = 0x2::dynamic_field::remove<0x1::string::String, StampMintInfo>(&mut arg1.id, arg2);
        let v5 = &arg1.stamp_type;
        let v6 = 0;
        let v7;
        while (v6 < 0x1::vector::length<0x1::string::String>(v5)) {
            if (*0x1::vector::borrow<0x1::string::String>(v5, v6) == arg2) {
                v7 = 0x1::option::some<u64>(v6);
                /* label 9 */
                0x1::vector::swap_remove<0x1::string::String>(&mut arg1.stamp_type, 0x1::option::destroy_some<u64>(v7));
                return
            };
            v6 = v6 + 1;
        };
        v7 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun set_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun set_event_description(arg0: &AdminCap, arg1: &mut Event, arg2: 0x1::string::String) {
        arg1.description = arg2;
    }

    public fun set_event_name(arg0: &AdminCap, arg1: &mut Event, arg2: 0x1::string::String) {
        arg1.event = arg2;
    }

    public fun set_event_stamp(arg0: &AdminCap, arg1: &mut Event, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String) {
        assert!(!0x1::vector::contains<0x1::string::String>(&arg1.stamp_type, &arg2), 9223372681099870207);
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

