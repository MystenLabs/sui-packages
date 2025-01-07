module 0xb06ee7d0b0bd1f12b020b076e60b0a6073bf6ced49f9e3d07cdb0696738794ee::suia {
    struct SUIA has drop {
        dummy_field: bool,
    }

    struct MedalStore has store, key {
        id: 0x2::object::UID,
        medals: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct Medal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_amount: u64,
        whitelist: 0x2::table::Table<address, bool>,
        owners: 0x2::table::Table<address, bool>,
        creator: address,
    }

    struct PersonalMedal has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        medal: 0x2::object::ID,
    }

    public entry fun add_medal_whitelist(arg0: &mut Medal, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, bool>(&arg0.whitelist, v1)) {
                0x2::table::add<address, bool>(&mut arg0.whitelist, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public entry fun claim_medal(arg0: &mut Medal, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::is_empty<address, bool>(&arg0.whitelist) || 0x2::table::contains<address, bool>(&arg0.whitelist, v0), 0);
        assert!(0x2::table::length<address, bool>(&arg0.owners) < arg0.max_amount, 1);
        assert!(!0x2::table::contains<address, bool>(&arg0.owners, v0), 2);
        0x2::table::add<address, bool>(&mut arg0.owners, v0, true);
        let v1 = PersonalMedal{
            id          : 0x2::object::new(arg1),
            name        : arg0.name,
            description : arg0.description,
            image_url   : arg0.image_url,
            medal       : 0x2::object::uid_to_inner(&arg0.id),
        };
        0x2::transfer::transfer<PersonalMedal>(v1, v0);
    }

    public entry fun create_medal(arg0: &mut MedalStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: vector<address>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Medal{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg5),
            max_amount  : arg3,
            whitelist   : 0x2::table::new<address, bool>(arg6),
            owners      : 0x2::table::new<address, bool>(arg6),
            creator     : 0x2::tx_context::sender(arg6),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg4)) {
            0x2::table::add<address, bool>(&mut v0.whitelist, *0x1::vector::borrow<address>(&arg4, v1), true);
            v1 = v1 + 1;
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.medals, 0x2::table::length<u64, 0x2::object::ID>(&arg0.medals), 0x2::object::uid_to_inner(&v0.id));
        0x2::transfer::share_object<Medal>(v0);
    }

    fun create_medal_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MedalStore{
            id     : 0x2::object::new(arg0),
            medals : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<MedalStore>(v0);
    }

    fun init(arg0: SUIA, arg1: &mut 0x2::tx_context::TxContext) {
        create_medal_store(arg1);
        let v0 = 0x2::package::claim<SUIA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suia.io/suia/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suia.io/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        let v5 = 0x2::display::new_with_fields<Medal>(&v0, v1, v3, arg1);
        0x2::display::update_version<Medal>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<Medal>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://suia.io/suia/{id}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://suia.io/"));
        let v10 = 0x2::display::new_with_fields<PersonalMedal>(&v0, v6, v8, arg1);
        0x2::display::update_version<PersonalMedal>(&mut v10);
        0x2::transfer::public_transfer<0x2::display::Display<PersonalMedal>>(v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

