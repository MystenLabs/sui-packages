module 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::orderbook {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolFee has store {
        fee_rate: u64,
        vault: 0x2::bag::Bag,
    }

    struct Orderbook has store, key {
        id: 0x2::object::UID,
        next_order_id: u64,
        open_orders: 0x2::table::Table<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>,
        user_open_orders: 0x2::table::Table<address, 0x2::linked_table::LinkedTable<u64, bool>>,
        protocol_fee: ProtocolFee,
        vault: 0x2::bag::Bag,
        version: u64,
    }

    struct TakeOrderReceipt {
        order_id: u64,
        taker: address,
        filling_amount: u64,
        taking_amount: u64,
    }

    struct OrderPlaced has copy, drop, store {
        order_id: u64,
        client_order_id: u64,
        maker_asset: 0x1::type_name::TypeName,
        taker_asset: 0x1::type_name::TypeName,
        maker: address,
        recipient: address,
        allowed_taker: 0x1::option::Option<address>,
        making_amount: u64,
        taking_amount: u64,
        expires_timestamp: u64,
        allowed_partial_fills: bool,
    }

    struct OrderFilled has copy, drop, store {
        order_id: u64,
        taker: address,
        filling_amount: u64,
        remaining_amount: u64,
        taking_amount: u64,
        fee_amount: u64,
    }

    struct OrderCanceled has copy, drop, store {
        order_id: u64,
        remaining_amount: u64,
        sender: address,
    }

    struct SetProtocolFeeRate has copy, drop, store {
        sender: address,
        fee_rate: u64,
    }

    struct CollectProtocolFee has copy, drop, store {
        sender: address,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    public fun cancel_order<T0>(arg0: &mut Orderbook, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version(arg0);
        check_order_exists(arg0, arg1);
        let v0 = remove_order(arg0, arg1, 0x2::tx_context::sender(arg2));
        let v1 = 0x1::type_name::get<T0>();
        assert!(&v1 == 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::maker_asset(&v0), 7);
        let v2 = 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remaining_amount(&v0);
        0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::destroy(v0);
        let v3 = OrderCanceled{
            order_id         : 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::order_id(&v0),
            remaining_amount : v2,
            sender           : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OrderCanceled>(v3);
        0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0x1::type_name::get<T0>()), v2, arg2)
    }

    public fun check_order_exists(arg0: &Orderbook, arg1: u64) {
        assert!(0x2::table::contains<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&arg0.open_orders, arg1), 2);
    }

    public fun check_version(arg0: &Orderbook) {
        assert!(arg0.version == 1, 999);
    }

    public entry fun collect_protocol_fee<T0>(arg0: &AdminCap, arg1: &mut Orderbook, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        let v0 = 0x2::math::min(0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg1.protocol_fee.vault, 0x1::type_name::get<T0>())), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.protocol_fee.vault, 0x1::type_name::get<T0>()), v0, arg4), arg3);
        let v1 = CollectProtocolFee{
            sender : 0x2::tx_context::sender(arg4),
            coin   : 0x1::type_name::get<T0>(),
            amount : v0,
        };
        0x2::event::emit<CollectProtocolFee>(v1);
    }

    public fun fill_order<T0>(arg0: &mut Orderbook, arg1: TakeOrderReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::coin::value<T0>(&arg2) >= arg1.taking_amount, 0);
        let TakeOrderReceipt {
            order_id       : v0,
            taker          : v1,
            filling_amount : v2,
            taking_amount  : _,
        } = arg1;
        let v4 = 0x2::coin::value<T0>(&arg2);
        let v5 = &mut arg2;
        let v6 = pay_fee_if_necessary<T0>(arg0, v5, arg3);
        let v7 = 0x2::table::borrow_mut<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut arg0.open_orders, v0);
        let v8 = 0x1::type_name::get<T0>();
        assert!(&v8 == 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::taker_asset(v7), 8);
        0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::fill(v7, v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::recipient(v7));
        let v9 = OrderFilled{
            order_id         : 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::order_id(v7),
            taker            : v1,
            filling_amount   : v2,
            remaining_amount : 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remaining_amount(v7),
            taking_amount    : v4,
            fee_amount       : v6,
        };
        0x2::event::emit<OrderFilled>(v9);
        if (0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remaining_amount(v7) == 0) {
            0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::destroy(remove_order(arg0, v0, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::maker(v7)));
        };
    }

    public fun get_order(arg0: &Orderbook, arg1: u64) : &0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order {
        check_order_exists(arg0, arg1);
        0x2::table::borrow<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&arg0.open_orders, arg1)
    }

    public fun get_user_open_orders(arg0: &Orderbook, arg1: address) : &0x2::linked_table::LinkedTable<u64, bool> {
        0x2::table::borrow<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_open_orders, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolFee{
            fee_rate : 0,
            vault    : 0x2::bag::new(arg0),
        };
        let v1 = Orderbook{
            id               : 0x2::object::new(arg0),
            next_order_id    : 1,
            open_orders      : 0x2::table::new<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(arg0),
            user_open_orders : 0x2::table::new<address, 0x2::linked_table::LinkedTable<u64, bool>>(arg0),
            protocol_fee     : v0,
            vault            : 0x2::bag::new(arg0),
            version          : 1,
        };
        0x2::transfer::share_object<Orderbook>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun inject_order(arg0: &mut Orderbook, arg1: 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::order_id(&arg1);
        0x2::table::add<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut arg0.open_orders, v0, arg1);
        if (!0x2::table::contains<address, 0x2::linked_table::LinkedTable<u64, bool>>(&arg0.user_open_orders, arg2)) {
            0x2::table::add<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, arg2, 0x2::linked_table::new<u64, bool>(arg3));
        };
        0x2::linked_table::push_back<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, arg2), v0, true);
    }

    public fun order_exists(arg0: &Orderbook, arg1: u64) : bool {
        0x2::table::contains<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&arg0.open_orders, arg1)
    }

    fun pay_fee_if_necessary<T0>(arg0: &mut Orderbook, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        if (arg0.protocol_fee.fee_rate > 0) {
            let v1 = 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::math::mul_div(arg0.protocol_fee.fee_rate, 0x2::coin::value<T0>(arg1), 1000000, false);
            v0 = v1;
            if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.protocol_fee.vault, 0x1::type_name::get<T0>())) {
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fee.vault, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
            };
            0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.protocol_fee.vault, 0x1::type_name::get<T0>()), 0x2::coin::split<T0>(arg1, v1, arg2));
        };
        v0
    }

    public fun place_order<T0, T1>(arg0: &mut Orderbook, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: u64, arg5: u64, arg6: bool, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_version(arg0);
        assert!(0x2::coin::value<T0>(&arg7) > 0, 0);
        assert!(arg4 > 0, 0);
        assert!(arg5 == 0 || arg5 > 0x2::clock::timestamp_ms(arg8), 1);
        let v0 = 0x2::coin::value<T0>(&arg7);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = 0x1::option::destroy_with_default<address>(arg2, v1);
        let v3 = arg0.next_order_id;
        arg0.next_order_id = arg0.next_order_id + 1;
        inject_order(arg0, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::new<T0, T1>(v3, arg1, v1, v2, arg3, v0, arg4, arg5, arg6), v1, arg9);
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vault, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        0x2::coin::put<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0x1::type_name::get<T0>()), arg7);
        let v4 = OrderPlaced{
            order_id              : v3,
            client_order_id       : arg1,
            maker_asset           : 0x1::type_name::get<T0>(),
            taker_asset           : 0x1::type_name::get<T1>(),
            maker                 : v1,
            recipient             : v2,
            allowed_taker         : arg3,
            making_amount         : v0,
            taking_amount         : arg4,
            expires_timestamp     : arg5,
            allowed_partial_fills : arg6,
        };
        0x2::event::emit<OrderPlaced>(v4);
    }

    public fun protocol_fee_rate(arg0: &Orderbook) : u64 {
        arg0.protocol_fee.fee_rate
    }

    public fun protocol_fee_value<T0>(arg0: &Orderbook) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.protocol_fee.vault, 0x1::type_name::get<T0>()))
    }

    fun remove_order(arg0: &mut Orderbook, arg1: u64, arg2: address) : 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order {
        assert!(0x2::linked_table::contains<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, arg2), arg1), 3);
        0x2::linked_table::remove<u64, bool>(0x2::table::borrow_mut<address, 0x2::linked_table::LinkedTable<u64, bool>>(&mut arg0.user_open_orders, arg2), arg1);
        let v0 = 0x2::table::remove<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut arg0.open_orders, arg1);
        assert!(0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::maker(&v0) == arg2, 3);
        v0
    }

    public entry fun set_protocol_fee(arg0: &AdminCap, arg1: &mut Orderbook, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        check_version(arg1);
        assert!(arg2 <= 100000, 5);
        arg1.protocol_fee.fee_rate = arg2;
        let v0 = SetProtocolFeeRate{
            sender   : 0x2::tx_context::sender(arg3),
            fee_rate : arg2,
        };
        0x2::event::emit<SetProtocolFeeRate>(v0);
    }

    public fun size(arg0: &Orderbook) : u64 {
        0x2::table::length<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&arg0.open_orders)
    }

    public fun take_order<T0>(arg0: &mut Orderbook, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, TakeOrderReceipt) {
        check_version(arg0);
        check_order_exists(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::table::borrow_mut<u64, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::Order>(&mut arg0.open_orders, arg1);
        let v2 = 0x1::type_name::get<T0>();
        assert!(&v2 == 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::maker_asset(v1), 7);
        assert!(!0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::is_expired(v1, arg3), 4);
        assert!(0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::is_allowed_taker(v1, v0), 6);
        assert!(arg2 == 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remaining_amount(v1) || arg2 < 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remaining_amount(v1) && 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::is_allowed_partial_fills(v1), 0);
        let v3 = 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::math::mul_div(arg2, 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::original_taking_amount(v1), 0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::making_amount(v1), true);
        assert!(v3 > 0, 0);
        0x16e51f1dd07710bdb9a99939464d733c137925eb92533f9703d9108abe6148ce::order::remains(v1, arg2);
        let v4 = TakeOrderReceipt{
            order_id       : arg1,
            taker          : v0,
            filling_amount : arg2,
            taking_amount  : v3,
        };
        (0x2::coin::take<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vault, 0x1::type_name::get<T0>()), arg2, arg4), v4)
    }

    public entry fun upgrade(arg0: &AdminCap, arg1: &mut Orderbook) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

