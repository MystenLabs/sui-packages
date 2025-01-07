module 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::controller {
    public entry fun modify_admin(arg0: &mut 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_config<T0, T1>(arg0: &mut 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::Global, arg1: bool, arg2: address, arg3: address, arg4: u8, arg5: 0x1::ascii::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::admin(arg0) == 0x2::tx_context::sender(arg6), 201);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::modify_pool_config<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun modify_controller(arg0: &mut 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::is_emergency(arg0), 202);
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::is_emergency(arg0), 203);
        assert!(0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xf57ca9420abc74e846ee70cb50b03292ea6f796643d01324e52e594ae91f6c20::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

