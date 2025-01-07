module 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::tocen_marketplace {
    struct Collection has copy, drop, store {
        fee_royalties_collection: u64,
        total_fee_royalties: u64,
    }

    struct InfoCollectionOffer has copy, drop, store {
        collection: 0x1::type_name::TypeName,
        address_offer: address,
        timestamp_offer: u64,
    }

    struct InfoCollectionOfferV2 has copy, drop, store {
        collection: 0x1::type_name::TypeName,
        address_offer: address,
        balance_offer: u64,
    }

    struct CollectionOffer has store, key {
        id: 0x2::object::UID,
    }

    struct Marketplace has store, key {
        id: 0x2::object::UID,
        fee_service: u64,
        feeBalance: 0x2::balance::Balance<0x2::sui::SUI>,
        fee_collection_unregistered: u64,
        collection_market: 0x2::table::Table<0x1::type_name::TypeName, Collection>,
        version: u64,
    }

    struct Sale has copy, drop, store {
        owner: address,
        price: u64,
    }

    struct Offer has copy, drop, store {
        address_offer: address,
        price: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        list_on_sale: Sale,
        user_offers: vector<Offer>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u64,
    }

    struct EventList has copy, drop {
        object_id: 0x2::object::ID,
        price: u64,
        owner: address,
    }

    struct EventUpdateList has copy, drop {
        object_id: 0x2::object::ID,
        price: u64,
        owner: address,
    }

    struct EventDeList has copy, drop {
        object_id: 0x2::object::ID,
        sender: address,
    }

    struct EventBuy has copy, drop {
        object_id: 0x2::object::ID,
        paid: u64,
        sender: address,
        receiver: address,
        fee_service: u64,
        fee_royalties: u64,
    }

    struct EventOrder has copy, drop {
        object_id: 0x2::object::ID,
        price_order: u64,
        sender: address,
    }

    struct EventCancelOrder has copy, drop {
        object_id: 0x2::object::ID,
        price_order: u64,
        sender: address,
    }

    struct EventCollectionOrderV2 has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        price_order: u64,
        quantity_order: u64,
        sender_order: address,
        sum_quantity: u64,
        sum_balance: u64,
    }

    struct EventCollectionOrder has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        price_order: u64,
        sender_order: address,
        timestamp_order: u64,
    }

    struct EventCollectionCancelV2 has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        price_order: u64,
        quantity_order: u64,
        sender_order: address,
        sum_quantity: u64,
        sum_balance: u64,
    }

    struct EventCollectionCancel has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        price_order: u64,
        sender_order: address,
        timestamp_order: u64,
    }

    struct EventCollectionAcceptOfferV2 has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        id_item: 0x2::object::ID,
        price_order: u64,
        sender_accept: address,
        receiver_order: address,
        sum_quantity: u64,
        sum_balance: u64,
        fee_service: u64,
        fee_royalties: u64,
    }

    struct EventCollectionAcceptOffer has copy, drop {
        collection_id: 0x1::type_name::TypeName,
        id_item: 0x2::object::ID,
        price_order: u64,
        sender: address,
        receiver: address,
        fee_service: u64,
        fee_royalties: u64,
    }

    struct EventAcceptOffer has copy, drop {
        object_id: 0x2::object::ID,
        price_order: u64,
        sender: address,
        receiver: address,
        fee_service: u64,
        fee_royalties: u64,
    }

    public entry fun accept_collection_offer_list<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0, init_collection(arg0.fee_collection_unregistered));
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0);
        let v2 = &mut v1.fee_royalties_collection;
        let v3 = &mut v1.total_fee_royalties;
        let v4 = InfoCollectionOffer{
            collection      : v0,
            address_offer   : arg4,
            timestamp_offer : arg5,
        };
        let v5 = 0x2::dynamic_field::remove<InfoCollectionOffer, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v4);
        assert!(arg3 == 0x2::balance::value<0x2::sui::SUI>(&v5), 9);
        let (_, v7, v8) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v2);
        *v3 = *v3 + v8;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v7));
        let v9 = EventCollectionAcceptOffer{
            collection_id : v0,
            id_item       : arg2,
            price_order   : arg3,
            sender        : 0x2::tx_context::sender(arg6),
            receiver      : arg4,
            fee_service   : arg0.fee_service,
            fee_royalties : *v2,
        };
        0x2::event::emit<EventCollectionAcceptOffer>(v9);
        let v10 = delist<T0>(arg0, arg2, arg6);
        0x2::transfer::public_transfer<T0>(v10, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg6), 0x2::tx_context::sender(arg6));
    }

    public entry fun accept_collection_offer_list_v2<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0, init_collection(arg0.fee_collection_unregistered));
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0);
        let v2 = &mut v1.fee_royalties_collection;
        let v3 = &mut v1.total_fee_royalties;
        let v4 = InfoCollectionOfferV2{
            collection    : v0,
            address_offer : arg4,
            balance_offer : arg3,
        };
        let v5 = 0x2::dynamic_field::borrow_mut<InfoCollectionOfferV2, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v4);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(v5), 9);
        let v6 = 0x2::balance::split<0x2::sui::SUI>(v5, arg3);
        let (_, v8, v9) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v2);
        *v3 = *v3 + v9;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v8));
        let v10 = EventCollectionAcceptOfferV2{
            collection_id  : v0,
            id_item        : arg2,
            price_order    : arg3,
            sender_accept  : 0x2::tx_context::sender(arg5),
            receiver_order : arg4,
            sum_quantity   : 0x2::balance::value<0x2::sui::SUI>(v5) / arg3,
            sum_balance    : 0x2::balance::value<0x2::sui::SUI>(v5),
            fee_service    : arg0.fee_service,
            fee_royalties  : *v2,
        };
        0x2::event::emit<EventCollectionAcceptOfferV2>(v10);
        let v11 = delist<T0>(arg0, arg2, arg5);
        0x2::transfer::public_transfer<T0>(v11, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), 0x2::tx_context::sender(arg5));
    }

    public entry fun accept_collection_offer_not_list<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: T0, arg3: u64, arg4: address, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0, init_collection(arg0.fee_collection_unregistered));
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0);
        let v2 = &mut v1.fee_royalties_collection;
        let v3 = &mut v1.total_fee_royalties;
        let v4 = InfoCollectionOffer{
            collection      : v0,
            address_offer   : arg4,
            timestamp_offer : arg5,
        };
        let v5 = 0x2::dynamic_field::remove<InfoCollectionOffer, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v4);
        assert!(arg3 == 0x2::balance::value<0x2::sui::SUI>(&v5), 9);
        let (_, v7, v8) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v2);
        *v3 = *v3 + v8;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v7));
        0x2::transfer::public_transfer<T0>(arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg6), 0x2::tx_context::sender(arg6));
        let v9 = EventCollectionAcceptOffer{
            collection_id : v0,
            id_item       : 0x2::object::id<T0>(&arg2),
            price_order   : arg3,
            sender        : 0x2::tx_context::sender(arg6),
            receiver      : arg4,
            fee_service   : arg0.fee_service,
            fee_royalties : *v2,
        };
        0x2::event::emit<EventCollectionAcceptOffer>(v9);
    }

    public entry fun accept_collection_offer_not_list_v2<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: T0, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v0)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0, init_collection(arg0.fee_collection_unregistered));
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v0);
        let v2 = &mut v1.fee_royalties_collection;
        let v3 = &mut v1.total_fee_royalties;
        let v4 = InfoCollectionOfferV2{
            collection    : v0,
            address_offer : arg4,
            balance_offer : arg3,
        };
        let v5 = 0x2::dynamic_field::borrow_mut<InfoCollectionOfferV2, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v4);
        assert!(arg3 <= 0x2::balance::value<0x2::sui::SUI>(v5), 9);
        let v6 = 0x2::balance::split<0x2::sui::SUI>(v5, arg3);
        let (_, v8, v9) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v2);
        *v3 = *v3 + v9;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v8));
        0x2::transfer::public_transfer<T0>(arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v6, arg5), 0x2::tx_context::sender(arg5));
        let v10 = EventCollectionAcceptOfferV2{
            collection_id  : v0,
            id_item        : 0x2::object::id<T0>(&arg2),
            price_order    : arg3,
            sender_accept  : 0x2::tx_context::sender(arg5),
            receiver_order : arg4,
            sum_quantity   : 0x2::balance::value<0x2::sui::SUI>(v5) / arg3,
            sum_balance    : 0x2::balance::value<0x2::sui::SUI>(v5),
            fee_service    : arg0.fee_service,
            fee_royalties  : *v2,
        };
        0x2::event::emit<EventCollectionAcceptOfferV2>(v10);
    }

    public entry fun accept_offer_list<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v2 = &mut v1.id;
        let v3 = &mut v1.list_on_sale;
        let v4 = &mut v1.user_offers;
        let v5 = &mut v1.sui_balance;
        let v6 = &mut v1.status;
        let v7 = Offer{
            address_offer : arg2,
            price         : arg3,
        };
        let v8 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v8)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v8, init_collection(arg0.fee_collection_unregistered));
        };
        let v9 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v8);
        let v10 = &mut v9.fee_royalties_collection;
        let v11 = &mut v9.total_fee_royalties;
        let (v12, v13) = 0x1::vector::index_of<Offer>(v4, &v7);
        assert!(v12 == true, 7);
        let v14 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list();
        assert!(v6 == &v14 && 0x2::dynamic_object_field::exists_<bool>(v2, true), 3);
        assert!(v0 == v3.owner, 1);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(v2, true), arg2);
        v3.owner = @0x0;
        v3.price = 0;
        *v6 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list();
        0x1::vector::remove<Offer>(v4, v13);
        let (v15, v16, v17) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v10);
        *v11 = *v11 + v17;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(v5, v16));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v5, v15), arg4), v0);
        let v18 = EventAcceptOffer{
            object_id     : arg1,
            price_order   : arg3,
            sender        : v0,
            receiver      : arg2,
            fee_service   : arg0.fee_service,
            fee_royalties : *v10,
        };
        0x2::event::emit<EventAcceptOffer>(v18);
    }

    public entry fun accept_offer_not_list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, v0);
        let v3 = &mut v2.user_offers;
        let v4 = &mut v2.sui_balance;
        let v5 = Offer{
            address_offer : arg2,
            price         : arg3,
        };
        let v6 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v6)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v6, init_collection(arg0.fee_collection_unregistered));
        };
        let v7 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v6);
        let v8 = &mut v7.fee_royalties_collection;
        let v9 = &mut v7.total_fee_royalties;
        let (v10, v11) = 0x1::vector::index_of<Offer>(v3, &v5);
        assert!(v10 == true, 7);
        0x1::vector::remove<Offer>(v3, v11);
        0x2::transfer::public_transfer<T0>(arg1, arg2);
        let (v12, v13, v14) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(arg3, arg0.fee_service, *v8);
        *v9 = *v9 + v14;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(v4, v13));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v4, v12), arg4), v1);
        let v15 = EventAcceptOffer{
            object_id     : v0,
            price_order   : arg3,
            sender        : v1,
            receiver      : arg2,
            fee_service   : arg0.fee_service,
            fee_royalties : *v8,
        };
        0x2::event::emit<EventAcceptOffer>(v15);
    }

    public entry fun batch_delist<T0: store + key>(arg0: &mut Marketplace, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            let v0 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v1 = delist<T0>(arg0, v0, arg2);
            0x2::transfer::public_transfer<T0>(v1, 0x2::tx_context::sender(arg2));
            let v2 = EventDeList{
                object_id : v0,
                sender    : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<EventDeList>(v2);
        };
    }

    public entry fun batch_list<T0: store + key>(arg0: &mut Marketplace, arg1: vector<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        assert!(0x1::vector::length<T0>(&arg1) == 0x1::vector::length<u64>(&arg2), 8);
        while (0x1::vector::length<T0>(&arg1) > 0) {
            list<T0>(arg0, 0x1::vector::pop_back<T0>(&mut arg1), 0x1::vector::pop_back<u64>(&mut arg2), arg3);
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v1 = &mut v0.id;
        let v2 = &mut v0.list_on_sale;
        let v3 = &mut v0.status;
        let v4 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v4)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v4, init_collection(arg0.fee_collection_unregistered));
        };
        let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v4);
        let v6 = &mut v5.fee_royalties_collection;
        let v7 = &mut v5.total_fee_royalties;
        let v8 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list();
        assert!(v3 == &v8, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v2.price, 2);
        let (v9, v10, v11) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(v2.price, arg0.fee_service, *v6);
        let v12 = v2.owner;
        *v7 = *v7 + v11;
        0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg2, v9, v12, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2), v10));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        let v13 = EventBuy{
            object_id     : arg1,
            paid          : v2.price,
            sender        : 0x2::tx_context::sender(arg3),
            receiver      : v12,
            fee_service   : arg0.fee_service,
            fee_royalties : *v6,
        };
        0x2::event::emit<EventBuy>(v13);
        *v3 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list();
        v2.price = 0;
        v2.owner = @0x0;
        0x2::dynamic_object_field::remove<bool, T0>(v1, true)
    }

    public entry fun buy_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = buy<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun buy_cart<T0: store + key>(arg0: &mut Marketplace, arg1: vector<0x2::object::ID>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = check_list_nft(arg0, arg1);
        assert!(v0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 6);
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v2 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, Collection>(&arg0.collection_market, v2)) {
            0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v2, init_collection(arg0.fee_collection_unregistered));
        };
        let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, v2);
        let v4 = &mut v3.fee_royalties_collection;
        let v5 = &mut v3.total_fee_royalties;
        let v6 = 0x2::tx_context::sender(arg3);
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            let v7 = 0x1::vector::pop_back<0x2::object::ID>(&mut arg1);
            let v8 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, v7);
            let v9 = &mut v8.list_on_sale;
            let v10 = &mut v8.status;
            0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<bool, T0>(&mut v8.id, true), v6);
            let (v11, v12, v13) = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::royalties::fee_service_collection(v9.price, arg0.fee_service, *v4);
            *v5 = *v5 + v13;
            0x2::pay::split_and_transfer<0x2::sui::SUI>(&mut arg2, v11, v9.owner, arg3);
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.feeBalance, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg2), v12));
            let v14 = EventBuy{
                object_id     : v7,
                paid          : v9.price,
                sender        : 0x2::tx_context::sender(arg3),
                receiver      : v9.owner,
                fee_service   : arg0.fee_service,
                fee_royalties : v13,
            };
            0x2::event::emit<EventBuy>(v14);
            *v10 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list();
            v9.price = 0;
            v9.owner = @0x0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v6);
    }

    public entry fun cancel_collection_offer<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = InfoCollectionOffer{
            collection      : v0,
            address_offer   : 0x2::tx_context::sender(arg4),
            timestamp_offer : arg3,
        };
        let v2 = 0x2::dynamic_field::remove<InfoCollectionOffer, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v1);
        assert!(arg2 == 0x2::balance::value<0x2::sui::SUI>(&v2), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4), 0x2::tx_context::sender(arg4));
        let v3 = EventCollectionCancel{
            collection_id   : v0,
            price_order     : arg2,
            sender_order    : 0x2::tx_context::sender(arg4),
            timestamp_order : v1.timestamp_offer,
        };
        0x2::event::emit<EventCollectionCancel>(v3);
    }

    public entry fun cancel_collection_offer_v2<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = InfoCollectionOfferV2{
            collection    : v0,
            address_offer : 0x2::tx_context::sender(arg4),
            balance_offer : arg2,
        };
        let v2 = 0x2::dynamic_field::borrow_mut<InfoCollectionOfferV2, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v1);
        assert!(arg2 * arg3 <= 0x2::balance::value<0x2::sui::SUI>(v2), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v2, arg2 * arg3), arg4), 0x2::tx_context::sender(arg4));
        let v3 = EventCollectionCancelV2{
            collection_id  : v0,
            price_order    : arg2,
            quantity_order : arg3,
            sender_order   : 0x2::tx_context::sender(arg4),
            sum_quantity   : 0x2::balance::value<0x2::sui::SUI>(v2) / arg2,
            sum_balance    : 0x2::balance::value<0x2::sui::SUI>(v2),
        };
        0x2::event::emit<EventCollectionCancelV2>(v3);
    }

    public entry fun cancel_offer(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v2 = &mut v1.user_offers;
        let v3 = &mut v1.sui_balance;
        let v4 = Offer{
            address_offer : v0,
            price         : arg2,
        };
        let (v5, v6) = 0x1::vector::index_of<Offer>(v2, &v4);
        assert!(v5 == true, 7);
        0x1::vector::remove<Offer>(v2, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(v3, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v7 = EventCancelOrder{
            object_id   : arg1,
            price_order : arg2,
            sender      : v0,
        };
        0x2::event::emit<EventCancelOrder>(v7);
    }

    fun check_list_nft(arg0: &mut Marketplace, arg1: vector<0x2::object::ID>) : (bool, u64) {
        let v0 = 0;
        while (0x1::vector::length<0x2::object::ID>(&arg1) > 0) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1));
            let v2 = &mut v1.list_on_sale;
            let v3 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list();
            if (&mut v1.status == &v3) {
                return (false, 0)
            };
            v0 = v0 + v2.price;
        };
        (true, v0)
    }

    public entry fun collection_offer<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: u64, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = InfoCollectionOffer{
            collection      : v0,
            address_offer   : 0x2::tx_context::sender(arg5),
            timestamp_offer : 0x2::clock::timestamp_ms(arg3),
        };
        let v2 = 0x2::balance::zero<0x2::sui::SUI>();
        let v3 = &mut v2;
        transferSui(v3, arg4, arg2, arg5);
        0x2::dynamic_field::add<InfoCollectionOffer, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v1, v2);
        let v4 = EventCollectionOrder{
            collection_id   : v0,
            price_order     : arg2,
            sender_order    : 0x2::tx_context::sender(arg5),
            timestamp_order : v1.timestamp_offer,
        };
        0x2::event::emit<EventCollectionOrder>(v4);
    }

    public entry fun collection_offer_v2<T0: store + key>(arg0: &mut Marketplace, arg1: &mut CollectionOffer, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = InfoCollectionOfferV2{
            collection    : v0,
            address_offer : 0x2::tx_context::sender(arg5),
            balance_offer : arg2,
        };
        if (!0x2::dynamic_field::exists_<InfoCollectionOfferV2>(&arg1.id, v1)) {
            0x2::dynamic_field::add<InfoCollectionOfferV2, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v1, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v2 = 0x2::dynamic_field::borrow_mut<InfoCollectionOfferV2, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg1.id, v1);
        transferSui(v2, arg4, arg2 * arg3, arg5);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(v2);
        let v4 = EventCollectionOrderV2{
            collection_id  : v0,
            price_order    : arg2,
            quantity_order : arg3,
            sender_order   : 0x2::tx_context::sender(arg5),
            sum_quantity   : v3 / arg2,
            sum_balance    : v3,
        };
        0x2::event::emit<EventCollectionOrderV2>(v4);
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v1 = &mut v0.id;
        let v2 = &mut v0.list_on_sale;
        let v3 = &mut v0.status;
        let v4 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list();
        assert!(v3 == &v4 && 0x2::dynamic_object_field::exists_<bool>(v1, true), 3);
        assert!(0x2::tx_context::sender(arg2) == v2.owner, 1);
        v2.owner = @0x0;
        v2.price = 0;
        *v3 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list();
        0x2::dynamic_object_field::remove<bool, T0>(v1, true)
    }

    public entry fun delist_and_take<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = delist<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
        let v1 = EventDeList{
            object_id : arg1,
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EventDeList>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id                          : 0x2::object::new(arg0),
            fee_service                 : 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_fee_service(),
            feeBalance                  : 0x2::balance::zero<0x2::sui::SUI>(),
            fee_collection_unregistered : 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_fee_collection_unregistered(),
            collection_market           : 0x2::table::new<0x1::type_name::TypeName, Collection>(arg0),
            version                     : 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(),
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = CollectionOffer{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<CollectionOffer>(v1);
    }

    fun init_collection(arg0: u64) : Collection {
        Collection{
            fee_royalties_collection : arg0,
            total_fee_royalties      : 0,
        }
    }

    fun init_nft_list(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Listing {
        let v0 = Sale{
            owner : arg0,
            price : arg1,
        };
        Listing{
            id           : 0x2::object::new(arg3),
            list_on_sale : v0,
            user_offers  : 0x1::vector::empty<Offer>(),
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            status       : arg2,
        }
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<T0>(&arg1);
        if (!0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, v1)) {
            let v2 = init_nft_list(v0, arg2, 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list(), arg3);
            0x2::dynamic_object_field::add<bool, T0>(&mut v2.id, true, arg1);
            0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v1, v2);
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, v1);
            let v4 = &mut v3.list_on_sale;
            v4.owner = v0;
            v4.price = arg2;
            v3.status = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list();
            0x2::dynamic_object_field::add<bool, T0>(&mut v3.id, true, arg1);
        };
        let v5 = EventList{
            object_id : v1,
            price     : arg2,
            owner     : v0,
        };
        0x2::event::emit<EventList>(v5);
    }

    public entry fun order_offer<T0: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        if (!0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let v1 = init_nft_list(@0x0, 0, 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_not_list(), arg4);
            0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, arg1, v1);
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = &mut v2.sui_balance;
        let v4 = Offer{
            address_offer : v0,
            price         : arg2,
        };
        0x1::vector::push_back<Offer>(&mut v2.user_offers, v4);
        transferSui(v3, arg3, arg2, arg4);
        let v5 = EventOrder{
            object_id   : arg1,
            price_order : arg2,
            sender      : v0,
        };
        0x2::event::emit<EventOrder>(v5);
    }

    public entry fun register_collection_market<T0: store + key>(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        0x2::table::add<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, 0x1::type_name::get<T0>(), init_collection(arg1));
    }

    fun transferSui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 6);
        0x2::balance::join<0x2::sui::SUI>(arg0, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg3));
    }

    public entry fun update_collection_market<T0: store + key>(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        0x2::table::borrow_mut<0x1::type_name::TypeName, Collection>(&mut arg0.collection_market, 0x1::type_name::get<T0>()).fee_royalties_collection = arg1;
    }

    public entry fun update_fee_collection_unregistered(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        arg0.fee_collection_unregistered = arg1;
    }

    public entry fun update_fee_market(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        arg0.fee_service = arg1;
    }

    public entry fun update_list(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v2 = &mut v1.id;
        let v3 = &mut v1.list_on_sale;
        let v4 = 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_status_list();
        assert!(&mut v1.status == &v4 && 0x2::dynamic_object_field::exists_<bool>(v2, true), 3);
        assert!(v0 == v3.owner, 1);
        v3.price = arg2;
        let v5 = EventUpdateList{
            object_id : arg1,
            price     : arg2,
            owner     : v0,
        };
        0x2::event::emit<EventUpdateList>(v5);
    }

    public entry fun update_version(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        arg0.version = arg1;
    }

    public entry fun withraw(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::config::get_version(), 123);
        assert!(0xcff63741bf5970ebca5fd90a4e2e51a553c37a29b991006ae82d43a31f095b8b::owner::check_owner(arg2), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.feeBalance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

