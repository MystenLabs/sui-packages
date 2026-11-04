module 0x24ffb8ac5013e626ada5afe019d412a293570a9340b2219021e0eaeaa4b24345::subs {
    struct Subscribed has copy, drop {
        streamer: address,
        subscriber: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        to_streamer: u64,
        fee: u64,
        l1: 0x1::option::Option<address>,
        to_l1: u64,
        l2: 0x1::option::Option<address>,
        to_l2: u64,
        to_treasury: u64,
        months: u64,
    }

    public fun max_months() : u64 {
        12
    }

    public fun subscribe<T0>(arg0: &0x24ffb8ac5013e626ada5afe019d412a293570a9340b2219021e0eaeaa4b24345::tips::Config, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x24ffb8ac5013e626ada5afe019d412a293570a9340b2219021e0eaeaa4b24345::tips::assert_live(arg0);
        assert!(arg3 > 0, 0);
        assert!(arg3 <= 12, 1);
        let (v0, v1, v2, v3, v4, v5, v6, v7) = 0x24ffb8ac5013e626ada5afe019d412a293570a9340b2219021e0eaeaa4b24345::tips::pay_sub<T0>(arg0, arg1, arg2, arg4);
        let v8 = Subscribed{
            streamer    : arg2,
            subscriber  : 0x2::tx_context::sender(arg4),
            coin_type   : 0x1::type_name::with_defining_ids<T0>(),
            amount      : v0,
            to_streamer : v1,
            fee         : v2,
            l1          : v3,
            to_l1       : v4,
            l2          : v5,
            to_l2       : v6,
            to_treasury : v7,
            months      : arg3,
        };
        0x2::event::emit<Subscribed>(v8);
    }

    // decompiled from Move bytecode v7
}

