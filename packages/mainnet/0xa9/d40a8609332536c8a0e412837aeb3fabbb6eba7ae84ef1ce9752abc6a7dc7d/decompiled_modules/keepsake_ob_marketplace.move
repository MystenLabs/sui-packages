module 0xa9d40a8609332536c8a0e412837aeb3fabbb6eba7ae84ef1ce9752abc6a7dc7d::keepsake_ob_marketplace {
    struct Wallet has store, key {
        id: 0x2::object::UID,
        owner: address,
        fee_bps: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        owner: address,
        admins: vector<address>,
        fee_bps: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        collateral_fee: u64,
    }

    struct KEEPSAKE_OB_MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct Admin has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct KeepsakeListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        ask: u64,
        owner: address,
        seller_kiosk: 0x2::object::ID,
        seller_wallet: 0x1::option::Option<0x2::object::ID>,
    }

    struct KeepsakeAuctionListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        bid: 0x2::balance::Balance<0x2::sui::SUI>,
        bidder: address,
        bid_amount: u64,
        collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        min_bid: u64,
        min_bid_increment: u64,
        starts: u64,
        expires: u64,
        owner: address,
        seller_kiosk: 0x2::object::ID,
        seller_wallet: 0x1::option::Option<0x2::object::ID>,
        buyer_wallet: 0x1::option::Option<0x2::object::ID>,
    }

    struct WonAuction<T0: key> {
        item: T0,
        bidder: address,
    }

    struct ListItemEvent has copy, drop {
        id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        ask: u64,
        auction: bool,
        type_name: 0x1::type_name::TypeName,
    }

    struct DelistItemEvent has copy, drop {
        id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        sale_price: u64,
        sold: bool,
        type_name: 0x1::type_name::TypeName,
    }

    public entry fun auction<T0: store + key>(arg0: &mut Marketplace, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg8, arg2, &arg0.id, arg9);
        inner_auction<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg7, 0x2::object::id<0x2::kiosk::Kiosk>(arg8), 0x1::option::none<0x2::object::ID>(), arg9);
    }

    public entry fun auction_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::object::ID, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::kiosk::Kiosk, arg10: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg9, arg2, &arg0.id, arg10);
        inner_auction<T0>(arg0, arg2, arg3, arg4, arg5, arg6, arg8, 0x2::object::id<0x2::kiosk::Kiosk>(arg9), 0x1::option::some<0x2::object::ID>(arg7), arg10);
    }

    public entry fun bid<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1);
        let v1 = v0.bid_amount;
        assert!(arg3 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 135289670000);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0.starts <= v2, 135289670101);
        assert!(v0.expires >= v2, 135289670100);
        if (v0.expires + 60000 < v2) {
            v0.expires = v0.expires + 60000;
        };
        if (v1 > 0) {
            assert!(arg3 >= v1 + v0.min_bid_increment, 135289670103);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0.bid, v1, arg5), v0.bidder);
        } else {
            assert!(arg3 >= v0.min_bid, 135289670104);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut v0.bid, arg2);
        v0.bidder = 0x2::tx_context::sender(arg5);
        v0.bid_amount = arg3;
    }

    public entry fun bid_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1);
        let v1 = v0.bid_amount;
        assert!(arg3 + arg3 * (0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, arg5).fee_bps as u64) / 10000 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 135289670000);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0.expires >= v2, 135289670100);
        assert!(v0.starts <= v2, 135289670101);
        if (v0.expires + 60000 < v2) {
            v0.expires = v0.expires + 60000;
        };
        if (v1 > 0) {
            assert!(arg3 >= v1 + v0.min_bid_increment, 135289670103);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0.bid, v1, arg6), v0.bidder);
        } else {
            assert!(arg3 >= v0.min_bid, 135289670104);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut v0.bid, arg2);
        v0.bidder = 0x2::tx_context::sender(arg6);
        v0.bid_amount = arg3;
        0x1::option::fill<0x2::object::ID>(&mut v0.buyer_wallet, arg5);
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : v2,
            owner         : v3,
            seller_kiosk  : _,
            seller_wallet : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg3);
        let v6 = v0;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) == v2, v2);
        let v8 = &mut v7;
        send_fees(arg0, v8, v2, 0x1::option::none<0x2::object::ID>(), v5);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v10 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, arg2, v1, &arg0.id, v9, arg5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v10, v7, v3);
        let v11 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v10, &v11);
        let v12 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v6),
            item_id    : v1,
            sale_price : v9,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v12);
        0x2::object::delete(v6);
        v10
    }

    public fun buy_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : v2,
            owner         : v3,
            seller_kiosk  : _,
            seller_wallet : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg3);
        let v6 = v0;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) == calculate_fees(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, arg5).fee_bps, v2) + v2, v2);
        let v8 = &mut v7;
        send_fees(arg0, v8, v2, 0x1::option::some<0x2::object::ID>(arg5), v5);
        let v9 = 0x2::balance::value<0x2::sui::SUI>(&v7);
        let v10 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, arg2, v1, &arg0.id, v9, arg6);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v10, v7, v3);
        let v11 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v10, &v11);
        let v12 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v6),
            item_id    : v1,
            sale_price : v9,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v12);
        0x2::object::delete(v6);
        v10
    }

    public fun calculate_fees(arg0: u64, arg1: u64) : u64 {
        arg1 * arg0 / 10000
    }

    public fun collateral_fee(arg0: &Marketplace) : u64 {
        arg0.collateral_fee
    }

    public fun complete_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let KeepsakeAuctionListing {
            id                : v0,
            item_id           : _,
            bid               : v2,
            bidder            : v3,
            bid_amount        : v4,
            collateral        : v5,
            min_bid           : v6,
            min_bid_increment : _,
            starts            : _,
            expires           : v9,
            owner             : v10,
            seller_kiosk      : _,
            seller_wallet     : v12,
            buyer_wallet      : v13,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg3);
        let v14 = v2;
        let v15 = v0;
        assert!(v3 == 0x2::tx_context::sender(arg5), 135289670001);
        let v16 = 0x2::balance::value<0x2::sui::SUI>(&v14);
        assert!(v16 >= v6, 135289670102);
        assert!(v9 < 0x2::clock::timestamp_ms(arg4), 135289670101);
        let v17 = &mut v14;
        send_fees(arg0, v17, v4, v13, v12);
        handle_listing_collateral(v5, v10, arg5);
        let v18 = 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::transfer_delegated<T0>(arg1, arg2, arg3, &arg0.id, 0x2::balance::value<0x2::sui::SUI>(&v14), arg5);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::set_paid<T0, 0x2::sui::SUI>(&mut v18, v14, v10);
        let v19 = Witness{dummy_field: false};
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::set_transfer_request_auth<T0, Witness>(&mut v18, &v19);
        let v20 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v15),
            item_id    : arg3,
            sale_price : v16,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v20);
        0x2::object::delete(v15);
        v18
    }

    public entry fun create_wallet(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg2 <= 125, 135289670000);
        let v0 = Wallet{
            id          : 0x2::object::new(arg3),
            owner       : arg1,
            fee_bps     : arg2,
            fee_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = 0x2::object::id<Wallet>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, Wallet>(&mut arg0.id, v1, v0);
        v1
    }

    public fun deauction<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::tx_context::TxContext) {
        let KeepsakeAuctionListing {
            id                : v0,
            item_id           : v1,
            bid               : v2,
            bidder            : v3,
            bid_amount        : v4,
            collateral        : v5,
            min_bid           : _,
            min_bid_increment : _,
            starts            : _,
            expires           : v9,
            owner             : v10,
            seller_kiosk      : _,
            seller_wallet     : _,
            buyer_wallet      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg4) == v10, 135289670001);
        let v14 = 0x2::clock::timestamp_ms(arg2);
        if (v4 != 0 && v14 > v9 && v14 < v9 + 86400000) {
            abort 135289670101
        };
        handle_unlisting_collateral(v5, v3, v2, arg0.owner, arg4);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg3, v1, &arg0.id);
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : _,
            owner         : v3,
            seller_kiosk  : _,
            seller_wallet : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg3) == v3, 135289670001);
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::remove_auth_transfer(arg1, v1, &arg0.id);
        let v7 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v6),
            item_id    : v1,
            sale_price : 0,
            sold       : false,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v7);
        0x2::object::delete(v6);
    }

    public fun fee(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    public fun fee_balance(arg0: &Marketplace) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance)
    }

    public fun fee_bps(arg0: &Marketplace) : u64 {
        arg0.fee_bps
    }

    fun handle_listing_collateral(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2);
        if (0x2::coin::value<0x2::sui::SUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
    }

    fun handle_unlisting_collateral(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: address, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        let v2 = 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg4);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        if (v1 > 0) {
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, v1 / 2, arg4), arg3);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg1);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
    }

    fun init(arg0: KEEPSAKE_OB_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KEEPSAKE_OB_MARKETPLACE>(arg0, arg1);
        let v0 = Marketplace{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            admins         : 0x1::vector::empty<address>(),
            fee_bps        : 0,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            collateral_fee : 0,
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = Admin{dummy_field: false};
        0x2::transfer::public_share_object<0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::Allowlist>(0x70e34fcd390b767edbddaf7573450528698188c84c5395af8c4b12e3e37622fa::allowlist::new_embedded_with_authorities<Admin>(v1, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::get<Witness>()), arg1));
    }

    public fun inner_auction<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x2::object::ID, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.collateral_fee == 0x2::coin::value<0x2::sui::SUI>(&arg6), 135289670000);
        let v0 = 0x2::object::new(arg9);
        let v1 = ListItemEvent{
            id        : 0x2::object::uid_to_inner(&v0),
            item_id   : arg1,
            ask       : arg2,
            auction   : true,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ListItemEvent>(v1);
        let v2 = KeepsakeAuctionListing<T0>{
            id                : v0,
            item_id           : arg1,
            bid               : 0x2::balance::zero<0x2::sui::SUI>(),
            bidder            : 0x2::tx_context::sender(arg9),
            bid_amount        : 0,
            collateral        : 0x2::coin::into_balance<0x2::sui::SUI>(arg6),
            min_bid           : arg2,
            min_bid_increment : arg3,
            starts            : arg4,
            expires           : arg5,
            owner             : 0x2::tx_context::sender(arg9),
            seller_kiosk      : arg7,
            seller_wallet     : arg8,
            buyer_wallet      : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1, v2);
    }

    fun inner_list<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = ListItemEvent{
            id        : 0x2::object::uid_to_inner(&v0),
            item_id   : arg1,
            ask       : arg2,
            auction   : false,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ListItemEvent>(v1);
        let v2 = KeepsakeListing<T0>{
            id            : v0,
            item_id       : arg1,
            ask           : arg2,
            owner         : 0x2::tx_context::sender(arg5),
            seller_kiosk  : arg3,
            seller_wallet : arg4,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg1, v2);
    }

    public entry fun is_admin(arg0: &mut Marketplace, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg4, arg2, &arg0.id, arg5);
        inner_list<T0>(arg0, arg2, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 0x1::option::none<0x2::object::ID>(), arg5);
    }

    public entry fun list_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &0x2::transfer_policy::TransferPolicy<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk::auth_exclusive_transfer(arg4, arg2, &arg0.id, arg6);
        inner_list<T0>(arg0, arg2, arg3, 0x2::object::id<0x2::kiosk::Kiosk>(arg4), 0x1::option::some<0x2::object::ID>(arg5), arg6);
    }

    public fun owner(arg0: &Marketplace) : address {
        arg0.owner
    }

    fun send_fees(arg0: &mut Marketplace, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>) : u64 {
        let v0 = calculate_fees(arg0.fee_bps, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(arg1, v0));
        let v1 = 0 + v0;
        let v2 = v1;
        if (0x1::option::is_some<0x2::object::ID>(&arg4)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg4));
            let v4 = calculate_fees(v3.fee_bps, arg2);
            0x2::balance::join<0x2::sui::SUI>(&mut v3.fee_balance, 0x2::balance::split<0x2::sui::SUI>(arg1, v4));
            v2 = v1 + v4;
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg3));
            let v6 = calculate_fees(v5.fee_bps, arg2);
            0x2::balance::join<0x2::sui::SUI>(&mut v5.fee_balance, 0x2::balance::split<0x2::sui::SUI>(arg1, v6));
            v2 = v2 + v6;
        };
        v2
    }

    public entry fun toggle_admin(arg0: &mut Marketplace, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 135289670001);
        if (is_admin(arg0, arg1)) {
            let (_, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
            0x1::vector::remove<address>(&mut arg0.admins, v1);
        } else {
            0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        };
    }

    public entry fun updateMarket(arg0: &mut Marketplace, arg1: &0x2::package::Publisher, arg2: address, arg3: u64, arg4: u64) {
        assert!(0x2::package::from_package<KEEPSAKE_OB_MARKETPLACE>(arg1), 0);
        assert!(arg4 % 2 == 0, 135289670000);
        assert!(arg3 <= 2000, 135289670000);
        arg0.owner = arg2;
        arg0.fee_bps = arg3;
        arg0.collateral_fee = arg4;
    }

    public entry fun withdraw(arg0: &mut Marketplace, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 135289670001);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        if (arg2 > v0) {
            arg2 = v0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.fee_balance, arg2, arg3), arg1);
    }

    public entry fun withdraw_from_wallet(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg4) == v0.owner, 135289670001);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0.fee_balance);
        if (arg3 > v1) {
            arg3 = v1;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0.fee_balance, arg3, arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

