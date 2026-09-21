module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::order {
    struct Order has copy, drop {
        id: u256,
    }

    fun assert_valid(arg0: &Order) {
        assert!(arg0.id >> 132 == 0, 0);
        assert!(quantity_lots(arg0) > 0, 3);
        assert_valid_order_shape(lower_tick(arg0), higher_tick(arg0));
    }

    fun assert_valid_order_shape(arg0: u64, arg1: u64) {
        let v0 = 1073741823;
        assert!(arg0 <= v0, 1);
        assert!(arg1 <= v0, 1);
        assert!(arg0 < arg1, 2);
        let v1 = arg0 == 0 && arg1 == v0;
        assert!(!v1, 2);
    }

    public(friend) fun assert_valid_quantity(arg0: u64) {
        let v0 = 10000;
        assert!(arg0 > 0 && arg0 % v0 == 0, 3);
        assert!(arg0 / v0 <= (4294967295 as u64), 3);
    }

    fun decode_tick(arg0: u256, arg1: u8) : u64 {
        ((arg0 >> arg1 & 1073741823) as u64)
    }

    public(friend) fun from_order_id(arg0: u256) : Order {
        let v0 = Order{id: arg0};
        assert_valid(&v0);
        v0
    }

    public(friend) fun higher_tick(arg0: &Order) : u64 {
        decode_tick(arg0.id, 40)
    }

    public(friend) fun id(arg0: &Order) : u256 {
        arg0.id
    }

    public(friend) fun lower_tick(arg0: &Order) : u64 {
        decode_tick(arg0.id, 70)
    }

    public(friend) fun max_quantity_lots() : u64 {
        (4294967295 as u64)
    }

    fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Order {
        assert!(arg0 <= 1073741823, 1);
        assert!(arg1 <= 1073741823, 1);
        assert!(arg2 > 0 && arg2 <= (4294967295 as u64), 3);
        assert!(arg3 <= (1099511627775 as u64), 4);
        assert_valid_order_shape(arg0, arg1);
        Order{id: (arg2 as u256) << 100 | (arg0 as u256) << 70 | (arg1 as u256) << 40 | (arg3 as u256)}
    }

    public(friend) fun new_from_ticks(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : Order {
        new(arg0, arg1, quantity_lots_from_quantity(arg2), arg3)
    }

    public(friend) fun quantity(arg0: &Order) : u64 {
        quantity_lots(arg0) * 10000
    }

    fun quantity_lots(arg0: &Order) : u64 {
        ((arg0.id >> 100 & 4294967295) as u64)
    }

    fun quantity_lots_from_quantity(arg0: u64) : u64 {
        assert_valid_quantity(arg0);
        arg0 / 10000
    }

    public(friend) fun replacement(arg0: &Order, arg1: u64, arg2: u64) : Order {
        assert!(arg1 < quantity(arg0), 3);
        new_from_ticks(lower_tick(arg0), higher_tick(arg0), arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

