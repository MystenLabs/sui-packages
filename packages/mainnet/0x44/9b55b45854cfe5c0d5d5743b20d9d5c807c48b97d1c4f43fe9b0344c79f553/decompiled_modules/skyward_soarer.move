module 0x449b55b45854cfe5c0d5d5743b20d9d5c807c48b97d1c4f43fe9b0344c79f553::skyward_soarer {
    struct SkywardSoarer has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
        link: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SKYWARD_SOARER has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: SkywardSoarer) {
        let SkywardSoarer {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
            link        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SKYWARD_SOARER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        let v4 = 0x2::package::claim<SKYWARD_SOARER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SkywardSoarer>(&v4, v0, v2, arg1);
        0x2::display::update_version<SkywardSoarer>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SkywardSoarer>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &AdminCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        while (arg1 > 0) {
            let v0 = SkywardSoarer{
                id          : 0x2::object::new(arg8),
                name        : arg2,
                description : arg4,
                image_url   : arg3,
                project_url : arg5,
                link        : arg6,
            };
            0x2::transfer::public_transfer<SkywardSoarer>(v0, arg7);
            arg1 = arg1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

