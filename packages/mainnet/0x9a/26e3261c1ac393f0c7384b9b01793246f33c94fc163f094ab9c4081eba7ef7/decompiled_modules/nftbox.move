module 0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nftbox {
    struct NFTBOX has drop {
        dummy_field: bool,
    }

    struct NftAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftTreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct NftOrder has store {
        secured_coin: u64,
        secured_nfts: vector<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>,
        secured_types: 0x2::vec_map::VecMap<u8, u64>,
    }

    struct NftPoolStartedEvent has copy, drop {
        id: address,
        soft_cap: u64,
        hard_cap: u64,
        round: u8,
        state: u8,
        use_whitelist: bool,
        vesting_time_ms: u64,
        owner: address,
        start_time: u64,
        end_time: u64,
    }

    struct NftPoolCreatedEvent has copy, drop {
        id: address,
        soft_cap: u64,
        hard_cap: u64,
        round: u8,
        state: u8,
        use_whitelist: bool,
        vesting_time_ms: u64,
        owner: address,
        start_time: u64,
        end_time: u64,
    }

    struct NftPoolBuyEvent has copy, drop {
        pool: address,
        buyer: address,
        amount: u64,
        cost: u64,
        timestamp: u64,
        nft_types: vector<u8>,
        nft_amounts: vector<u64>,
        total_nft_bought: u64,
        total_cost: u64,
        participants: u64,
        total_raised: u64,
        sold_out: bool,
    }

    struct NftPoolStopEvent has copy, drop {
        id: address,
        total_sold_coin: u64,
        total_sold_nft: u64,
        soft_cap_percent: u64,
        soft_cap: u64,
        hard_cap: u64,
        round: u8,
        state: u8,
        use_whitelist: bool,
        vesting_time_ms: u64,
        owner: address,
        start_time: u64,
        end_time: u64,
    }

    struct NftPoolClaimedEvent has copy, drop {
        pool: address,
        buyer: address,
        secured_nfts: u64,
        secured_coin: u64,
        secured_types: 0x2::vec_map::VecMap<u8, u64>,
        timestamp_ms: u64,
    }

    struct NftPoolRefundEvent has copy, drop {
        pool: address,
        buyer: address,
        secured_nfts: u64,
        refund_coin: u64,
        timestamp_ms: u64,
    }

    struct NftTemplate has drop, store {
        cap: u64,
        sold: u64,
        allocate: u64,
        price: u64,
        type: u8,
        name: vector<u8>,
        link: vector<u8>,
        image_url: vector<u8>,
        description: vector<u8>,
        project_url: vector<u8>,
        edition: u64,
        thumbnail_url: vector<u8>,
        creator: vector<u8>,
        attributes: 0x2::vec_map::VecMap<vector<u8>, vector<u8>>,
    }

    struct NftPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        templates: 0x2::table::Table<u8, NftTemplate>,
        soft_cap_percent: u64,
        soft_cap: u64,
        hard_cap: u64,
        round: u8,
        state: u8,
        use_whitelist: bool,
        vesting_time_ms: u64,
        fund: 0x2::coin::Coin<T0>,
        start_time: u64,
        end_time: u64,
        participants: u64,
        total_sold_coin: u64,
        total_sold_nft: u64,
        orders: 0x2::table::Table<address, NftOrder>,
        require_kyc: bool,
    }

    struct NftRemoveCollection has copy, drop {
        pool: address,
        nft_type: u8,
    }

    struct NftAddCollectionEvent has copy, drop {
        pool: address,
        soft_cap: u64,
        hard_cap: u64,
    }

    public fun add_attribute<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: u8, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(arg1.state == 1, 6007);
        assert!(0x1::vector::length<u8>(&arg3) > 0 && 0x1::vector::length<u8>(&arg4) > 0 && 0x2::table::contains<u8, NftTemplate>(&arg1.templates, arg2), 6018);
        let v0 = 0x2::table::borrow_mut<u8, NftTemplate>(&mut arg1.templates, arg2);
        assert!(!0x2::vec_map::contains<vector<u8>, vector<u8>>(&v0.attributes, &arg3), 6018);
        0x2::vec_map::insert<vector<u8>, vector<u8>>(&mut v0.attributes, arg3, arg4);
    }

    public fun add_collection<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u8, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: vector<u8>, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 1, 6007);
        assert!(arg2 >= arg3 && arg3 > 0 && arg4 > 0 && arg5 > 0 && 0x1::vector::length<u8>(&arg6) > 0 && 0x1::vector::length<u8>(&arg7) > 0 && 0x1::vector::length<u8>(&arg8) > 0 && 0x1::vector::length<u8>(&arg9) > 0 && 0x1::vector::length<u8>(&arg10) > 0 && arg11 > 0 && 0x1::vector::length<u8>(&arg12) > 0 && 0x1::vector::length<u8>(&arg13) > 0, 6018);
        let v0 = NftTemplate{
            cap           : arg2,
            sold          : 0,
            allocate      : arg3,
            price         : arg4,
            type          : arg5,
            name          : arg6,
            link          : arg7,
            image_url     : arg8,
            description   : arg9,
            project_url   : arg10,
            edition       : arg11,
            thumbnail_url : arg12,
            creator       : arg13,
            attributes    : 0x2::vec_map::empty<vector<u8>, vector<u8>>(),
        };
        0x2::table::add<u8, NftTemplate>(&mut arg1.templates, arg5, v0);
        arg1.hard_cap = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::mul_add_u64(arg2, arg4, arg1.hard_cap);
        arg1.soft_cap = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::mul_u64(arg1.hard_cap, arg1.soft_cap_percent) / 10000;
        let v1 = NftAddCollectionEvent{
            pool     : 0x2::object::uid_to_address(&arg1.id),
            soft_cap : arg1.soft_cap,
            hard_cap : arg1.hard_cap,
        };
        0x2::event::emit<NftAddCollectionEvent>(v1);
    }

    public fun add_whitelist<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: vector<address>) {
        assert!(arg1.use_whitelist, 6020);
        assert!(arg1.state == 1, 6007);
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (!0x2::table::contains<address, NftOrder>(&arg1.orders, v1)) {
                let v2 = NftOrder{
                    secured_coin  : 0,
                    secured_nfts  : 0x1::vector::empty<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(),
                    secured_types : 0x2::vec_map::empty<u8, u64>(),
                };
                0x2::table::add<address, NftOrder>(&mut arg1.orders, v1, v2);
            };
        };
    }

    public fun buy_nft<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: vector<u64>, arg3: &mut NftPool<T0>, arg4: &0x2::clock::Clock, arg5: &0xd537ca3d976dde01617ecf4241c37b817038081928b7f922c4f13e3cb764f57c::kyc::Kyc, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.state == 2, 6011);
        let v0 = 0x2::tx_context::sender(arg6);
        if (arg3.require_kyc) {
            assert!(0xd537ca3d976dde01617ecf4241c37b817038081928b7f922c4f13e3cb764f57c::kyc::hasKYC(v0, arg5), 6025);
        };
        let v1 = 0x2::table::contains<address, NftOrder>(&arg3.orders, v0);
        assert!(!arg3.use_whitelist || v1, 6016);
        assert!(0x1::vector::length<u64>(&arg2) > 0 && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u8>(&arg1), 6018);
        let v2 = 0x1::vector::length<u8>(&arg1);
        let v3 = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::zero();
        let v4 = 0;
        let v5 = 0x2::vec_map::empty<u8, u64>();
        while (v2 > 0) {
            v2 = v2 - 1;
            let v6 = *0x1::vector::borrow<u8>(&arg1, v2);
            assert!(0x2::vec_map::contains<u8, u64>(&v5, &v6), 6018);
            let v7 = *0x1::vector::borrow<u64>(&arg2, v2);
            assert!(v7 > 0 && v6 > 0 && 0x2::table::contains<u8, NftTemplate>(&arg3.templates, v6), 6018);
            let v8 = 0x2::table::borrow_mut<u8, NftTemplate>(&mut arg3.templates, v6);
            let v9 = if (!0x2::table::contains<address, NftOrder>(&arg3.orders, v0)) {
                0
            } else {
                let v10 = 0x2::table::borrow<address, NftOrder>(&arg3.orders, v0);
                if (!0x2::vec_map::contains<u8, u64>(&v10.secured_types, &v6)) {
                    0
                } else {
                    *0x2::vec_map::get<u8, u64>(&v10.secured_types, &v6)
                }
            };
            assert!(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(v9, v7) <= v8.allocate, 6021);
            assert!(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(v8.sold, v7) <= v8.cap, 6012);
            v8.sold = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(v7, v8.sold);
            v3 = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::mul_add(0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::from_u64(v7), 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::from_u64(v8.price), v3);
            v4 = v4 + v7;
        };
        let v11 = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::as_u64(v3);
        assert!(v11 <= 0x2::coin::value<T0>(arg0), 6010);
        if (!v1 || 0x2::table::borrow<address, NftOrder>(&arg3.orders, v0).secured_coin > 0) {
            arg3.participants = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::increment_u64(arg3.participants);
        };
        arg3.total_sold_coin = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(arg3.total_sold_coin, v11);
        arg3.total_sold_nft = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(arg3.total_sold_nft, v4);
        0x2::coin::join<T0>(&mut arg3.fund, 0x2::coin::split<T0>(arg0, v11, arg6));
        let v12 = 0x1::vector::empty<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>();
        let v13 = 0x1::vector::length<u8>(&arg1);
        let v14 = if (v1) {
            &mut 0x2::table::borrow_mut<address, NftOrder>(&mut arg3.orders, v0).secured_types
        } else {
            let v15 = 0x2::vec_map::empty<u8, u64>();
            &mut v15
        };
        while (v13 > 0) {
            v13 = v13 - 1;
            let v16 = *0x1::vector::borrow<u8>(&arg1, v13);
            let v17 = *0x1::vector::borrow<u64>(&arg2, v13);
            0x1::vector::append<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&mut v12, mint_nft_batch_int(v17, 0x2::table::borrow<u8, NftTemplate>(&arg3.templates, v16), arg6));
            let v18 = if (0x2::vec_map::contains<u8, u64>(v14, &v16)) {
                let (_, v20) = 0x2::vec_map::remove<u8, u64>(v14, &v16);
                v20 + v17
            } else {
                v17
            };
            0x2::vec_map::insert<u8, u64>(v14, v16, v18);
        };
        if (v1) {
            let v21 = 0x2::table::borrow_mut<address, NftOrder>(&mut arg3.orders, v0);
            v21.secured_coin = 0xba8f8fabcc241c95a90829e3a989edb80bf76e48cfa1eca38972285fd894f98::u256::add_u64(v21.secured_coin, v11);
            0x1::vector::append<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&mut v21.secured_nfts, v12);
        } else {
            let v22 = NftOrder{
                secured_coin  : v11,
                secured_nfts  : v12,
                secured_types : *v14,
            };
            0x2::table::add<address, NftOrder>(&mut arg3.orders, v0, v22);
        };
        let v23 = 0x2::table::borrow<address, NftOrder>(&arg3.orders, v0);
        let v24 = &v23.secured_nfts;
        let v25 = 0x2::coin::value<T0>(&arg3.fund);
        let v26 = if (v25 == arg3.hard_cap) {
            arg3.state = 5;
            true
        } else {
            false
        };
        let v27 = NftPoolBuyEvent{
            pool             : 0x2::object::uid_to_address(&arg3.id),
            buyer            : v0,
            amount           : v4,
            cost             : v11,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
            nft_types        : arg1,
            nft_amounts      : arg2,
            total_nft_bought : 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(v24),
            total_cost       : v23.secured_coin,
            participants     : arg3.participants,
            total_raised     : v25,
            sold_out         : v26,
        };
        0x2::event::emit<NftPoolBuyEvent>(v27);
    }

    public fun change_admin(arg0: NftAdminCap, arg1: address) {
        0x2::transfer::public_transfer<NftAdminCap>(arg0, arg1);
    }

    public fun change_treasury_admin(arg0: NftTreasuryCap, arg1: address) {
        0x2::transfer::public_transfer<NftTreasuryCap>(arg0, arg1);
    }

    public fun claim_nft<T0>(arg0: &mut NftPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 5, 6007);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.vesting_time_ms, 6002);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, NftOrder>(&mut arg0.orders, v1) && 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&0x2::table::borrow<address, NftOrder>(&arg0.orders, v1).secured_nfts) > 0, 6013);
        let NftOrder {
            secured_coin  : v2,
            secured_nfts  : v3,
            secured_types : v4,
        } = 0x2::table::remove<address, NftOrder>(&mut arg0.orders, v1);
        let v5 = v3;
        let v6 = 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&mut v5);
        while (0 < v6) {
            0x2::transfer::public_transfer<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(0x1::vector::pop_back<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&mut v5), v1);
        };
        0x1::vector::destroy_empty<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(v5);
        let v7 = NftPoolClaimedEvent{
            pool          : 0x2::object::id_address<NftPool<T0>>(arg0),
            buyer         : v1,
            secured_nfts  : v6,
            secured_coin  : v2,
            secured_types : v4,
            timestamp_ms  : v0,
        };
        0x2::event::emit<NftPoolClaimedEvent>(v7);
    }

    public fun claim_refund<T0>(arg0: &mut NftPool<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 3, 6007);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, NftOrder>(&mut arg0.orders, v0) && 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&0x2::table::borrow<address, NftOrder>(&mut arg0.orders, v0).secured_nfts) > 0, 6013);
        let v1 = 0x2::table::remove<address, NftOrder>(&mut arg0.orders, v0);
        let v2 = v1.secured_coin;
        destroyNftOrder(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0.fund, v2, arg2), v0);
        let v3 = NftPoolRefundEvent{
            pool         : 0x2::object::id_address<NftPool<T0>>(arg0),
            buyer        : v0,
            secured_nfts : 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&v1.secured_nfts),
            refund_coin  : v2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<NftPoolRefundEvent>(v3);
    }

    public fun create_pool<T0>(arg0: &NftAdminCap, arg1: address, arg2: u64, arg3: u8, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg2 < 10000, 6000);
        assert!(arg3 >= 1 && arg3 <= 3, 6001);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(arg5 > v0, 6002);
        assert!(arg6 > v0 && arg7 > arg6, 6006);
        let v1 = NftPool<T0>{
            id               : 0x2::object::new(arg10),
            owner            : arg1,
            templates        : 0x2::table::new<u8, NftTemplate>(arg10),
            soft_cap_percent : arg2,
            soft_cap         : 0,
            hard_cap         : 0,
            round            : arg3,
            state            : 1,
            use_whitelist    : arg4,
            vesting_time_ms  : arg5,
            fund             : 0x2::coin::zero<T0>(arg10),
            start_time       : arg6,
            end_time         : arg7,
            participants     : 0,
            total_sold_coin  : 0,
            total_sold_nft   : 0,
            orders           : 0x2::table::new<address, NftOrder>(arg10),
            require_kyc      : arg9,
        };
        let v2 = NftPoolCreatedEvent{
            id              : 0x2::object::id_address<NftPool<T0>>(&v1),
            soft_cap        : v1.soft_cap,
            hard_cap        : v1.hard_cap,
            round           : v1.round,
            state           : v1.state,
            use_whitelist   : v1.use_whitelist,
            vesting_time_ms : v1.vesting_time_ms,
            owner           : v1.owner,
            start_time      : v1.start_time,
            end_time        : v1.end_time,
        };
        0x2::event::emit<NftPoolCreatedEvent>(v2);
        0x2::transfer::share_object<NftPool<T0>>(v1);
    }

    fun destroyNftOrder(arg0: NftOrder) {
        let NftOrder {
            secured_coin  : _,
            secured_nfts  : v1,
            secured_types : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x1::vector::length<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&v4);
        while (v5 > 0) {
            v5 = v5 - 1;
            0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::burn(0x1::vector::pop_back<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(&mut v4));
        };
        0x1::vector::destroy_empty<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT>(v4);
        let v6 = 0x2::vec_map::keys<u8, u64>(&v3);
        let v7 = 0x1::vector::length<u8>(&v6);
        while (v7 > 0) {
            let v8 = 0x1::vector::pop_back<u8>(&mut v6);
            let (_, _) = 0x2::vec_map::remove<u8, u64>(&mut v3, &v8);
            v7 = v7 - 1;
        };
        0x2::vec_map::destroy_empty<u8, u64>(v3);
    }

    fun init(arg0: NFTBOX, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0x1a7e3c7a16c9c4caa61941ccb30a336dc38673e0ee6cd19491ff71415eea869, 6022);
        let v0 = NftAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NftAdminCap>(v0, @0x1a7e3c7a16c9c4caa61941ccb30a336dc38673e0ee6cd19491ff71415eea869);
        let v1 = NftTreasuryCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<NftTreasuryCap>(v1, @0x1a7e3c7a16c9c4caa61941ccb30a336dc38673e0ee6cd19491ff71415eea869);
    }

    fun mint_nft_batch_int(arg0: u64, arg1: &NftTemplate, arg2: &mut 0x2::tx_context::TxContext) : vector<0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::PriNFT> {
        0x9a26e3261c1ac393f0c7384b9b01793246f33c94fc163f094ab9c4081eba7ef7::nft_private::mint_batch(arg0, arg1.name, arg1.link, arg1.image_url, arg1.description, arg1.project_url, arg1.edition, arg1.thumbnail_url, arg1.creator, &arg1.attributes, arg2)
    }

    public fun remove_collection<T0>(arg0: &NftAdminCap, arg1: u8, arg2: &mut NftPool<T0>) {
        0x2::table::remove<u8, NftTemplate>(&mut arg2.templates, arg1);
        let v0 = NftRemoveCollection{
            pool     : 0x2::object::id_address<NftPool<T0>>(arg2),
            nft_type : arg1,
        };
        0x2::event::emit<NftRemoveCollection>(v0);
    }

    public fun remove_whitelist<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: vector<address>) {
        assert!(arg1.use_whitelist, 6020);
        assert!(arg1.state == 1, 6007);
        let v0 = 0x1::vector::length<address>(&arg2);
        while (v0 > 0) {
            v0 = v0 - 1;
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            if (0x2::table::contains<address, NftOrder>(&arg1.orders, v1)) {
                destroyNftOrder(0x2::table::remove<address, NftOrder>(&mut arg1.orders, v1));
            };
        };
    }

    public fun start_pool<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.state == 1, 6007);
        assert!(0x2::table::length<u8, NftTemplate>(&arg1.templates) > 0, 6014);
        arg1.state = 2;
        arg1.start_time = 0x2::clock::timestamp_ms(arg2);
        let v0 = NftPoolStartedEvent{
            id              : 0x2::object::id_address<NftPool<T0>>(arg1),
            soft_cap        : arg1.soft_cap,
            hard_cap        : arg1.hard_cap,
            round           : arg1.round,
            state           : arg1.state,
            use_whitelist   : arg1.use_whitelist,
            vesting_time_ms : arg1.vesting_time_ms,
            owner           : arg1.owner,
            start_time      : arg1.start_time,
            end_time        : arg1.end_time,
        };
        0x2::event::emit<NftPoolStartedEvent>(v0);
    }

    public fun stop_pool<T0>(arg0: &NftAdminCap, arg1: &mut NftPool<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg1.state == 2, 6007);
        arg1.end_time = 0x2::clock::timestamp_ms(arg2);
        if (arg1.total_sold_coin < arg1.soft_cap) {
            arg1.state = 3;
        } else {
            arg1.state = 5;
        };
        let v0 = NftPoolStopEvent{
            id               : 0x2::object::id_address<NftPool<T0>>(arg1),
            total_sold_coin  : arg1.total_sold_coin,
            total_sold_nft   : arg1.total_sold_nft,
            soft_cap_percent : arg1.soft_cap_percent,
            soft_cap         : arg1.soft_cap,
            hard_cap         : arg1.hard_cap,
            round            : arg1.round,
            state            : arg1.state,
            use_whitelist    : arg1.use_whitelist,
            vesting_time_ms  : arg1.vesting_time_ms,
            owner            : arg1.owner,
            start_time       : arg1.start_time,
            end_time         : arg1.end_time,
        };
        0x2::event::emit<NftPoolStopEvent>(v0);
    }

    public fun withdraw_fund<T0>(arg0: &NftTreasuryCap, arg1: &mut NftPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.state == 5, 6007);
        assert!(arg2 <= 0x2::coin::value<T0>(&arg1.fund), 6010);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.fund, arg2, arg3), arg1.owner);
    }

    // decompiled from Move bytecode v6
}

