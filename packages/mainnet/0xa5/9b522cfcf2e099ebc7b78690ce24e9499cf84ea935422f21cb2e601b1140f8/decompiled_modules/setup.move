module 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x2::package::UpgradeCap, arg2: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State>(0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::new_state(arg2, arg3, arg4, arg5, arg6));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<DeployerCap>(&arg1, 0x2::package::compatible_policy(), 1);
        0x2::package::make_immutable(arg1);
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_cctp_mayan_caller(arg0: &0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::AdminCap, arg1: &mut 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State, arg2: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: u32, arg4: address) {
        assert!(arg3 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2), 0);
        0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    public fun register_cctp_mayan_recipient<T0>(arg0: &0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::AdminCap, arg1: &mut 0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::State, arg2: &0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::State, arg3: u32, arg4: &0x2::coin::CoinMetadata<T0>, arg5: address) {
        assert!(arg3 != 0x34c884874be4cb4b84e79fa280d7b041f186f4d1ef08be1dc74b20e94376951a::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        0xa59b522cfcf2e099ebc7b78690ce24e9499cf84ea935422f21cb2e601b1140f8::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    // decompiled from Move bytecode v6
}

