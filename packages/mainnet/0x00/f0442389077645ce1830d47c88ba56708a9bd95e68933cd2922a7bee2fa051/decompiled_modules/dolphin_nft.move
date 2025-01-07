module 0xf0442389077645ce1830d47c88ba56708a9bd95e68933cd2922a7bee2fa051::dolphin_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct DOLPHIN_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCapability has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct GlobalConfig<phantom T0> has store, key {
        id: 0x2::object::UID,
        manager: address,
        limit: u64,
        diamond_count: u64,
        gold_count: u64,
        silver_count: u64,
        normal_count: u64,
        price: u64,
        wl_mint: 0x2::table::Table<address, u64>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun transfer(arg0: NFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<NFT>(arg0, arg1);
    }

    public fun url(arg0: &NFT) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun add_whitelist<T0>(arg0: &mut GlobalConfig<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            0x2::table::add<address, u64>(&mut arg0.wl_mint, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<u64>(&mut arg2));
        };
    }

    public entry fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy<T0>(arg0: &0x2::random::Random, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut GlobalConfig<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::coin::value<T0>(&arg1) >= arg3.price * arg2, 1);
        let v1 = 0;
        while (v1 < arg2) {
            let v2 = mint<T0>(arg0, arg3, arg4);
            0x2::transfer::transfer<NFT>(v2, v0);
            v1 = v1 + 1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3.manager);
    }

    entry fun create_nft_config<T0>(arg0: &AdminCapability, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig<T0>{
            id            : 0x2::object::new(arg2),
            manager       : 0x2::tx_context::sender(arg2),
            limit         : 1000,
            diamond_count : 50,
            gold_count    : 250,
            silver_count  : 300,
            normal_count  : 400,
            price         : arg1,
            wl_mint       : 0x2::table::new<address, u64>(arg2),
        };
        0x2::transfer::share_object<GlobalConfig<T0>>(v0);
    }

    public fun description(arg0: &NFT) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: DOLPHIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
    }

    fun mint<T0>(arg0: &0x2::random::Random, arg1: &mut GlobalConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x2::url::new_unsafe_from_bytes(b"");
        let v3 = 0x2::random::new_generator(arg0, arg2);
        let v4 = 0x2::random::generate_u64_in_range(&mut v3, 0, arg1.diamond_count + arg1.gold_count + arg1.silver_count + arg1.normal_count);
        if (v4 < arg1.diamond_count) {
            v0 = 0x1::string::utf8(b"Diamond");
            v1 = 0x1::string::utf8(b"Diamond Dolphin");
            v2 = 0x2::url::new_unsafe_from_bytes(b"");
            arg1.diamond_count = arg1.diamond_count - 1;
        } else if (v4 < arg1.diamond_count + arg1.gold_count) {
            v0 = 0x1::string::utf8(b"Gold");
            v1 = 0x1::string::utf8(b"Gold Dolphin");
            v2 = 0x2::url::new_unsafe_from_bytes(b"");
            arg1.gold_count = arg1.gold_count - 1;
        } else if (v4 < arg1.diamond_count + arg1.gold_count + arg1.silver_count) {
            v0 = 0x1::string::utf8(b"Silver");
            v1 = 0x1::string::utf8(b"Silver Dolphin");
            v2 = 0x2::url::new_unsafe_from_bytes(b"");
            arg1.silver_count = arg1.silver_count - 1;
        } else if (v4 < arg1.diamond_count + arg1.gold_count + arg1.silver_count + arg1.normal_count) {
            v0 = 0x1::string::utf8(b"Normal");
            v1 = 0x1::string::utf8(b"Normal Dolphin");
            v2 = 0x2::url::new_unsafe_from_bytes(b"");
            arg1.normal_count = arg1.normal_count - 1;
        };
        let v5 = NFT{
            id          : 0x2::object::new(arg2),
            name        : v0,
            description : v1,
            url         : v2,
        };
        let v6 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v5),
            creator   : 0x2::tx_context::sender(arg2),
            name      : v5.name,
        };
        0x2::event::emit<NFTMinted>(v6);
        v5
    }

    entry fun mint_whitelist<T0>(arg0: &0x2::random::Random, arg1: &mut GlobalConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, u64>(&arg1.wl_mint, v0), 4);
        let v1 = 0;
        while (v1 < *0x2::table::borrow<address, u64>(&arg1.wl_mint, v0)) {
            let v2 = mint<T0>(arg0, arg1, arg2);
            0x2::transfer::transfer<NFT>(v2, v0);
            v1 = v1 + 1;
        };
        0x2::table::remove<address, u64>(&mut arg1.wl_mint, v0);
    }

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun remove_whitelist<T0>(arg0: &mut GlobalConfig<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.manager == 0x2::tx_context::sender(arg3), 2);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2), 3);
        while (0x1::vector::length<address>(&arg1) > 0) {
            0x1::vector::pop_back<u64>(&mut arg2);
            0x2::table::remove<address, u64>(&mut arg0.wl_mint, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    // decompiled from Move bytecode v6
}

