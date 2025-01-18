module 0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::suiai_router {
    struct FeeObject has key {
        id: 0x2::object::UID,
        admin: address,
        balance_suai: 0x2::balance::Balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>,
        balance_sui: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BuyEventV1<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
    }

    struct BuyEventV2<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
    }

    struct SellEventV1<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
    }

    struct SellEventV2<phantom T0> has copy, drop {
        recipient: address,
        amount_in: u64,
    }

    struct FeeCollectedEventV1 has copy, drop {
        recipient: address,
        amount: u64,
        order_id: 0x1::string::String,
    }

    struct FeeCollectedEventV2 has copy, drop {
        recipient: address,
        amount: u64,
        order_id: 0x1::string::String,
    }

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in_v1<T0>(arg0: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::Pool<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::buy<T0>(arg0, arg1, arg4, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3, arg6), arg6);
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg6));
        let v0 = BuyEventV1<T0>{
            recipient : 0x2::tx_context::sender(arg6),
            amount_in : arg3,
        };
        0x2::event::emit<BuyEventV1<T0>>(v0);
        let v1 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v1);
    }

    public entry fun buy_exact_in_v2<T0>(arg0: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::Pool<T0>, arg2: 0x2::coin::Coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&arg2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::buy<T0>(arg0, arg1, arg3, 0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg2, v0, arg5), arg5);
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(arg2, 0x2::tx_context::sender(arg5));
        let v1 = BuyEventV2<T0>{
            recipient : 0x2::tx_context::sender(arg5),
            amount_in : v0,
        };
        0x2::event::emit<BuyEventV2<T0>>(v1);
        let v2 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v2);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
    }

    public entry fun collect_fees(arg0: &mut FeeObject, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::from_balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::balance::withdraw_all<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg0.balance_suai), arg1), 0x2::tx_context::sender(arg1));
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0x2::sui::SUI>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance_sui), arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeObject{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            balance_suai : 0x2::balance::zero<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(),
            balance_sui  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<FeeObject>(v1);
    }

    public entry fun pay_fee_v1(arg0: &mut FeeObject, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg4)));
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0x2::sui::SUI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = FeeCollectedEventV1{
            recipient : arg0.admin,
            amount    : arg2,
            order_id  : arg3,
        };
        0x2::event::emit<FeeCollectedEventV1>(v0);
    }

    public entry fun pay_fee_v2(arg0: &mut FeeObject, arg1: 0x2::coin::Coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&arg1) >= arg2, 2);
        0x2::balance::join<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg0.balance_suai, 0x2::coin::into_balance<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(0x2::coin::split<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(&mut arg1, arg2, arg4)));
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = FeeCollectedEventV2{
            recipient : arg0.admin,
            amount    : arg2,
            order_id  : arg3,
        };
        0x2::event::emit<FeeCollectedEventV2>(v0);
    }

    public entry fun sell_exact_in_v1<T0>(arg0: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai::sell<T0>(arg0, arg1, arg4, 0x2::coin::split<T0>(&mut arg2, arg3, arg6), arg6);
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        let v0 = SellEventV1<T0>{
            recipient : 0x2::tx_context::sender(arg6),
            amount_in : arg3,
        };
        0x2::event::emit<SellEventV1<T0>>(v0);
        let v1 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v1);
    }

    public entry fun sell_exact_in_v2<T0>(arg0: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::SuiAi<0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suai::SUAI>, arg1: &mut 0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        0xbc732bc5f1e9a9f4bdf4c0672ee538dbf56c161afe04ff1de2176efabdf41f92::suiai_v2::sell<T0>(arg0, arg1, arg4, 0x2::coin::split<T0>(&mut arg2, arg3, arg6), arg6);
        0x4561d63d8b0e9d9d664f2d37fa23ec2f7f38e0586fa73c290e8ca1a40358f124::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg6));
        let v0 = SellEventV2<T0>{
            recipient : 0x2::tx_context::sender(arg6),
            amount_in : arg3,
        };
        0x2::event::emit<SellEventV2<T0>>(v0);
        let v1 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

