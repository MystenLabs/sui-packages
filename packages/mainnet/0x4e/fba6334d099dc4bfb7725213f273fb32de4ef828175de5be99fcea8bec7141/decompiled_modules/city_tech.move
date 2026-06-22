module 0x4efba6334d099dc4bfb7725213f273fb32de4ef828175de5be99fcea8bec7141::city_tech {
    struct CITY_TECH has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct CityTech has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun burn(arg0: CityTech) {
        let CityTech {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CITY_TECH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection_description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection_image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.tech/gear/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.tech"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha City"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"City Tech"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A collection of mysterious items. Something tells you they're important."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.tech/assets/city-tech/Peerless.png"));
        let v4 = 0x2::package::claim<CITY_TECH>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CityTech>(&v4, v0, v2, arg1);
        0x2::display::update_version<CityTech>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<CityTech>>(v5, v6);
        let v7 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v7, v6);
    }

    public fun mint_batch(arg0: &MintCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u64>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v2 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            let v3 = 0;
            while (v3 < *0x1::vector::borrow<u64>(&arg6, v0)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v2, *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<0x1::string::String>(&arg5, v1));
                v1 = v1 + 1;
                v3 = v3 + 1;
            };
            let v4 = CityTech{
                id          : 0x2::object::new(arg8),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg1, v0),
                description : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                image_url   : *0x1::vector::borrow<0x1::string::String>(&arg3, v0),
                attributes  : v2,
            };
            0x2::transfer::public_transfer<CityTech>(v4, arg7);
            v0 = v0 + 1;
        };
    }

    public fun mint_to(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<0x1::string::String>(&arg5, v1));
            v1 = v1 + 1;
        };
        let v2 = CityTech{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            attributes  : v0,
        };
        0x2::transfer::public_transfer<CityTech>(v2, arg6);
    }

    // decompiled from Move bytecode v7
}

