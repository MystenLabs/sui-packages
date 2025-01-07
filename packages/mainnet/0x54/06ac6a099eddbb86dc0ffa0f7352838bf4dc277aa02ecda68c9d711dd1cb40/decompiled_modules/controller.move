module 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::controller {
    public entry fun modify_controller_global(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_controller_supplybag(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::SupplyBag, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::modify_controller(arg0, arg1);
    }

    public entry fun pause_global(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::is_emergency(arg0), 202);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::pause(arg0);
    }

    public entry fun pause_supplybag(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::is_emergency(arg0), 202);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::pause(arg0);
    }

    public entry fun resume_global(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::is_emergency(arg0), 203);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::implements::resume(arg0);
    }

    public entry fun resume_supplybag(arg0: &mut 0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::is_emergency(arg0), 203);
        assert!(0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xe9c2eaa56289b9d2132066e5f59e5164ccb01f64edba90fb63a36ffb63ff1387::wsui::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

