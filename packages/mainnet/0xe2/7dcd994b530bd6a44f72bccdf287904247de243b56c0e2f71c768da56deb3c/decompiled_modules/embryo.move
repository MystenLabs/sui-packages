module 0xe27dcd994b530bd6a44f72bccdf287904247de243b56c0e2f71c768da56deb3c::embryo {
    struct Embryo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        project_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EMBRYO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Embryo) {
        let Embryo {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            project_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: EMBRYO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<EMBRYO>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Embryo>(&v4, v0, v2, arg1);
        0x2::display::update_version<Embryo>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Embryo>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &AdminCap, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        while (arg1 > 0) {
            let v0 = Embryo{
                id          : 0x2::object::new(arg7),
                name        : arg2,
                description : arg4,
                image_url   : arg3,
                project_url : arg5,
            };
            0x2::transfer::public_transfer<Embryo>(v0, arg6);
            arg1 = arg1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

