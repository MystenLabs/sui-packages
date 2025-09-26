module 0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::order {
    struct NewOrderEvent has copy, drop {
        object: address,
        service: address,
        progress: 0x1::option::Option<address>,
        amount: u64,
    }

    struct Item has copy, drop, store {
        name: 0x1::string::String,
        endpoint: 0x1::option::Option<0x1::string::String>,
        price: u64,
        stock: u64,
    }

    public fun AGENT_COUNT(arg0: u64) {
        assert!(arg0 <= 8, 1506);
    }

    public fun ASSERT_DISCOUNT_NEW(arg0: &0x1::string::String, arg1: u8, arg2: u64) {
        0xc20a07cf9f9a20d1880ea8bbb83cd0f97a9fe3ebff8e9c74cb2ba7929f9bf85d::common::ASSERT_NAMELEN(arg0);
        DNT_TYPE(arg1);
        if (arg1 == DISCOUNT_TYPE_OFF_RATIO()) {
            DNT_OFF(arg2);
        };
    }

    public fun DISCOUNT_TYPE_MINUS() : u8 {
        1
    }

    public fun DISCOUNT_TYPE_OFF_RATIO() : u8 {
        0
    }

    public fun DNT_COUNT(arg0: u64) {
        assert!(arg0 < 8, 1502);
    }

    public fun DNT_OFF(arg0: u64) {
        assert!(arg0 <= 10000, 1501);
    }

    public fun DNT_TYPE(arg0: u8) {
        assert!(arg0 == 0 || arg0 == 1, 1500);
    }

    public fun DNT_TYPE2() {
        abort 1500
    }

    public fun Item_endpoint(arg0: &Item) : &0x1::option::Option<0x1::string::String> {
        &arg0.endpoint
    }

    public fun Item_find(arg0: &vector<Item>, arg1: &0x1::string::String) : (bool, u64, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Item>(arg0)) {
            let v1 = 0x1::vector::borrow<Item>(arg0, v0);
            if (v1.name == *arg1) {
                return (true, v1.price, v1.stock)
            };
            v0 = v0 + 1;
        };
        ORDER_ITEM_NOT_FOUND();
        (false, 0, 0)
    }

    public fun Item_name(arg0: &Item) : &0x1::string::String {
        &arg0.name
    }

    public fun Item_new(arg0: &0x1::string::String, arg1: &0x1::option::Option<0x1::string::String>, arg2: u64, arg3: u64) : Item {
        Item{
            name     : *arg0,
            endpoint : *arg1,
            price    : arg2,
            stock    : arg3,
        }
    }

    public fun Item_price(arg0: &Item) : u64 {
        arg0.price
    }

    public fun Item_price_set(arg0: &mut Item, arg1: u64) {
        arg0.price = arg1;
    }

    public fun Item_sock_set(arg0: &mut Item, arg1: u64) {
        arg0.stock = arg1;
    }

    public fun Item_stock(arg0: &Item) : u64 {
        arg0.stock
    }

    public fun NewOrderEvent_emit(arg0: &address, arg1: &address, arg2: &0x1::option::Option<address>, arg3: u64) {
        let v0 = NewOrderEvent{
            object   : *arg0,
            service  : *arg1,
            progress : *arg2,
            amount   : arg3,
        };
        0x2::event::emit<NewOrderEvent>(v0);
    }

    public fun ORDER_ITEM_NOT_FOUND() {
        abort 1508
    }

    public fun ORD_COIN(arg0: bool) {
        assert!(arg0, 1505);
    }

    public fun ORD_PAYER(arg0: bool) {
        assert!(arg0, 1504);
    }

    public fun ORD_PERM(arg0: bool) {
        assert!(arg0, 1503);
    }

    public fun PROGRESS(arg0: bool) {
        assert!(arg0, 1507);
    }

    // decompiled from Move bytecode v6
}

