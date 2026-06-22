module 0x305b64b4341990c8da8f8d874c89c8dae10213a243b39648a441e4972ead730b::city_test {
    struct CITY_TEST has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct CityTest has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun init(arg0: CITY_TEST, arg1: &mut 0x2::tx_context::TxContext) {
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
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.io/test/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha City Test Lab"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"City Test"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha City test collection."));
        let v4 = 0x2::package::claim<CITY_TEST>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CityTest>(&v4, v0, v2, arg1);
        0x2::display::update_version<CityTest>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<CityTest>>(v5, v6);
        let v7 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v7, v6);
    }

    public fun mint_to(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg4)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg4, v1), *0x1::vector::borrow<0x1::string::String>(&arg5, v1));
            v1 = v1 + 1;
        };
        let v2 = CityTest{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            attributes  : v0,
        };
        0x2::transfer::public_transfer<CityTest>(v2, arg6);
    }

    // decompiled from Move bytecode v7
}

