module 0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::move_pump_router {
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

    public entry fun buy_exact_out<T0>(arg0: &FeeObject, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::buy_returns<T0>(arg1, arg2, arg3, arg4, arg6, arg8);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg2) - v3;
        let v5 = v4 * arg0.buy_fee / 10000;
        assert!(v3 >= v5, 3);
        assert!(v4 + v5 <= arg5, 2);
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg8));
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg8));
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v5, arg8), arg0.admin);
        let v6 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : v4,
            amount_out : arg4,
        };
        0x2::event::emit<BuyEvent<T0>>(v6);
        let v7 = FeeCollectedEvent{
            recipient : arg0.admin,
            amount    : v5,
        };
        0x2::event::emit<FeeCollectedEvent>(v7);
        let v8 = OrderCompletedEvent{order_id: arg7};
        0x2::event::emit<OrderCompletedEvent>(v8);
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

    public entry fun sell_exact_in<T0>(arg0: &FeeObject, arg1: &mut 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::Configuration, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 3);
        let (v0, v1) = 0x92fecee99603c0628ced2fbd37f85c05f6c0049c183eb6b1b58db24764c6c7bc::move_pump::sell_returns<T0>(arg1, 0x2::coin::split<T0>(&mut arg2, arg3, arg7), arg4, arg5, arg7);
        let v2 = v0;
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&v2);
        assert!(v3 >= arg4, 1);
        let v4 = v3 * arg0.sell_fee / 10000;
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<T0>(v1, 0x2::tx_context::sender(arg7));
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<T0>(arg2, 0x2::tx_context::sender(arg7));
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<0x2::sui::SUI>(v2, 0x2::tx_context::sender(arg7));
        0xa6304815f113c1913a3e2aee388650974f485321085b1868790b79c65775a9c6::utils::send_coin<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v2, v4, arg7), arg0.admin);
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

