module 0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::controller {
    public entry fun modify_burn(arg0: &mut 0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::burn(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::modify_burn(arg0, arg1);
    }

    public entry fun modify_controller(arg0: &mut 0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::is_emergency(arg0), 202);
        assert!(0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::is_emergency(arg0), 203);
        assert!(0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x1e2173d4b517c8ecfcaaa891ccadc679d5c4e41ec7db6836311eccd014478d11::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

