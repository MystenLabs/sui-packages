module 0xefd748503bc15c1523157a0d57d4380a69fcd66d489a949319be8356e34f3618::skyward {
    struct Skyward has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct SKYWARD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Skyward) {
        let Skyward {
            id        : v0,
            name      : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: SKYWARD, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Roboguys play chess on a beach."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://example.com/"));
        let v4 = 0x2::package::claim<SKYWARD>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Skyward>(&v4, v0, v2, arg1);
        0x2::display::update_version<Skyward>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Skyward>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &0x2::package::Publisher, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Skyward>(arg0), 0);
        assert!(0x2::package::from_module<Skyward>(arg0), 0);
        assert!(arg1 > 0, 1);
        while (arg1 > 0) {
            let v0 = Skyward{
                id        : 0x2::object::new(arg5),
                name      : arg2,
                image_url : arg3,
            };
            0x2::transfer::public_transfer<Skyward>(v0, arg4);
            arg1 = arg1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

