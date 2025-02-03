module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::orderbook {
    struct ProtectedActions has drop, store {
        create_order: bool,
        fill_order: bool,
        match_orders: bool,
        cancel_order: bool,
    }

    struct Orderbook<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        next_order_id: u64,
        protected_actions: ProtectedActions,
        open_orders: 0x2::table::Table<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>,
        user_open_orders: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, bool>>,
        vault: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::Vault<T0, T1>,
    }

    public(friend) fun new<T0: store + key, T1>(arg0: &mut 0x2::tx_context::TxContext) : Orderbook<T0, T1> {
        Orderbook<T0, T1>{
            id                : 0x2::object::new(arg0),
            next_order_id     : 1,
            protected_actions : no_protections(),
            open_orders       : 0x2::table::new<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(arg0),
            user_open_orders  : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, bool>>(arg0),
            vault             : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::new<T0, T1>(arg0),
        }
    }

    public(friend) fun assert_not_protected_cancel_order<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        if (arg0.protected_actions.cancel_order) {
            abort 3
        };
    }

    public(friend) fun assert_not_protected_create_order<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        if (arg0.protected_actions.create_order) {
            abort 3
        };
    }

    public(friend) fun assert_not_protected_fill_order<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        if (arg0.protected_actions.fill_order) {
            abort 3
        };
    }

    public(friend) fun assert_not_protected_match_orders<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        if (arg0.protected_actions.match_orders) {
            abort 3
        };
    }

    public(friend) fun assert_order_exists<T0: store + key, T1>(arg0: &Orderbook<T0, T1>, arg1: u64) {
        if (!0x2::table::contains<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&arg0.open_orders, arg1)) {
            abort 0
        };
    }

    public(friend) fun borrow_mut_vault<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>) : &mut 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::Vault<T0, T1> {
        &mut arg0.vault
    }

    public fun borrow_order<T0: store + key, T1>(arg0: &Orderbook<T0, T1>, arg1: u64) : &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order {
        assert_order_exists<T0, T1>(arg0, arg1);
        0x2::table::borrow<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&arg0.open_orders, arg1)
    }

    public fun borrow_uid<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public fun borrow_vault<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) : &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::Vault<T0, T1> {
        &arg0.vault
    }

    public(friend) fun cancel_ft_order<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_not_protected_cancel_order<T0, T1>(arg0);
        cancel_ft_order_<T0, T1>(arg0, arg1, arg2)
    }

    fun cancel_ft_order_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = remove_order<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg2));
        if (!0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(&v0)))) {
            abort 2
        };
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_order_canceled_event(0x2::object::id<Orderbook<T0, T1>>(arg0), arg1);
        0x2::coin::from_balance<T1>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::withdraw_ft<T0, T1>(&mut arg0.vault, *0x1::option::borrow<u64>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::amount(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(&v0)))), arg2)
    }

    public(friend) fun cancel_ft_orders<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: vector<u64>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_not_protected_cancel_order<T0, T1>(arg0);
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::reverse<u64>(&mut arg1);
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            let v1 = cancel_ft_order_<T0, T1>(arg0, 0x1::vector::pop_back<u64>(&mut arg1), arg2);
            0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, v1);
        };
        0x1::vector::destroy_empty<u64>(arg1);
        let v2 = 0x2::coin::zero<T1>(arg2);
        0x2::pay::join_vec<T1>(&mut v2, v0);
        v2
    }

    public(friend) fun cancel_nft_order<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) : T0 {
        assert_not_protected_cancel_order<T0, T1>(arg0);
        cancel_nft_order_<T0, T1>(arg0, arg1, arg2)
    }

    fun cancel_nft_order_<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &0x2::tx_context::TxContext) : T0 {
        let v0 = remove_order<T0, T1>(arg0, arg1, 0x2::tx_context::sender(arg2));
        if (!0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::is_non_fungible_token(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::item_type(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(&v0)))) {
            abort 2
        };
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_order_canceled_event(0x2::object::id<Orderbook<T0, T1>>(arg0), arg1);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::withdraw_nft<T0, T1>(&mut arg0.vault, *0x1::option::borrow<0x2::object::ID>(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::identifier(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(&v0))))
    }

    public(friend) fun cancel_nft_orders<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: vector<u64>, arg2: &0x2::tx_context::TxContext) : vector<T0> {
        assert_not_protected_cancel_order<T0, T1>(arg0);
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::reverse<u64>(&mut arg1);
        while (!0x1::vector::is_empty<u64>(&arg1)) {
            0x1::vector::push_back<T0>(&mut v0, cancel_nft_order_<T0, T1>(arg0, 0x1::vector::pop_back<u64>(&mut arg1), arg2));
        };
        0x1::vector::destroy_empty<u64>(arg1);
        v0
    }

    public(friend) fun create_order_ft_to_nft<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: 0x1::option::Option<0x2::object::ID>, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_protected_create_order<T0, T1>(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier::verify_creation_time(arg1, arg2, arg6);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::deposit_ft<T0, T1>(&mut arg0.vault, 0x2::coin::into_balance<T1>(arg3));
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::new(0, 0x2::tx_context::sender(arg7), arg1, arg2, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::new(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::fungible_token(), 0x1::option::none<0x2::object::ID>(), 0x1::option::some<u64>(0x2::coin::value<T1>(&arg3))), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::new(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::non_fungible_token(), arg4, 0x1::option::none<u64>()), arg5);
        inject_order<T0, T1>(arg0, v0, arg7);
    }

    public(friend) fun create_order_nft_to_ft<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: u64, arg3: T0, arg4: u64, arg5: address, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_not_protected_create_order<T0, T1>(arg0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::verifier::verify_creation_time(arg1, arg2, arg6);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::vault::deposit_nft<T0, T1>(&mut arg0.vault, arg3);
        let v0 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::new(0, 0x2::tx_context::sender(arg7), arg1, arg2, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::new(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::non_fungible_token(), 0x1::option::some<0x2::object::ID>(0x2::object::id<T0>(&arg3)), 0x1::option::none<u64>()), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::new(0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::fungible_token(), 0x1::option::none<0x2::object::ID>(), 0x1::option::some<u64>(arg4)), arg5);
        inject_order<T0, T1>(arg0, v0, arg7);
    }

    public fun custom_protections(arg0: bool, arg1: bool, arg2: bool, arg3: bool) : ProtectedActions {
        ProtectedActions{
            create_order : arg0,
            fill_order   : arg1,
            match_orders : arg2,
            cancel_order : arg3,
        }
    }

    fun get_order_id<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>) : u64 {
        arg0.next_order_id = arg0.next_order_id + 1;
        arg0.next_order_id
    }

    fun inject_order<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = get_order_id<T0, T1>(arg0);
        let v1 = 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&arg1);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::set_order_id(&mut arg1, v0);
        0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::event_emitter::emit_order_placed_event(0x2::object::id<Orderbook<T0, T1>>(arg0), v0, v1, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offer(&arg1), 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::consideration(&arg1));
        0x2::table::add<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut arg0.open_orders, v0, arg1);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_open_orders, v1)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, v1, 0x2::linked_table::new<u64, bool>(arg2));
        };
        0x2::linked_table::push_back<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, v1), v0, true);
    }

    public fun no_protections() : ProtectedActions {
        ProtectedActions{
            create_order : false,
            fill_order   : false,
            match_orders : false,
            cancel_order : false,
        }
    }

    fun remove_order<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: address) : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order {
        assert_order_exists<T0, T1>(arg0, arg1);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_open_orders, arg2) || !0x2::linked_table::contains<u64, bool>(0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_open_orders, arg2), arg1)) {
            abort 1
        };
        0x2::linked_table::remove<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, arg2), arg1);
        0x2::table::remove<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut arg0.open_orders, arg1)
    }

    public(friend) fun set_protections<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: ProtectedActions) {
        arg0.protected_actions = arg1;
    }

    public(friend) fun take_order<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64) : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order {
        assert_order_exists<T0, T1>(arg0, arg1);
        let v0 = 0x2::table::remove<u64, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::Order>(&mut arg0.open_orders, arg1);
        0x2::linked_table::remove<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order::offerer(&v0)), arg1);
        v0
    }

    // decompiled from Move bytecode v6
}

