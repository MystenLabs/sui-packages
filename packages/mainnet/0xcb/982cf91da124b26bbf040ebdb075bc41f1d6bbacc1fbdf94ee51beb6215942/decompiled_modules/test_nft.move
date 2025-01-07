module 0xcb982cf91da124b26bbf040ebdb075bc41f1d6bbacc1fbdf94ee51beb6215942::test_nft {
    struct MinterData has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        collection_name: 0x1::string::String,
        collection_description: 0x1::string::String,
        info_nfts: vector<InfoNFT>,
        project_url: 0x1::string::String,
        price_mint: u64,
        max_nft_user_can_mint: u64,
        next_token_id: u64,
        total_supply: u64,
        whitelist: vector<address>,
        percentage_datas: vector<PercentageData>,
        buyers: 0x2::vec_map::VecMap<address, u64>,
    }

    struct PercentageData has store {
        random_table: vector<u64>,
        remaining_nfts: vector<u64>,
        tier_rates: vector<u64>,
        total_rate: u64,
        cap: u64,
        start_time: u64,
        end_time: u64,
    }

    struct InfoNFT has store {
        tier: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct TestNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        tier: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        id: 0x2::object::ID,
        buyer: address,
        id_nft: 0x2::object::ID,
        name_nft: 0x1::string::String,
    }

    struct TEST_NFT has drop {
        dummy_field: bool,
    }

    public entry fun add_whitelist(arg0: &mut MinterData, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg2) == arg0.owner, 10);
        0x1::vector::append<address>(&mut arg0.whitelist, arg1);
    }

    public entry fun config_sold(arg0: &mut MinterData, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg3) == arg0.owner, 10);
        arg0.max_nft_user_can_mint = arg1;
        arg0.total_supply = arg2;
    }

    fun get_tier_by_seed(arg0: vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        if (arg1 >= 0 && arg1 < *0x1::vector::borrow<u64>(&arg0, 0)) {
            v0 = 0;
        };
        let v1 = 0;
        loop {
            if (arg1 >= *0x1::vector::borrow<u64>(&arg0, v1) && arg1 < *0x1::vector::borrow<u64>(&arg0, v1 + 1)) {
                v0 = v1 + 1;
            };
            v1 = v1 + 1;
            if (v1 >= 0x1::vector::length<u64>(&arg0) - 1) {
                break
            };
        };
        v0
    }

    fun give_change(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= arg1, 3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    fun init(arg0: TEST_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{project_url}"));
        let v4 = 0x2::package::claim<TEST_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<TestNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<TestNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TestNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = InfoNFT{
            tier      : 0x1::string::utf8(b"Testing"),
            image_url : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
            url       : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
        };
        let v7 = InfoNFT{
            tier      : 0x1::string::utf8(b"Testing"),
            image_url : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
            url       : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
        };
        let v8 = InfoNFT{
            tier      : 0x1::string::utf8(b"Testing"),
            image_url : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
            url       : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
        };
        let v9 = InfoNFT{
            tier      : 0x1::string::utf8(b"Testing"),
            image_url : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
            url       : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
        };
        let v10 = InfoNFT{
            tier      : 0x1::string::utf8(b"Testing"),
            image_url : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
            url       : 0x1::string::utf8(b"https://ipfs.watorflow.com/ipfs/Qmbvhxfze9N2Z5Bcy6Hb5qX1EVtbZyNU3PNHYrNybtz5ob"),
        };
        let v11 = 0x1::vector::empty<InfoNFT>();
        let v12 = &mut v11;
        0x1::vector::push_back<InfoNFT>(v12, v6);
        0x1::vector::push_back<InfoNFT>(v12, v7);
        0x1::vector::push_back<InfoNFT>(v12, v8);
        0x1::vector::push_back<InfoNFT>(v12, v9);
        0x1::vector::push_back<InfoNFT>(v12, v10);
        let v13 = PercentageData{
            random_table   : vector[555, 833, 1000],
            remaining_nfts : vector[556, 278, 167],
            tier_rates     : vector[556, 278, 167],
            total_rate     : 1000,
            cap            : 1000,
            start_time     : 0x2::tx_context::epoch_timestamp_ms(arg1),
            end_time       : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v14 = PercentageData{
            random_table   : vector[4444, 7491, 8989, 9888, 10000],
            remaining_nfts : vector[4444, 2222, 1333, 800, 100],
            tier_rates     : vector[4494, 2497, 1498, 899, 112],
            total_rate     : 10000,
            cap            : 8900,
            start_time     : 0x2::tx_context::epoch_timestamp_ms(arg1),
            end_time       : 0x2::tx_context::epoch_timestamp_ms(arg1),
        };
        let v15 = 0x1::vector::empty<PercentageData>();
        let v16 = &mut v15;
        0x1::vector::push_back<PercentageData>(v16, v13);
        0x1::vector::push_back<PercentageData>(v16, v14);
        let v17 = MinterData{
            id                     : 0x2::object::new(arg1),
            owner                  : 0x2::tx_context::sender(arg1),
            balance                : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::zero<0x2::sui::SUI>(arg1)),
            collection_name        : 0x1::string::utf8(b"NFT for Testing"),
            collection_description : 0x1::string::utf8(b"This NFT for testing."),
            info_nfts              : v11,
            project_url            : 0x1::string::utf8(b"https://test.com/"),
            price_mint             : 50000000,
            max_nft_user_can_mint  : 1,
            next_token_id          : 1,
            total_supply           : 10000,
            whitelist              : 0x1::vector::empty<address>(),
            percentage_datas       : v15,
            buyers                 : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<MinterData>(v17);
    }

    public entry fun mint_desui_nft(arg0: &mut MinterData, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg1) == arg0.owner, 10);
        assert!(arg0.next_token_id <= arg0.total_supply, 2);
        assert!(arg0.next_token_id <= 100, 12);
        let v0 = 0x1::vector::borrow<InfoNFT>(&arg0.info_nfts, 4);
        let v1 = arg0.collection_name;
        0x1::string::append(&mut v1, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v1, num_str(arg0.next_token_id));
        let v2 = TestNFT{
            id          : 0x2::object::new(arg1),
            name        : v1,
            tier        : v0.tier,
            description : arg0.collection_description,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(v0.url)),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(v0.image_url)),
            project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
        };
        let v3 = MintNFTEvent{
            id       : 0x2::object::uid_to_inner(&v2.id),
            buyer    : 0x2::tx_context::sender(arg1),
            id_nft   : 0x2::object::uid_to_inner(&v2.id),
            name_nft : v1,
        };
        0x2::event::emit<MintNFTEvent>(v3);
        0x2::transfer::public_transfer<TestNFT>(v2, 0x2::tx_context::sender(arg1));
        arg0.next_token_id = arg0.next_token_id + 1;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun paid_mint(arg0: &mut MinterData, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (!0x2::vec_map::contains<address, u64>(&arg0.buyers, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.buyers, v0, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.buyers, &v0);
        let v2 = 0x1::vector::borrow_mut<PercentageData>(&mut arg0.percentage_datas, 1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v2.start_time, 13);
        assert!(0x2::clock::timestamp_ms(arg2) <= v2.end_time, 14);
        assert!(*v1 < arg0.max_nft_user_can_mint, 11);
        assert!(arg0.next_token_id <= arg0.total_supply, 2);
        assert!(arg0.next_token_id <= v2.cap, 12);
        *v1 = *v1 + 1;
        let v3;
        let v4;
        loop {
            v4 = (0x2::clock::timestamp_ms(arg2) + arg0.next_token_id) % v2.total_rate;
            v3 = get_tier_by_seed(v2.random_table, v4);
            if (*0x1::vector::borrow<u64>(&v2.remaining_nfts, v3) == 0) {
                *0x1::vector::borrow_mut<u64>(&mut v2.tier_rates, v3) = 0;
                set_random_table(v2);
            };
            if (*0x1::vector::borrow<u64>(&v2.remaining_nfts, v3) != 0) {
                break
            };
        };
        let v5 = 0x1::vector::borrow<InfoNFT>(&arg0.info_nfts, v3);
        let v6 = arg0.collection_name;
        0x1::string::append(&mut v6, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v6, num_str(arg0.next_token_id));
        let v7 = TestNFT{
            id          : 0x2::object::new(arg3),
            name        : v6,
            tier        : v5.tier,
            description : arg0.collection_description,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(v5.url)),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(v5.image_url)),
            project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
        };
        let v8 = MintNFTEvent{
            id       : 0x2::object::uid_to_inner(&v7.id),
            buyer    : 0x2::tx_context::sender(arg3),
            id_nft   : 0x2::object::uid_to_inner(&v7.id),
            name_nft : v6,
        };
        0x2::event::emit<MintNFTEvent>(v8);
        0x2::transfer::public_transfer<TestNFT>(v7, v0);
        arg0.next_token_id = arg0.next_token_id + 1;
        let v9 = 0x1::vector::borrow_mut<u64>(&mut v2.remaining_nfts, v3);
        *v9 = *v9 - 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(give_change(arg1, arg0.price_mint, arg3)));
        0x1::debug::print<u64>(&v4);
    }

    fun set_random_table(arg0: &mut PercentageData) {
        arg0.total_rate = 0;
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        loop {
            arg0.total_rate = arg0.total_rate + *0x1::vector::borrow<u64>(&arg0.tier_rates, v1);
            0x1::vector::push_back<u64>(&mut v0, arg0.total_rate);
            v1 = v1 + 1;
            if (v1 >= 0x1::vector::length<u64>(&arg0.tier_rates)) {
                break
            };
        };
        arg0.random_table = v0;
    }

    public entry fun setup_time_round(arg0: &mut MinterData, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg4) == arg0.owner, 10);
        let v0 = 0x1::vector::borrow_mut<PercentageData>(&mut arg0.percentage_datas, arg1);
        v0.start_time = arg2;
        v0.end_time = arg3;
    }

    public entry fun whitelist_mint(arg0: &mut MinterData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (!0x2::vec_map::contains<address, u64>(&arg0.buyers, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.buyers, v0, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.buyers, &v0);
        let v2 = 0x1::vector::borrow_mut<PercentageData>(&mut arg0.percentage_datas, 0);
        assert!(0x2::clock::timestamp_ms(arg1) >= v2.start_time, 13);
        assert!(0x2::clock::timestamp_ms(arg1) <= v2.end_time, 14);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 9);
        assert!(*v1 < arg0.max_nft_user_can_mint, 11);
        assert!(arg0.next_token_id <= arg0.total_supply, 2);
        assert!(arg0.next_token_id <= v2.cap, 12);
        *v1 = *v1 + 1;
        let v3;
        let v4;
        loop {
            v3 = (0x2::clock::timestamp_ms(arg1) + arg0.next_token_id) % v2.total_rate;
            v4 = get_tier_by_seed(v2.random_table, v3);
            if (*0x1::vector::borrow<u64>(&v2.remaining_nfts, v4) == 0) {
                *0x1::vector::borrow_mut<u64>(&mut v2.tier_rates, v4) = 0;
                set_random_table(v2);
            };
            if (*0x1::vector::borrow<u64>(&v2.remaining_nfts, v4) != 0) {
                break
            };
        };
        let v5 = 0x1::vector::borrow<InfoNFT>(&arg0.info_nfts, v4);
        let v6 = arg0.collection_name;
        0x1::string::append(&mut v6, 0x1::string::utf8(b" #"));
        0x1::string::append(&mut v6, num_str(arg0.next_token_id));
        let v7 = TestNFT{
            id          : 0x2::object::new(arg2),
            name        : v6,
            tier        : v5.tier,
            description : arg0.collection_description,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(v5.url)),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(v5.image_url)),
            project_url : 0x2::url::new_unsafe(0x1::string::to_ascii(arg0.project_url)),
        };
        let v8 = MintNFTEvent{
            id       : 0x2::object::uid_to_inner(&v7.id),
            buyer    : 0x2::tx_context::sender(arg2),
            id_nft   : 0x2::object::uid_to_inner(&v7.id),
            name_nft : v6,
        };
        0x2::event::emit<MintNFTEvent>(v8);
        0x2::transfer::public_transfer<TestNFT>(v7, v0);
        arg0.next_token_id = arg0.next_token_id + 1;
        let v9 = 0x1::vector::borrow_mut<u64>(&mut v2.remaining_nfts, v4);
        0x1::debug::print<u64>(&v3);
        0x1::debug::print<u64>(&v4);
        *v9 = *v9 - 1;
    }

    public entry fun withdraw(arg0: &mut MinterData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xd405b4b6cc3b704270de1452e0c37557e372c638e19c9008ed55a56329016d64 || 0x2::tx_context::sender(arg2) == arg0.owner, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

