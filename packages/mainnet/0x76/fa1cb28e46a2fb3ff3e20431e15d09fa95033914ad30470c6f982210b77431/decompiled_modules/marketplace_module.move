module 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::marketplace_module {
    struct Admin has key {
        id: 0x2::object::UID,
        enable_addresses: vector<address>,
        receive_address: address,
        pool: 0x2::coin::Coin<0x2::sui::SUI>,
        total_pool: u64,
    }

    struct Marketplace has key {
        id: 0x2::object::UID,
        containers_list: vector<Container_Status>,
        container_maximum_size: u64,
        collection_fee_container_id: 0x2::object::ID,
    }

    struct Container_Status has drop, store {
        container_id: 0x2::object::ID,
        can_deposit: bool,
    }

    struct Container has key {
        id: 0x2::object::UID,
        objects_in_list: u64,
    }

    struct List<T0: store + key> has store, key {
        id: 0x2::object::UID,
        container_id: 0x2::object::ID,
        seller: address,
        item: T0,
        price: u64,
    }

    struct AuctionItem<T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        current_offerer: address,
        container_id: 0x2::object::ID,
        item: T0,
        start_price: u64,
        current_price: u64,
        paid: 0x2::coin::Coin<0x2::sui::SUI>,
        start_time: u64,
        end_time: u64,
    }

    struct EventCreateContainer has copy, drop {
        container_id: 0x2::object::ID,
    }

    struct EventListNft has copy, drop {
        list_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        container_id: 0x2::object::ID,
        marketplace_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct EventBuyNft has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
        new_owner: address,
    }

    struct EventDeListNft has copy, drop {
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct EventUpdateListingPrice has copy, drop {
        nft_id: 0x2::object::ID,
        new_price: u64,
    }

    struct EventAdminChangeReciveAddress has copy, drop {
        new_market_fee_revice_address: address,
    }

    struct Offer<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        container_id: 0x2::object::ID,
        paid: T0,
        offer_price: u64,
        offerer: address,
        end_time: u64,
    }

    struct OfferNftEvent has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offer_price: u64,
        offerer: address,
        marketplace_id: 0x2::object::ID,
        expried_at: u64,
        container_id: 0x2::object::ID,
    }

    struct DeleteOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offerer: address,
    }

    struct AdminReturnOfferEvent has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offerer: address,
    }

    struct OwnerAcceptOfferEvent has copy, drop {
        nft_id: 0x2::object::ID,
        offer_price: u64,
        seller: address,
        new_nft_owner: address,
    }

    struct ListAuctionEvent has copy, drop {
        seller: address,
        list_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        container_id: 0x2::object::ID,
        auction_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        start_price: u64,
        auction_package_id: 0x2::object::ID,
    }

    struct AuctionEvent has copy, drop {
        nft_id: 0x2::object::ID,
        price: u64,
        offerer: address,
    }

    struct DeAuctionEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct AcceptAutionEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct AddCollectionFeeEvent has copy, drop {
        collection_name: 0x1::string::String,
        creator_fee: u64,
    }

    struct DeleteCollectionFeeEvent has copy, drop {
        collection_name: 0x1::string::String,
    }

    struct UpdateCollectionFeeEvent has copy, drop {
        collection_name: 0x1::string::String,
        creator_fee: u64,
    }

    public entry fun add_collection_fee<T0: store + key>(arg0: &mut Admin, arg1: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg4)) == true, 4003);
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg2);
        let v2 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v2, arg3);
        0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::add_collection_fee(arg1, v0, v1, v2, arg4);
        let v3 = AddCollectionFeeEvent{
            collection_name : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            creator_fee     : arg2,
        };
        0x2::event::emit<AddCollectionFeeEvent>(v3);
    }

    public entry fun delete_collection_fee<T0: store + key>(arg0: &mut Admin, arg1: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg2)) == true, 4003);
        0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::delete_collection_fee(arg1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), arg2);
        let v0 = DeleteCollectionFeeEvent{collection_name: 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()))};
        0x2::event::emit<DeleteCollectionFeeEvent>(v0);
    }

    public entry fun update_collection_fee<T0: store + key>(arg0: &mut Admin, arg1: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(isAdmin(arg0, 0x2::tx_context::sender(arg3)) == true, 4003);
        0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::update_collection_fee(arg1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), arg2, arg3);
        let v0 = UpdateCollectionFeeEvent{
            collection_name : 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            creator_fee     : arg2,
        };
        0x2::event::emit<UpdateCollectionFeeEvent>(v0);
    }

    public entry fun accept_auction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: &mut Admin, arg3: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let AuctionItem {
            id              : v0,
            seller          : v1,
            current_offerer : v2,
            container_id    : _,
            item            : v4,
            start_price     : _,
            current_price   : v6,
            paid            : v7,
            start_time      : _,
            end_time        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionItem<T0>>(&mut arg1.id, arg4);
        let v10 = v7;
        let v11 = if (v1 == 0x2::tx_context::sender(arg5)) {
            true
        } else {
            let v12 = check_sender_is_in_enable_admin_addresses(arg2, arg5);
            v12 == true
        };
        assert!(v11, 5003);
        let (v13, v14) = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_creator_fee(arg3, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), v6, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v14), arg5), v13);
        let v15 = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_service_fee(arg3, v6);
        0x2::coin::join<0x2::sui::SUI>(&mut arg2.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v15), arg5));
        arg2.total_pool = arg2.total_pool + v15;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v6 - v15 - v14), arg5), v1);
        0x2::transfer::public_transfer<T0>(v4, v2);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        0x2::object::delete(v0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        let v16 = AcceptAutionEvent{nft_id: arg4};
        0x2::event::emit<AcceptAutionEvent>(v16);
    }

    public entry fun admin_change_market_fee_reciver_address(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = check_sender_is_in_enable_admin_addresses(arg0, arg2);
        assert!(v0 == true, 4003);
        arg0.receive_address = arg1;
        let v1 = EventAdminChangeReciveAddress{new_market_fee_revice_address: arg1};
        0x2::event::emit<EventAdminChangeReciveAddress>(v1);
    }

    public entry fun admin_update_enable_addresses(arg0: &mut Admin, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) > 0, 4017);
        let v0 = check_sender_is_in_enable_admin_addresses(arg0, arg2);
        assert!(v0 == true, 4003);
        0x1::vector::append<address>(&mut arg0.enable_addresses, arg1);
    }

    public fun change_container_status(arg0: &mut Marketplace, arg1: &mut Container, arg2: bool) {
        let v0 = &mut arg0.containers_list;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Container_Status>(v0)) {
            let v2 = 0x1::vector::borrow_mut<Container_Status>(v0, v1);
            if (v2.container_id == 0x2::object::uid_to_inner(&arg1.id)) {
                v2.can_deposit = arg2;
                break
            };
            v1 = v1 + 1;
        };
    }

    fun check_sender_is_in_enable_admin_addresses(arg0: &mut Admin, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0;
        let v1 = arg0.enable_addresses;
        while (v0 < 0x1::vector::length<address>(&v1)) {
            if (0x2::tx_context::sender(arg1) == *0x1::vector::borrow<address>(&v1, v0)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun create_new_container(arg0: &mut Marketplace, arg1: &mut 0x2::tx_context::TxContext) : Container {
        let v0 = Container{
            id              : 0x2::object::new(arg1),
            objects_in_list : 1,
        };
        let v1 = Container_Status{
            container_id : 0x2::object::id<Container>(&v0),
            can_deposit  : true,
        };
        0x1::vector::push_back<Container_Status>(&mut arg0.containers_list, v1);
        v0
    }

    public entry fun deauction<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: &mut Admin, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let AuctionItem {
            id              : v0,
            seller          : v1,
            current_offerer : v2,
            container_id    : _,
            item            : v4,
            start_price     : _,
            current_price   : v6,
            paid            : v7,
            start_time      : _,
            end_time        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionItem<T0>>(&mut arg1.id, arg3);
        let v10 = v7;
        let v11 = if (v1 == 0x2::tx_context::sender(arg4)) {
            true
        } else {
            let v12 = check_sender_is_in_enable_admin_addresses(arg2, arg4);
            v12 == true
        };
        assert!(v11, 5003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v10), v6), arg4), v2);
        0x2::transfer::public_transfer<T0>(v4, 0x2::tx_context::sender(arg4));
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        0x2::object::delete(v0);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v10);
        let v13 = DeAuctionEvent{nft_id: arg3};
        0x2::event::emit<DeAuctionEvent>(v13);
    }

    public entry fun emergency_cancel_offer(arg0: &mut Marketplace, arg1: &mut Container, arg2: &mut Admin, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id           : v0,
            nft_id       : _,
            container_id : _,
            paid         : v3,
            offer_price  : _,
            offerer      : v5,
            end_time     : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg1.id, arg4);
        let v7 = v0;
        assert!(check_sender_is_in_enable_admin_addresses(arg2, arg5) == true, 4003);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        let v8 = DeleteOfferEvent{
            offer_id : 0x2::object::uid_to_inner(&v7),
            nft_id   : arg3,
            offerer  : v5,
        };
        0x2::event::emit<DeleteOfferEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v5);
        0x2::object::delete(v7);
    }

    public entry fun emergency_delist_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: &mut Admin, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let List {
            id           : v0,
            container_id : _,
            seller       : v2,
            item         : v3,
            price        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, List<T0>>(&mut arg1.id, arg3);
        let v5 = check_sender_is_in_enable_admin_addresses(arg2, arg4);
        assert!(v5 == true, 4004);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        let v6 = EventDeListNft{
            nft_id : arg3,
            seller : v2,
        };
        0x2::event::emit<EventDeListNft>(v6);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg4));
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = Admin{
            id               : 0x2::object::new(arg0),
            enable_addresses : v0,
            receive_address  : 0x2::tx_context::sender(arg0),
            pool             : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg0),
            total_pool       : 0,
        };
        let v2 = Marketplace{
            id                          : 0x2::object::new(arg0),
            containers_list             : 0x1::vector::empty<Container_Status>(),
            container_maximum_size      : 100,
            collection_fee_container_id : 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::create_fee_container(25, arg0),
        };
        let v3 = Container{
            id              : 0x2::object::new(arg0),
            objects_in_list : 0,
        };
        let v4 = Container_Status{
            container_id : 0x2::object::id<Container>(&v3),
            can_deposit  : true,
        };
        0x1::vector::push_back<Container_Status>(&mut v2.containers_list, v4);
        0x2::transfer::share_object<Container>(v3);
        0x2::transfer::share_object<Admin>(v1);
        0x2::transfer::share_object<Marketplace>(v2);
    }

    public fun isAdmin(arg0: &mut Admin, arg1: address) : bool {
        let v0 = false;
        let v1 = arg0.enable_addresses;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            if (*0x1::vector::borrow<address>(&v1, v2) == arg1) {
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public entry fun make_accept_offer_with_listed_nft_in_different_container<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Admin, arg2: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg3: &mut Container, arg4: &mut Container, arg5: 0x2::object::ID, arg6: 0x2::object::ID, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let List {
            id           : v0,
            container_id : _,
            seller       : v2,
            item         : v3,
            price        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, List<T0>>(&mut arg3.id, arg5);
        assert!(v2 == 0x2::tx_context::sender(arg8), 4004);
        let Offer {
            id           : v5,
            nft_id       : _,
            container_id : _,
            paid         : v8,
            offer_price  : v9,
            offerer      : v10,
            end_time     : v11,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg4.id, arg6);
        let v12 = v8;
        assert!(0x2::clock::timestamp_ms(arg7) < v11, 4015);
        let v13 = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_service_fee(arg2, v9);
        let (v14, v15) = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_creator_fee(arg2, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), v9, arg8);
        let v16 = if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v15), arg8), v14);
            v9 - v15 - v13
        } else {
            v9 - v13
        };
        let v17 = OwnerAcceptOfferEvent{
            nft_id        : arg5,
            offer_price   : v9,
            seller        : v2,
            new_nft_owner : v10,
        };
        0x2::event::emit<OwnerAcceptOfferEvent>(v17);
        change_container_status(arg0, arg4, true);
        change_container_status(arg0, arg3, true);
        arg4.objects_in_list = arg4.objects_in_list - 1;
        arg3.objects_in_list = arg3.objects_in_list - 1;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v13), arg8));
        arg1.total_pool = arg1.total_pool + v13;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v16), arg8), v2);
        0x2::transfer::public_transfer<T0>(v3, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, v10);
        0x2::object::delete(v0);
        0x2::object::delete(v5);
    }

    public entry fun make_accept_offer_with_listed_nft_in_same_container<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Admin, arg2: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg3: &mut Container, arg4: 0x2::object::ID, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let List {
            id           : v0,
            container_id : _,
            seller       : v2,
            item         : v3,
            price        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, List<T0>>(&mut arg3.id, arg4);
        assert!(v2 == 0x2::tx_context::sender(arg7), 4004);
        let Offer {
            id           : v5,
            nft_id       : _,
            container_id : _,
            paid         : v8,
            offer_price  : v9,
            offerer      : v10,
            end_time     : v11,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg3.id, arg5);
        let v12 = v8;
        assert!(0x2::clock::timestamp_ms(arg6) < v11, 4015);
        let v13 = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_service_fee(arg2, v9);
        let (v14, v15) = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_creator_fee(arg2, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), v9, arg7);
        let v16 = if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v15), arg7), v14);
            v9 - v15 - v13
        } else {
            v9 - v13
        };
        let v17 = OwnerAcceptOfferEvent{
            nft_id        : arg4,
            offer_price   : v9,
            seller        : v2,
            new_nft_owner : v10,
        };
        0x2::event::emit<OwnerAcceptOfferEvent>(v17);
        change_container_status(arg0, arg3, true);
        arg3.objects_in_list = arg3.objects_in_list - 2;
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v13), arg7));
        arg1.total_pool = arg1.total_pool + v13;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v12), v16), arg7), v2);
        0x2::transfer::public_transfer<T0>(v3, v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v12, v10);
        0x2::object::delete(v0);
        0x2::object::delete(v5);
    }

    public entry fun make_accept_offer_with_non_listed_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Admin, arg2: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg3: &mut Container, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: T0, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::object::id<T0>(&arg6);
        let Offer {
            id           : v0,
            nft_id       : v1,
            container_id : _,
            paid         : v3,
            offer_price  : v4,
            offerer      : v5,
            end_time     : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg3.id, arg4);
        let v7 = v3;
        assert!(0x2::clock::timestamp_ms(arg5) < v6, 4015);
        assert!(v1 == 0x2::object::id<T0>(&arg6), 4016);
        let v8 = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_service_fee(arg2, v4);
        let (v9, v10) = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_creator_fee(arg2, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), v4, arg7);
        let v11 = if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v7), v10), arg7), v9);
            v4 - v10 - v8
        } else {
            v4 - v8
        };
        change_container_status(arg0, arg3, true);
        arg3.objects_in_list = arg3.objects_in_list - 1;
        let v12 = OwnerAcceptOfferEvent{
            nft_id        : v1,
            offer_price   : v4,
            seller        : 0x2::tx_context::sender(arg7),
            new_nft_owner : v5,
        };
        0x2::event::emit<OwnerAcceptOfferEvent>(v12);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v7), v8), arg7));
        arg1.total_pool = arg1.total_pool + v8;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v7), v11), arg7), 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<T0>(arg6, v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, v5);
        0x2::object::delete(v0);
    }

    public entry fun make_admin_return_offer(arg0: &mut Marketplace, arg1: &mut Container, arg2: &mut Admin, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id           : v0,
            nft_id       : _,
            container_id : _,
            paid         : v3,
            offer_price  : _,
            offerer      : v5,
            end_time     : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg1.id, arg4);
        let v7 = v0;
        assert!(check_sender_is_in_enable_admin_addresses(arg2, arg6) == true, 4003);
        assert!(0x2::clock::timestamp_ms(arg5) > v6, 4015);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        let v8 = DeleteOfferEvent{
            offer_id : 0x2::object::uid_to_inner(&v7),
            nft_id   : arg3,
            offerer  : v5,
        };
        0x2::event::emit<DeleteOfferEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v5);
        0x2::object::delete(v7);
    }

    public entry fun make_auction<T0: store + key>(arg0: &mut Container, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AuctionItem<T0>>(&mut arg0.id, arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x2::tx_context::sender(arg5) != v0.seller, 5005);
        assert!(v1 >= v0.start_time && v1 <= v0.end_time, 5001);
        assert!(arg2 > v0.current_price, 5002);
        assert!(arg2 > v0.start_price, 5002);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v0.paid), v0.current_price), arg5), v0.current_offerer);
        0x2::coin::join<0x2::sui::SUI>(&mut v0.paid, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg1), arg2), arg5));
        v0.current_offerer = 0x2::tx_context::sender(arg5);
        v0.current_price = arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        let v2 = AuctionEvent{
            nft_id  : arg3,
            price   : arg2,
            offerer : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<AuctionEvent>(v2);
    }

    public entry fun make_buy_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Admin, arg2: &mut Container, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::FeeContainer, arg6: &mut 0x2::tx_context::TxContext) {
        change_container_status(arg0, arg2, true);
        arg2.objects_in_list = arg2.objects_in_list - 1;
        let List {
            id           : v0,
            container_id : _,
            seller       : v2,
            item         : v3,
            price        : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, List<T0>>(&mut arg2.id, arg3);
        let v5 = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_service_fee(arg5, v4);
        let (v6, v7) = 0x76fa1cb28e46a2fb3ff3e20431e15d09fa95033914ad30470c6f982210b77431::collection_fee_module::get_creator_fee(arg5, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())), v4, arg6);
        let v8 = if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), v7), arg6), v6);
            v4 - v7 - v5
        } else {
            v4 - v5
        };
        let v9 = EventBuyNft{
            nft_id    : arg3,
            seller    : v2,
            new_owner : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<EventBuyNft>(v9);
        0x2::coin::join<0x2::sui::SUI>(&mut arg1.pool, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), v5), arg6));
        arg1.total_pool = arg1.total_pool + v5;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg4), v8), arg6), v2);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg6));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, 0x2::tx_context::sender(arg6));
        0x2::object::delete(v0);
    }

    public entry fun make_delist_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let List {
            id           : v0,
            container_id : _,
            seller       : v2,
            item         : v3,
            price        : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, List<T0>>(&mut arg1.id, arg2);
        assert!(v2 == 0x2::tx_context::sender(arg3), 4004);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        let v5 = EventDeListNft{
            nft_id : arg2,
            seller : v2,
        };
        0x2::event::emit<EventDeListNft>(v5);
        0x2::transfer::public_transfer<T0>(v3, 0x2::tx_context::sender(arg3));
        0x2::object::delete(v0);
    }

    public entry fun make_list_auction_nft<T0: store + key>(arg0: 0x2::object::ID, arg1: &mut Marketplace, arg2: &mut Container, arg3: T0, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg2.objects_in_list == arg1.container_maximum_size) {
            let v0 = create_new_container(arg1, arg7);
            let v1 = 0x2::object::id<T0>(&arg3);
            let v2 = AuctionItem<T0>{
                id              : 0x2::object::new(arg7),
                seller          : 0x2::tx_context::sender(arg7),
                current_offerer : 0x2::tx_context::sender(arg7),
                container_id    : 0x2::object::id<Container>(&v0),
                item            : arg3,
                start_price     : arg4,
                current_price   : 0,
                paid            : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7),
                start_time      : arg5,
                end_time        : arg6,
            };
            let v3 = ListAuctionEvent{
                seller             : 0x2::tx_context::sender(arg7),
                list_id            : 0x2::object::id<AuctionItem<T0>>(&v2),
                nft_id             : v1,
                container_id       : 0x2::object::id<Container>(&v0),
                auction_id         : 0x2::object::id<Marketplace>(arg1),
                start_time         : arg5,
                end_time           : arg6,
                start_price        : arg4,
                auction_package_id : arg0,
            };
            0x2::event::emit<ListAuctionEvent>(v3);
            0x2::dynamic_object_field::add<0x2::object::ID, AuctionItem<T0>>(&mut v0.id, v1, v2);
            0x2::transfer::share_object<Container>(v0);
        } else {
            let v4 = 0x2::object::id<T0>(&arg3);
            let v5 = AuctionItem<T0>{
                id              : 0x2::object::new(arg7),
                seller          : 0x2::tx_context::sender(arg7),
                current_offerer : 0x2::tx_context::sender(arg7),
                container_id    : 0x2::object::id<Container>(arg2),
                item            : arg3,
                start_price     : arg4,
                current_price   : 0,
                paid            : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::zero<0x2::sui::SUI>(), arg7),
                start_time      : arg5,
                end_time        : arg6,
            };
            let v6 = ListAuctionEvent{
                seller             : 0x2::tx_context::sender(arg7),
                list_id            : 0x2::object::id<AuctionItem<T0>>(&v5),
                nft_id             : v4,
                container_id       : 0x2::object::id<Container>(arg2),
                auction_id         : 0x2::object::id<Marketplace>(arg1),
                start_time         : arg5,
                end_time           : arg6,
                start_price        : arg4,
                auction_package_id : arg0,
            };
            0x2::event::emit<ListAuctionEvent>(v6);
            if (arg2.objects_in_list + 1 == arg1.container_maximum_size) {
                change_container_status(arg1, arg2, false);
            };
            arg2.objects_in_list = arg2.objects_in_list + 1;
            0x2::dynamic_object_field::add<0x2::object::ID, AuctionItem<T0>>(&mut arg2.id, v4, v5);
        };
    }

    public entry fun make_list_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: 0x2::object::ID, arg3: T0, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg1.objects_in_list >= arg0.container_maximum_size) {
            change_container_status(arg0, arg1, false);
            let v0 = create_new_container(arg0, arg5);
            let v1 = 0x2::object::id<T0>(&arg3);
            let v2 = List<T0>{
                id           : 0x2::object::new(arg5),
                container_id : 0x2::object::id<Container>(&v0),
                seller       : 0x2::tx_context::sender(arg5),
                item         : arg3,
                price        : arg4,
            };
            let v3 = EventListNft{
                list_id        : 0x2::object::id<List<T0>>(&v2),
                nft_id         : v1,
                container_id   : 0x2::object::id<Container>(&v0),
                marketplace_id : arg2,
                price          : arg4,
                seller         : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<EventListNft>(v3);
            0x2::dynamic_object_field::add<0x2::object::ID, List<T0>>(&mut v0.id, v1, v2);
            let v4 = EventCreateContainer{container_id: 0x2::object::id<Container>(&v0)};
            0x2::event::emit<EventCreateContainer>(v4);
            0x2::transfer::share_object<Container>(v0);
        } else {
            let v5 = 0x2::object::id<T0>(&arg3);
            let v6 = List<T0>{
                id           : 0x2::object::new(arg5),
                container_id : 0x2::object::uid_to_inner(&arg1.id),
                seller       : 0x2::tx_context::sender(arg5),
                item         : arg3,
                price        : arg4,
            };
            let v7 = EventListNft{
                list_id        : 0x2::object::id<List<T0>>(&v6),
                nft_id         : v5,
                container_id   : 0x2::object::uid_to_inner(&arg1.id),
                marketplace_id : arg2,
                price          : arg4,
                seller         : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<EventListNft>(v7);
            if (arg1.objects_in_list + 1 == arg0.container_maximum_size) {
                change_container_status(arg0, arg1, false);
            };
            arg1.objects_in_list = arg1.objects_in_list + 1;
            0x2::dynamic_object_field::add<0x2::object::ID, List<T0>>(&mut arg1.id, v5, v6);
        };
    }

    public entry fun make_offer_with_nft<T0: store + key>(arg0: &mut Marketplace, arg1: &mut Container, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg1.objects_in_list >= arg0.container_maximum_size) {
            change_container_status(arg0, arg1, false);
            let v0 = create_new_container(arg0, arg7);
            let v1 = Offer<0x2::coin::Coin<0x2::sui::SUI>>{
                id           : 0x2::object::new(arg7),
                nft_id       : arg3,
                container_id : 0x2::object::uid_to_inner(&v0.id),
                paid         : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg5), arg4), arg7),
                offer_price  : arg4,
                offerer      : 0x2::tx_context::sender(arg7),
                end_time     : arg6,
            };
            let v2 = OfferNftEvent{
                offer_id       : 0x2::object::id<Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&v1),
                nft_id         : arg3,
                offer_price    : arg4,
                offerer        : 0x2::tx_context::sender(arg7),
                marketplace_id : arg2,
                expried_at     : arg6,
                container_id   : 0x2::object::uid_to_inner(&v0.id),
            };
            0x2::event::emit<OfferNftEvent>(v2);
            0x2::dynamic_object_field::add<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut v0.id, 0x2::object::id<Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&v1), v1);
            let v3 = EventCreateContainer{container_id: 0x2::object::id<Container>(&v0)};
            0x2::event::emit<EventCreateContainer>(v3);
            0x2::transfer::share_object<Container>(v0);
        } else {
            let v4 = Offer<0x2::coin::Coin<0x2::sui::SUI>>{
                id           : 0x2::object::new(arg7),
                nft_id       : arg3,
                container_id : 0x2::object::uid_to_inner(&arg1.id),
                paid         : 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg5), arg4), arg7),
                offer_price  : arg4,
                offerer      : 0x2::tx_context::sender(arg7),
                end_time     : arg6,
            };
            let v5 = OfferNftEvent{
                offer_id       : 0x2::object::id<Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&v4),
                nft_id         : arg3,
                offer_price    : arg4,
                offerer        : 0x2::tx_context::sender(arg7),
                marketplace_id : arg2,
                expried_at     : arg6,
                container_id   : 0x2::object::uid_to_inner(&arg1.id),
            };
            0x2::event::emit<OfferNftEvent>(v5);
            if (arg1.objects_in_list + 1 == arg0.container_maximum_size) {
                change_container_status(arg0, arg1, false);
            };
            arg1.objects_in_list = arg1.objects_in_list + 1;
            0x2::dynamic_object_field::add<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg1.id, 0x2::object::id<Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&v4), v4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, 0x2::tx_context::sender(arg7));
    }

    public entry fun make_update_listing_price<T0: store + key>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, List<T0>>(&mut arg0.id, arg1);
        let v1 = &mut v0.price;
        let v2 = 0x2::tx_context::sender(arg3);
        assert!(&mut v0.seller == &mut v2, 4004);
        *v1 = arg2;
        let v3 = EventUpdateListingPrice{
            nft_id    : arg1,
            new_price : arg2,
        };
        0x2::event::emit<EventUpdateListingPrice>(v3);
    }

    public entry fun make_user_delete_offer(arg0: &mut Marketplace, arg1: &mut Container, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id           : v0,
            nft_id       : _,
            container_id : _,
            paid         : v3,
            offer_price  : _,
            offerer      : v5,
            end_time     : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Offer<0x2::coin::Coin<0x2::sui::SUI>>>(&mut arg1.id, arg3);
        let v7 = v0;
        assert!(v5 == 0x2::tx_context::sender(arg4), 4014);
        change_container_status(arg0, arg1, true);
        arg1.objects_in_list = arg1.objects_in_list - 1;
        let v8 = DeleteOfferEvent{
            offer_id : 0x2::object::uid_to_inner(&v7),
            nft_id   : arg2,
            offerer  : v5,
        };
        0x2::event::emit<DeleteOfferEvent>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v5);
        0x2::object::delete(v7);
    }

    public entry fun withdraw(arg0: &mut Admin, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = isAdmin(arg0, 0x2::tx_context::sender(arg2));
        assert!(v0 == true, 4003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut arg0.pool), arg0.total_pool), arg2), arg1);
        arg0.total_pool = 0;
    }

    // decompiled from Move bytecode v6
}

