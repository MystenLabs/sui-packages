module 0x160397d745dbcf48d32a71215d1cf73357ca8971ccb8521431d3f730a9a6b10a::stamp {
    struct STAMP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Event has store {
        name: 0x1::ascii::String,
        description: 0x1::ascii::String,
        mint_count: u32,
        image_url: 0x1::ascii::String,
        points: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        registered_collections: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>,
        events: 0x2::table::Table<0x1::ascii::String, Event>,
    }

    struct Stamp<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
        points: u64,
        event: 0x1::ascii::String,
        description: 0x1::ascii::String,
    }

    fun assert_version(arg0: &Config) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u64>(&arg0.versions, &v0), 101);
    }

    public fun event_exists(arg0: &Config, arg1: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)
    }

    public fun get_collection_display_id(arg0: &Config, arg1: 0x1::type_name::TypeName) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registered_collections, &arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::vec_map::get<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registered_collections, &arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun get_event_description(arg0: &Config, arg1: 0x1::ascii::String) : 0x1::option::Option<0x1::ascii::String> {
        if (0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)) {
            0x1::option::some<0x1::ascii::String>(0x2::table::borrow<0x1::ascii::String, Event>(&arg0.events, arg1).description)
        } else {
            0x1::option::none<0x1::ascii::String>()
        }
    }

    public fun get_event_image_url(arg0: &Config, arg1: 0x1::ascii::String) : 0x1::option::Option<0x1::ascii::String> {
        if (0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)) {
            0x1::option::some<0x1::ascii::String>(0x2::table::borrow<0x1::ascii::String, Event>(&arg0.events, arg1).image_url)
        } else {
            0x1::option::none<0x1::ascii::String>()
        }
    }

    public fun get_event_mint_count(arg0: &Config, arg1: 0x1::ascii::String) : 0x1::option::Option<u32> {
        if (0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)) {
            0x1::option::some<u32>(0x2::table::borrow<0x1::ascii::String, Event>(&arg0.events, arg1).mint_count)
        } else {
            0x1::option::none<u32>()
        }
    }

    public fun get_event_name(arg0: &Config, arg1: 0x1::ascii::String) : 0x1::option::Option<0x1::ascii::String> {
        if (0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)) {
            0x1::option::some<0x1::ascii::String>(0x2::table::borrow<0x1::ascii::String, Event>(&arg0.events, arg1).name)
        } else {
            0x1::option::none<0x1::ascii::String>()
        }
    }

    public fun get_event_points(arg0: &Config, arg1: 0x1::ascii::String) : 0x1::option::Option<u64> {
        if (0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1)) {
            0x1::option::some<u64>(0x2::table::borrow<0x1::ascii::String, Event>(&arg0.events, arg1).points)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun get_managers(arg0: &Config) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.managers)
    }

    public fun get_registered_collections(arg0: &Config) : vector<0x1::type_name::TypeName> {
        let (v0, _) = 0x2::vec_map::into_keys_values<0x1::type_name::TypeName, 0x2::object::ID>(arg0.registered_collections);
        v0
    }

    public fun get_stamp_description<T0>(arg0: &Stamp<T0>) : 0x1::ascii::String {
        arg0.description
    }

    public fun get_stamp_event<T0>(arg0: &Stamp<T0>) : 0x1::ascii::String {
        arg0.event
    }

    public fun get_stamp_image_url<T0>(arg0: &Stamp<T0>) : 0x1::ascii::String {
        arg0.image_url
    }

    public fun get_stamp_info<T0>(arg0: &Stamp<T0>) : (0x1::ascii::String, 0x1::ascii::String, u64, 0x1::ascii::String, 0x1::ascii::String) {
        (arg0.name, arg0.image_url, arg0.points, arg0.event, arg0.description)
    }

    public fun get_stamp_name<T0>(arg0: &Stamp<T0>) : 0x1::ascii::String {
        arg0.name
    }

    public fun get_stamp_points<T0>(arg0: &Stamp<T0>) : u64 {
        arg0.points
    }

    public fun get_supported_versions(arg0: &Config) : vector<u64> {
        0x2::vec_set::into_keys<u64>(arg0.versions)
    }

    fun init(arg0: STAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STAMP>(arg0, arg1), v0);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id                     : 0x2::object::new(arg1),
            versions               : 0x2::vec_set::singleton<u64>(1),
            managers               : 0x2::vec_set::singleton<address>(v0),
            registered_collections : 0x2::vec_map::empty<0x1::type_name::TypeName, 0x2::object::ID>(),
            events                 : 0x2::table::new<0x1::ascii::String, Event>(arg1),
        };
        0x2::transfer::public_share_object<Config>(v2);
    }

    public fun is_collection_registered(arg0: &Config, arg1: 0x1::type_name::TypeName) : bool {
        0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registered_collections, &arg1)
    }

    public fun is_manager(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.managers, &arg1)
    }

    public fun mint_to<T0>(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::vec_set::contains<address>(&arg0.managers, &v0), 106);
        assert!(0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1), 102);
        let v1 = 0x2::table::borrow_mut<0x1::ascii::String, Event>(&mut arg0.events, arg1);
        v1.mint_count = v1.mint_count + 1;
        let v2 = v1.name;
        0x1::ascii::append(&mut v2, 0x1::ascii::string(b"#"));
        0x1::ascii::append(&mut v2, 0x1::string::to_ascii(0x1::u32::to_string(v1.mint_count)));
        let v3 = Stamp<T0>{
            id          : 0x2::object::new(arg3),
            name        : v2,
            image_url   : v1.image_url,
            points      : v1.points,
            event       : arg1,
            description : v1.description,
        };
        0x2::transfer::transfer<Stamp<T0>>(v3, arg2);
    }

    public fun new_collection<T0: drop>(arg0: &mut Config, arg1: &mut 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.registered_collections, &v0), 105);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"event"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{event}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        let v5 = 0x2::display::new_with_fields<Stamp<T0>>(arg1, v1, v3, arg2);
        0x2::display::update_version<Stamp<T0>>(&mut v5);
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.registered_collections, v0, 0x2::object::id<0x2::display::Display<Stamp<T0>>>(&v5));
        0x2::transfer::public_transfer<0x2::display::Display<Stamp<T0>>>(v5, 0x2::tx_context::sender(arg2));
    }

    public fun new_event(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: u64) {
        assert_version(arg0);
        assert!(!0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg2), 103);
        let v0 = Event{
            name        : arg2,
            description : arg3,
            mint_count  : 0,
            image_url   : arg4,
            points      : arg5,
        };
        0x2::table::add<0x1::ascii::String, Event>(&mut arg0.events, arg2, v0);
    }

    public fun update_event_description(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        assert_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg2), 102);
        0x2::table::borrow_mut<0x1::ascii::String, Event>(&mut arg0.events, arg2).description = arg3;
    }

    public fun update_event_image_url(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String) {
        assert_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg2), 102);
        0x2::table::borrow_mut<0x1::ascii::String, Event>(&mut arg0.events, arg2).image_url = arg3;
    }

    public fun update_event_name(arg0: &mut Config, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: &AdminCap) {
        assert_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg1), 102);
        assert!(!0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg2), 104);
        0x2::table::add<0x1::ascii::String, Event>(&mut arg0.events, arg2, 0x2::table::remove<0x1::ascii::String, Event>(&mut arg0.events, arg1));
    }

    public fun update_event_points(arg0: &mut Config, arg1: &AdminCap, arg2: 0x1::ascii::String, arg3: u64) {
        assert_version(arg0);
        assert!(0x2::table::contains<0x1::ascii::String, Event>(&arg0.events, arg2), 102);
        0x2::table::borrow_mut<0x1::ascii::String, Event>(&mut arg0.events, arg2).points = arg3;
    }

    // decompiled from Move bytecode v6
}

