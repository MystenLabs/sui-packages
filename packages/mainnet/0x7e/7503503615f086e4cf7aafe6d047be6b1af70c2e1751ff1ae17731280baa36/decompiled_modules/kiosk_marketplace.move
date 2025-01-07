module 0x7e7503503615f086e4cf7aafe6d047be6b1af70c2e1751ff1ae17731280baa36::kiosk_marketplace {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        fee_bps: u16,
    }

    struct MarketplaceConfig has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        fee_bps: u16,
        admin: address,
        beneficiary: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        list_items: 0x2::object_table::ObjectTable<0x2::object::ID, Listing>,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        owner: address,
        nft_type: 0x1::ascii::String,
    }

    struct ListingEvent has copy, drop {
        item_id: 0x2::object::ID,
        price: u64,
        seller: address,
        nft_type: 0x1::ascii::String,
    }

    struct DeListEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        nft_type: 0x1::ascii::String,
    }

    struct BuyEvent has copy, drop {
        item_id: 0x2::object::ID,
        price: u64,
        buyer: address,
        nft_type: 0x1::ascii::String,
    }

    public entry fun delist<T0: store + key>(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id       : v0,
            price    : _,
            owner    : v2,
            nft_type : v3,
        } = 0x2::object_table::remove<0x2::object::ID, Listing>(&mut arg0.list_items, arg3);
        0x2::kiosk::set_owner(arg1, arg2, arg4);
        assert!(v2 == 0x2::tx_context::sender(arg4), 101);
        0x2::kiosk::delist<T0>(arg1, arg2, arg3);
        0x2::object::delete(v0);
        let v4 = DeListEvent{
            item_id  : arg3,
            seller   : v2,
            nft_type : v3,
        };
        0x2::event::emit<DeListEvent>(v4);
    }

    public entry fun list<T0: store + key>(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 103);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::tx_context::sender(arg5);
        0x2::kiosk::set_owner(arg1, arg2, arg5);
        let v2 = Listing{
            id       : 0x2::object::new(arg5),
            price    : arg4,
            owner    : v1,
            nft_type : v0,
        };
        0x2::object_table::add<0x2::object::ID, Listing>(&mut arg0.list_items, arg3, v2);
        0x2::kiosk::list<T0>(arg1, arg2, arg3, arg4);
        let v3 = ListingEvent{
            item_id  : arg3,
            price    : arg4,
            seller   : v1,
            nft_type : v0,
        };
        0x2::event::emit<ListingEvent>(v3);
    }

    public entry fun buy<T0: store + key>(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 103);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg4);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg4);
        let Listing {
            id       : v2,
            price    : v3,
            owner    : _,
            nft_type : v5,
        } = 0x2::object_table::remove<0x2::object::ID, Listing>(&mut arg0.list_items, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) >= v3, 104);
        let (v6, v7) = 0x2::kiosk::purchase<T0>(arg2, arg3, 0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg5));
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, v7);
        0x2::transfer::public_transfer<T0>(v6, v0);
        0x2::object::delete(v2);
        let v11 = BuyEvent{
            item_id  : arg3,
            price    : v3,
            buyer    : v0,
            nft_type : v5,
        };
        0x2::event::emit<BuyEvent>(v11);
    }

    fun charge_service_fee(arg0: &mut MarketplaceConfig, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (((arg1 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3)));
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketplaceConfig{
            id          : 0x2::object::new(arg0),
            is_paused   : false,
            fee_bps     : 200,
            admin       : 0x2::tx_context::sender(arg0),
            beneficiary : @0xf491dd55ae411d4c95522299e46b2a96d1003ff9683802c868f343e72deb983a,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            list_items  : 0x2::object_table::new<0x2::object::ID, Listing>(arg0),
        };
        0x2::transfer::public_share_object<MarketplaceConfig>(v0);
    }

    public entry fun set_marketplace(arg0: &mut MarketplaceConfig, arg1: address, arg2: u16, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 102);
        arg0.admin = arg1;
        arg0.fee_bps = arg2;
    }

    public entry fun set_status(arg0: &mut MarketplaceConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 102);
        arg0.is_paused = arg1;
    }

    public entry fun withdraw(arg0: &mut MarketplaceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1) || arg0.beneficiary == 0x2::tx_context::sender(arg1), 102);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg1), arg0.beneficiary);
        };
    }

    // decompiled from Move bytecode v6
}

