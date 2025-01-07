module 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::controller {
    public entry fun modify_controller_global(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_controller_supplybag(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::SupplyBag, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::modify_controller(arg0, arg1);
    }

    public entry fun pause_global(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::is_emergency(arg0), 202);
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::pause(arg0);
    }

    public entry fun pause_supplybag(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::is_emergency(arg0), 202);
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::pause(arg0);
    }

    public entry fun resume_global(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::is_emergency(arg0), 203);
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::implements::resume(arg0);
    }

    public entry fun resume_supplybag(arg0: &mut 0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::is_emergency(arg0), 203);
        assert!(0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x5106182b167bc18531c3d66b75f4110c53d1d0b4aa91dbc904ace3ab8ec4ca29::wsui::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

