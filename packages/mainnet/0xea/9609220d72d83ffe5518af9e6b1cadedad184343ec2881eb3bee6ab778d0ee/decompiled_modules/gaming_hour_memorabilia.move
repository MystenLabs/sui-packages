module 0xea9609220d72d83ffe5518af9e6b1cadedad184343ec2881eb3bee6ab778d0ee::gaming_hour_memorabilia {
    struct GAMING_HOUR_MEMORABILIA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AttendanceProof has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_id: 0x1::string::String,
    }

    fun init(arg0: GAMING_HOUR_MEMORABILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAMING_HOUR_MEMORABILIA>(arg0, arg1);
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://i.imgur.com/{image_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.notion.so/Gaming-Hour-c7449ad76848426d9ca8e1ab5bd69425?pvs=4"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Darkwing"));
        let v5 = 0x2::display::new_with_fields<AttendanceProof>(&v0, v1, v3, arg1);
        0x2::display::update_version<AttendanceProof>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<AttendanceProof>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg4)) {
            let v1 = 0x1::vector::pop_back<address>(arg4);
            let v2 = AttendanceProof{
                id          : 0x2::object::new(arg5),
                title       : arg1,
                description : arg2,
                image_id    : arg3,
            };
            0x2::transfer::public_transfer<AttendanceProof>(v2, v1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

