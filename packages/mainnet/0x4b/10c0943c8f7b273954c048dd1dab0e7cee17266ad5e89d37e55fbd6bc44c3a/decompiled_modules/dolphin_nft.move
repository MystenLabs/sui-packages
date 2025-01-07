module 0x4b10c0943c8f7b273954c048dd1dab0e7cee17266ad5e89d37e55fbd6bc44c3a::dolphin_nft {
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
        wl_minted: 0x2::table::Table<address, u64>,
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

    public entry fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy<T0>(arg0: &0x2::random::Random, arg1: 0x2::coin::Coin<T0>, arg2: &mut GlobalConfig<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<T0>(&arg1) >= arg2.price, 1);
        let v1 = 0x1::string::utf8(b"");
        let v2 = 0x1::string::utf8(b"");
        let v3 = 0x2::url::new_unsafe_from_bytes(b"");
        let v4 = 0x2::random::new_generator(arg0, arg3);
        let v5 = 0x2::random::generate_u64_in_range(&mut v4, 0, arg2.diamond_count + arg2.gold_count + arg2.silver_count + arg2.normal_count);
        if (v5 < arg2.diamond_count) {
            v1 = 0x1::string::utf8(b"Diamond");
            v2 = 0x1::string::utf8(b"Diamond Dolphin");
            v3 = 0x2::url::new_unsafe_from_bytes(b"");
            arg2.diamond_count = arg2.diamond_count - 1;
        } else if (v5 < arg2.diamond_count + arg2.gold_count) {
            v1 = 0x1::string::utf8(b"Gold");
            v2 = 0x1::string::utf8(b"Gold Dolphin");
            v3 = 0x2::url::new_unsafe_from_bytes(b"");
            arg2.gold_count = arg2.gold_count - 1;
        } else if (v5 < arg2.diamond_count + arg2.gold_count + arg2.silver_count) {
            v1 = 0x1::string::utf8(b"Silver");
            v2 = 0x1::string::utf8(b"Silver Dolphin");
            v3 = 0x2::url::new_unsafe_from_bytes(b"");
            arg2.silver_count = arg2.silver_count - 1;
        } else if (v5 < arg2.diamond_count + arg2.gold_count + arg2.silver_count + arg2.normal_count) {
            v1 = 0x1::string::utf8(b"Normal");
            v2 = 0x1::string::utf8(b"Normal Dolphin");
            v3 = 0x2::url::new_unsafe_from_bytes(b"");
            arg2.normal_count = arg2.normal_count - 1;
        };
        let v6 = NFT{
            id          : 0x2::object::new(arg3),
            name        : v1,
            description : v2,
            url         : v3,
        };
        let v7 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v6),
            creator   : v0,
            name      : v6.name,
        };
        0x2::event::emit<NFTMinted>(v7);
        0x2::transfer::transfer<NFT>(v6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2.manager);
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
            wl_minted     : 0x2::table::new<address, u64>(arg2),
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

    public fun name(arg0: &NFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

