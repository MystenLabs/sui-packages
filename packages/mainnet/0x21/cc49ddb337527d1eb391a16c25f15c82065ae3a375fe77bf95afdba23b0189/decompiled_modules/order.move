module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::order {
    struct Order has drop, store {
        order_id: u64,
        offerer: address,
        offer: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
        consideration: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item,
        start_time: u64,
        end_time: u64,
        recipient: address,
    }

    public fun consideration(arg0: &Order) : &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item {
        &arg0.consideration
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: u64, arg3: u64, arg4: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, arg5: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item, arg6: address) : Order {
        Order{
            order_id      : arg0,
            offerer       : arg1,
            offer         : arg4,
            consideration : arg5,
            start_time    : arg2,
            end_time      : arg3,
            recipient     : arg6,
        }
    }

    public fun offer(arg0: &Order) : &0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item::Item {
        &arg0.offer
    }

    public fun offerer(arg0: &Order) : address {
        arg0.offerer
    }

    public fun order_end_time(arg0: &Order) : u64 {
        arg0.end_time
    }

    public fun order_id(arg0: &Order) : u64 {
        arg0.order_id
    }

    public fun order_start_time(arg0: &Order) : u64 {
        arg0.start_time
    }

    public fun recipient(arg0: &Order) : address {
        arg0.recipient
    }

    public(friend) fun set_order_id(arg0: &mut Order, arg1: u64) {
        arg0.order_id = arg1;
    }

    // decompiled from Move bytecode v6
}

