module 0x458a9540bd46811ae25ce4e2e19e8c20adda58fc500f0a3a47e3297207d4b648::collection {
    struct CreepyPopsCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreepyPopsCollection has key {
        id: 0x2::object::UID,
        owner: address,
        minted: u64,
        max_supply: u64,
        price: u64,
        price_whitelist: u64,
        release: u64,
        whitelist: 0x2::vec_set::VecSet<address>,
    }

    struct CreepyPopsNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
        website: 0x2::url::Url,
        fields: 0x2::url::Url,
    }

    struct CreepyPopsNftMinted has copy, drop {
        id: 0x2::object::ID,
        creator: address,
    }

    fun pay<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::pay::split_and_transfer<T0>(&mut arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg3));
    }

    fun url(arg0: vector<vector<u8>>) : 0x2::url::Url {
        0x1::vector::reverse<vector<u8>>(&mut arg0);
        let v0 = 0x1::vector::empty<u8>();
        while (!0x1::vector::is_empty<vector<u8>>(&arg0)) {
            0x1::vector::append<u8>(&mut v0, 0x1::vector::pop_back<vector<u8>>(&mut arg0));
        };
        0x1::vector::destroy_empty<vector<u8>>(arg0);
        0x2::url::new_unsafe_from_bytes(v0)
    }

    public entry fun add_to_whitelist(arg0: &CreepyPopsCap, arg1: &mut CreepyPopsCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_released(arg1, arg3), 1);
        0x2::vec_set::insert<address>(&mut arg1.whitelist, arg2);
    }

    public entry fun add_to_whitelist_multiple(arg0: &CreepyPopsCap, arg1: &mut CreepyPopsCollection, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (!0x1::vector::is_empty<address>(&arg2)) {
            add_to_whitelist(arg0, arg1, 0x1::vector::pop_back<address>(&mut arg2), arg3);
        };
    }

    fun get_name(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"#");
        0x1::string::insert(&mut v0, 0, 0x1::string::utf8(b"CreepyPops"));
        let v1 = 0x1::string::utf8(int_to_bytes(arg0));
        0x1::string::insert(&mut v1, 0, v0);
        v1
    }

    fun get_price(arg0: &mut CreepyPopsCollection, arg1: &mut 0x2::tx_context::TxContext) : (bool, u64) {
        let v0 = false;
        let v1 = arg0.price;
        let v2 = is_released(arg0, arg1);
        if (!v2) {
            let v3 = is_whitelisted(arg0, arg1);
            v0 = v3;
            assert!(v3, 2);
            v1 = arg0.price_whitelist;
        };
        (v0, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CreepyPopsCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CreepyPopsCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CreepyPopsCollection{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            minted          : 0,
            max_supply      : 1501,
            price           : 1990000000,
            price_whitelist : 0,
            release         : 0,
            whitelist       : new_set<address>(vector[]),
        };
        0x2::transfer::share_object<CreepyPopsCollection>(v1);
    }

    fun int_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun is_released(arg0: &mut CreepyPopsCollection, arg1: &mut 0x2::tx_context::TxContext) : bool {
        arg0.release < 0x2::tx_context::epoch(arg1)
    }

    public entry fun is_whitelisted(arg0: &mut CreepyPopsCollection, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::contains<address>(&arg0.whitelist, &v0)
    }

    fun join_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>) : 0x2::coin::Coin<T0> {
        assert!(0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0, 3);
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
        while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
            0x2::coin::join<T0>(&mut v0, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
        v0
    }

    public entry fun mint(arg0: &mut CreepyPopsCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.max_supply, 0);
        let (v0, v1) = get_price(arg0, arg2);
        pay<0x2::sui::SUI>(arg1, v1, arg0.owner, arg2);
        let v2 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v2, b"https://creepy-pops.vercel.app/");
        let v3 = 0x1::vector::empty<vector<u8>>();
        let v4 = &mut v3;
        0x1::vector::push_back<vector<u8>>(v4, b"ipfs://bafybeihmh3u3kowucic5pdgvvepgioqd2oakalylrhr233g5fmadb7eyau/");
        0x1::vector::push_back<vector<u8>>(v4, int_to_bytes(arg0.minted + 1));
        0x1::vector::push_back<vector<u8>>(v4, b".json");
        let v5 = CreepyPopsNft{
            id          : 0x2::object::new(arg2),
            name        : get_name(arg0.minted + 1),
            description : 0x1::string::utf8(b"CreepyPops Nft"),
            creator     : 0x1::string::utf8(b"CreepyPops Team"),
            website     : url(v2),
            fields      : url(v3),
        };
        let v6 = CreepyPopsNftMinted{
            id      : 0x2::object::uid_to_inner(&v5.id),
            creator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<CreepyPopsNftMinted>(v6);
        0x2::transfer::transfer<CreepyPopsNft>(v5, 0x2::tx_context::sender(arg2));
        arg0.minted = arg0.minted + 1;
        if (v0) {
            let v7 = 0x2::tx_context::sender(arg2);
            0x2::vec_set::remove<address>(&mut arg0.whitelist, &v7);
        };
    }

    public entry fun mint_with_multiple(arg0: &mut CreepyPopsCollection, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        mint(arg0, join_coins<0x2::sui::SUI>(arg1), arg2);
    }

    fun new_set<T0: copy + drop>(arg0: vector<T0>) : 0x2::vec_set::VecSet<T0> {
        let v0 = 0x2::vec_set::empty<T0>();
        while (!0x1::vector::is_empty<T0>(&arg0)) {
            0x2::vec_set::insert<T0>(&mut v0, 0x1::vector::pop_back<T0>(&mut arg0));
        };
        v0
    }

    public entry fun set_price(arg0: &CreepyPopsCap, arg1: &mut CreepyPopsCollection, arg2: u64) {
        arg1.price = arg2;
    }

    public entry fun set_release(arg0: &CreepyPopsCap, arg1: &mut CreepyPopsCollection, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_released(arg1, arg3), 1);
        arg1.release = arg2;
    }

    // decompiled from Move bytecode v6
}

