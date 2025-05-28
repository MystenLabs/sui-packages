module 0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage {
    struct NFTStorage has store, key {
        id: 0x2::object::UID,
        nfts: 0x2::linked_table::LinkedTable<0x2::object::ID, 0x2::object::ID>,
        owners: 0x2::table::Table<address, vector<0x2::object::ID>>,
        available_numbers: vector<u16>,
        is_initialized: bool,
    }

    struct TestNfts has store, key {
        id: 0x2::object::UID,
        nft_number: u16,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
        walrus_id: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        hash: 0x1::string::String,
        creator: address,
        treasury_id: 0x2::object::ID,
        is_revealed: bool,
    }

    public(friend) fun id(arg0: &TestNfts) : 0x2::object::ID {
        0x2::object::id<TestNfts>(arg0)
    }

    public(friend) fun add_to_minted_nfts(arg0: &mut NFTStorage, arg1: &TestNfts) {
        0x2::linked_table::push_back<0x2::object::ID, 0x2::object::ID>(&mut arg0.nfts, 0x2::object::id<TestNfts>(arg1), arg1.treasury_id);
    }

    public fun admin_initialize_available_nfts(arg0: &mut NFTStorage, arg1: &0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::options::OptionsStorage, arg2: vector<u16>, arg3: &0x2::tx_context::TxContext) {
        0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::options::assert_is_admin(arg1, arg3);
        assert!(arg0.is_initialized == false, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg2)) {
            let v1 = *0x1::vector::borrow<u16>(&arg2, v0);
            if (!0x1::vector::contains<u16>(&arg0.available_numbers, &v1)) {
                0x1::vector::push_back<u16>(&mut arg0.available_numbers, v1);
            };
            v0 = v0 + 1;
        };
        if ((0x1::vector::length<u16>(&arg0.available_numbers) as u16) == 3333) {
            arg0.is_initialized = true;
        };
    }

    public(friend) fun create_nft<T0: drop>(arg0: &mut NFTStorage, arg1: &mut 0x2::tx_context::TxContext) : TestNfts {
        let v0 = retrieve_available_nft(arg0);
        let v1 = TestNfts{
            id           : 0x2::object::new(arg1),
            nft_number   : v0,
            description  : 0x1::string::utf8(b"Unrevealed..."),
            image_url    : 0x1::string::utf8(b"https://zenfrogs.com/zen-unrevealed.png"),
            url          : 0x1::string::utf8(b"https://zenfrogs.com/zen-unrevealed.png"),
            walrus_id    : 0x1::string::utf8(b"..."),
            metadata_uri : 0x1::string::utf8(b"..."),
            hash         : 0x1::string::utf8(b"..."),
            creator      : 0x2::tx_context::sender(arg1),
            treasury_id  : 0x2::object::id<NFTStorage>(arg0),
            is_revealed  : false,
        };
        let v2 = 0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::voting::create_treasury<T0>(v0, 0x2::object::id<TestNfts>(&v1), arg1);
        v1.treasury_id = 0x2::object::id<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::voting::VotingTreasury<T0>>(&v2);
        0x2::transfer::public_share_object<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::voting::VotingTreasury<T0>>(v2);
        add_to_minted_nfts(arg0, &v1);
        v1
    }

    public(friend) fun create_nft_storage(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTStorage{
            id                : 0x2::object::new(arg0),
            nfts              : 0x2::linked_table::new<0x2::object::ID, 0x2::object::ID>(arg0),
            owners            : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            available_numbers : 0x1::vector::empty<u16>(),
            is_initialized    : false,
        };
        0x2::transfer::share_object<NFTStorage>(v0);
    }

    public fun get_nfts_by_creator(arg0: &NFTStorage, arg1: address) : &vector<0x2::object::ID> {
        0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.owners, arg1)
    }

    public(friend) fun is_revealed(arg0: &TestNfts) : bool {
        arg0.is_revealed
    }

    public(friend) fun number(arg0: &TestNfts) : u16 {
        arg0.nft_number
    }

    public(friend) fun retrieve_available_nft(arg0: &mut NFTStorage) : u16 {
        0x1::vector::pop_back<u16>(&mut arg0.available_numbers)
    }

    public(friend) fun set_nft_data(arg0: &mut TestNfts, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
        arg0.hash = 0x1::string::utf8(arg2);
        arg0.image_url = 0x1::string::utf8(arg3);
        arg0.url = 0x1::string::utf8(arg3);
        arg0.walrus_id = 0x1::string::utf8(arg4);
        arg0.metadata_uri = 0x1::string::utf8(arg5);
        arg0.is_revealed = true;
    }

    public(friend) fun track_mint_owned_count(arg0: &mut NFTStorage, arg1: address, arg2: 0x2::object::ID) : u64 {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.owners, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.owners, arg1);
            0x1::vector::push_back<0x2::object::ID>(v1, arg2);
            0x1::vector::length<0x2::object::ID>(v1)
        } else {
            let v2 = 0x1::vector::empty<0x2::object::ID>();
            0x1::vector::push_back<0x2::object::ID>(&mut v2, arg2);
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.owners, arg1, v2);
            1
        }
    }

    // decompiled from Move bytecode v6
}

