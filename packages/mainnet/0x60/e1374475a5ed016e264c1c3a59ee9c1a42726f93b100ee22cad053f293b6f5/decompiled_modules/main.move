module 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::main {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        version: u64,
        deposit_id: u128,
        nid: 0x1::string::String,
        connection: 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::ConnectionState,
        orders: 0x2::table::Table<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>,
        finished_orders: 0x2::table::Table<vector<u8>, bool>,
        fee: u8,
        fee_handler: address,
        funds: 0x2::bag::Bag,
    }

    struct OrderFilled has copy, drop {
        id: u128,
        src_nid: 0x1::string::String,
        fee: u128,
        to_amount: u128,
        solver: 0x1::string::String,
    }

    struct OrderCancelled has copy, drop {
        id: u128,
        src_nid: 0x1::string::String,
        order_bytes: vector<u8>,
    }

    struct OrderClosed has copy, drop {
        id: u128,
    }

    struct Params has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    entry fun swap<T0>(arg0: &mut Storage, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<T0>, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u128, arg6: vector<u8>, arg7: &0x2::tx_context::TxContext) {
        let v0 = get_next_deposit_id(arg0);
        let v1 = get_id(arg0);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::new(v0, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::id_to_hex_string(&v1), arg0.nid, arg1, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::address_to_hex_string(&v2), arg4, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::get_type_string<T0>(), (0x2::coin::value<T0>(&arg2) as u128), arg3, arg5, arg6);
        0x2::bag::add<u128, 0x2::coin::Coin<T0>>(&mut arg0.funds, v0, arg2);
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::emit(v3);
        0x2::table::add<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(&mut arg0.orders, v0, v3);
    }

    entry fun get_receipt(arg0: &Storage, arg1: 0x1::string::String, arg2: u128) : bool {
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::get_receipt(&arg0.connection, arg1, arg2)
    }

    public fun get_relayer(arg0: &Storage) : address {
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::get_relayer(&arg0.connection)
    }

    entry fun receive_message<T0>(arg0: &mut Storage, arg1: 0x1::string::String, arg2: u128, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = get_connection_state_mut(arg0);
        let v1 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::receive_message(v0, arg1, arg2, arg3, arg4);
        if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_type(&v1) == 1) {
            let v2 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_message(&v1);
            let v3 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::decode(&v2);
            resolve_fill<T0>(arg0, arg1, &v3, arg4);
        } else if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_type(&v1) == 2) {
            let v4 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_message(&v1);
            let v5 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::decode(&v4);
            resolve_cancel(arg0, arg1, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::get_order_bytes(&v5), arg4);
        };
    }

    entry fun set_relayer(arg0: &mut Storage, arg1: &AdminCap, arg2: address) {
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::set_relayer(get_connection_state_mut(arg0), arg2);
    }

    entry fun cancel(arg0: &mut Storage, arg1: u128, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(&arg0.orders, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_creator(v0) == 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::address_to_hex_string(&v1), 9223373544388296703);
        let v2 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_dst_nid(v0);
        let v3 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::new(2, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::encode(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::new(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::encode(v0))));
        if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(v0) == v2) {
            let v4 = arg0.nid;
            let v5 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::encode(0x2::table::borrow<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(&arg0.orders, arg1));
            resolve_cancel(arg0, v4, v5, arg2);
        } else {
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::send_message(get_connection_state_mut(arg0), v2, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::encode(&v3));
        };
    }

    entry fun fill<T0, T1>(arg0: &mut Storage, arg1: u128, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: u128, arg9: 0x1::string::String, arg10: u128, arg11: vector<u8>, arg12: 0x2::coin::Coin<T1>, arg13: 0x1::string::String, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::new(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v1 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::encode(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.finished_orders, v2), 1);
        assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::get_type_string<T1>() == 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_to_token(&v0), 2);
        assert!((0x2::coin::value<T1>(&arg12) as u128) == 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_to_amount(&v0), 3);
        0x2::table::add<vector<u8>, bool>(&mut arg0.finished_orders, v2, true);
        let v3 = 0x2::coin::value<T1>(&arg12) * (arg0.fee as u64) / 10000;
        let v4 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::new(arg1, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::encode(&v0), arg13);
        let v5 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::new(1, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::encode(&v4));
        let v6 = OrderFilled{
            id        : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_id(&v0),
            src_nid   : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v0),
            fee       : (v3 as u128),
            to_amount : (0x2::coin::value<T1>(&arg12) as u128),
            solver    : arg13,
        };
        0x2::event::emit<OrderFilled>(v6);
        let v7 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_destination_address(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg12, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::address_from_str(&v7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg12, v3, arg14), arg0.fee_handler);
        if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v0) == 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_dst_nid(&v0)) {
            resolve_fill<T0>(arg0, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v0), &v4, arg14);
        } else {
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::send_message(get_connection_state_mut(arg0), 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v0), 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::encode(&v5));
        };
    }

    fun get_connection_state_mut(arg0: &mut Storage) : &mut 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::ConnectionState {
        &mut arg0.connection
    }

    public entry fun get_deposit_id(arg0: &Storage) : u128 {
        arg0.deposit_id
    }

    public fun get_finished_orders(arg0: &Storage) : &0x2::table::Table<vector<u8>, bool> {
        &arg0.finished_orders
    }

    public fun get_funds(arg0: &Storage) : &0x2::bag::Bag {
        &arg0.funds
    }

    public fun get_id(arg0: &Storage) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun get_next_deposit_id(arg0: &mut Storage) : u128 {
        let v0 = arg0.deposit_id + 1;
        arg0.deposit_id = v0;
        v0
    }

    public entry fun get_order(arg0: &Storage, arg1: u128) : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder {
        *0x2::table::borrow<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(&arg0.orders, arg1)
    }

    public entry fun get_protocol_fee(arg0: &Storage) : u8 {
        arg0.fee
    }

    entry fun get_receive_msg_args(arg0: &Storage, arg1: vector<u8>) : Params {
        let v0 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::decode(&arg1);
        let v1 = if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_type(&v0) == 1) {
            let v2 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_message(&v0);
            let v3 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::decode(&v2);
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_order_bytes(&v3)
        } else {
            assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_type(&v0) == 2, 4);
            let v4 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::get_message(&v0);
            let v5 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::decode(&v4);
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_cancel::get_order_bytes(&v5)
        };
        let v6 = v1;
        let v7 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::decode(&v6);
        let v8 = if (0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v7) == 0x1::string::utf8(b"sui")) {
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_token(&v7)
        } else {
            0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_to_token(&v7)
        };
        let v9 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v9, v8);
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = get_id(arg0);
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::id_to_hex_string(&v11));
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"srcNid"));
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"conn_sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v10, 0x1::string::utf8(b"msg"));
        Params{
            type_args : v9,
            args      : v10,
        }
    }

    public fun get_type_args(arg0: &Params) : vector<0x1::string::String> {
        arg0.type_args
    }

    public fun get_version(arg0: &Storage) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Storage{
            id              : 0x2::object::new(arg0),
            version         : 1,
            deposit_id      : 0,
            nid             : 0x1::string::utf8(b"sui"),
            connection      : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::new(0x2::tx_context::sender(arg0), arg0),
            orders          : 0x2::table::new<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(arg0),
            finished_orders : 0x2::table::new<vector<u8>, bool>(arg0),
            fee             : 1,
            fee_handler     : 0x2::tx_context::sender(arg0),
            funds           : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Storage>(v1);
    }

    fun resolve_cancel(arg0: &mut Storage, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::hash::keccak256(&arg2);
        let v1 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::decode(&arg2);
        assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v1) == arg1, 5);
        assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_dst_nid(&v1) == arg0.nid, 6);
        if (0x2::table::contains<vector<u8>, bool>(&arg0.finished_orders, v0)) {
            abort 1
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.finished_orders, v0, true);
        let v2 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::new(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_id(&v1), arg2, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_creator(&v1));
        let v3 = OrderCancelled{
            id          : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_id(&v1),
            src_nid     : 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v1),
            order_bytes : arg2,
        };
        0x2::event::emit<OrderCancelled>(v3);
        let v4 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::new(1, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::encode(&v2));
        0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::cluster_connection::send_message(get_connection_state_mut(arg0), 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_src_nid(&v1), 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_message::encode(&v4));
    }

    fun resolve_fill<T0>(arg0: &mut Storage, arg1: 0x1::string::String, arg2: &0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::OrderFill, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::remove<u128, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::SwapOrder>(&mut arg0.orders, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_id(arg2));
        let v1 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::encode(&v0);
        let v2 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_order_bytes(arg2);
        assert!(0x2::hash::keccak256(&v1) == 0x2::hash::keccak256(&v2), 9223372573725687807);
        assert!(0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::swap_order::get_dst_nid(&v0) == arg1, 9223372578020655103);
        let v3 = OrderClosed{id: 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_id(arg2)};
        0x2::event::emit<OrderClosed>(v3);
        let v4 = 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_solver(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<u128, 0x2::coin::Coin<T0>>(&mut arg0.funds, 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::order_fill::get_id(arg2)), 0xbf8044a8f498b43e48ad9ad8a7d23027a45255903e8b4765dda38da2d1b89600::utils::address_from_str(&v4));
    }

    entry fun set_fee(arg0: &mut Storage, arg1: &AdminCap, arg2: u8) {
        arg0.fee = arg2;
    }

    entry fun set_fee_handler(arg0: &mut Storage, arg1: &AdminCap, arg2: address) {
        arg0.fee_handler = arg2;
    }

    // decompiled from Move bytecode v6
}

