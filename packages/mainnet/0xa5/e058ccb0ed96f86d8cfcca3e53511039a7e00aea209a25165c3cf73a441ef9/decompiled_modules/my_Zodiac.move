module 0xa5e058ccb0ed96f86d8cfcca3e53511039a7e00aea209a25165c3cf73a441ef9::my_Zodiac {
    struct Zodiac has store, key {
        id: 0x2::object::UID,
        number: u8,
        name: 0x1::string::String,
        img_url: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
    }

    struct GlobalBool has store, key {
        id: 0x2::object::UID,
        value: bool,
    }

    struct MY_ZODIAC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: Zodiac) {
        let Zodiac {
            id          : v0,
            number      : _,
            name        : _,
            img_url     : _,
            description : _,
            creator     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MY_ZODIAC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://linktr.ee/3dabfl"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://twitter.com/3DABFL"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<MY_ZODIAC>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Zodiac>(&v4, v0, v2, arg1);
        0x2::display::update_version<Zodiac>(&mut v5);
        let v6 = GlobalBool{
            id    : 0x2::object::new(arg1),
            value : true,
        };
        0x2::transfer::share_object<GlobalBool>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Zodiac>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut GlobalBool, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.value, 1);
        let v0 = 0;
        while (v0 < 120) {
            let v1 = v0 + 1;
            v0 = v1;
            let v2 = Zodiac{
                id          : 0x2::object::new(arg5),
                number      : v1,
                name        : arg1,
                img_url     : arg2,
                description : arg3,
                creator     : arg4,
            };
            0x2::transfer::public_transfer<Zodiac>(v2, 0x2::tx_context::sender(arg5));
        };
    }

    public entry fun set_false(arg0: &mut GlobalBool) {
        arg0.value = false;
    }

    // decompiled from Move bytecode v6
}

