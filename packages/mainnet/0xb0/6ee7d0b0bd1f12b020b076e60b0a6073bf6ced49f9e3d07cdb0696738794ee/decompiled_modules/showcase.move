module 0xb06ee7d0b0bd1f12b020b076e60b0a6073bf6ced49f9e3d07cdb0696738794ee::showcase {
    struct Layout has store {
        name: 0x1::string::String,
        max_nft_num: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        admin: address,
        layouts: 0x2::vec_map::VecMap<0x1::string::String, Layout>,
    }

    struct Showcase has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        layout: 0x1::string::String,
        creator: address,
        nfts: 0x2::bag::Bag,
    }

    struct SHOWCASE has drop {
        dummy_field: bool,
    }

    public entry fun add_layout(arg0: &mut Config, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::string::utf8(arg1);
        let v1 = Layout{
            name        : v0,
            max_nft_num : arg2,
        };
        0x2::vec_map::insert<0x1::string::String, Layout>(&mut arg0.layouts, v0, v1);
    }

    public entry fun add_nft_to_showcase<T0: store + key>(arg0: &Config, arg1: &mut Showcase, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::bag::contains<u64>(&arg1.nfts, arg3)) {
            abort 4
        };
        assert!(arg3 < 0x2::vec_map::get<0x1::string::String, Layout>(&arg0.layouts, &arg1.layout).max_nft_num, 5);
        0x2::bag::add<u64, T0>(&mut arg1.nfts, arg3, arg2);
    }

    fun create_config(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            layouts : 0x2::vec_map::empty<0x1::string::String, Layout>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun create_showcase(arg0: &Config, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg4);
        assert!(0x2::vec_map::contains<0x1::string::String, Layout>(&arg0.layouts, &v0), 3);
        let v1 = Showcase{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            layout      : v0,
            creator     : 0x2::tx_context::sender(arg5),
            nfts        : 0x2::bag::new(arg5),
        };
        0x2::transfer::transfer<Showcase>(v1, 0x2::tx_context::sender(arg5));
    }

    public entry fun extract_from_showcase<T0: store + key>(arg0: &mut Showcase, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::bag::contains<u64>(&arg0.nfts, arg1), 6);
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<u64, T0>(&mut arg0.nfts, arg1), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: SHOWCASE, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(arg1);
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suia.io/suia/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suia.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<SHOWCASE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Showcase>(&v4, v0, v2, arg1);
        0x2::display::update_version<Showcase>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Showcase>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

