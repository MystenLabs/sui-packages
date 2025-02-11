module 0x870740527a9a0c7c248244d256e6f1b28677909d4b3e7107eb932c4d46ddbb21::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Supply has store, key {
        id: 0x2::object::UID,
        bitmaps: vector<vector<u64>>,
    }

    struct Data has store, key {
        id: 0x2::object::UID,
        curve: 0x1::option::Option<0x2::object::ID>,
        images: 0x2::table::Table<u64, 0x1::string::String>,
        labels: vector<0x1::string::String>,
        values: vector<vector<0x1::string::String>>,
    }

    struct SuiShiba has store, key {
        id: 0x2::object::UID,
        number: u64,
        image: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ManagerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun id(arg0: &SuiShiba) : 0x2::object::ID {
        0x2::object::id<SuiShiba>(arg0)
    }

    public(friend) fun attributes(arg0: &SuiShiba) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    fun burn(arg0: SuiShiba, arg1: &mut Supply, arg2: &Data) : 0x2::object::UID {
        let SuiShiba {
            id         : v0,
            number     : v1,
            image      : _,
            attributes : v3,
        } = arg0;
        let v4 = v3;
        let v5 = 0;
        let v6 = 0x1::vector::empty<0x1::string::String>();
        while (v5 < 0x1::vector::length<0x1::string::String>(&arg2.labels)) {
            let v7 = *0x1::vector::borrow<0x1::string::String>(&arg2.labels, v5);
            0x1::vector::push_back<0x1::string::String>(&mut v6, *0x2::vec_map::get<0x1::string::String, 0x1::string::String>(&v4, &v7));
            v5 = v5 + 1;
        };
        let v8 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v8, v1);
        0x1::vector::push_back<u64>(&mut v8, encode_bitmap(v6, arg2.values));
        0x1::vector::push_back<vector<u64>>(&mut arg1.bitmaps, v8);
        v0
    }

    public fun buy_on_curve(arg0: 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::CurveBuyOrder<SuiShiba>, arg1: &Data, arg2: &mut Supply, arg3: &mut 0x2::tx_context::TxContext) : (vector<SuiShiba>, 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::CurveBuyOrder<SuiShiba>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg1.curve), 0);
        let v0 = 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::buy_order_curve<SuiShiba>(&arg0);
        assert!(&v0 == 0x1::option::borrow<0x2::object::ID>(&arg1.curve), 0);
        (mint(arg1, arg2, 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::buy_order_size<SuiShiba>(&arg0), arg3), arg0)
    }

    public fun decode_bitmap(arg0: u64, arg1: vector<vector<0x1::string::String>>) : vector<0x1::string::String> {
        let v0 = 0x1::vector::length<vector<0x1::string::String>>(&arg1);
        assert!(v0 >= 5 && v0 <= 16, 0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg1, v3), ((arg0 >> v2 & 15) as u64)));
            v2 = v2 + 4;
            v3 = v3 + 1;
        };
        v1
    }

    public fun encode_bitmap(arg0: vector<0x1::string::String>, arg1: vector<vector<0x1::string::String>>) : u64 {
        let v0 = 0x1::vector::length<vector<0x1::string::String>>(&arg1);
        assert!(v0 >= 5 && v0 <= 16, 0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x1::vector::borrow<0x1::string::String>(&arg0, v3);
            let v5 = 0x1::vector::borrow<vector<0x1::string::String>>(&arg1, v3);
            let v6 = 0;
            let v7 = 0;
            while (v6 < 0x1::vector::length<0x1::string::String>(v5)) {
                if (*0x1::vector::borrow<0x1::string::String>(v5, v6) == *v4) {
                    v7 = (v6 as u64);
                    break
                };
                v6 = v6 + 1;
            };
            v1 = v1 | v7 << v2;
            v2 = v2 + 4;
            v3 = v3 + 1;
        };
        v1
    }

    public(friend) fun image(arg0: &SuiShiba) : &0x1::string::String {
        &arg0.image
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TOKEN>(arg0, arg1);
        let v1 = 0x2::display::new<SuiShiba>(&v0, arg1);
        0x2::display::add<SuiShiba>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"SUI SHIBA #{number}"));
        0x2::display::add<SuiShiba>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"This is a collection of 1000 NFTs called SUI SHIBA."));
        0x2::display::add<SuiShiba>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://{image}"));
        0x2::display::add<SuiShiba>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<SuiShiba>(&mut v1);
        let v2 = Supply{
            id      : 0x2::object::new(arg1),
            bitmaps : 0x1::vector::empty<vector<u64>>(),
        };
        let v3 = Data{
            id     : 0x2::object::new(arg1),
            curve  : 0x1::option::none<0x2::object::ID>(),
            images : 0x2::table::new<u64, 0x1::string::String>(arg1),
            labels : 0x1::vector::empty<0x1::string::String>(),
            values : 0x1::vector::empty<vector<0x1::string::String>>(),
        };
        let v4 = ManagerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_share_object<Supply>(v2);
        0x2::transfer::public_share_object<Data>(v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiShiba>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<ManagerCap>(v4, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &Data, arg1: &mut Supply, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : vector<SuiShiba> {
        assert!(arg2 > 0 && arg2 <= 1000, 0);
        assert!(arg2 <= 0x1::vector::length<vector<u64>>(&arg1.bitmaps), 9223372706869673983);
        let v0 = 0;
        let v1 = 0x1::vector::empty<SuiShiba>();
        while (v0 < arg2) {
            let v2 = 0x1::vector::swap_remove<vector<u64>>(&mut arg1.bitmaps, (random_in_range(seed(0x2::tx_context::digest(arg3)), 0, 0x1::vector::length<vector<u64>>(&arg1.bitmaps) - 1) as u64));
            let v3 = 0x1::vector::pop_back<u64>(&mut v2);
            let v4 = decode_bitmap(v3, arg0.values);
            let v5 = 0;
            let v6 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
            while (v5 < 0x1::vector::length<0x1::string::String>(&arg0.labels)) {
                0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v6, *0x1::vector::borrow<0x1::string::String>(&arg0.labels, v5), *0x1::vector::borrow<0x1::string::String>(&v4, v5));
                v5 = v5 + 1;
            };
            let v7 = SuiShiba{
                id         : 0x2::object::new(arg3),
                number     : 0x1::vector::pop_back<u64>(&mut v2),
                image      : *0x2::table::borrow<u64, 0x1::string::String>(&arg0.images, v3),
                attributes : v6,
            };
            0x1::vector::push_back<SuiShiba>(&mut v1, v7);
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun number(arg0: &SuiShiba) : u64 {
        arg0.number
    }

    fun random_in_range(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 >= arg1, 1);
        if (arg1 == arg2) {
            return arg1
        };
        arg1 + random_u64(arg0) % (arg2 - arg1 + 1)
    }

    fun random_u64(arg0: u64) : u64 {
        let v0 = arg0 ^ arg0 << 13;
        let v1 = v0 ^ v0 >> 7;
        v1 ^ v1 << 17
    }

    fun seed(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) >= 8, 1);
        (*0x1::vector::borrow<u8>(arg0, 0) as u64) | (*0x1::vector::borrow<u8>(arg0, 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, 7) as u64) << 56
    }

    public fun sell_on_curve(arg0: vector<SuiShiba>, arg1: 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::CurveSellOrder<SuiShiba>, arg2: &mut Supply, arg3: &Data) : (vector<0x2::object::UID>, 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::CurveSellOrder<SuiShiba>) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg3.curve), 0);
        let v0 = 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::sell_order_curve<SuiShiba>(&arg1);
        assert!(&v0 == 0x1::option::borrow<0x2::object::ID>(&arg3.curve), 0);
        let v1 = 0x50a3ac2280430c3b668535d82b56c7fe860cac42132b687ca1e1cd11dfe8c918::curve::sell_asset_ids<SuiShiba>(&arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&v1) == 0x1::vector::length<SuiShiba>(&arg0), 0);
        let v2 = 0;
        let v3 = 0x1::vector::empty<0x2::object::UID>();
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v4 = 0x1::vector::pop_back<SuiShiba>(&mut arg0);
            assert!(id(&v4) == 0x1::vector::pop_back<0x2::object::ID>(&mut v1), 0);
            0x1::vector::push_back<0x2::object::UID>(&mut v3, burn(v4, arg2, arg3));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<SuiShiba>(arg0);
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        0x1::vector::reverse<0x2::object::UID>(&mut v3);
        (v3, arg1)
    }

    public fun set_curve(arg0: &ManagerCap, arg1: &mut Data, arg2: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg1.curve), 0);
        arg1.curve = 0x1::option::some<0x2::object::ID>(arg2);
    }

    public fun set_images(arg0: &ManagerCap, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: &mut Data, arg4: &mut Supply) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg1), 0);
        assert!(!0x1::vector::is_empty<u64>(&arg2), 0);
        assert!(0x1::vector::length<u64>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        0x1::vector::reverse<u64>(&mut arg2);
        let v0 = 0x1::vector::length<vector<u64>>(&arg4.bitmaps);
        while (!0x1::vector::is_empty<0x1::string::String>(&arg1)) {
            v0 = v0 + 1;
            let v1 = 0x1::vector::pop_back<u64>(&mut arg2);
            0x2::table::add<u64, 0x1::string::String>(&mut arg3.images, v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg1));
            let v2 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v2, v0);
            0x1::vector::push_back<u64>(&mut v2, v1);
            0x1::vector::push_back<vector<u64>>(&mut arg4.bitmaps, v2);
        };
    }

    public fun set_traits(arg0: &ManagerCap, arg1: vector<0x1::string::String>, arg2: vector<vector<0x1::string::String>>, arg3: &mut Data) {
        assert!(0x1::vector::length<0x1::string::String>(&arg1) >= 5 && 0x1::vector::length<0x1::string::String>(&arg1) <= 16, 0);
        assert!(0x1::vector::length<vector<0x1::string::String>>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg1), 0);
        assert!(0x1::vector::is_empty<0x1::string::String>(&arg3.labels), 0);
        assert!(0x1::vector::is_empty<vector<0x1::string::String>>(&arg3.values), 0);
        let v0 = 1;
        while (v0 <= 0x1::vector::length<vector<0x1::string::String>>(&arg3.values)) {
            let v1 = 0x1::vector::length<0x1::string::String>(0x1::vector::borrow<vector<0x1::string::String>>(&arg3.values, v0));
            assert!(v1 >= 5 && v1 <= 16, 9223372552250851327);
            v0 = v0 + 1;
        };
        arg3.values = arg2;
        arg3.labels = arg1;
    }

    // decompiled from Move bytecode v6
}

