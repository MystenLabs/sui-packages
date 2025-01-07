module 0x4cffb9cecfe89dbc42daf0f1b2934a03122625679b9a569654e88b8ab14ec74b::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    struct Ape has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ApeMinted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct ApeUpdated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    fun check_authority(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<APE>(arg0), 0);
    }

    public fun create(arg0: &0x2::package::Publisher, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: vector<u8>, arg12: vector<u8>, arg13: &mut 0x2::tx_context::TxContext) : Ape {
        check_authority(arg0);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"background"), 0x1::string::utf8(arg4));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(arg5));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"level"), 0x1::string::utf8(arg6));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"fur"), 0x1::string::utf8(arg7));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"clothes"), 0x1::string::utf8(arg8));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"mouth"), 0x1::string::utf8(arg9));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"eyes"), 0x1::string::utf8(arg10));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"hat"), 0x1::string::utf8(arg11));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"earring"), 0x1::string::utf8(arg12));
        let v1 = Ape{
            id          : 0x2::object::new(arg13),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x1::string::utf8(arg3),
            attributes  : v0,
        };
        let v2 = ApeMinted{
            id    : 0x2::object::id<Ape>(&v1),
            owner : 0x2::tx_context::sender(arg13),
        };
        0x2::event::emit<ApeMinted>(v2);
        v1
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        let v4 = 0x2::package::claim<APE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Ape>(&v4, v0, v2, arg1);
        0x2::display::update_version<Ape>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Ape>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun reveal(arg0: &mut Ape, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        arg0.url = 0x1::string::utf8(arg1);
        let v0 = ApeUpdated{
            id    : 0x2::object::id<Ape>(arg0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ApeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

