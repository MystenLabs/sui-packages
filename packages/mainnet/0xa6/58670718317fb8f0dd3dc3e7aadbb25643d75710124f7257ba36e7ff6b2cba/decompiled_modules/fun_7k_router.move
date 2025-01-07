module 0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::fun_7k_router {
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

    public entry fun buy_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::fun_7k::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg7: 0x1::string::String, arg8: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg9: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg3, 2);
        let v0 = arg3 * arg0.buy_fee / 10000;
        let v1 = 0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg3 - v0, arg10);
        let (v2, v3) = 0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::fun_7k::buy_<T0>(arg1, &mut v1, true, arg4, arg5, arg6, arg10);
        let v4 = v3;
        let v5 = v2;
        let v6 = 0x2::coin::value<T0>(&v5);
        assert!(v6 >= arg4, 1);
        if (0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::locked_coin::value<T0>(&v4) == 0) {
            0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::locked_coin::destroy_zero<T0>(v4);
        } else {
            0x2::transfer::public_transfer<0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::locked_coin::LockedCoin<T0>>(v4, 0x2::tx_context::sender(arg10));
        };
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<0x2::sui::SUI, T0>(arg8, arg9, arg3 - v0, &mut v5, arg4, v6, 0x1::option::none<address>(), 0, arg10);
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<T0>(v5, 0x2::tx_context::sender(arg10));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<0x2::sui::SUI>(arg2, 0x2::tx_context::sender(arg10));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg10));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg10), arg0.admin);
        let v7 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg10),
            amount_in  : arg3 - v0,
            amount_out : v6,
        };
        0x2::event::emit<BuyEvent<T0>>(v7);
        let v8 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v0,
        };
        0x2::event::emit<FeeCollectedEvent>(v8);
        let v9 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v9);
    }

    public entry fun change_admin(arg0: &AdminCap, arg1: &mut FeeObject, arg2: address) {
        arg1.admin = arg2;
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::fun_7k::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg7: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 2);
        let v0 = 0x2::coin::split<T0>(&mut arg2, arg3, arg8);
        let v1 = 0x3068e532f3d924839df360444fa096cada1d5ad66a9d15df610e88166bbdaa60::fun_7k::sell_<T0>(arg1, &mut v0, true, arg4, arg8);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        let v3 = v2 * arg0.sell_fee / 10000;
        assert!(v2 - v3 >= arg4, 1);
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<T0, 0x2::sui::SUI>(arg6, arg7, arg3, &mut v1, arg4, v2 - v3, 0x1::option::none<address>(), 0, arg8);
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg8));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg8));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg8));
        0xa658670718317fb8f0dd3dc3e7aadbb25643d75710124f7257ba36e7ff6b2cba::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v1, v3, arg8), arg0.admin);
        let v4 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : arg3,
            amount_out : v2 - v3,
        };
        0x2::event::emit<SellEvent<T0>>(v4);
        let v5 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v3,
        };
        0x2::event::emit<FeeCollectedEvent>(v5);
        let v6 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

