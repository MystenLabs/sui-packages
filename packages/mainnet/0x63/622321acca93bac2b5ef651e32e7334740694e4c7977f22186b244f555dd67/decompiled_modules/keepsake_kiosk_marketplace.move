module 0x63622321acca93bac2b5ef651e32e7334740694e4c7977f22186b244f555dd67::keepsake_kiosk_marketplace {
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

    struct KEEPSAKE_KIOSK_MARKETPLACE has drop {
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
        cap: 0x2::kiosk::PurchaseCap<T0>,
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
        cap: 0x2::kiosk::PurchaseCap<T0>,
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

    public entry fun auction<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: 0x1::option::Option<0x2::object::ID>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_fees(arg0.fee_bps, arg2);
        let v1 = v0;
        if (0x1::option::is_some<0x2::object::ID>(&arg9)) {
            v1 = v0 + calculate_fees(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg9)).fee_bps, arg2);
        };
        assert!(arg0.collateral_fee == 0x2::coin::value<0x2::sui::SUI>(&arg6), 135289670000);
        let v2 = 0x2::object::new(arg10);
        let v3 = ListItemEvent{
            id        : 0x2::object::uid_to_inner(&v2),
            item_id   : arg1,
            ask       : arg2,
            auction   : true,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ListItemEvent>(v3);
        let v4 = KeepsakeAuctionListing<T0>{
            id                : v2,
            item_id           : arg1,
            bid               : 0x2::balance::zero<0x2::sui::SUI>(),
            bidder            : 0x2::tx_context::sender(arg10),
            bid_amount        : 0,
            collateral        : 0x2::coin::into_balance<0x2::sui::SUI>(arg6),
            min_bid           : arg2,
            min_bid_increment : arg3,
            starts            : arg4,
            expires           : arg5,
            owner             : 0x2::tx_context::sender(arg10),
            seller_kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg7),
            seller_wallet     : arg9,
            buyer_wallet      : 0x1::option::none<0x2::object::ID>(),
            cap               : 0x2::kiosk::list_with_purchase_cap<T0>(arg7, arg8, arg1, arg2 - v1, arg10),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1, v4);
    }

    public entry fun bid<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Marketplace>(arg0);
        let v1 = 0;
        if (0x1::option::is_some<0x2::object::ID>(&arg5)) {
            let v2 = 0x1::option::extract<0x2::object::ID>(&mut arg5);
            v0 = v2;
            v1 = arg3 * (0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, v2).fee_bps as u64) / 10000;
        };
        let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1);
        if (0x1::option::is_some<0x2::object::ID>(&arg5)) {
            0x1::option::fill<0x2::object::ID>(&mut v3.buyer_wallet, v0);
        };
        let v4 = v3.bid_amount;
        assert!(arg3 + v1 == 0x2::coin::value<0x2::sui::SUI>(&arg2), 135289670000);
        let v5 = 0x2::clock::timestamp_ms(arg4);
        assert!(v3.expires >= v5, 135289670100);
        assert!(v3.starts <= v5, 135289670101);
        if (v3.expires + 60000 < v5) {
            v3.expires = v3.expires + 60000;
        };
        if (v4 > 0) {
            assert!(arg3 >= v4 + v3.min_bid_increment, 135289670103);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v3.bid, v4, arg6), v3.bidder);
        } else {
            assert!(arg3 >= v3.min_bid, 135289670104);
        };
        0x2::coin::put<0x2::sui::SUI>(&mut v3.bid, arg2);
        v3.bidder = 0x2::tx_context::sender(arg6);
        v3.bid_amount = arg3;
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : v2,
            owner         : _,
            seller_kiosk  : _,
            seller_wallet : v5,
            cap           : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        let v7 = v0;
        let v8 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (0x1::option::is_some<0x2::object::ID>(&arg4)) {
            assert!(0x2::balance::value<0x2::sui::SUI>(&v8) == calculate_fees(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg4)).fee_bps, v2) + v2, v2);
        } else {
            assert!(0x2::balance::value<0x2::sui::SUI>(&v8) == v2, v2);
        };
        let v9 = &mut v8;
        send_fees(arg0, v9, v2, arg4, v5);
        let v10 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v7),
            item_id    : v1,
            sale_price : 0x2::balance::value<0x2::sui::SUI>(&v8),
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v10);
        0x2::object::delete(v7);
        0x2::kiosk::purchase_with_cap<T0>(arg1, v6, 0x2::coin::from_balance<0x2::sui::SUI>(v8, arg5))
    }

    public fun calculate_fees(arg0: u64, arg1: u64) : u64 {
        arg1 * arg0 / 10000
    }

    public fun collateral_fee(arg0: &Marketplace) : u64 {
        arg0.collateral_fee
    }

    public fun complete_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
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
            cap               : v14,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg2);
        let v15 = v2;
        let v16 = v0;
        assert!(v3 == 0x2::tx_context::sender(arg4), 135289670001);
        let v17 = 0x2::balance::value<0x2::sui::SUI>(&v15);
        assert!(v17 >= v6, 135289670102);
        assert!(v9 < 0x2::clock::timestamp_ms(arg3), 135289670101);
        let v18 = &mut v15;
        send_fees(arg0, v18, v4, v13, v12);
        handle_listing_collateral(v5, v10, arg4);
        let v19 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v16),
            item_id    : arg2,
            sale_price : v17,
            sold       : true,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v19);
        0x2::object::delete(v16);
        0x2::kiosk::purchase_with_cap<T0>(arg1, v14, 0x2::coin::from_balance<0x2::sui::SUI>(v15, arg4))
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
            item_id           : _,
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
            cap               : v14,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeAuctionListing<T0>>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        assert!(0x2::tx_context::sender(arg4) == v10, 135289670001);
        let v15 = 0x2::clock::timestamp_ms(arg2);
        if (v4 != 0 && v15 > v9 && v15 < v9 + 86400000) {
            abort 135289670101
        };
        handle_unlisting_collateral(v5, v3, v2, arg0.owner, arg4);
        0x2::kiosk::return_purchase_cap<T0>(arg3, v14);
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let KeepsakeListing {
            id            : v0,
            item_id       : v1,
            ask           : _,
            owner         : v3,
            seller_kiosk  : _,
            seller_wallet : _,
            cap           : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg2);
        let v7 = v0;
        assert!(0x2::tx_context::sender(arg3) == v3, 135289670001);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v6);
        let v8 = DelistItemEvent{
            id         : 0x2::object::uid_to_inner(&v7),
            item_id    : v1,
            sale_price : 0,
            sold       : false,
            type_name  : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DelistItemEvent>(v8);
        0x2::object::delete(v7);
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

    fun init(arg0: KEEPSAKE_KIOSK_MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<KEEPSAKE_KIOSK_MARKETPLACE>(arg0, arg1);
        let v0 = Marketplace{
            id             : 0x2::object::new(arg1),
            owner          : 0x2::tx_context::sender(arg1),
            admins         : 0x1::vector::empty<address>(),
            fee_bps        : 0,
            fee_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
            collateral_fee : 0,
        };
        0x2::transfer::share_object<Marketplace>(v0);
    }

    public entry fun is_admin(arg0: &mut Marketplace, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x1::option::Option<0x2::object::ID>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_fees(arg0.fee_bps, arg2);
        let v1 = v0;
        if (0x1::option::is_some<0x2::object::ID>(&arg5)) {
            v1 = v0 + calculate_fees(0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Wallet>(&mut arg0.id, 0x1::option::extract<0x2::object::ID>(&mut arg5)).fee_bps, arg2);
        };
        let v2 = 0x2::object::new(arg6);
        let v3 = ListItemEvent{
            id        : 0x2::object::uid_to_inner(&v2),
            item_id   : arg1,
            ask       : arg2,
            auction   : false,
            type_name : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ListItemEvent>(v3);
        let v4 = KeepsakeListing<T0>{
            id            : v2,
            item_id       : arg1,
            ask           : arg2,
            owner         : 0x2::tx_context::sender(arg6),
            seller_kiosk  : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            seller_wallet : arg5,
            cap           : 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg1, arg2 - v1, arg6),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, KeepsakeListing<T0>>(&mut arg0.id, arg1, v4);
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
        assert!(0x2::package::from_package<KEEPSAKE_KIOSK_MARKETPLACE>(arg1), 0);
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

