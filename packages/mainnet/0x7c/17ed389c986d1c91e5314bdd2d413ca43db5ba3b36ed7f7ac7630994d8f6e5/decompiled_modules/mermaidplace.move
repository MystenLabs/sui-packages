module 0x7c17ed389c986d1c91e5314bdd2d413ca43db5ba3b36ed7f7ac7630994d8f6e5::mermaidplace {
    struct MermaidplaceConfig has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        fee_bps: u16,
        admin: address,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        list_items: 0x2::object_table::ObjectTable<0x2::object::ID, Listing>,
        vec_sponsor: vector<address>,
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

    struct ForceDeListEvent has copy, drop {
        item_id: 0x2::object::ID,
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
        royalty_fee: u64,
        service_fee: u64,
        received: u64,
        buyer: address,
        nft_type: 0x1::ascii::String,
    }

    struct ChangePriceEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        new_price: u64,
    }

    struct ColorObject has key {
        id: 0x2::object::UID,
        red: u8,
        green: u8,
        blue: u8,
    }

    entry fun addSponsor(arg0: &mut MermaidplaceConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<address>(&mut arg0.vec_sponsor, arg1);
    }

    public entry fun buy<T0: store + key>(arg0: &mut MermaidplaceConfig, arg1: &mut 0x7c17ed389c986d1c91e5314bdd2d413ca43db5ba3b36ed7f7ac7630994d8f6e5::royalty_fee::RoyaltyBag, arg2: 0x2::object::ID, arg3: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg3);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v1, arg3);
        let Listing {
            id       : v2,
            price    : v3,
            owner    : v4,
            nft_type : v5,
        } = 0x2::object_table::remove<0x2::object::ID, Listing>(&mut arg0.list_items, arg2);
        let v6 = v2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&v1) >= v3, 4);
        let v7 = &mut v1;
        let v8 = charge_service_fee(arg0, v3, v7, arg4);
        let v9 = 0x7c17ed389c986d1c91e5314bdd2d413ca43db5ba3b36ed7f7ac7630994d8f6e5::royalty_fee::charge_royalty<T0>(arg1, v3, &mut v1, arg4);
        assert!(v8 + v9 < v3, 5);
        let v10 = v3 - v8 - v9;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v10, arg4), v4);
        if (0x2::coin::value<0x2::sui::SUI>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v1);
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v6, true), v0);
        0x2::object::delete(v6);
        let v11 = BuyEvent{
            item_id     : arg2,
            price       : v3,
            royalty_fee : v9,
            service_fee : v8,
            received    : v10,
            buyer       : v0,
            nft_type    : v5,
        };
        0x2::event::emit<BuyEvent>(v11);
    }

    public entry fun change_price(arg0: &mut MermaidplaceConfig, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Listing>(&mut arg0.list_items, arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 3);
        v0.price = arg2;
        let v1 = ChangePriceEvent{
            item_id   : arg1,
            seller    : v0.owner,
            new_price : arg2,
        };
        0x2::event::emit<ChangePriceEvent>(v1);
    }

    fun charge_service_fee(arg0: &mut MermaidplaceConfig, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = (((arg1 as u128) * (arg0.fee_bps as u128) / 10000) as u64);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg3)));
        };
        v0
    }

    public entry fun createColor(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = newColor(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<ColorObject>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun delist<T0: store + key>(arg0: &mut MermaidplaceConfig, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id       : v0,
            price    : _,
            owner    : v2,
            nft_type : v3,
        } = 0x2::object_table::remove<0x2::object::ID, Listing>(&mut arg0.list_items, arg1);
        let v4 = v0;
        assert!(v2 == 0x2::tx_context::sender(arg2), 3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v4, true), v2);
        0x2::object::delete(v4);
        let v5 = DeListEvent{
            item_id  : arg1,
            seller   : v2,
            nft_type : v3,
        };
        0x2::event::emit<DeListEvent>(v5);
    }

    public entry fun force_batch_delist<T0: store + key>(arg0: &mut MermaidplaceConfig, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v1 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let Listing {
                id       : v2,
                price    : _,
                owner    : v4,
                nft_type : v5,
            } = 0x2::object_table::remove<0x2::object::ID, Listing>(&mut arg0.list_items, v1);
            let v6 = v2;
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v6, true), v4);
            0x2::object::delete(v6);
            let v7 = ForceDeListEvent{
                item_id  : v1,
                seller   : v4,
                nft_type : v5,
            };
            0x2::event::emit<ForceDeListEvent>(v7);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MermaidplaceConfig{
            id          : 0x2::object::new(arg0),
            is_paused   : false,
            fee_bps     : 500,
            admin       : 0x2::tx_context::sender(arg0),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
            list_items  : 0x2::object_table::new<0x2::object::ID, Listing>(arg0),
            vec_sponsor : 0x1::vector::empty<address>(),
        };
        0x2::transfer::public_share_object<MermaidplaceConfig>(v0);
        0x7c17ed389c986d1c91e5314bdd2d413ca43db5ba3b36ed7f7ac7630994d8f6e5::royalty_fee::init_royalty_bag(arg0);
    }

    public entry fun list<T0: store + key>(arg0: &mut MermaidplaceConfig, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 2);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Listing{
            id       : 0x2::object::new(arg3),
            price    : arg2,
            owner    : v1,
            nft_type : v0,
        };
        let v3 = 0x2::object::id<T0>(&arg1);
        0x2::dynamic_object_field::add<bool, T0>(&mut v2.id, true, arg1);
        0x2::object_table::add<0x2::object::ID, Listing>(&mut arg0.list_items, v3, v2);
        let v4 = ListingEvent{
            item_id  : v3,
            price    : arg2,
            seller   : v1,
            nft_type : v0,
        };
        0x2::event::emit<ListingEvent>(v4);
    }

    public fun newColor(arg0: u8, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : ColorObject {
        ColorObject{
            id    : 0x2::object::new(arg3),
            red   : arg0,
            green : arg1,
            blue  : arg2,
        }
    }

    public entry fun set_mermaidplace_admin(arg0: &mut MermaidplaceConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.admin = arg1;
    }

    public entry fun set_mermaidplace_fee(arg0: &mut MermaidplaceConfig, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.fee_bps = arg1;
    }

    public entry fun set_status(arg0: &mut MermaidplaceConfig, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.is_paused = arg1;
    }

    public entry fun withdraw(arg0: &mut MermaidplaceConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg1), arg0.admin);
        };
    }

    // decompiled from Move bytecode v6
}

