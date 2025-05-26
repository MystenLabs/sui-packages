module 0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::controller {
    public entry fun modify_controller(arg0: &mut 0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::is_emergency(arg0), 202);
        assert!(0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::is_emergency(arg0), 203);
        assert!(0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x77393656cd209f3551e2231a6516efe83ea039c868daa58a45f8346ba84eef2e::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

