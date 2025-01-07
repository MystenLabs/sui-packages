module 0x35678f570c66f1d0cbdafac51879f8f6f402ec17c48993922cbde445750082c5::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MintConfig has store, key {
        id: 0x2::object::UID,
        count: u64,
        price: u64,
        addr: address,
        max: 0x1::option::Option<u64>,
        addr_max_count: 0x1::option::Option<u64>,
        mint_condition: 0x2::table::Table<address, u64>,
        start_time: 0x1::option::Option<u64>,
    }

    struct TestNetNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTBurned has copy, drop {
        object_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"collection"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"img_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Torao"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Torao"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Torao"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TestNetNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TestNetNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestNetNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = if (0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0)
        };
        let v7 = if (0 == 0) {
            0x1::option::none<u64>()
        } else {
            0x1::option::some<u64>(0)
        };
        let v8 = MintConfig{
            id             : 0x2::object::new(arg1),
            count          : 0,
            price          : 0,
            addr           : 0x2::tx_context::sender(arg1),
            max            : v6,
            addr_max_count : v7,
            mint_condition : 0x2::table::new<address, u64>(arg1),
            start_time     : 0x1::option::none<u64>(),
        };
        0x2::transfer::public_share_object<MintConfig>(v8);
    }

    public entry fun manage_mint_cap_addr_max_count(arg0: &0x2::package::Publisher, arg1: &mut MintConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<NFT>(arg0), 324);
        arg1.addr_max_count = 0x1::option::some<u64>(arg2);
    }

    public entry fun manage_mint_cap_address(arg0: &0x2::package::Publisher, arg1: &mut MintConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<NFT>(arg0), 324);
        arg1.addr = arg2;
    }

    public entry fun manage_mint_cap_max(arg0: &0x2::package::Publisher, arg1: &mut MintConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<NFT>(arg0), 324);
        arg1.max = 0x1::option::some<u64>(arg2);
    }

    public entry fun manage_mint_cap_price(arg0: &0x2::package::Publisher, arg1: &mut MintConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<NFT>(arg0), 324);
        arg1.price = arg2;
    }

    public entry fun manage_mint_cap_start_time(arg0: &0x2::package::Publisher, arg1: &mut MintConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<NFT>(arg0), 324);
        arg1.start_time = 0x1::option::some<u64>(arg2);
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::string::utf8(b"Torao");
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        arg0.count = arg0.count + 1;
        let v2 = 18446744073709551615;
        assert!(arg0.count <= *0x1::option::borrow_with_default<u64>(&arg0.max, &v2), 141);
        if (0x2::table::contains<address, u64>(&arg0.mint_condition, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.mint_condition, v0);
            let v4 = 18446744073709551615;
            assert!(*v3 + 1 <= *0x1::option::borrow_with_default<u64>(&arg0.addr_max_count, &v4), 64);
            *v3 = *v3 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.mint_condition, v0, 1);
        };
        0x1::string::append(&mut v1, num_to_string(arg0.count));
        let v5 = TestNetNFT{
            id        : 0x2::object::new(arg1),
            name      : v1,
            url       : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZfjpjxLw3oE28Ac41SuFnytKVJpkV8Y6ZNq5m3JB9jzN/3140.jpg"),
            image_url : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmZfjpjxLw3oE28Ac41SuFnytKVJpkV8Y6ZNq5m3JB9jzN/3140.jpg"),
            img_url   : 0x1::string::utf8(b"https://ipfs.io/ipfs/QmZfjpjxLw3oE28Ac41SuFnytKVJpkV8Y6ZNq5m3JB9jzN/3140.jpg"),
        };
        let v6 = NFTMinted{
            object_id : 0x2::object::id<TestNetNFT>(&v5),
            creator   : v0,
            name      : v5.name,
            url       : v5.url,
        };
        0x2::event::emit<NFTMinted>(v6);
        0x2::transfer::public_transfer<TestNetNFT>(v5, v0);
    }

    public fun name(arg0: &TestNetNFT) : &0x1::string::String {
        &arg0.name
    }

    fun num_to_string(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        if (arg0 == 0) {
            0x1::vector::push_back<u8>(&mut v0, 48);
        } else {
            while (arg0 != 0) {
                0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
                arg0 = arg0 / 10;
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

