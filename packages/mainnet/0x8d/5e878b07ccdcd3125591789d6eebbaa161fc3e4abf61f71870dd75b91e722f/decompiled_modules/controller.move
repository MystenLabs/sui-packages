module 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::controller {
    public entry fun modify_controller(arg0: &mut 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::is_emergency(arg0), 202);
        assert!(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::is_emergency(arg0), 203);
        assert!(0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x8d5e878b07ccdcd3125591789d6eebbaa161fc3e4abf61f71870dd75b91e722f::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

