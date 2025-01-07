module 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::beneficiary {
    public entry fun withdraw<T0, T1>(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::is_emergency(arg0), 302);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::beneficiary(arg0) == 0x2::tx_context::sender(arg1), 301);
        let v0 = 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::get_mut_pool<T0, T1>(arg0, 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::is_order<T0, T1>());
        let (v1, v2, v3, v4) = 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::withdraw<T0, T1>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x2::tx_context::sender(arg1));
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::event::withdrew_event(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::global_id<T0, T1>(v0), 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::generate_lp_name<T0, T1>(), v3, v4);
    }

    public entry fun withdraw_supplybag(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::SupplyBag, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::is_emergency(arg0), 302);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::beneficiary(arg0) == 0x2::tx_context::sender(arg2), 301);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::withdraw_coin(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

