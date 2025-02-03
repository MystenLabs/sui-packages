module 0x696f867093729ce3c56f7fb2834ea2124021380562a0284cfc0a776f427acbfd::matched_order {
    struct MatchedOrder has copy, drop, store {
        order_id: u64,
        quantity: u64,
        price: u64,
        is_bid: bool,
    }

    public(friend) fun burn(arg0: MatchedOrder) : (u64, u64, u64, bool) {
        let MatchedOrder {
            order_id : v0,
            quantity : v1,
            price    : v2,
            is_bid   : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun info(arg0: &MatchedOrder) : (u64, u64, u64, bool) {
        (arg0.order_id, arg0.quantity, arg0.price, arg0.is_bid)
    }

    public(friend) fun mint(arg0: u64, arg1: u64, arg2: u64, arg3: bool) : MatchedOrder {
        MatchedOrder{
            order_id : arg0,
            quantity : arg1,
            price    : arg2,
            is_bid   : arg3,
        }
    }

    public(friend) fun update_quantity(arg0: &mut MatchedOrder, arg1: u64) {
        arg0.quantity = arg1;
    }

    // decompiled from Move bytecode v6
}

