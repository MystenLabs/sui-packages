module 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::State>(0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::new_state(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun register_cctp_mayan_caller(arg0: &0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::AdminCap, arg1: &mut 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: address) {
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    entry fun register_cctp_mayan_recipient<T0>(arg0: &0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::AdminCap, arg1: &mut 0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: &0x2::coin::CoinMetadata<T0>, arg5: address) {
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        0xa3c8a3da0a4d5994f99bde248fff4b4eb7fd7310340c5b54afdd1377713d9ded::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    // decompiled from Move bytecode v6
}

