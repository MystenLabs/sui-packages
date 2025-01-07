module 0xadab60864a8ffc49e20520a46da30e935539ef5f30a18fc8f522c4c82035438f::store {
    struct STORE has drop {
        dummy_field: bool,
    }

    struct StoreOwnerCap has key {
        id: 0x2::object::UID,
        store_id: 0x2::object::ID,
    }

    struct AirdropPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        rate: u64,
        vault: 0x2::balance::Balance<T0>,
    }

    struct ItemStore has store, key {
        id: 0x2::object::UID,
        revenue: u64,
        initial_amount: u64,
        total_amount: u64,
        name: 0x1::string::String,
        logo_url: 0x2::url::Url,
        banner_url: 0x2::url::Url,
        description: vector<u8>,
        start_time: u64,
        owner: address,
        is_airdrop: bool,
        paid: 0x2::balance::Balance<0x2::sui::SUI>,
        item_ids: vector<0x2::object::ID>,
        affiliate: Affiliate,
    }

    struct Item has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        img_url: 0x2::url::Url,
        url: 0x2::url::Url,
        creator: address,
    }

    struct Buyer has store, key {
        id: 0x2::object::UID,
        account: address,
        quantity: u64,
    }

    struct ListedItem has store, key {
        id: 0x2::object::UID,
        url: 0x2::url::Url,
        name: 0x1::string::String,
        description: 0x1::string::String,
        price: u64,
        quantity: 0x1::option::Option<u64>,
        max_buy: u64,
        buyers: 0x2::object_table::ObjectTable<address, Buyer>,
        creator: address,
    }

    struct Referrer has store, key {
        id: 0x2::object::UID,
        referrer: address,
        total_rewards: u64,
        ref_list: vector<address>,
        is_claim: bool,
    }

    struct Affiliate has store, key {
        id: 0x2::object::UID,
        reward_percent: u64,
        total_rewards: u64,
        total_ref: u64,
        referrers: 0x2::object_table::ObjectTable<address, Referrer>,
    }

    struct ItemCreated has copy, drop {
        name: 0x1::string::String,
        quantity: u64,
        buyer_addr: address,
    }

    public entry fun buy(arg0: &mut ItemStore, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 5);
        let v0 = 0x2::dynamic_object_field::borrow<vector<u8>, ListedItem>(&mut arg0.id, arg2);
        assert!(arg3 <= v0.max_buy, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v0.price * arg3, 0);
        buy_and_take(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun buy_airdrop<T0>(arg0: &mut ItemStore, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_airdrop, 6);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.start_time, 5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, ListedItem>(&mut arg0.id, arg2);
        assert!(arg3 <= v0.max_buy, 7);
        if (0x1::option::is_some<u64>(&v0.quantity)) {
            assert!(*0x1::option::borrow<u64>(&v0.quantity) > arg3, 0);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == v0.price * arg3, 0);
        let v1 = 0x2::dynamic_object_field::borrow_mut<bool, AirdropPool<T0>>(&mut v0.id, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v1.vault, v1.rate * arg3, arg6), 0x2::tx_context::sender(arg6));
        buy_and_take(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    fun buy_and_take(arg0: &mut ItemStore, arg1: vector<u8>, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, ListedItem>(&mut arg0.id, arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(!0x2::object_table::contains<address, Buyer>(&v0.buyers, v1), 1);
        if (0x1::option::is_some<u64>(&v0.quantity)) {
            let v2 = 0x1::option::borrow<u64>(&v0.quantity);
            assert!(*v2 > arg2, 0);
            0x1::option::swap<u64>(&mut v0.quantity, *v2 - arg2);
        };
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        let v4 = 0;
        if (arg0.affiliate.reward_percent > 0) {
            if (arg4 != @0x1) {
                let v5 = v0.price * arg0.affiliate.reward_percent / 100;
                v4 = v5;
                let v6 = v5 * arg2;
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v3, v6, arg5), arg4);
                arg0.affiliate.total_rewards = arg0.affiliate.total_rewards + v6;
                if (!0x2::object_table::contains<address, Referrer>(&arg0.affiliate.referrers, arg4)) {
                    let v7 = Referrer{
                        id            : 0x2::object::new(arg5),
                        referrer      : arg4,
                        total_rewards : v6,
                        ref_list      : 0x1::vector::empty<address>(),
                        is_claim      : false,
                    };
                    0x1::vector::push_back<address>(&mut v7.ref_list, v1);
                    0x2::object_table::add<address, Referrer>(&mut arg0.affiliate.referrers, arg4, v7);
                    arg0.affiliate.total_ref = arg0.affiliate.total_ref + 1;
                } else {
                    let v8 = 0x2::object_table::borrow_mut<address, Referrer>(&mut arg0.affiliate.referrers, arg4);
                    v8.total_rewards = v8.total_rewards + v6;
                    if (!0x1::vector::contains<address>(&v8.ref_list, &v1)) {
                        0x1::vector::push_back<address>(&mut v8.ref_list, v1);
                    };
                };
            };
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.paid, v3);
        arg0.revenue = arg0.revenue + (v0.price - v4) * arg2;
        arg0.total_amount = arg0.total_amount - arg2;
        let v9 = 0;
        while (v9 < arg2) {
            let v10 = Item{
                id          : 0x2::object::new(arg5),
                name        : v0.name,
                description : v0.description,
                image_url   : v0.url,
                img_url     : v0.url,
                url         : v0.url,
                creator     : v0.creator,
            };
            0x2::transfer::transfer<Item>(v10, v1);
            v9 = v9 + 1;
        };
        let v11 = Buyer{
            id       : 0x2::object::new(arg5),
            account  : v1,
            quantity : arg2,
        };
        0x2::object_table::add<address, Buyer>(&mut v0.buyers, v1, v11);
        let v12 = ItemCreated{
            name       : v0.name,
            quantity   : arg2,
            buyer_addr : v1,
        };
        0x2::event::emit<ItemCreated>(v12);
    }

    public entry fun collect_profits(arg0: &mut ItemStore, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.paid, 0x2::balance::value<0x2::sui::SUI>(&arg0.paid), arg1), v0);
    }

    public entry fun create_store(arg0: &0x2::clock::Clock, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: bool, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 > 0x2::clock::timestamp_ms(arg0), 4);
        let v0 = 0x2::tx_context::sender(arg9);
        if (v0 != @0x96fa421b3331299e4856b5f50f62ec0af2784a34a7278fcad55c0286a351fee9 || v0 != @0x96fa421b3331299e4856b5f50f62ec0af2784a34a7278fcad55c0286a351fee9) {
            assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= 100000000, 8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg8, 100000000, arg9), @0x96fa421b3331299e4856b5f50f62ec0af2784a34a7278fcad55c0286a351fee9);
            if (0x2::coin::value<0x2::sui::SUI>(&arg8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, v0);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(arg8);
            };
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, v0);
        };
        let v1 = 0x2::object::new(arg9);
        let v2 = Affiliate{
            id             : 0x2::object::new(arg9),
            reward_percent : arg6,
            total_rewards  : 0,
            total_ref      : 0,
            referrers      : 0x2::object_table::new<address, Referrer>(arg9),
        };
        let v3 = ItemStore{
            id             : v1,
            revenue        : 0,
            initial_amount : 0,
            total_amount   : 0,
            name           : 0x1::string::utf8(arg1),
            logo_url       : 0x2::url::new_unsafe_from_bytes(arg2),
            banner_url     : 0x2::url::new_unsafe_from_bytes(arg3),
            description    : arg4,
            start_time     : arg5,
            owner          : v0,
            is_airdrop     : arg7,
            paid           : 0x2::balance::zero<0x2::sui::SUI>(),
            item_ids       : 0x1::vector::empty<0x2::object::ID>(),
            affiliate      : v2,
        };
        0x2::transfer::share_object<ItemStore>(v3);
        let v4 = StoreOwnerCap{
            id       : 0x2::object::new(arg9),
            store_id : 0x2::object::uid_to_inner(&v1),
        };
        0x2::transfer::transfer<StoreOwnerCap>(v4, v0);
    }

    fun init(arg0: STORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description} - Minted by BeLaunch NFTs Store"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://belaunch.io/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{creator}"));
        let v4 = 0x2::package::claim<STORE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Item>(&v4, v0, v2, arg1);
        0x2::display::update_version<Item>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, v6);
        0x2::transfer::public_transfer<0x2::display::Display<Item>>(v5, v6);
    }

    public entry fun sell(arg0: &mut ItemStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(arg4 > 0, 0);
        assert!(v0 == arg0.owner, 2);
        let v1 = 0x2::object::new(arg7);
        let v2 = ListedItem{
            id          : v1,
            url         : 0x2::url::new_unsafe_from_bytes(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            price       : arg3,
            quantity    : 0x1::option::none<u64>(),
            max_buy     : arg5,
            buyers      : 0x2::object_table::new<address, Buyer>(arg7),
            creator     : v0,
        };
        0x2::dynamic_object_field::add<vector<u8>, ListedItem>(&mut arg0.id, arg1, v2);
        arg0.initial_amount = arg0.initial_amount + arg4;
        arg0.total_amount = arg0.total_amount + arg4;
        set_quantity(arg0, arg1, arg4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.item_ids, 0x2::object::uid_to_inner(&v1));
    }

    public entry fun sell_airdrop<T0>(arg0: &mut ItemStore, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: u64, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_airdrop, 6);
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(arg7 > 0, 0);
        assert!(arg4 > 0, 0);
        assert!(v0 == arg0.owner, 2);
        let v1 = arg7 * arg4;
        assert!(0x2::coin::value<T0>(&arg8) >= v1, 0);
        let v2 = 0x2::object::new(arg9);
        let v3 = ListedItem{
            id          : v2,
            url         : 0x2::url::new_unsafe_from_bytes(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            price       : arg3,
            quantity    : 0x1::option::none<u64>(),
            max_buy     : arg5,
            buyers      : 0x2::object_table::new<address, Buyer>(arg9),
            creator     : v0,
        };
        let v4 = AirdropPool<T0>{
            id    : 0x2::object::new(arg9),
            rate  : arg7,
            vault : 0x2::balance::zero<T0>(),
        };
        0x2::balance::join<T0>(&mut v4.vault, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg8, v1, arg9)));
        if (0x2::coin::value<T0>(&arg8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg8, v0);
        } else {
            0x2::coin::destroy_zero<T0>(arg8);
        };
        0x2::dynamic_object_field::add<bool, AirdropPool<T0>>(&mut v3.id, true, v4);
        0x2::dynamic_object_field::add<vector<u8>, ListedItem>(&mut arg0.id, arg1, v3);
        arg0.initial_amount = arg0.initial_amount + arg4;
        arg0.total_amount = arg0.total_amount + arg4;
        set_quantity(arg0, arg1, arg4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.item_ids, 0x2::object::uid_to_inner(&v2));
    }

    fun set_quantity(arg0: &mut ItemStore, arg1: vector<u8>, arg2: u64) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, ListedItem>(&mut arg0.id, arg1);
        if (0x1::option::is_none<u64>(&v0.quantity)) {
            0x1::option::fill<u64>(&mut v0.quantity, arg2);
        } else {
            0x1::option::swap<u64>(&mut v0.quantity, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

