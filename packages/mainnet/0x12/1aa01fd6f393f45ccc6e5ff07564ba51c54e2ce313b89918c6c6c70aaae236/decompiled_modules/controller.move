module 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::controller {
    public entry fun modify_controller_global(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::modify_controller(arg0, arg1);
    }

    public entry fun modify_controller_supplybag(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::modify_controller(arg0, arg1);
    }

    public entry fun pause_global(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 202);
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::pause(arg0);
    }

    public entry fun pause_supplybag(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::is_emergency(arg0), 202);
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::pause(arg0);
    }

    public entry fun resume_global(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::is_emergency(arg0), 203);
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::implements::resume(arg0);
    }

    public entry fun resume_supplybag(arg0: &mut 0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::SupplyBag, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::is_emergency(arg0), 203);
        assert!(0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x121aa01fd6f393f45ccc6e5ff07564ba51c54e2ce313b89918c6c6c70aaae236::wsui::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

