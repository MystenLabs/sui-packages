module 0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::State>(0x1b6975dc8ec98bcafbd521aa6e9882d11649445aea3f7b9c1852e922aa8145d0::state::new(arg2, arg3, arg4, arg5, arg6));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        0x2::package::make_immutable(arg1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

