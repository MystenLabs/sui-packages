module 0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::suiai_router {
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
    }

    struct SellEvent<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        recipient: address,
        amount: u64,
        order_id: 0x1::string::String,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg2: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::Pool<T0>, arg3: 0x2::coin::Coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = arg4 * arg0.buy_fee / 10000;
        assert!(0x2::coin::value<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&arg3) >= arg4, 2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::buy<T0>(arg1, arg2, arg5, 0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg3, arg4 - v0, arg7), arg7);
        0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg3, v0, arg7), arg0.admin);
        0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(arg3, 0x2::tx_context::sender(arg7));
        let v1 = BuyEvent<T0>{
            recipient : 0x2::tx_context::sender(arg7),
            amount_in : arg4 - v0,
        };
        0x2::event::emit<BuyEvent<T0>>(v1);
        let v2 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
            order_id  : arg6,
        };
        0x2::event::emit<FeeCollectedEvent>(v2);
        let v3 = OrderCompletedEvent{order_id: arg6};
        0x2::event::emit<OrderCompletedEvent>(v3);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun collect_fee(arg0: &FeeObject, arg1: 0x2::coin::Coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&arg1) >= arg2, 2);
        0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg1, arg2, arg4), arg0.admin);
        0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : arg2,
            order_id  : arg3,
        };
        0x2::event::emit<FeeCollectedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id       : 0x2::object::new(arg0),
            buy_fee  : 100,
            sell_fee : 100,
            admin    : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::sell<T0>(arg0, arg1, arg4, 0x2::coin::split<T0>(&mut arg2, arg3, arg6), arg6);
        0x15b47cb3a43d05b4e479190d9120ece9d3e37812ec9d8d0a62159912a0f172f0::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        let v0 = SellEvent<T0>{
            recipient : 0x2::tx_context::sender(arg6),
            amount_in : arg3,
        };
        0x2::event::emit<SellEvent<T0>>(v0);
        let v1 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

