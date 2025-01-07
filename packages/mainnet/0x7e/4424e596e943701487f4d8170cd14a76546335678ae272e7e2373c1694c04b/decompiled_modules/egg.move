module 0x7e4424e596e943701487f4d8170cd14a76546335678ae272e7e2373c1694c04b::egg {
    struct Egg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        origin: 0x1::string::String,
        pet_type: 0x1::string::String,
        rarity: 0x1::string::String,
        thumbnail_url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct EGG has drop {
        dummy_field: bool,
    }

    public fun destroy(arg0: Egg) {
        let Egg {
            id            : v0,
            name          : _,
            description   : _,
            origin        : _,
            pet_type      : _,
            rarity        : _,
            thumbnail_url : _,
            image_url     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suipets.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A Collection of Genesis Eggs"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suipets.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"PetPals Foundation"));
        let v4 = 0x2::package::claim<EGG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Egg>(&v4, v0, v2, arg1);
        0x2::display::update_version<Egg>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Egg>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : Egg {
        assert!(0x2::package::from_module<Egg>(arg0), 0);
        Egg{
            id            : 0x2::object::new(arg8),
            name          : arg1,
            description   : arg2,
            origin        : arg3,
            pet_type      : arg4,
            rarity        : arg5,
            thumbnail_url : arg6,
            image_url     : arg7,
        }
    }

    // decompiled from Move bytecode v6
}

