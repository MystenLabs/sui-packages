module 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::pool {
    struct Order<phantom T0> has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        price: u128,
        status: u8,
        deposit_id: 0x2::object::ID,
        withdraw_id: 0x1::option::Option<0x2::object::ID>,
        expire_ts: u64,
        confirmed_ts: u64,
        created_ts: u64,
        canceled_ts: u64,
        sold_ts: u64,
    }

    struct UserIndexer has store, key {
        id: 0x2::object::UID,
        orders: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        order_ids: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>,
        price_indexer: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::SkipList<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>,
        in_sales_order_count: u64,
        in_sales_amount: u64,
        total_trade_volume: u64,
        total_trade_amount: u64,
        creator: address,
        confirmed_ts: u64,
        created_ts: u64,
    }

    struct CollectionSimpleInfo has copy, drop, store {
        collection_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        quote_coin: 0x1::type_name::TypeName,
        creator: address,
        confirmed_ts: u64,
        created_ts: u64,
    }

    struct Collections has store, key {
        id: 0x2::object::UID,
        list: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, CollectionSimpleInfo>,
    }

    struct POOL has drop {
        dummy_field: bool,
    }

    struct InitEvent has copy, drop, store {
        collections_id: 0x2::object::ID,
        user_indexer_id: 0x2::object::ID,
    }

    struct CollectionCreatedEvent has copy, drop, store {
        collection_id: 0x2::object::ID,
        p: 0x1::string::String,
        tick: 0x1::string::String,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderListedEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        price: u128,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        deposit_id: 0x2::object::ID,
        expire_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderConfirmedEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        price: u128,
        deposit_id: 0x2::object::ID,
        created_ts: u64,
        expire_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderCanceledBySellerEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        price: u128,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        deposit_id: 0x2::object::ID,
        withdraw_id: 0x2::object::ID,
        created_ts: u64,
        confirmed_ts: u64,
        expire_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderCanceledByValidatorEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        price: u128,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        deposit_id: 0x2::object::ID,
        created_ts: u64,
        confirmed_ts: u64,
        expire_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderDealEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u128,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        deposit_id: 0x2::object::ID,
        withdraw_id: 0x2::object::ID,
        protocol_fee: u64,
        confirmed_ts: u64,
        created_ts: u64,
        expire_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderDeleteEvent has copy, drop, store {
        order_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u128,
        inscription: 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription,
        deposit_id: 0x2::object::ID,
        withdraw_id: 0x1::option::Option<0x2::object::ID>,
        created_ts: u64,
        confirmed_ts: u64,
        canceled_ts: u64,
        expire_ts: u64,
        sold_ts: u64,
        quote_coin: 0x1::type_name::TypeName,
    }

    struct OrderSimpleInfo has copy, drop, store {
        order_id: 0x2::object::ID,
        price: u128,
        amt: u64,
    }

    struct FetchConfirmedOrderIDsEvent has copy, drop, store {
        orders: vector<OrderSimpleInfo>,
    }

    struct FetchSellerOrderIDsEvent has copy, drop, store {
        orders: vector<0x2::object::ID>,
    }

    fun add_order_to_user_indexer(arg0: &mut UserIndexer, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.orders, arg1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.orders, arg1, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg3));
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.orders, arg1), arg2, true);
    }

    fun build_extends_vec_map(arg0: vector<0x1::string::String>, arg1: vector<0x1::string::String>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg1), 10);
        let v1 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v2 = 0;
        while (v2 < v0) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, *0x1::vector::borrow<0x1::string::String>(&arg0, v2), *0x1::vector::borrow<0x1::string::String>(&arg1, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun buy<T0>(arg0: &mut 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut UserIndexer, arg2: &mut Collection<T0>, arg3: &mut Order<T0>, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        if (arg3.status != 1) {
            abort 2
        };
        if (0x2::tx_context::sender(arg6) == arg3.seller) {
            abort 4
        };
        if (arg3.collection_id != 0x2::object::id<Collection<T0>>(arg2)) {
            abort 1
        };
        if (arg3.expire_ts < 0x2::clock::timestamp_ms(arg5)) {
            abort 13
        };
        let v0 = 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_amt(&arg3.inscription);
        let v1 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_ceil(arg3.price, (v0 as u128), 1000000000000) as u64);
        if (v1 > 0x2::coin::value<T0>(&arg4)) {
            abort 5
        };
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u64::mul_div_ceil(v1, 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::get_protocol_fee_rate<T0>(arg0), 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::protocol_fee_denom());
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::receive_protocol_fee<T0>(arg0, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg4, v2, arg6)));
        send_coin<T0>(0x2::coin::split<T0>(&mut arg4, v1 - v2, arg6), arg3.seller);
        send_coin<T0>(arg4, 0x2::tx_context::sender(arg6));
        arg3.status = 4;
        arg3.sold_ts = 0x2::clock::timestamp_ms(arg5);
        arg3.buyer = 0x2::tx_context::sender(arg6);
        arg2.total_trade_volume = arg2.total_trade_volume + v1;
        arg2.total_trade_amount = arg2.total_trade_amount + v0;
        remove_from_collection<T0>(arg2, arg3);
        add_order_to_user_indexer(arg1, arg3.buyer, 0x2::object::id<Order<T0>>(arg3), arg6);
        let v3 = OrderDealEvent{
            order_id      : 0x2::object::id<Order<T0>>(arg3),
            collection_id : arg3.collection_id,
            seller        : arg3.seller,
            buyer         : arg3.buyer,
            price         : arg3.price,
            inscription   : arg3.inscription,
            deposit_id    : arg3.deposit_id,
            withdraw_id   : 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::transfer_from_vault(arg0, &arg3.inscription, arg3.buyer, arg6),
            protocol_fee  : v2,
            confirmed_ts  : arg3.confirmed_ts,
            created_ts    : arg3.created_ts,
            expire_ts     : arg3.expire_ts,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderDealEvent>(v3);
    }

    public fun cancel_order_by_seller<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Collection<T0>, arg2: &mut Order<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        if (arg2.status != 1) {
            abort 2
        };
        if (arg2.collection_id != 0x2::object::id<Collection<T0>>(arg1)) {
            abort 1
        };
        if (arg2.seller != 0x2::tx_context::sender(arg4)) {
            abort 3
        };
        arg2.status = 2;
        arg2.canceled_ts = 0x2::clock::timestamp_ms(arg3);
        remove_from_collection<T0>(arg1, arg2);
        let v0 = OrderCanceledBySellerEvent{
            order_id      : 0x2::object::id<Order<T0>>(arg2),
            collection_id : arg2.collection_id,
            seller        : arg2.seller,
            price         : arg2.price,
            inscription   : arg2.inscription,
            deposit_id    : arg2.deposit_id,
            withdraw_id   : 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::transfer_from_vault(arg0, &arg2.inscription, arg2.seller, arg4),
            created_ts    : arg2.created_ts,
            confirmed_ts  : arg2.confirmed_ts,
            expire_ts     : arg2.expire_ts,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderCanceledBySellerEvent>(v0);
    }

    public fun cancel_order_by_validator<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Collection<T0>, arg2: &mut Order<T0>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::check_validator_role(arg0, 0x2::tx_context::sender(arg5));
        if (arg2.status != 0) {
            abort 9
        };
        if (arg2.collection_id != 0x2::object::id<Collection<T0>>(arg1)) {
            abort 1
        };
        let v0 = 0x2::object::id_bytes<Order<T0>>(arg2);
        0x1::vector::append<u8>(&mut v0, x"00");
        if (!0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::validator::verify(arg0, v0, arg3)) {
            abort 7
        };
        arg2.status = 3;
        arg2.canceled_ts = 0x2::clock::timestamp_ms(arg4);
        remove_from_collection<T0>(arg1, arg2);
        let v1 = OrderCanceledByValidatorEvent{
            order_id      : 0x2::object::uid_to_inner(&arg2.id),
            collection_id : arg2.collection_id,
            seller        : arg2.seller,
            price         : arg2.price,
            inscription   : arg2.inscription,
            deposit_id    : arg2.deposit_id,
            created_ts    : arg2.created_ts,
            confirmed_ts  : arg2.confirmed_ts,
            expire_ts     : arg2.expire_ts,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderCanceledByValidatorEvent>(v1);
    }

    public fun confirm_order<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Order<T0>, arg2: &mut Collection<T0>, arg3: vector<0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        if (arg1.status != 0) {
            return
        };
        if (arg1.collection_id != 0x2::object::id<Collection<T0>>(arg2)) {
            abort 1
        };
        let v0 = 0x2::object::id_bytes<Order<T0>>(arg1);
        0x1::vector::append<u8>(&mut v0, x"01");
        if (!0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::validator::verify(arg0, v0, arg3)) {
            abort 7
        };
        let v1 = 0x2::object::id<Order<T0>>(arg1);
        arg1.status = 1;
        arg1.confirmed_ts = 0x2::clock::timestamp_ms(arg4);
        arg2.in_sales_amount = arg2.in_sales_amount + 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_amt(&arg1.inscription);
        arg2.in_sales_order_count = arg2.in_sales_order_count + 1;
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::contains<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg2.price_indexer, arg1.price)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::insert<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.price_indexer, arg1.price, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, u64>(arg5));
        };
        let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg2.price_indexer, arg1.price);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, u64>(v2, v1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, u64>(v2, v1, 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_amt(&arg1.inscription));
        };
        let v3 = OrderConfirmedEvent{
            order_id      : v1,
            collection_id : 0x2::object::id<Collection<T0>>(arg2),
            seller        : arg1.seller,
            inscription   : arg1.inscription,
            price         : arg1.price,
            deposit_id    : arg1.deposit_id,
            created_ts    : arg1.created_ts,
            expire_ts     : arg1.expire_ts,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderConfirmedEvent>(v3);
    }

    public fun create_collection<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg2: &mut Collections, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        let v0 = create_collection_internal<T0>(arg0, arg1, arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5), arg6);
        0x2::transfer::public_share_object<Collection<T0>>(v0);
        let v1 = CollectionCreatedEvent{
            collection_id : 0x2::object::id<Collection<T0>>(&v0),
            p             : arg3,
            tick          : arg4,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CollectionCreatedEvent>(v1);
    }

    public fun create_collection_and_list_order<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg2: &mut Collections, arg3: &mut UserIndexer, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: u128, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg11);
        assert!(arg10 > v0, 12);
        let v1 = create_collection_internal<T0>(arg0, arg1, arg2, arg4, arg5, v0, arg12);
        let v2 = &mut v1;
        let (v3, v4) = create_order_internal<T0>(arg0, v2, arg3, arg4, arg5, arg6, build_extends_vec_map(arg7, arg8), arg9, arg10, v0, arg12);
        let v5 = v4;
        let v6 = 0x2::object::id<Collection<T0>>(&v1);
        0x2::transfer::public_share_object<Collection<T0>>(v1);
        0x2::transfer::public_share_object<Order<T0>>(v5);
        let v7 = CollectionCreatedEvent{
            collection_id : v6,
            p             : arg4,
            tick          : arg5,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<CollectionCreatedEvent>(v7);
        let v8 = OrderListedEvent{
            order_id      : 0x2::object::id<Order<T0>>(&v5),
            collection_id : v6,
            seller        : 0x2::tx_context::sender(arg12),
            price         : arg9,
            inscription   : v3,
            deposit_id    : v5.deposit_id,
            expire_ts     : arg10,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderListedEvent>(v8);
    }

    fun create_collection_internal<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::GlobalConfig, arg2: &mut Collections, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : Collection<T0> {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_quote_coin<T0>(arg0);
        assert!(0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::contains_tick(arg1, 0x25e58c592e1fd392c6549b9eedbccc09aed00f1c87b42aaea1843118ab3725f4::config::tick_key(arg3, arg4)), 8);
        let v0 = get_collection_key<T0>(arg3, arg4);
        assert!(!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, CollectionSimpleInfo>(&arg2.list, v0), 6);
        let v1 = Collection<T0>{
            id                   : 0x2::object::new(arg6),
            p                    : arg3,
            tick                 : arg4,
            order_ids            : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg6),
            price_indexer        : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::new<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(20, 2, 0, arg6),
            in_sales_order_count : 0,
            in_sales_amount      : 0,
            total_trade_volume   : 0,
            total_trade_amount   : 0,
            creator              : 0x2::tx_context::sender(arg6),
            confirmed_ts         : 0,
            created_ts           : arg5,
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, CollectionSimpleInfo>(&mut arg2.list, v0, create_collection_simple_info<T0>(&v1));
        v1
    }

    fun create_collection_simple_info<T0>(arg0: &Collection<T0>) : CollectionSimpleInfo {
        CollectionSimpleInfo{
            collection_id : 0x2::object::id<Collection<T0>>(arg0),
            p             : arg0.p,
            tick          : arg0.tick,
            quote_coin    : 0x1::type_name::get<T0>(),
            creator       : arg0.creator,
            confirmed_ts  : arg0.confirmed_ts,
            created_ts    : arg0.created_ts,
        }
    }

    fun create_order_internal<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Collection<T0>, arg2: &mut UserIndexer, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg7: u128, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : (0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::Inscription, Order<T0>) {
        let v0 = 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::new(arg3, arg4, arg5, arg6);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = Order<T0>{
            id            : 0x2::object::new(arg10),
            collection_id : 0x2::object::id<Collection<T0>>(arg1),
            seller        : v1,
            buyer         : @0x0,
            inscription   : v0,
            price         : arg7,
            status        : 0,
            deposit_id    : 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::transfer_to_vault(arg0, &v0, arg10),
            withdraw_id   : 0x1::option::none<0x2::object::ID>(),
            expire_ts     : arg8,
            confirmed_ts  : 0,
            created_ts    : arg9,
            canceled_ts   : 0,
            sold_ts       : 0,
        };
        if (get_collection_key<T0>(0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_p(&v2.inscription), 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_tick(&v2.inscription)) != get_collection_key<T0>(arg1.p, arg1.tick)) {
            abort 1
        };
        let v3 = 0x2::object::id<Order<T0>>(&v2);
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut arg1.order_ids, v3, true);
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg2.orders, v1)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg2.orders, v1, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg10));
        };
        0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg2.orders, v1), v3, true);
        (v0, v2)
    }

    public fun delete_order_by_validator<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Collection<T0>, arg2: &mut UserIndexer, arg3: Order<T0>, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        if (arg3.status == 0 || arg3.status == 1) {
            abort 11
        };
        if (arg3.collection_id != 0x2::object::id<Collection<T0>>(arg1)) {
            abort 1
        };
        let v0 = 0x2::object::id_bytes<Order<T0>>(&arg3);
        0x1::vector::append<u8>(&mut v0, x"02");
        if (!0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::validator::verify(arg0, v0, arg4)) {
            abort 7
        };
        let v1 = if (arg3.status == 2 || arg3.status == 3) {
            arg3.canceled_ts + 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::get_delete_grace(arg0)
        } else {
            arg3.sold_ts + 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::get_delete_grace(arg0)
        };
        if (v1 > 0x2::clock::timestamp_ms(arg5)) {
            abort 14
        };
        let v2 = 0x2::object::id<Order<T0>>(&arg3);
        remove_order_from_user_indexer(arg2, arg3.seller, v2);
        remove_order_from_user_indexer(arg2, arg3.buyer, v2);
        let v3 = OrderDeleteEvent{
            order_id      : v2,
            collection_id : arg3.collection_id,
            seller        : arg3.seller,
            buyer         : arg3.buyer,
            price         : arg3.price,
            inscription   : arg3.inscription,
            deposit_id    : arg3.deposit_id,
            withdraw_id   : arg3.withdraw_id,
            created_ts    : arg3.created_ts,
            confirmed_ts  : arg3.confirmed_ts,
            canceled_ts   : arg3.canceled_ts,
            expire_ts     : arg3.expire_ts,
            sold_ts       : arg3.sold_ts,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderDeleteEvent>(v3);
        let Order {
            id            : v4,
            collection_id : _,
            seller        : _,
            buyer         : _,
            inscription   : _,
            price         : _,
            status        : _,
            deposit_id    : _,
            withdraw_id   : _,
            expire_ts     : _,
            confirmed_ts  : _,
            created_ts    : _,
            canceled_ts   : _,
            sold_ts       : _,
        } = arg3;
        0x2::object::delete(v4);
    }

    public fun fetch_confirmed_orders<T0>(arg0: &Collection<T0>, arg1: u128, arg2: vector<0x2::object::ID>, arg3: u64) {
        let v0 = 0x1::vector::empty<OrderSimpleInfo>();
        let v1 = if (arg1 > 0) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::find_next<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg0.price_indexer, arg1, true)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::head<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg0.price_indexer)
        };
        let v2 = v1;
        let v3 = 0;
        while (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u128::is_some(&v2) && v3 < arg3) {
            let v4 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::option_u128::borrow(&v2);
            let v5 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::borrow<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg0.price_indexer, v4);
            let v6 = if (0x1::vector::length<0x2::object::ID>(&arg2) > 0) {
                let v7 = *0x1::vector::borrow<0x2::object::ID>(&arg2, 0);
                if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, u64>(v5, v7)) {
                    0x1::option::some<0x2::object::ID>(v7)
                } else {
                    0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, u64>(v5)
                }
            } else {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, u64>(v5)
            };
            let v8 = v6;
            while (0x1::option::is_some<0x2::object::ID>(&v8) && v3 < arg3) {
                let v9 = *0x1::option::borrow<0x2::object::ID>(&v8);
                let v10 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, u64>(v5, v9);
                let v11 = OrderSimpleInfo{
                    order_id : v9,
                    price    : v4,
                    amt      : *0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_value<0x2::object::ID, u64>(v10),
                };
                0x1::vector::push_back<OrderSimpleInfo>(&mut v0, v11);
                v8 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, u64>(v10);
                v3 = v3 + 1;
            };
            v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::find_next<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg0.price_indexer, v4, false);
            arg2 = 0x1::vector::empty<0x2::object::ID>();
        };
        let v12 = FetchConfirmedOrderIDsEvent{orders: v0};
        0x2::event::emit<FetchConfirmedOrderIDsEvent>(v12);
    }

    public fun fetch_seller_orders(arg0: &UserIndexer, arg1: address, arg2: vector<0x2::object::ID>, arg3: u64) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (!0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.orders, arg1)) {
            return
        };
        let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.orders, arg1);
        let v2 = if (0x1::vector::is_empty<0x2::object::ID>(&arg2)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, bool>(v1)
        } else {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v1, *0x1::vector::borrow<0x2::object::ID>(&arg2, 0)))
        };
        let v3 = v2;
        let v4 = 0;
        while (0x1::option::is_some<0x2::object::ID>(&v3) && v4 < arg3) {
            let v5 = *0x1::option::borrow<0x2::object::ID>(&v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v5);
            v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v1, v5));
            v4 = v4 + 1;
        };
        let v6 = FetchSellerOrderIDsEvent{orders: v0};
        0x2::event::emit<FetchSellerOrderIDsEvent>(v6);
    }

    public fun get_collection_key<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x2::object::ID {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, arg1);
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::object::id_from_bytes(0x2::hash::blake2b256(0x1::string::bytes(&v0)))
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Collections{
            id   : 0x2::object::new(arg1),
            list : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, CollectionSimpleInfo>(arg1),
        };
        let v1 = UserIndexer{
            id     : 0x2::object::new(arg1),
            orders : 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
        };
        0x2::transfer::public_share_object<Collections>(v0);
        0x2::transfer::public_share_object<UserIndexer>(v1);
        let v2 = InitEvent{
            collections_id  : 0x2::object::id<Collections>(&v0),
            user_indexer_id : 0x2::object::id<UserIndexer>(&v1),
        };
        0x2::event::emit<InitEvent>(v2);
    }

    public fun list_order<T0>(arg0: &0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::GlobalConfig, arg1: &mut Collection<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: u128, arg8: u64, arg9: &mut UserIndexer, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::config::checked_package_version(arg0);
        assert!(arg8 > 0x2::clock::timestamp_ms(arg10), 12);
        let (v0, v1) = create_order_internal<T0>(arg0, arg1, arg9, arg2, arg3, arg4, build_extends_vec_map(arg5, arg6), arg7, arg8, 0x2::clock::timestamp_ms(arg10), arg11);
        let v2 = v1;
        0x2::transfer::public_share_object<Order<T0>>(v2);
        let v3 = OrderListedEvent{
            order_id      : 0x2::object::id<Order<T0>>(&v2),
            collection_id : 0x2::object::id<Collection<T0>>(arg1),
            seller        : 0x2::tx_context::sender(arg11),
            price         : arg7,
            inscription   : v0,
            deposit_id    : v2.deposit_id,
            expire_ts     : arg8,
            quote_coin    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<OrderListedEvent>(v3);
    }

    fun remove_from_collection<T0>(arg0: &mut Collection<T0>, arg1: &Order<T0>) {
        let v0 = 0x2::object::id<Order<T0>>(arg1);
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(&arg0.order_ids, v0)) {
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(&mut arg0.order_ids, v0);
        };
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::contains<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&arg0.price_indexer, arg1.price)) {
            let v1 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::borrow_mut<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg0.price_indexer, arg1.price);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, u64>(v1, v0)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, u64>(v1, v0);
            };
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, u64>(v1) == 0) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::destroy_empty<0x2::object::ID, u64>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::skip_list_u128::remove<0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, u64>>(&mut arg0.price_indexer, arg1.price));
            };
        };
        if ((arg1.status == 2 || arg1.status == 4) && arg0.in_sales_amount >= 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_amt(&arg1.inscription)) {
            arg0.in_sales_amount = arg0.in_sales_amount - 0x2409cf4d1cb092acb0680a7b619b6ec58f8a73692a4c9f19d3be3550b87d791c::inscription::get_amt(&arg1.inscription);
        };
        if (arg0.in_sales_order_count > 0) {
            arg0.in_sales_order_count = arg0.in_sales_order_count - 1;
        };
    }

    fun remove_order_from_user_indexer(arg0: &mut UserIndexer, arg1: address, arg2: 0x2::object::ID) {
        if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.orders, arg1)) {
            let v0 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.orders, arg1);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(v0, arg2)) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<0x2::object::ID, bool>(v0, arg2);
            };
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::length<0x2::object::ID, bool>(v0) == 0) {
                0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::destroy_empty<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::remove<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.orders, arg1));
            };
        };
    }

    public fun send_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

