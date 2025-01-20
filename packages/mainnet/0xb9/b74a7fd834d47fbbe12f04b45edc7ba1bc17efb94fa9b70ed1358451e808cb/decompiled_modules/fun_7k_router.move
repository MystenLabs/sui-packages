module 0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::fun_7k_router {
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

    struct OrderCompletedEvent has copy, drop {
        order_id: 0x1::string::String,
    }

    public entry fun buy_exact_in<T0>(arg0: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg5: 0x1::string::String, arg6: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg7: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let (v1, v2) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg0, &mut arg1, true, arg2, arg3, arg4, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::value<T0>(&v4);
        assert!(v5 >= arg2, 1);
        if (0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::value<T0>(&v3) == 0) {
            0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v3);
        } else {
            0x2::transfer::public_transfer<0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::LockedCoin<T0>>(v3, 0x2::tx_context::sender(arg8));
        };
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<0x2::sui::SUI, T0>(arg6, arg7, v0, &mut v4, arg2, v5, 0x1::option::none<address>(), 0, arg8);
        0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::utils::send_coin<T0>(v4, 0x2::tx_context::sender(arg8));
        0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::utils::send_coin<0x2::sui::SUI>(arg1, 0x2::tx_context::sender(arg8));
        let v6 = BuyEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg8),
            amount_in  : v0,
            amount_out : v5,
        };
        0x2::event::emit<BuyEvent<T0>>(v6);
        let v7 = OrderCompletedEvent{order_id: arg5};
        0x2::event::emit<OrderCompletedEvent>(v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun sell_exact_in<T0>(arg0: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg6: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) >= arg2, 2);
        let v0 = 0x2::coin::split<T0>(&mut arg1, arg2, arg7);
        let v1 = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg0, &mut v0, true, arg3, arg7);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&v1);
        assert!(v2 >= arg3, 1);
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle::settle<T0, 0x2::sui::SUI>(arg5, arg6, arg2, &mut v1, arg3, v2, 0x1::option::none<address>(), 0, arg7);
        0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::utils::send_coin<T0>(arg1, 0x2::tx_context::sender(arg7));
        0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::utils::send_coin<T0>(v0, 0x2::tx_context::sender(arg7));
        0xb9b74a7fd834d47fbbe12f04b45edc7ba1bc17efb94fa9b70ed1358451e808cb::utils::send_coin<0x2::sui::SUI>(v1, 0x2::tx_context::sender(arg7));
        let v3 = SellEvent<T0>{
            recipient  : 0x2::tx_context::sender(arg7),
            amount_in  : arg2,
            amount_out : v2,
        };
        0x2::event::emit<SellEvent<T0>>(v3);
        let v4 = OrderCompletedEvent{order_id: arg4};
        0x2::event::emit<OrderCompletedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

