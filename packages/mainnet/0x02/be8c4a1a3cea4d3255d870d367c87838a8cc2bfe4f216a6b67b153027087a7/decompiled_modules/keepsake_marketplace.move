module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::keepsake_marketplace {
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

    struct KEEPSAKE_MARKETPLACE has drop {
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
        seller_wallet: 0x1::option::Option<0x2::object::ID>,
    }

    struct KeepsakeAuctionListing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
        bid: 0x2::balance::Balance<0x2::sui::SUI>,
        bid_amount: u64,
        collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        min_bid: u64,
        min_bid_increment: u64,
        starts: u64,
        expires: u64,
        owner: address,
        bidder: address,
        seller_wallet: 0x1::option::Option<0x2::object::ID>,
        buyer_wallet: 0x1::option::Option<0x2::object::ID>,
    }

    struct WonAuction<T0: key> {
        item: T0,
        bidder: address,
    }

    struct ListItemEvent has copy, drop {
        item_id: 0x2::object::ID,
        ask: u64,
        auction: bool,
        type_name: 0x1::type_name::TypeName,
    }

    struct DelistItemEvent has copy, drop {
        item_id: 0x2::object::ID,
        sale_price: u64,
        sold: bool,
        type_name: 0x1::type_name::TypeName,
    }

    public entry fun auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        inner_auction<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg8, 0x1::option::none<0x2::object::ID>(), arg9);
    }

    public entry fun auction_many<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: vector<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg3)) {
            let v1 = 0x2::coin::split<0x2::sui::SUI>(arg8, arg0.collateral_fee, arg9);
            inner_auction<T0>(arg0, arg1, 0x1::vector::pop_back<T0>(&mut arg3), arg4, arg5, arg6, arg7, v1, 0x1::option::none<0x2::object::ID>(), arg9);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg3);
    }

    public entry fun auction_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x2::object::ID, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        inner_auction<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg7, arg9, 0x1::option::some<0x2::object::ID>(arg8), arg10);
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

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferRequest<T0> {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : v2,
            owner         : v3,
            seller_wallet : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == v2, 135289670000);
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v6 = 0x2::kiosk::take<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v5), v1);
        send_fees(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3), v2, 0x1::option::none<0x2::object::ID>(), v4, v3, arg4);
        let v7 = DelistItemEvent{
            item_id    : v1,
            sale_price : v2,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v7);
        0x2::transfer::public_transfer<T0>(v6, 0x2::tx_context::sender(arg4));
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::new_request<T0>(0x2::object::id<T0>(&v6), v2, v5)
    }

    public fun buy_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferRequest<T0> {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : v2,
            owner         : v3,
            seller_wallet : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        let v5 = calculate_fees(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, arg4).fee_bps, v2) + v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v5, 135289670000);
        let v6 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v7 = 0x2::kiosk::take<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v6), v1);
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg5));
        send_fees(arg0, v8, v2, 0x1::option::some<0x2::object::ID>(arg4), v4, v3, arg5);
        0x2::object::delete(v0);
        let v9 = DelistItemEvent{
            item_id    : v1,
            sale_price : v2,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v9);
        0x2::transfer::public_transfer<T0>(v7, 0x2::tx_context::sender(arg5));
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::new_request<T0>(0x2::object::id<T0>(&v7), v2, v6)
    }

    public fun calculate_fees(arg0: u64, arg1: u64) : u64 {
        arg1 * arg0 / 10000
    }

    public fun collateral_fee(arg0: &Marketplace) : u64 {
        arg0.collateral_fee
    }

    public fun complete_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferRequest<T0> {
        let KeepsakeAuctionListing {
            id                : v0,
            item_id           : _,
            bid               : v2,
            bid_amount        : v3,
            collateral        : v4,
            min_bid           : v5,
            min_bid_increment : _,
            starts            : _,
            expires           : v8,
            owner             : v9,
            bidder            : v10,
            seller_wallet     : v11,
            buyer_wallet      : v12,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg2);
        let v13 = v2;
        0x2::object::delete(v0);
        let v14 = 0x2::balance::value<0x2::sui::SUI>(&v13);
        assert!(v14 >= v5, 135289670102);
        assert!(v8 < 0x2::clock::timestamp_ms(arg3), 135289670101);
        handle_listing_collateral(v4, v9, arg4);
        let v15 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v16 = 0x2::kiosk::take<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, v15), arg2);
        send_fees(arg0, v13, v3, v12, v11, v9, arg4);
        let v17 = DelistItemEvent{
            item_id    : arg2,
            sale_price : v14,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v17);
        0x2::transfer::public_transfer<T0>(v16, v10);
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::new_request<T0>(arg2, v3, v15)
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

    public fun deauction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let KeepsakeAuctionListing {
            id                : v0,
            item_id           : v1,
            bid               : v2,
            bid_amount        : v3,
            collateral        : v4,
            min_bid           : _,
            min_bid_increment : _,
            starts            : _,
            expires           : v8,
            owner             : v9,
            bidder            : v10,
            seller_wallet     : _,
            buyer_wallet      : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg4) == v9, 135289670001);
        let v13 = 0x2::clock::timestamp_ms(arg3);
        if (v3 != 0 && v13 > v8 && v13 < v8 + 86400000) {
            abort 135289670101
        };
        handle_unlisting_collateral(v4, v10, v2, arg0.owner, arg4);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, 0x2::object::id<0x2::kiosk::Kiosk>(arg1)), v1), 0x2::tx_context::sender(arg4));
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : _,
            owner         : v3,
            seller_wallet : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg3) == v3, 135289670001);
        let v5 = DelistItemEvent{
            item_id    : v1,
            sale_price : 0,
            sold       : false,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v5);
        0x2::kiosk::take<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, 0x2::object::id<0x2::kiosk::Kiosk>(arg1)), v1)
    }

    public entry fun delist_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
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

    fun init(arg0: KEEPSAKE_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KEEPSAKE_MARKETPLACE>(arg0, arg1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v0;
        let v3 = Marketplace{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            admins         : 0x1::vector::empty<address>(),
            fee_bps        : 0,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            collateral_fee : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut v3.id, 0x2::object::id<0x2::kiosk::Kiosk>(&v2), v1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x2::transfer::share_object<Marketplace>(v3);
    }

    fun inner_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::option::Option<0x2::object::ID>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg2);
        assert!(arg0.collateral_fee == 0x2::coin::value<0x2::sui::SUI>(&arg7), 135289670000);
        0x2::kiosk::place<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, 0x2::object::id<0x2::kiosk::Kiosk>(arg1)), arg2);
        let v1 = KeepsakeAuctionListing<T0>{
            id                : 0x2::object::new(arg9),
            item_id           : v0,
            bid               : 0x2::balance::zero<0x2::sui::SUI>(),
            bid_amount        : 0,
            collateral        : 0x2::coin::into_balance<0x2::sui::SUI>(arg7),
            min_bid           : arg3,
            min_bid_increment : arg4,
            starts            : arg5,
            expires           : arg6,
            owner             : 0x2::tx_context::sender(arg9),
            bidder            : 0x2::tx_context::sender(arg9),
            seller_wallet     : arg8,
            buyer_wallet      : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, v0, v1);
    }

    fun inner_list<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = ListItemEvent{
            item_id   : 0x2::object::id<T0>(&arg2),
            ask       : arg3,
            auction   : false,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ListItemEvent>(v0);
        let v1 = 0x2::object::id<T0>(&arg2);
        0x2::kiosk::place<T0>(arg1, 0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::kiosk::KioskOwnerCap>(&mut arg0.id, 0x2::object::id<0x2::kiosk::Kiosk>(arg1)), arg2);
        let v2 = KeepsakeListing<T0>{
            id            : 0x2::object::new(arg5),
            item_id       : v1,
            ask           : arg3,
            owner         : 0x2::tx_context::sender(arg5),
            seller_wallet : arg4,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, v1, v2);
    }

    public entry fun is_admin(arg0: &mut Marketplace, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        inner_list<T0>(arg0, arg1, arg3, arg4, 0x1::option::none<0x2::object::ID>(), arg5);
    }

    public entry fun list_many<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: vector<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg3)) {
            inner_list<T0>(arg0, arg1, 0x1::vector::pop_back<T0>(&mut arg3), arg4, 0x1::option::none<0x2::object::ID>(), arg5);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg3);
    }

    public entry fun list_with_wallet<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: u64, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        inner_list<T0>(arg0, arg1, arg3, arg4, 0x1::option::some<0x2::object::ID>(arg5), arg6);
    }

    public fun owner(arg0: &Marketplace) : address {
        arg0.owner
    }

    fun send_fees(arg0: &mut Marketplace, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, calculate_fees(arg0.fee_bps, arg2)));
        if (0x1::option::is_some<0x2::object::ID>(&arg4)) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg4));
            0x2::balance::join<0x2::sui::SUI>(&mut v0.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, calculate_fees(v0.fee_bps, arg2)));
        };
        if (0x1::option::is_some<0x2::object::ID>(&arg3)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg3));
            0x2::balance::join<0x2::sui::SUI>(&mut v1.fee_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, calculate_fees(v1.fee_bps, arg2)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg1, arg6), arg5);
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
        assert!(0x2::package::from_package<KEEPSAKE_MARKETPLACE>(arg1), 0);
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

