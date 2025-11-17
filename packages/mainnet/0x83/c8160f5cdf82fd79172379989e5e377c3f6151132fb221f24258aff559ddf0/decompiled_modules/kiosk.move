module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::kiosk {
    struct Kiosk has store, key {
        id: 0x2::object::UID,
        owner: address,
        kiosk_items_count: u64,
    }

    struct KioskItem has copy, drop, store {
        id: u64,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        price: u64,
        only_item_swap: bool,
        is_active: bool,
    }

    struct KioskItemOffer has copy, drop, store {
        id: u64,
        kiosk_item_id: u64,
        offered_item_id: 0x2::object::ID,
        offerer: address,
        created_at: u64,
        status: u8,
    }

    struct KioskCreated has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct KioskItemListed has copy, drop {
        id: u64,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        seller: address,
        price: u64,
        only_item_swap: bool,
    }

    struct KioskItemUpdated has copy, drop {
        id: u64,
        kiosk_id: 0x2::object::ID,
        seller: address,
        old_price: u64,
        new_price: u64,
        new_only_item_swap: bool,
    }

    struct KioskItemSold has copy, drop {
        id: u64,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price: u64,
        service_fee: u64,
        developer_royalty: u64,
        total_paid: u64,
        seller_net_amount: u64,
        trade_type: u8,
    }

    struct KioskItemCanceled has copy, drop {
        id: u64,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        canceled_by: address,
        seller: address,
    }

    struct KioskItemOfferCreated has copy, drop {
        id: u64,
        kiosk_item_id: u64,
        offered_item_id: 0x2::object::ID,
        offerer: address,
        kiosk_id: 0x2::object::ID,
    }

    struct KioskItemOfferAccepted has copy, drop {
        id: u64,
        kiosk_item_id: u64,
        kiosk_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        offered_item_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        service_fee: u64,
        developer_royalty: u64,
        total_paid: u64,
        seller_net_amount: u64,
        trade_type: u8,
    }

    struct KioskItemOfferCanceled has copy, drop {
        id: u64,
        kiosk_item_id: u64,
        offered_item_id: 0x2::object::ID,
        canceled_by: address,
        kiosk_id: 0x2::object::ID,
    }

    struct KIOSK has drop {
        dummy_field: bool,
    }

    public fun accept_item_offer(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg2: &mut Kiosk, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = get_kiosk_item_key(arg3);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg2.id, v1), 4);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg2.id, v1);
        assert!(v2.is_active, 4);
        assert!(v0 == v2.seller, 1);
        let v3 = get_offer_key(arg3, arg4);
        assert!(0x2::dynamic_field::exists_<u64>(&arg2.id, v3), 10);
        assert!(0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg2.id, v3).status == 1, 13);
        let v4 = 0x2::dynamic_field::remove<u64, KioskItemOffer>(&mut arg2.id, v3);
        let v5 = 0x2::dynamic_field::remove<vector<u8>, KioskItem>(&mut arg2.id, v1);
        let v6 = 0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg2.id, arg3);
        let v7 = 0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg2.id, get_offered_item_key(arg3, arg4));
        let v8 = 0x2::dynamic_field::remove<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg2.id, get_gas_payment_key(arg3, arg4));
        let v9 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&v6);
        let v10 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&v7);
        assert!(v9 == v5.item_id, 8);
        assert!(v10 == v4.offered_item_id, 8);
        let v11 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_collection_owner(arg1);
        let (_, _, _, _, v16) = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::get_fee_manager(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v16, 3);
        let v17 = if (0x2::coin::value<0x2::sui::SUI>(&arg5) == v16) {
            arg5
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, v0);
            0x2::coin::split<0x2::sui::SUI>(&mut arg5, v16, arg6)
        };
        0x2::coin::join<0x2::sui::SUI>(&mut v8, v17);
        let v18 = 0x2::coin::value<0x2::sui::SUI>(&v8);
        let v19 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::calculate_item_swap_developer_royalty(arg0, v11, v18);
        if (v19 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v19, arg6), v11);
        };
        if (0x2::coin::value<0x2::sui::SUI>(&v8) > 0) {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::deposit_service_fee(arg0, v8, arg6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
        let v20 = v4.offerer;
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::update_item_owner(&mut v6, v20);
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::update_item_owner(&mut v7, v0);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(v6, v20);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(v7, v0);
        v4.status = 2;
        v5.is_active = false;
        0x2::dynamic_field::add<u64, KioskItemOffer>(&mut arg2.id, v3, v4);
        0x2::dynamic_field::add<vector<u8>, KioskItem>(&mut arg2.id, v1, v5);
        let v21 = KioskItemOfferAccepted{
            id                : arg4,
            kiosk_item_id     : arg3,
            kiosk_id          : 0x2::object::id<Kiosk>(arg2),
            item_id           : v9,
            offered_item_id   : v10,
            buyer             : v20,
            seller            : v0,
            service_fee       : v18 - v19,
            developer_royalty : v19,
            total_paid        : v18,
            seller_net_amount : 0,
            trade_type        : 2,
        };
        0x2::event::emit<KioskItemOfferAccepted>(v21);
    }

    public fun admin_create_kiosk(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg2), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = Kiosk{
            id                : 0x2::object::new(arg2),
            owner             : arg1,
            kiosk_items_count : 0,
        };
        let v1 = KioskCreated{
            id    : 0x2::object::id<Kiosk>(&v0),
            owner : arg1,
        };
        0x2::event::emit<KioskCreated>(v1);
        0x2::transfer::public_share_object<Kiosk>(v0);
    }

    public fun buy_item_with_coins(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::Collection, arg1: &mut Kiosk, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_kiosk_item_key(arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v1), 4);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg1.id, v1);
        assert!(v2.is_active, 4);
        assert!(v0 != v2.seller, 6);
        assert!(!v2.only_item_swap, 11);
        let v3 = 0x2::dynamic_field::remove<vector<u8>, KioskItem>(&mut arg1.id, v1);
        let v4 = 0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg1.id, arg2);
        assert!(v3.is_active, 7);
        let v5 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&v4);
        assert!(v5 == v3.item_id, 8);
        let v6 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v6 >= v3.price, 3);
        let v7 = if (v6 == v3.price) {
            arg3
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
            0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3.price, arg5)
        };
        let v8 = v7;
        let v9 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::collection::get_collection_owner(arg0);
        let v10 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::calculate_purchase_fee(arg4, v3.price);
        let v11 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::calculate_purchase_developer_royalty(arg4, v9, v3.price);
        assert!(v10 >= 0, 9);
        assert!(v11 >= 0, 9);
        let v12 = v10 + v11;
        assert!(v3.price >= v12, 17);
        let v13 = v3.price - v12;
        if (v10 > 0) {
            0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::deposit_service_fee(arg4, 0x2::coin::split<0x2::sui::SUI>(&mut v8, v10, arg5), arg5);
        };
        if (v11 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v8, v11, arg5), v9);
        };
        let v14 = 0x2::coin::value<0x2::sui::SUI>(&v8);
        assert!(v14 == v13, 9);
        if (v14 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v3.seller);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
        };
        0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::update_item_owner(&mut v4, v0);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(v4, v0);
        v3.is_active = false;
        0x2::dynamic_field::add<vector<u8>, KioskItem>(&mut arg1.id, v1, v3);
        let v15 = KioskItemSold{
            id                : arg2,
            kiosk_id          : 0x2::object::id<Kiosk>(arg1),
            item_id           : v5,
            buyer             : v0,
            seller            : v3.seller,
            price             : v3.price,
            service_fee       : v10,
            developer_royalty : v11,
            total_paid        : v3.price,
            seller_net_amount : v13,
            trade_type        : 1,
        };
        0x2::event::emit<KioskItemSold>(v15);
    }

    public fun cancel_item_offer(arg0: &mut Kiosk, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_offer_key(arg1, arg2);
        assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, v1), 10);
        let v2 = 0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg0.id, v1);
        assert!(v2.status == 1, 13);
        assert!(v0 == v2.offerer, 14);
        let v3 = 0x2::dynamic_field::remove<u64, KioskItemOffer>(&mut arg0.id, v1);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg0.id, get_offered_item_key(arg1, arg2)), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, get_gas_payment_key(arg1, arg2)), v0);
        v3.status = 3;
        0x2::dynamic_field::add<u64, KioskItemOffer>(&mut arg0.id, v1, v3);
        let v4 = KioskItemOfferCanceled{
            id              : arg2,
            kiosk_item_id   : arg1,
            offered_item_id : v3.offered_item_id,
            canceled_by     : v0,
            kiosk_id        : 0x2::object::id<Kiosk>(arg0),
        };
        0x2::event::emit<KioskItemOfferCanceled>(v4);
    }

    public fun cancel_kiosk_item(arg0: &mut Kiosk, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = get_kiosk_item_key(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1), 4);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg0.id, v1);
        assert!(v2.is_active, 4);
        assert!(v0 == arg0.owner || v0 == v2.seller, 1);
        assert!(0x2::dynamic_field::exists_<u64>(&arg0.id, arg1), 4);
        let v3 = v2.seller;
        let v4 = v2.item_id;
        let v5 = 0x2::dynamic_field::remove<vector<u8>, KioskItem>(&mut arg0.id, v1);
        let v6 = 0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg0.id, arg1);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&v6) == v4, 8);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(v6, v3);
        let v7 = KioskItem{
            id             : v5.id,
            kiosk_id       : v5.kiosk_id,
            item_id        : v5.item_id,
            seller         : v5.seller,
            price          : v5.price,
            only_item_swap : v5.only_item_swap,
            is_active      : false,
        };
        0x2::dynamic_field::add<vector<u8>, KioskItem>(&mut arg0.id, v1, v7);
        let v8 = KioskItemCanceled{
            id          : arg1,
            kiosk_id    : 0x2::object::id<Kiosk>(arg0),
            item_id     : v4,
            canceled_by : v0,
            seller      : v3,
        };
        0x2::event::emit<KioskItemCanceled>(v8);
    }

    public fun create_item_offer(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::FeeManager, arg1: &mut Kiosk, arg2: u64, arg3: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = get_kiosk_item_key(arg2);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v1), 4);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg1.id, v1);
        assert!(v2.is_active, 4);
        assert!(v0 != v2.seller, 6);
        let v3 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&arg3);
        assert!(v3 != v2.item_id, 8);
        let (_, _, _, _, v8) = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager::get_fee_manager(arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= v8, 3);
        let v9 = if (0x2::coin::value<0x2::sui::SUI>(&arg4) == v8) {
            arg4
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, v0);
            0x2::coin::split<0x2::sui::SUI>(&mut arg4, v8, arg5)
        };
        let v10 = generate_offer_id(arg1, arg2);
        let v11 = get_offer_key(arg2, v10);
        assert!(!0x2::dynamic_field::exists_<u64>(&arg1.id, v11), 12);
        let v12 = KioskItemOffer{
            id              : v10,
            kiosk_item_id   : arg2,
            offered_item_id : v3,
            offerer         : v0,
            created_at      : 0x2::tx_context::epoch(arg5),
            status          : 1,
        };
        0x2::dynamic_field::add<u64, KioskItemOffer>(&mut arg1.id, v11, v12);
        0x2::dynamic_field::add<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg1.id, get_offered_item_key(arg2, v10), arg3);
        0x2::dynamic_field::add<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, get_gas_payment_key(arg2, v10), v9);
        let v13 = KioskItemOfferCreated{
            id              : v10,
            kiosk_item_id   : arg2,
            offered_item_id : v3,
            offerer         : v0,
            kiosk_id        : 0x2::object::id<Kiosk>(arg1),
        };
        0x2::event::emit<KioskItemOfferCreated>(v13);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Kiosk{
            id                : 0x2::object::new(arg0),
            owner             : v0,
            kiosk_items_count : 0,
        };
        let v2 = KioskCreated{
            id    : 0x2::object::id<Kiosk>(&v1),
            owner : v0,
        };
        0x2::event::emit<KioskCreated>(v2);
        0x2::transfer::public_share_object<Kiosk>(v1);
    }

    public fun create_kiosk_item(arg0: &mut Kiosk, arg1: 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::get_item_id(&arg1);
        assert!(v0 == arg0.owner, 1);
        assert!(!is_item_already_listed(arg0, v1), 5);
        if (arg3) {
            assert!(arg2 == 0, 2);
        } else {
            assert!(arg2 > 0, 2);
        };
        arg0.kiosk_items_count = arg0.kiosk_items_count + 1;
        let v2 = arg0.kiosk_items_count;
        let v3 = KioskItem{
            id             : v2,
            kiosk_id       : 0x2::object::id<Kiosk>(arg0),
            item_id        : v1,
            seller         : v0,
            price          : arg2,
            only_item_swap : arg3,
            is_active      : true,
        };
        0x2::dynamic_field::add<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg0.id, v2, arg1);
        0x2::dynamic_field::add<vector<u8>, KioskItem>(&mut arg0.id, get_kiosk_item_key(v2), v3);
        let v4 = KioskItemListed{
            id             : v2,
            kiosk_id       : 0x2::object::id<Kiosk>(arg0),
            item_id        : v1,
            seller         : v0,
            price          : arg2,
            only_item_swap : arg3,
        };
        0x2::event::emit<KioskItemListed>(v4);
    }

    fun generate_offer_id(arg0: &Kiosk, arg1: u64) : u64 {
        let v0 = 1;
        while (v0 <= 1000 && 0x2::dynamic_field::exists_<u64>(&arg0.id, get_offer_key(arg1, v0))) {
            v0 = v0 + 1;
        };
        assert!(v0 <= 1000, 15);
        v0
    }

    fun get_gas_payment_key(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 18446744073, 16);
        arg0 * 1000000 + arg1 + 300000
    }

    public fun get_kiosk_item_info(arg0: &Kiosk, arg1: u64) : (bool, u64, address, address, u64) {
        let v0 = get_kiosk_item_key(arg1);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0)) {
            let v6 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg0.id, v0);
            (v6.is_active, v6.id, 0x2::object::id_to_address(&v6.item_id), v6.seller, v6.price)
        } else {
            (false, 0, @0x0, @0x0, 0)
        }
    }

    fun get_kiosk_item_key(arg0: u64) : vector<u8> {
        let v0 = b"kiosk_item_";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        v0
    }

    public fun get_kiosk_items_count(arg0: &Kiosk) : u64 {
        arg0.kiosk_items_count
    }

    public fun get_kiosk_owner(arg0: &Kiosk) : address {
        arg0.owner
    }

    public fun get_offer_info(arg0: &Kiosk, arg1: u64, arg2: u64) : (u8, address, address, u64) {
        let v0 = get_offer_key(arg1, arg2);
        if (0x2::dynamic_field::exists_<u64>(&arg0.id, v0)) {
            let v5 = 0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg0.id, v0);
            (v5.status, 0x2::object::id_to_address(&v5.offered_item_id), v5.offerer, v5.created_at)
        } else {
            (0, @0x0, @0x0, 0)
        }
    }

    fun get_offer_key(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 18446744073, 16);
        arg0 * 1000000 + arg1 + 100000
    }

    fun get_offered_item_key(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 < 18446744073, 16);
        arg0 * 1000000 + arg1 + 200000
    }

    public fun get_offers_count_for_listing(arg0: &Kiosk, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 1;
        while (v1 <= 1000) {
            let v2 = get_offer_key(arg1, v1);
            if (0x2::dynamic_field::exists_<u64>(&arg0.id, v2)) {
                if (0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg0.id, v2).status == 1) {
                    v0 = v0 + 1;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
    }

    fun is_item_already_listed(arg0: &Kiosk, arg1: 0x2::object::ID) : bool {
        let v0 = 1;
        while (v0 <= arg0.kiosk_items_count) {
            let v1 = get_kiosk_item_key(v0);
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg0.id, v1);
                if (v2.is_active && v2.item_id == arg1) {
                    return true
                };
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_kiosk_item_active(arg0: &Kiosk, arg1: u64) : bool {
        let v0 = get_kiosk_item_key(arg1);
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v0) && 0x2::dynamic_field::borrow<vector<u8>, KioskItem>(&arg0.id, v0).is_active
    }

    public fun reject_all_other_offers(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Kiosk, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = 1;
        while (v0 <= 1000) {
            if (v0 != arg3) {
                let v1 = get_offer_key(arg2, v0);
                if (0x2::dynamic_field::exists_<u64>(&arg1.id, v1)) {
                    if (0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg1.id, v1).status == 1) {
                        let v2 = 0x2::dynamic_field::remove<u64, KioskItemOffer>(&mut arg1.id, v1);
                        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg1.id, get_offered_item_key(arg2, v0)), v2.offerer);
                        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, get_gas_payment_key(arg2, v0)), v2.offerer);
                        v2.status = 4;
                        0x2::dynamic_field::add<u64, KioskItemOffer>(&mut arg1.id, v1, v2);
                        let v3 = KioskItemOfferCanceled{
                            id              : v0,
                            kiosk_item_id   : arg2,
                            offered_item_id : v2.offered_item_id,
                            canceled_by     : @0x0,
                            kiosk_id        : 0x2::object::id<Kiosk>(arg1),
                        };
                        0x2::event::emit<KioskItemOfferCanceled>(v3);
                    };
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun reject_single_offer(arg0: &mut 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut Kiosk, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::factory_role()), 1);
        let v0 = get_offer_key(arg2, arg3);
        assert!(0x2::dynamic_field::exists_<u64>(&arg1.id, v0), 10);
        assert!(0x2::dynamic_field::borrow<u64, KioskItemOffer>(&arg1.id, v0).status == 1, 13);
        let v1 = 0x2::dynamic_field::remove<u64, KioskItemOffer>(&mut arg1.id, v0);
        0x2::transfer::public_transfer<0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(0x2::dynamic_field::remove<u64, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::item::Item>(&mut arg1.id, get_offered_item_key(arg2, arg3)), v1.offerer);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::dynamic_field::remove<u64, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.id, get_gas_payment_key(arg2, arg3)), v1.offerer);
        v1.status = 4;
        0x2::dynamic_field::add<u64, KioskItemOffer>(&mut arg1.id, v0, v1);
        let v2 = KioskItemOfferCanceled{
            id              : arg3,
            kiosk_item_id   : arg2,
            offered_item_id : v1.offered_item_id,
            canceled_by     : @0x0,
            kiosk_id        : 0x2::object::id<Kiosk>(arg1),
        };
        0x2::event::emit<KioskItemOfferCanceled>(v2);
    }

    public fun update_kiosk_item(arg0: &mut Kiosk, arg1: u64, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner, 1);
        let v1 = get_kiosk_item_key(arg1);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, v1), 4);
        let v2 = 0x2::dynamic_field::remove<vector<u8>, KioskItem>(&mut arg0.id, v1);
        assert!(v2.is_active, 4);
        assert!(v0 == v2.seller, 1);
        if (arg3) {
            assert!(arg2 == 0, 2);
        } else {
            assert!(arg2 > 0, 2);
        };
        v2.price = arg2;
        v2.only_item_swap = arg3;
        0x2::dynamic_field::add<vector<u8>, KioskItem>(&mut arg0.id, v1, v2);
        let v3 = KioskItemUpdated{
            id                 : arg1,
            kiosk_id           : 0x2::object::id<Kiosk>(arg0),
            seller             : v0,
            old_price          : v2.price,
            new_price          : arg2,
            new_only_item_swap : arg3,
        };
        0x2::event::emit<KioskItemUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

