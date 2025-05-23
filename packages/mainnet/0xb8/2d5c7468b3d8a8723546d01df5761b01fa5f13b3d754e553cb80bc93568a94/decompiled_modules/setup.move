module 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::State>(0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::new_state(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun register_cctp_mayan_caller(arg0: &0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::AdminCap, arg1: &mut 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: address) {
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::assert_valid_version(arg1);
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    entry fun register_cctp_mayan_recipient<T0>(arg0: &0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::AdminCap, arg1: &mut 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: &0x2::coin::CoinMetadata<T0>, arg5: address) {
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::assert_valid_version(arg1);
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    entry fun register_paired_emitter(arg0: &0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::AdminCap, arg1: &mut 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::State, arg2: u16, arg3: address) {
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::assert_valid_version(arg1);
        0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::state::add_paired_emitter(arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

