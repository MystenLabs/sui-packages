module 0x40ea8a397c454e0f9e1cef3844c1bb7f2e92a09569c475212b1d8a2986017ed2::blackbook {
    struct BLACKBOOK has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Attendance has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintAttendanceEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
    }

    fun init(arg0: BLACKBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<BLACKBOOK>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://bit.ly/blackbooknetwork"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Black Book"));
        let v5 = 0x2::display::new_with_fields<Attendance>(&v0, v1, v3, arg1);
        0x2::display::update_version<Attendance>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Attendance>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Attendance{
            id          : 0x2::object::new(arg4),
            title       : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = MintAttendanceEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            title     : v0.title,
        };
        0x2::event::emit<MintAttendanceEvent>(v2);
        0x2::transfer::public_transfer<Attendance>(v0, v1);
    }

    // decompiled from Move bytecode v6
}

