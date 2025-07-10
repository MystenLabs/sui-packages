module 0xb573a182eeeb7d3badb985eebe7905258fd357f1346c71942d613bc44fc38457::tide_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct NewPool has copy, drop {
        pool: address,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
        feed_x: address,
        feed_y: address,
    }

    struct Swap has copy, drop {
        pool: address,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_out: u64,
        price_x: u256,
        price_y: u256,
        balance_x: u64,
        balance_y: u64,
    }

    public(friend) fun emit_new_pool(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: address, arg4: address) {
        let v0 = NewPool{
            pool   : arg0,
            coin_x : arg1,
            coin_y : arg2,
            feed_x : arg3,
            feed_y : arg4,
        };
        let v1 = Event<NewPool>{pos0: v0};
        0x2::event::emit<Event<NewPool>>(v1);
    }

    public(friend) fun emit_swap(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u256, arg7: u256, arg8: u64, arg9: u64) {
        let v0 = Swap{
            pool       : arg0,
            coin_in    : arg1,
            coin_out   : arg2,
            amount_in  : arg3,
            amount_out : arg4,
            fee_out    : arg5,
            price_x    : arg6,
            price_y    : arg7,
            balance_x  : arg8,
            balance_y  : arg9,
        };
        let v1 = Event<Swap>{pos0: v0};
        0x2::event::emit<Event<Swap>>(v1);
    }

    // decompiled from Move bytecode v6
}

