module 0xd4f2ed32137798ffe050a1e4961661f5ad9522b8a3d6d016508adb12fe9d6b46::dolphin_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        rarity: 0x1::string::String,
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
        url: 0x2::url::Url,
        rarity: u64,
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
            id     : v0,
            url    : _,
            rarity : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    entry fun buy<T0>(arg0: &0x2::random::Random, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut GlobalConfig<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, u64>(&arg3.wl_mint, v0), 4);
        assert!(0x2::coin::value<T0>(&arg1) >= arg3.price * arg2, 1);
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg3.wl_mint, v0);
        assert!(*v1 >= arg2, 3);
        *v1 = *v1 - arg2;
        let v2 = 0;
        while (v2 < arg2) {
            let v3 = mint<T0>(arg0, arg3, arg4);
            0x2::transfer::transfer<NFT>(v3, v0);
            v2 = v2 + 1;
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

    public fun get_whitelist<T0>(arg0: &GlobalConfig<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.wl_mint, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.wl_mint, arg1)
        }
    }

    fun init(arg0: DOLPHIN_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapability{
            id    : 0x2::object::new(arg1),
            admin : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<AdminCapability>(v0, 0x2::tx_context::sender(arg1));
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
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{Dolphin Agent OG NFT}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The official collection of AgentStarter, OG NFTs from the Dolphin Agent Ecosystem, is a crucial piece in the Ecosystem, directly related to the operations of the AgentStarter launchpad platform."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://dolphinagent.com/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Dolphin Agent"));
        let v5 = 0x2::package::claim<DOLPHIN_NFT>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = NFT{
            id     : 0x2::object::new(arg1),
            url    : 0x2::url::new_unsafe_from_bytes(b"https://public.dolphinagent.com/dolphin-agent/assets/dolphin-collection.png"),
            rarity : 0x1::string::utf8(b"Genesis"),
        };
        0x2::transfer::public_transfer<NFT>(v7, 0x2::tx_context::sender(arg1));
    }

    fun mint<T0>(arg0: &0x2::random::Random, arg1: &mut GlobalConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) : NFT {
        let v0 = 0x2::url::new_unsafe_from_bytes(b"");
        let v1 = 0x2::random::new_generator(arg0, arg2);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, arg1.diamond_count + arg1.gold_count + arg1.silver_count + arg1.normal_count);
        let v3 = 0;
        let v4 = b"Normal";
        if (v2 < arg1.diamond_count) {
            v0 = 0x2::url::new_unsafe_from_bytes(b"https://public.dolphinagent.com/dolphin-agent/assets/diamond.jpg");
            arg1.diamond_count = arg1.diamond_count - 1;
            v3 = 3;
            v4 = b"Diamond";
        } else if (v2 < arg1.diamond_count + arg1.gold_count) {
            v0 = 0x2::url::new_unsafe_from_bytes(b"https://public.dolphinagent.com/dolphin-agent/assets/gold.jpg");
            arg1.gold_count = arg1.gold_count - 1;
            v3 = 2;
            v4 = b"Gold";
        } else if (v2 < arg1.diamond_count + arg1.gold_count + arg1.silver_count) {
            v0 = 0x2::url::new_unsafe_from_bytes(b"https://public.dolphinagent.com/dolphin-agent/assets/silver.jpg");
            arg1.silver_count = arg1.silver_count - 1;
            v3 = 1;
            v4 = b"Silver";
        } else if (v2 < arg1.diamond_count + arg1.gold_count + arg1.silver_count + arg1.normal_count) {
            v0 = 0x2::url::new_unsafe_from_bytes(b"https://public.dolphinagent.com/dolphin-agent/assets/normal.jpg");
            arg1.normal_count = arg1.normal_count - 1;
            v3 = 0;
            v4 = b"Normal";
        };
        let v5 = NFT{
            id     : 0x2::object::new(arg2),
            url    : v0,
            rarity : 0x1::string::utf8(v4),
        };
        let v6 = NFTMinted{
            object_id : 0x2::object::id<NFT>(&v5),
            creator   : 0x2::tx_context::sender(arg2),
            url       : v5.url,
            rarity    : v3,
        };
        0x2::event::emit<NFTMinted>(v6);
        v5
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

