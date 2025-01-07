module 0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::turbospump_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        buy_fee: u64,
        sell_fee: u64,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
        amount_out: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg3 * arg0.buy_fee / 10000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 2);
        let v1 = arg3 - v0;
        let (v2, v3) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::buy_with_return<T0>(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg7), v1, arg4, true, arg5, arg7);
        let v4 = v3;
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v4, 0x2::tx_context::sender(arg7));
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg7), arg0.admin);
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg7));
        let v5 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : v1,
            amount_out : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<BuyEvent<T0>>(v5);
        let v6 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 90,
            sell_fee : 90,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let (v0, v1) = 0x96e1396c8a771c8ae404b86328dc27e7b66af39847a31926980c96dbc1096a15::turbospump::sell_with_return<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg3, arg4, true, arg5, arg7);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = v3 * arg0.sell_fee / 10000;
        assert!(v3 - v4 >= arg4, 1);
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg7));
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0x59e5bcc6ba14f32fdf96bc276d00509479e6867762ab8f782ffb071134337ff1::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg7), arg0.admin);
        let v5 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg3,
            amount_out : v3 - v4,
        };
        0x2::event::emit<SellEvent<T0>>(v5);
        let v6 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v4,
        };
        0x2::event::emit<FeeCollectedEvent>(v6);
        let v7 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

