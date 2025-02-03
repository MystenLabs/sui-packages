module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State>(0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::new_state(arg2, arg3, arg4, arg5, arg6));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        0x2::package::make_immutable(arg1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_cctp_mayan_recipient(arg0: &0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::AdminCap, arg1: &mut 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::State, arg2: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: u32, arg4: address) {
        assert!(arg3 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2), 0);
        0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::state::add_cctp_mayan_recipient(arg0, arg1, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

