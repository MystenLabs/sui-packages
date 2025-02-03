module 0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::setup {
    struct DeployerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg3: u16, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_share_object<0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::State>(0x26efee2b51c911237888e5dc6702868abca3c7ac12c53f76ef8eba0697695e3d::state::new(arg2, arg1, arg3, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new_nonzero(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::from_bytes(arg4)), arg5));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

