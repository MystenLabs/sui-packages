module 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_disabler {
    struct BenefactorDisablerRole {
        dummy_field: bool,
    }

    public fun disable_benefactor(arg0: &mut 0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::Treasury, arg1: &0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::auth::Auth<BenefactorDisablerRole>, arg2: address) {
        assert!(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::is_enabled(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor(arg0, arg2)), 13835339607568285697);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::events::emit_benefactor_disabled(arg2);
        0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::benefactor_config::set_enabled(0x41d587e5336f1c86cad50d38a7136db99333bb9bda91cea4ba69115defeb1402::treasury::benefactor_mut(arg0, arg2), false);
    }

    // decompiled from Move bytecode v6
}

