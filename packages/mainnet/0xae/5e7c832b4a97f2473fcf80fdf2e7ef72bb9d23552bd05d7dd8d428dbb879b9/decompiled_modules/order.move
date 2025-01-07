module 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order {
    struct Operation has copy, drop, store {
        type: u64,
        data: vector<u8>,
    }

    struct Order has drop, store {
        operations: vector<Operation>,
        creator: address,
        approves: 0x2::vec_set::VecSet<address>,
        againsts: 0x2::vec_set::VecSet<address>,
    }

    struct OrderBook has store {
        min_sn: u64,
        max_sn: u64,
        pendings: 0x2::table::Table<u64, Order>,
    }

    public(friend) fun add_order(arg0: &mut OrderBook, arg1: vector<Operation>, arg2: address) : u64 {
        let v0 = arg0.max_sn;
        0x2::table::add<u64, Order>(&mut arg0.pendings, v0, new_order(arg1, arg2));
        arg0.max_sn = arg0.max_sn + 1;
        assert!(arg0.max_sn - arg0.min_sn <= 128, 1004);
        v0
    }

    public fun can_be_timelock_operation(arg0: &Operation) : bool {
        if (is_recovery_operation(arg0)) {
            return true
        };
        if (is_admin_operation(arg0)) {
            let v0 = get_sub_type(arg0);
            return 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_permission_range_operation(v0) || 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_role_range_operation(v0) || 0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::admin_operation::is_policy_range_operation(v0)
        };
        false
    }

    public fun get_last_sn(arg0: &OrderBook) : u64 {
        arg0.max_sn - 1
    }

    fun get_main_type(arg0: &Operation) : u64 {
        arg0.type >> 32
    }

    public fun get_op_data(arg0: &Operation) : vector<u8> {
        arg0.data
    }

    public fun get_operation(arg0: &Order, arg1: u64) : &Operation {
        0x1::vector::borrow<Operation>(&arg0.operations, arg1)
    }

    public fun get_operation_count(arg0: &Order) : u64 {
        0x1::vector::length<Operation>(&arg0.operations)
    }

    public fun get_operations(arg0: &Order) : vector<Operation> {
        arg0.operations
    }

    public(friend) fun get_order_mut(arg0: &mut OrderBook, arg1: u64) : &mut Order {
        assert!(0x2::table::contains<u64, Order>(&arg0.pendings, arg1), 1006);
        0x2::table::borrow_mut<u64, Order>(&mut arg0.pendings, arg1)
    }

    public fun get_order_rd(arg0: &OrderBook, arg1: u64) : &Order {
        0x2::table::borrow<u64, Order>(&arg0.pendings, arg1)
    }

    public fun get_sn_rd(arg0: &OrderBook) : (u64, u64, u64) {
        (arg0.min_sn, arg0.max_sn, arg0.max_sn - 1)
    }

    public fun get_sub_type(arg0: &Operation) : u64 {
        arg0.type & 4294967295
    }

    public fun is_admin_operation(arg0: &Operation) : bool {
        get_main_type(arg0) == 0
    }

    public fun is_coin_operation(arg0: &Operation) : bool {
        get_main_type(arg0) == 1
    }

    public fun is_object_operation(arg0: &Operation) : bool {
        get_main_type(arg0) == 2
    }

    public fun is_recovery_operation(arg0: &Operation) : bool {
        get_main_type(arg0) == 3
    }

    public fun new_operation(arg0: u64, arg1: vector<u8>) : Operation {
        Operation{
            type : arg0,
            data : arg1,
        }
    }

    public fun new_order(arg0: vector<Operation>, arg1: address) : Order {
        assert!(0x1::vector::length<Operation>(&arg0) < 64, 1002);
        Order{
            operations : arg0,
            creator    : arg1,
            approves   : 0x2::vec_set::empty<address>(),
            againsts   : 0x2::vec_set::empty<address>(),
        }
    }

    public fun new_order_book(arg0: &mut 0x2::tx_context::TxContext) : OrderBook {
        OrderBook{
            min_sn   : 0,
            max_sn   : 0,
            pendings : 0x2::table::new<u64, Order>(arg0),
        }
    }

    public fun new_valid_operations(arg0: vector<u64>, arg1: vector<vector<u8>>, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) : vector<Operation> {
        assert!(0x1::vector::length<u64>(&arg0) > 0, 1000);
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 1000);
        let v0 = Operation{
            type : *0x1::vector::borrow<u64>(&arg0, 0),
            data : *0x1::vector::borrow<vector<u8>>(&arg1, 0),
        };
        let v1 = 0x1::vector::empty<Operation>();
        0x1::vector::push_back<Operation>(&mut v1, v0);
        let v2 = 0x1::vector::length<u8>(&v0.data) + 8 * 0x1::vector::length<u64>(&arg0);
        let v3 = get_main_type(&v0);
        validate_opertaion(&v0, v3, arg2);
        let v4 = 0x1::vector::length<Operation>(&v1);
        while (v4 < 0x1::vector::length<u64>(&arg0)) {
            let v5 = *0x1::vector::borrow<vector<u8>>(&arg1, v4);
            v2 = v2 + 0x1::vector::length<u8>(&v5);
            assert!(v2 <= 65536, 1003);
            let v6 = new_operation(*0x1::vector::borrow<u64>(&arg0, v4), v5);
            validate_opertaion(&v6, v3, arg2);
            0x1::vector::push_back<Operation>(&mut v1, v6);
            v4 = v4 + 1;
        };
        v1
    }

    public(friend) fun pop_min_order(arg0: &mut OrderBook) : (Order, u64) {
        arg0.min_sn = arg0.min_sn + 1;
        (0x2::table::remove<u64, Order>(&mut arg0.pendings, arg0.min_sn), arg0.min_sn)
    }

    public fun signers_of_order(arg0: &Order) : (address, vector<address>, vector<address>) {
        (arg0.creator, 0x2::vec_set::into_keys<address>(arg0.approves), 0x2::vec_set::into_keys<address>(arg0.againsts))
    }

    fun validate_opertaion(arg0: &Operation, arg1: u64, arg2: &0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::OrderContext) {
        assert!(get_main_type(arg0) == arg1, 1001);
        if (0xae5e7c832b4a97f2473fcf80fdf2e7ef72bb9d23552bd05d7dd8d428dbb879b9::order_context::in_timelock_mode(arg2)) {
            assert!(can_be_timelock_operation(arg0), 1007);
        } else {
            assert!(!is_recovery_operation(arg0), 1008);
        };
    }

    public(friend) fun vote(arg0: &mut Order, arg1: address, arg2: bool) {
        if (arg2) {
            0x2::vec_set::insert<address>(&mut arg0.approves, arg1);
            assert!(0x2::vec_set::size<address>(&arg0.approves) <= 256, 1005);
            if (0x2::vec_set::contains<address>(&arg0.againsts, &arg1)) {
                0x2::vec_set::remove<address>(&mut arg0.againsts, &arg1);
            };
        } else {
            0x2::vec_set::insert<address>(&mut arg0.againsts, arg1);
            assert!(0x2::vec_set::size<address>(&arg0.againsts) <= 256, 1005);
            if (0x2::vec_set::contains<address>(&arg0.approves, &arg1)) {
                0x2::vec_set::remove<address>(&mut arg0.approves, &arg1);
            };
        };
    }

    // decompiled from Move bytecode v6
}

