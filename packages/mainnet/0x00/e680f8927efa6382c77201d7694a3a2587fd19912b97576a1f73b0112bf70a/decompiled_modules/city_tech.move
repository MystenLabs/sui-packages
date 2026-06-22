module 0xe680f8927efa6382c77201d7694a3a2587fd19912b97576a1f73b0112bf70a::city_tech {
    struct CITY_TECH has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BiologicUpgrade has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
        amp: u64,
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
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"rarity"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"amp"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.io/tech/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://alphacity.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Alpha City Tech Lab"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{rarity}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{amp}"));
        let v4 = 0x2::package::claim<CITY_TECH>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BiologicUpgrade>(&v4, v0, v2, arg1);
        0x2::display::update_version<BiologicUpgrade>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<BiologicUpgrade>>(v5, v6);
        let v7 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v7, v6);
    }

    public fun mint_batch(arg0: &MintCap, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<u64>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = BiologicUpgrade{
                id          : 0x2::object::new(arg7),
                name        : *0x1::vector::borrow<0x1::string::String>(&arg1, v0),
                description : *0x1::vector::borrow<0x1::string::String>(&arg2, v0),
                image_url   : *0x1::vector::borrow<0x1::string::String>(&arg3, v0),
                rarity      : *0x1::vector::borrow<0x1::string::String>(&arg4, v0),
                amp         : *0x1::vector::borrow<u64>(&arg5, v0),
            };
            0x2::transfer::public_transfer<BiologicUpgrade>(v1, arg6);
            v0 = v0 + 1;
        };
    }

    public fun mint_to(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = BiologicUpgrade{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            rarity      : arg4,
            amp         : arg5,
        };
        0x2::transfer::public_transfer<BiologicUpgrade>(v0, arg6);
    }

    // decompiled from Move bytecode v7
}

