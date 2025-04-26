module 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::whitelist {
    struct WHITELIST has drop {
        dummy_field: bool,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        item_type: 0x1::type_name::TypeName,
        launch_id: 0x2::object::ID,
        phase_id: 0x2::object::ID,
    }

    struct WhitelistCreatedEvent has copy, drop {
        whitelist_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        phase_id: 0x2::object::ID,
    }

    public fun new<T0: store + key>(arg0: &0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::LaunchOperatorCap, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg2: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg3: &mut 0x2::tx_context::TxContext) : Whitelist {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::launch_operator_cap_authorize(arg0, 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::id<T0>(arg1));
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::launch_operator_cap_authorize(arg0, 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::launch_id<T0>(arg2));
        internal_new<T0>(arg2, arg3)
    }

    public fun id(arg0: &Whitelist) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun launch_id(arg0: &Whitelist) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun destroy(arg0: Whitelist) {
        let Whitelist {
            id        : v0,
            item_type : _,
            launch_id : _,
            phase_id  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: WHITELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WHITELIST>(arg0, arg1);
        let v1 = 0x2::display::new<Whitelist>(&v0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"item_type"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"launch_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"phase_id"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{item_type}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{launch_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{phase_id}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://allow.anima.nexus/{launch_id}/{phase_id}.webp"));
        0x2::display::add_multiple<Whitelist>(&mut v1, v2, v4);
        0x2::display::update_version<Whitelist>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<Whitelist>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun internal_new<T0: store + key>(arg0: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg1: &mut 0x2::tx_context::TxContext) : Whitelist {
        let v0 = Whitelist{
            id        : 0x2::object::new(arg1),
            item_type : 0x1::type_name::get<T0>(),
            launch_id : 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::launch_id<T0>(arg0),
            phase_id  : 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::id<T0>(arg0),
        };
        let v1 = WhitelistCreatedEvent{
            whitelist_id : 0x2::object::uid_to_inner(&v0.id),
            launch_id    : v0.launch_id,
            phase_id     : v0.phase_id,
        };
        0x2::event::emit<WhitelistCreatedEvent>(v1);
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::increment_whitelist_count<T0>(arg0);
        v0
    }

    public fun issue_bulk<T0: store + key>(arg0: &0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::LaunchOperatorCap, arg1: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::Launch<T0>, arg2: &mut 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::Phase<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::launch_operator_cap_authorize(arg0, 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::id<T0>(arg1));
        0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::launch::launch_operator_cap_authorize(arg0, 0x60e688bb4071cd6ea5aed6f22b2dc717e067bbcbe60b73c931a0be728c3cfb75::phase::launch_id<T0>(arg2));
        while (!0x1::vector::is_empty<address>(&arg3)) {
            let v0 = 0x1::vector::empty<Whitelist>();
            let v1 = 0;
            while (v1 < 0x1::vector::pop_back<u64>(&mut arg4)) {
                0x1::vector::push_back<Whitelist>(&mut v0, internal_new<T0>(arg2, arg5));
                v1 = v1 + 1;
            };
            let v2 = 0;
            while (v2 < 0x1::vector::length<Whitelist>(&v0)) {
                0x2::transfer::public_transfer<Whitelist>(0x1::vector::pop_back<Whitelist>(&mut v0), 0x1::vector::pop_back<address>(&mut arg3));
                v2 = v2 + 1;
            };
            0x1::vector::destroy_empty<Whitelist>(v0);
        };
        0x1::vector::destroy_empty<address>(arg3);
    }

    public fun phase_id(arg0: &Whitelist) : 0x2::object::ID {
        arg0.phase_id
    }

    // decompiled from Move bytecode v6
}

