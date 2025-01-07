module 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::venue {
    struct Venue<phantom T0> has store, key {
        id: 0x2::object::UID,
        sale_start_time: u64,
        sale_duration: u64,
        sale_end_time: u64,
        price: u64,
        qty_sold: u64,
        sales_cap: u64,
        max_purchase_qty: u64,
        users_purchased_qty: 0x2::table::Table<address, u64>,
        whitelist: 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist::Whitelist,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Venue<T0> {
        assert!(0x2::clock::timestamp_ms(arg5) < arg0 && arg1 > 0, 1);
        assert!(arg3 > 0, 7);
        Venue<T0>{
            id                  : 0x2::object::new(arg6),
            sale_start_time     : arg0,
            sale_duration       : arg1,
            sale_end_time       : arg0 + arg1,
            price               : arg2,
            qty_sold            : 0,
            sales_cap           : arg3,
            max_purchase_qty    : arg4,
            users_purchased_qty : 0x2::table::new<address, u64>(arg6),
            whitelist           : 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist::new(arg6),
        }
    }

    public fun assert_is_allowed<T0>(arg0: &Venue<T0>, arg1: address) {
        assert!(is_allowed<T0>(arg0, arg1), 6);
    }

    public fun assert_is_live<T0>(arg0: &Venue<T0>, arg1: &0x2::clock::Clock) {
        assert!(is_live<T0>(arg0, arg1), 5);
    }

    public(friend) fun borrow_whitelist_mut<T0>(arg0: &mut Venue<T0>) : &mut 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist::Whitelist {
        &mut arg0.whitelist
    }

    public(friend) fun decrease_sale_duration<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = arg0.sale_end_time - arg1;
        assert!(0x2::clock::timestamp_ms(arg2) < v0 && arg0.sale_duration > arg1, 4);
        arg0.sale_duration = arg0.sale_duration - arg1;
        arg0.sale_end_time = v0;
    }

    public(friend) fun increase_sale_duration<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.sale_end_time, 3);
        arg0.sale_duration = arg0.sale_duration + arg1;
        arg0.sale_end_time = arg0.sale_start_time + arg0.sale_duration;
    }

    public fun is_allowed<T0>(arg0: &Venue<T0>, arg1: address) : bool {
        0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist::is_empty(&arg0.whitelist) || 0x7a6a0d7178c1cbc70e2c8c6c0c251adc350f08ad129ed566bbb15e1053c77105::market_whitelist::is_whitelisted(&arg0.whitelist, arg1)
    }

    public fun is_live<T0>(arg0: &Venue<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        v0 >= arg0.sale_start_time && v0 < arg0.sale_end_time
    }

    public fun max_purchase_qty<T0>(arg0: &Venue<T0>) : u64 {
        arg0.max_purchase_qty
    }

    public fun price<T0>(arg0: &Venue<T0>) : u64 {
        arg0.price
    }

    public fun qty_sold<T0>(arg0: &Venue<T0>) : u64 {
        arg0.qty_sold
    }

    public fun sale_duration<T0>(arg0: &Venue<T0>) : u64 {
        arg0.sale_duration
    }

    public fun sale_end_time<T0>(arg0: &Venue<T0>) : u64 {
        arg0.sale_end_time
    }

    public fun sale_start_time<T0>(arg0: &Venue<T0>) : u64 {
        arg0.sale_start_time
    }

    public fun sales_cap<T0>(arg0: &Venue<T0>) : u64 {
        arg0.sales_cap
    }

    public(friend) fun sell<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: address) {
        arg0.qty_sold = arg0.qty_sold + arg1;
        assert!(arg0.qty_sold <= arg0.sales_cap, 8);
        if (!0x2::table::contains<address, u64>(&arg0.users_purchased_qty, arg2)) {
            0x2::table::add<address, u64>(&mut arg0.users_purchased_qty, arg2, 0);
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.users_purchased_qty, arg2);
        *v0 = *v0 + arg1;
        assert!(arg0.max_purchase_qty == 0 || *v0 <= arg0.max_purchase_qty, 9);
    }

    public(friend) fun set_max_purchase_qty<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.sale_end_time, 3);
        arg0.max_purchase_qty = arg1;
    }

    public(friend) fun set_sale_start_time<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.sale_start_time, 2);
        assert!(0x2::clock::timestamp_ms(arg2) < arg1, 1);
        arg0.sale_start_time = arg1;
        arg0.sale_end_time = arg0.sale_start_time + arg0.sale_duration;
    }

    public(friend) fun set_sales_cap<T0>(arg0: &mut Venue<T0>, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.sale_end_time, 3);
        assert!(arg1 >= arg0.qty_sold, 7);
        arg0.sales_cap = arg1;
    }

    public fun users_purchased_qty<T0>(arg0: &Venue<T0>) : &0x2::table::Table<address, u64> {
        &arg0.users_purchased_qty
    }

    // decompiled from Move bytecode v6
}

