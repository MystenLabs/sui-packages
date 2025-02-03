module 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct MarketGlobal has key {
        id: 0x2::object::UID,
        balance_SHUI: 0x2::balance::Balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>,
        balance_SUI: 0x2::balance::Balance<0x2::sui::SUI>,
        creator: address,
        game_sales: 0x2::linked_table::LinkedTable<u64, vector<OnSale>>,
        version: u64,
    }

    struct TransactionRecord has copy, drop {
        seller: address,
        buyer: address,
        name: 0x1::string::String,
        num: u64,
        price: u64,
        price_gas: u64,
        type: 0x1::string::String,
        coinType: 0x1::string::String,
        time: u64,
    }

    struct OnSale has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        num: u64,
        price: u64,
        coinType: 0x1::string::String,
        owner: address,
        metaId: u64,
        type: 0x1::string::String,
        onsale_time: u64,
        bag: 0x2::bag::Bag,
        nftType: 0x1::string::String,
        nft_addr: address,
    }

    public fun change_owner(arg0: &mut MarketGlobal, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 7);
        arg0.creator = arg1;
    }

    public entry fun get_game_sales(arg0: &MarketGlobal, arg1: &0x2::clock::Clock) : 0x1::string::String {
        let v0 = &arg0.game_sales;
        if (0x2::linked_table::is_empty<u64, vector<OnSale>>(v0)) {
            return 0x1::string::utf8(b"none")
        };
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x2::linked_table::front<u64, vector<OnSale>>(v0);
        0x1::vector::append<u8>(&mut v1, print_onsale_vector(0x2::linked_table::borrow<u64, vector<OnSale>>(v0, *0x1::option::borrow<u64>(v2))));
        let v3 = 0x2::linked_table::next<u64, vector<OnSale>>(v0, *0x1::option::borrow<u64>(v2));
        while (0x1::option::is_some<u64>(v3)) {
            let v4 = *0x1::option::borrow<u64>(v3);
            0x1::vector::append<u8>(&mut v1, print_onsale_vector(0x2::linked_table::borrow<u64, vector<OnSale>>(v0, v4)));
            v3 = 0x2::linked_table::next<u64, vector<OnSale>>(v0, v4);
        };
        0x1::string::utf8(v1)
    }

    public fun increment(arg0: &mut MarketGlobal, arg1: u64) {
        assert!(arg0.version == 0, 8);
        arg0.version = arg1;
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketGlobal{
            id           : 0x2::object::new(arg1),
            balance_SHUI : 0x2::balance::zero<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(),
            balance_SUI  : 0x2::balance::zero<0x2::sui::SUI>(),
            creator      : 0x2::tx_context::sender(arg1),
            game_sales   : 0x2::linked_table::new<u64, vector<OnSale>>(arg1),
            version      : 0,
        };
        0x2::transfer::share_object<MarketGlobal>(v0);
    }

    public entry fun list_game_item(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::tree_of_life::extract_drop_items(arg1, arg2, arg4);
        let v0 = &mut arg0.game_sales;
        let v1 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1);
        assert!(arg5 == 0x1::string::utf8(b"SUI") || arg5 == 0x1::string::utf8(b"SHUI"), 5);
        if (0x2::linked_table::contains<u64, vector<OnSale>>(v0, v1)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(v0, v1);
            assert!(0x1::vector::length<OnSale>(v2) <= 10, 4);
            0x1::vector::push_back<OnSale>(v2, new_sale(v1, arg2, arg4, arg3, arg5, arg6, 0x1::string::utf8(b"gamefi"), arg7));
        } else {
            let v3 = 0x1::vector::empty<OnSale>();
            0x1::vector::push_back<OnSale>(&mut v3, new_sale(v1, arg2, arg4, arg3, arg5, arg6, 0x1::string::utf8(b"gamefi"), arg7));
            0x2::linked_table::push_back<u64, vector<OnSale>>(v0, v1, v3);
        };
    }

    public entry fun list_nft_item<T0: store + key>(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = &mut arg0.game_sales;
        let v1 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1);
        assert!(arg4 == 0x1::string::utf8(b"SUI") || arg4 == 0x1::string::utf8(b"SHUI"), 5);
        if (0x2::linked_table::contains<u64, vector<OnSale>>(v0, v1)) {
            let v2 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(v0, v1);
            assert!(0x1::vector::length<OnSale>(v2) <= 10, 4);
            0x1::vector::push_back<OnSale>(v2, new_nft_sale<T0>(0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1), arg2, arg3, arg4, arg5, 0x1::string::utf8(b"nft"), arg6, arg7));
        } else {
            let v3 = 0x1::vector::empty<OnSale>();
            0x1::vector::push_back<OnSale>(&mut v3, new_nft_sale<T0>(0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1), arg2, arg3, arg4, arg5, 0x1::string::utf8(b"nft"), arg6, arg7));
            0x2::linked_table::push_back<u64, vector<OnSale>>(v0, v1, v3);
        };
    }

    public fun merge_coins<T0>(arg0: vector<0x2::coin::Coin<T0>>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::vector::length<0x2::coin::Coin<T0>>(&arg0) > 0) {
            let v1 = 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0);
            while (!0x1::vector::is_empty<0x2::coin::Coin<T0>>(&arg0)) {
                0x2::coin::join<T0>(&mut v1, 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut arg0));
            };
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            v1
        } else {
            0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(arg0);
            0x2::coin::zero<T0>(arg1)
        }
    }

    fun new_nft_sale<T0: store + key>(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: 0x1::string::String, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) : OnSale {
        let v0 = 0x2::bag::new(arg7);
        let v1 = 0x1::type_name::get<T0>();
        0x2::bag::add<u64, T0>(&mut v0, 0, arg6);
        OnSale{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            num         : 1,
            price       : arg2,
            coinType    : arg3,
            owner       : 0x2::tx_context::sender(arg7),
            metaId      : arg0,
            type        : arg5,
            onsale_time : 0x2::clock::timestamp_ms(arg4),
            bag         : v0,
            nftType     : 0x1::string::from_ascii(*0x1::type_name::borrow_string(&v1)),
            nft_addr    : 0x2::object::id_address<T0>(&arg6),
        }
    }

    fun new_sale(arg0: u64, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : OnSale {
        OnSale{
            id          : 0x2::object::new(arg7),
            name        : arg1,
            num         : arg2,
            price       : arg3,
            coinType    : arg4,
            owner       : 0x2::tx_context::sender(arg7),
            metaId      : arg0,
            type        : arg6,
            onsale_time : 0x2::clock::timestamp_ms(arg5),
            bag         : 0x2::bag::new(arg7),
            nftType     : 0x1::string::utf8(b""),
            nft_addr    : @0x0,
        }
    }

    fun numbers_to_ascii_vector(arg0: u64) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    fun print_onsale_vector(arg0: &vector<OnSale>) : vector<u8> {
        let v0 = 0x1::ascii::byte(0x1::ascii::char(44));
        let v1 = 0x1::string::utf8(b"");
        let v2 = *0x1::string::bytes(&v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<OnSale>(arg0)) {
            let v4 = 0x1::vector::borrow<OnSale>(arg0, v3);
            let v5 = 0x2::address::to_string(0x2::object::uid_to_address(&v4.id));
            let v6 = 0x1::string::utf8(b"0x");
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v6));
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v5));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4.name));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4.nftType));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(v4.num));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(v4.price));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4.coinType));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v4.type));
            0x1::vector::push_back<u8>(&mut v2, v0);
            let v7 = 0x2::address::to_string(v4.owner);
            let v8 = 0x1::string::utf8(b"0x");
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v8));
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v7));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(v4.metaId));
            0x1::vector::push_back<u8>(&mut v2, v0);
            let v9 = 0x2::address::to_string(v4.nft_addr);
            0x1::vector::append<u8>(&mut v2, *0x1::string::bytes(&v9));
            0x1::vector::push_back<u8>(&mut v2, v0);
            0x1::vector::append<u8>(&mut v2, numbers_to_ascii_vector(v4.onsale_time));
            0x1::vector::push_back<u8>(&mut v2, 0x1::ascii::byte(0x1::ascii::char(59)));
            v3 = v3 + 1;
        };
        v2
    }

    public entry fun purchase_game_item<T0>(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = merge_coins<T0>(arg5, arg7);
        assert!(0x2::linked_table::contains<u64, vector<OnSale>>(&arg0.game_sales, arg2), 2);
        let v1 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(&mut arg0.game_sales, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<OnSale>(v1)) {
            let v3 = 0x1::vector::borrow<OnSale>(v1, v2);
            if (v3.name == arg3 && v3.num == arg4 && v3.price <= 0x2::coin::value<T0>(&v0)) {
                let OnSale {
                    id          : v4,
                    name        : v5,
                    num         : v6,
                    price       : v7,
                    coinType    : v8,
                    owner       : v9,
                    metaId      : v10,
                    type        : v11,
                    onsale_time : _,
                    bag         : v13,
                    nftType     : _,
                    nft_addr    : _,
                } = 0x1::vector::remove<OnSale>(v1, v2);
                let v16 = TransactionRecord{
                    seller    : v9,
                    buyer     : 0x2::tx_context::sender(arg7),
                    name      : v5,
                    num       : v6,
                    price     : v7,
                    price_gas : v7 / 1000,
                    type      : v11,
                    coinType  : v8,
                    time      : 0x2::clock::timestamp_ms(arg6),
                };
                0x2::event::emit<TransactionRecord>(v16);
                if (v8 == 0x1::string::utf8(b"SUI")) {
                    assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()))), 5);
                } else if (v8 == 0x1::string::utf8(b"SHUI")) {
                    assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>()))), 5);
                };
                0x2::bag::destroy_empty(v13);
                0x2::object::delete(v4);
                if (0x1::vector::length<OnSale>(v1) == 0) {
                    0x1::vector::destroy_empty<OnSale>(0x2::linked_table::remove<u64, vector<OnSale>>(&mut arg0.game_sales, v10));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v7 / 1000, arg7), arg0.creator);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v7 * 999 / 1000, arg7), v9);
                0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::tree_of_life::fill_items(arg1, v5, v6);
                break
            };
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public entry fun purchase_nft_item<T0, T1: store + key>(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x2::coin::Coin<T0>>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        assert!(arg2 != 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1), 6);
        let v0 = merge_coins<T0>(arg5, arg7);
        assert!(0x2::linked_table::contains<u64, vector<OnSale>>(&arg0.game_sales, arg2), 2);
        let v1 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(&mut arg0.game_sales, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<OnSale>(v1)) {
            let v3 = 0x1::vector::borrow<OnSale>(v1, v2);
            if (v3.name == arg3 && v3.num == arg4 && v3.price <= 0x2::coin::value<T0>(&v0)) {
                let OnSale {
                    id          : v4,
                    name        : v5,
                    num         : v6,
                    price       : v7,
                    coinType    : v8,
                    owner       : v9,
                    metaId      : _,
                    type        : v11,
                    onsale_time : _,
                    bag         : v13,
                    nftType     : _,
                    nft_addr    : _,
                } = 0x1::vector::remove<OnSale>(v1, v2);
                let v16 = v13;
                let v17 = TransactionRecord{
                    seller    : v9,
                    buyer     : 0x2::tx_context::sender(arg7),
                    name      : v5,
                    num       : v6,
                    price     : v7,
                    price_gas : v7 / 1000,
                    type      : v11,
                    coinType  : v8,
                    time      : 0x2::clock::timestamp_ms(arg6),
                };
                0x2::event::emit<TransactionRecord>(v17);
                if (v8 == 0x1::string::utf8(b"SUI")) {
                    assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>()))), 5);
                } else if (v8 == 0x1::string::utf8(b"SHUI")) {
                    assert!(0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))) == 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>()))), 5);
                };
                if (0x2::bag::length(&v16) > 0) {
                    0x2::transfer::public_transfer<T1>(0x2::bag::remove<u64, T1>(&mut v16, 0), 0x2::tx_context::sender(arg7));
                };
                0x2::bag::destroy_empty(v16);
                0x2::object::delete(v4);
                if (0x1::vector::length<OnSale>(v1) == 0) {
                    0x1::vector::destroy_empty<OnSale>(0x2::linked_table::remove<u64, vector<OnSale>>(&mut arg0.game_sales, arg2));
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v7 / 1000, arg7), arg0.creator);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, v7 * 999 / 1000, arg7), v9);
                break
            };
            v2 = v2 + 1;
        };
        if (0x2::coin::value<T0>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg7));
        } else {
            0x2::coin::destroy_zero<T0>(v0);
        };
    }

    public fun query_my_onsale(arg0: &MarketGlobal, arg1: u64) : 0x1::string::String {
        let v0 = &arg0.game_sales;
        if (0x2::linked_table::is_empty<u64, vector<OnSale>>(v0)) {
            return 0x1::string::utf8(b"none")
        };
        if (!0x2::linked_table::contains<u64, vector<OnSale>>(v0, arg1)) {
            return 0x1::string::utf8(b"none")
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, print_onsale_vector(0x2::linked_table::borrow<u64, vector<OnSale>>(v0, arg1)));
        0x1::string::utf8(v1)
    }

    public entry fun unlist_game_item(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1);
        assert!(0x2::linked_table::contains<u64, vector<OnSale>>(&arg0.game_sales, v0), 2);
        let v1 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(&mut arg0.game_sales, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<OnSale>(v1)) {
            let v3 = 0x1::vector::borrow<OnSale>(v1, v2);
            if (v3.name == arg2 && v3.num == arg3 && v3.price == arg4) {
                let OnSale {
                    id          : v4,
                    name        : _,
                    num         : _,
                    price       : _,
                    coinType    : _,
                    owner       : v9,
                    metaId      : v10,
                    type        : _,
                    onsale_time : v12,
                    bag         : v13,
                    nftType     : _,
                    nft_addr    : _,
                } = 0x1::vector::remove<OnSale>(v1, v2);
                if ((0x2::clock::timestamp_ms(arg5) - v12) / 86400000 < 10) {
                    assert!(v9 == 0x2::tx_context::sender(arg6), 3);
                };
                0x2::bag::destroy_empty(v13);
                0x2::object::delete(v4);
                if (0x1::vector::length<OnSale>(v1) == 0) {
                    0x1::vector::destroy_empty<OnSale>(0x2::linked_table::remove<u64, vector<OnSale>>(&mut arg0.game_sales, v10));
                };
                0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::tree_of_life::fill_items(arg1, arg2, arg3);
                break
            };
            v2 = v2 + 1;
        };
    }

    public entry fun unlist_nft_item<T0: store + key>(arg0: &mut MarketGlobal, arg1: &mut 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::MetaIdentity, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 8);
        let v0 = 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::metaIdentity::getMetaId(arg1);
        assert!(0x2::linked_table::contains<u64, vector<OnSale>>(&arg0.game_sales, v0), 2);
        let v1 = 0x2::linked_table::borrow_mut<u64, vector<OnSale>>(&mut arg0.game_sales, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<OnSale>(v1)) {
            let v3 = 0x1::vector::borrow<OnSale>(v1, v2);
            if (v3.name == arg2 && v3.num == arg3 && v3.price == arg4) {
                let OnSale {
                    id          : v4,
                    name        : _,
                    num         : _,
                    price       : _,
                    coinType    : _,
                    owner       : v9,
                    metaId      : _,
                    type        : _,
                    onsale_time : v12,
                    bag         : v13,
                    nftType     : _,
                    nft_addr    : _,
                } = 0x1::vector::remove<OnSale>(v1, v2);
                let v16 = v13;
                if ((0x2::clock::timestamp_ms(arg5) - v12) / 86400000 < 10) {
                    assert!(v9 == 0x2::tx_context::sender(arg6), 3);
                };
                if (0x2::bag::length(&v16) > 0) {
                    0x2::transfer::public_transfer<T0>(0x2::bag::remove<u64, T0>(&mut v16, 0), 0x2::tx_context::sender(arg6));
                };
                0x2::bag::destroy_empty(v16);
                0x2::object::delete(v4);
                if (0x1::vector::length<OnSale>(v1) == 0) {
                    0x1::vector::destroy_empty<OnSale>(0x2::linked_table::remove<u64, vector<OnSale>>(&mut arg0.game_sales, v0));
                    break
                } else {
                    break
                };
            };
            v2 = v2 + 1;
        };
    }

    public entry fun withdraw_shui(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>>(0x2::coin::from_balance<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(0x2::balance::split<0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::shui::SHUI>(&mut arg0.balance_SHUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_sui(arg0: &mut MarketGlobal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance_SUI, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

