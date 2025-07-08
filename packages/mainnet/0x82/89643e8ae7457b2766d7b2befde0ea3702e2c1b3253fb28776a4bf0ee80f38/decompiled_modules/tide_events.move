module 0x8289643e8ae7457b2766d7b2befde0ea3702e2c1b3253fb28776a4bf0ee80f38::tide_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct NewPool has copy, drop {
        pool: address,
        coin_x: 0x1::type_name::TypeName,
        coin_y: 0x1::type_name::TypeName,
    }

    struct Swap has copy, drop {
        pool: address,
        coinIn: 0x1::type_name::TypeName,
        coinOut: 0x1::type_name::TypeName,
        amountIn: u64,
        amountOut: u64,
        fee: u64,
        balance_x: u64,
        balance_y: u64,
    }

    public(friend) fun emit_new_pool(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) {
        let v0 = NewPool{
            pool   : arg0,
            coin_x : arg1,
            coin_y : arg2,
        };
        let v1 = Event<NewPool>{pos0: v0};
        0x2::event::emit<Event<NewPool>>(v1);
    }

    public(friend) fun emit_swap(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = Swap{
            pool      : arg0,
            coinIn    : arg1,
            coinOut   : arg2,
            amountIn  : arg3,
            amountOut : arg4,
            fee       : arg5,
            balance_x : arg6,
            balance_y : arg7,
        };
        let v1 = Event<Swap>{pos0: v0};
        0x2::event::emit<Event<Swap>>(v1);
    }

    // decompiled from Move bytecode v6
}

