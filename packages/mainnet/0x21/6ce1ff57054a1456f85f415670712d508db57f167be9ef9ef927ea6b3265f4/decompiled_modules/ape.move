module 0x216ce1ff57054a1456f85f415670712d508db57f167be9ef9ef927ea6b3265f4::ape {
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

    struct APE has drop {
        dummy_field: bool,
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Ape {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"background"), 0x1::string::utf8(arg3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(arg4));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"level"), 0x1::string::utf8(arg5));
        let v1 = Ape{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
            attributes  : v0,
        };
        let v2 = ApeMinted{
            id    : 0x2::object::id<Ape>(&v1),
            owner : 0x2::tx_context::sender(arg6),
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

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = create(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<Ape>(v0, 0x2::tx_context::sender(arg6));
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

