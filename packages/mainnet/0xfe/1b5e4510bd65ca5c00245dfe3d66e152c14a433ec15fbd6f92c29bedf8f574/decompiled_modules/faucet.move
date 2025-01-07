module 0xfe1b5e4510bd65ca5c00245dfe3d66e152c14a433ec15fbd6f92c29bedf8f574::faucet {
    struct Champion has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        tier: 0x1::string::String,
        max_num_stamps_slot: u64,
        current_num_stamps: u64,
        stamps: 0x2::vec_map::VecMap<0x2::object::ID, 0x1::string::String>,
    }

    struct Stamp has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct FAUCET has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FAUCET>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tier"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tier}"));
        let v5 = 0x2::display::new_with_fields<Champion>(&v0, v1, v3, arg1);
        0x2::display::update_version<Champion>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Champion>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"id"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        let v10 = 0x2::display::new_with_fields<Stamp>(&v0, v6, v8, arg1);
        0x2::display::update_version<Stamp>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<Stamp>>(v10, 0x2::tx_context::sender(arg1));
        let (v11, v12) = 0x2::transfer_policy::new<Champion>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Champion>>(v11);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Champion>>(v12, 0x2::tx_context::sender(arg1));
        let (v13, v14) = 0x2::transfer_policy::new<Stamp>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Stamp>>(v13);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Stamp>>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Champion{
            id                  : 0x2::object::new(arg0),
            name                : 0x1::string::utf8(b"Charizard"),
            image_url           : 0x1::string::utf8(b"https://img.pokemondb.net/sprites/brilliant-diamond-shining-pearl/normal/charizard.png"),
            tier                : 0x1::string::utf8(b"3"),
            max_num_stamps_slot : 5,
            current_num_stamps  : 2,
            stamps              : 0x2::vec_map::empty<0x2::object::ID, 0x1::string::String>(),
        };
        let v1 = Stamp{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Amulet"),
            image_url : 0x1::string::utf8(b"https://images.wikidexcdn.net/mwuploads/wikidex/b/b9/latest/20231030190805/Amuleto_EP.png"),
        };
        let v2 = Stamp{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Rocky Helmet"),
            image_url : 0x1::string::utf8(b"https://images.wikidexcdn.net/mwuploads/wikidex/3/33/latest/20230122002043/Casco_dentado_EP.png"),
        };
        0x2::vec_map::insert<0x2::object::ID, 0x1::string::String>(&mut v0.stamps, 0x2::object::id<Stamp>(&v1), 0x1::string::utf8(b"Amulet"));
        0x2::vec_map::insert<0x2::object::ID, 0x1::string::String>(&mut v0.stamps, 0x2::object::id<Stamp>(&v2), 0x1::string::utf8(b"Rocky Helmet"));
        0x2::dynamic_object_field::add<vector<u8>, Stamp>(&mut v0.id, b"stamp_1_slot", v1);
        0x2::dynamic_object_field::add<vector<u8>, Stamp>(&mut v0.id, b"stamp_2_slot", v2);
        0x2::transfer::public_transfer<Champion>(v0, 0x2::tx_context::sender(arg0));
        let v3 = Champion{
            id                  : 0x2::object::new(arg0),
            name                : 0x1::string::utf8(b"Snorlax"),
            image_url           : 0x1::string::utf8(b"https://img.pokemondb.net/sprites/brilliant-diamond-shining-pearl/normal/snorlax.png"),
            tier                : 0x1::string::utf8(b"2"),
            max_num_stamps_slot : 5,
            current_num_stamps  : 1,
            stamps              : 0x2::vec_map::empty<0x2::object::ID, 0x1::string::String>(),
        };
        let v4 = Stamp{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Googles"),
            image_url : 0x1::string::utf8(b"https://images.wikidexcdn.net/mwuploads/wikidex/5/58/latest/20230122141114/Gafa_protectora_EP.png"),
        };
        0x2::vec_map::insert<0x2::object::ID, 0x1::string::String>(&mut v3.stamps, 0x2::object::id<Stamp>(&v4), 0x1::string::utf8(b"Googles"));
        0x2::dynamic_object_field::add<vector<u8>, Stamp>(&mut v3.id, b"stamp_1_slot", v4);
        0x2::transfer::public_transfer<Champion>(v3, 0x2::tx_context::sender(arg0));
        let v5 = Champion{
            id                  : 0x2::object::new(arg0),
            name                : 0x1::string::utf8(b"Porygon"),
            image_url           : 0x1::string::utf8(b"https://img.pokemondb.net/sprites/brilliant-diamond-shining-pearl/normal/porygon.png"),
            tier                : 0x1::string::utf8(b"1"),
            max_num_stamps_slot : 5,
            current_num_stamps  : 0,
            stamps              : 0x2::vec_map::empty<0x2::object::ID, 0x1::string::String>(),
        };
        0x2::transfer::public_transfer<Champion>(v5, 0x2::tx_context::sender(arg0));
        let v6 = Stamp{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Destiny Knot"),
            image_url : 0x1::string::utf8(b"https://images.wikidexcdn.net/mwuploads/wikidex/f/f1/latest/20230122134131/Lazo_destino_EP.png"),
        };
        0x2::transfer::public_transfer<Stamp>(v6, 0x2::tx_context::sender(arg0));
        let v7 = Stamp{
            id        : 0x2::object::new(arg0),
            name      : 0x1::string::utf8(b"Smoke Ball"),
            image_url : 0x1::string::utf8(b"https://images.wikidexcdn.net/mwuploads/wikidex/5/59/latest/20230122134030/Bola_de_humo_EP.png"),
        };
        0x2::transfer::public_transfer<Stamp>(v7, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

