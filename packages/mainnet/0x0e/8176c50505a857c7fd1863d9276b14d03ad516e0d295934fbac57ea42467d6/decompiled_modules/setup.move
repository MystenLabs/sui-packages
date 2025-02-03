module 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::setup {
    struct DeployerCap has key {
        id: 0x2::object::UID,
    }

    entry fun complete(arg0: DeployerCap, arg1: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::State>(0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::new_state(arg1, arg2, arg3, arg4));
        let DeployerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeployerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeployerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun register_cctp_mayan_caller(arg0: &0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::AdminCap, arg1: &mut 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: address) {
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::add_cctp_mayan_caller(arg0, arg1, arg3, arg4);
    }

    public fun register_cctp_mayan_recipient<T0>(arg0: &0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::AdminCap, arg1: &mut 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::State, arg2: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg3: u32, arg4: &0x2::coin::CoinMetadata<T0>, arg5: address) {
        assert!(arg3 != 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::local_domain(arg2), 0);
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg4);
        0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::state::add_cctp_mayan_recipient(arg0, arg1, arg3, 0x2::object::id_to_address(&v0), arg5);
    }

    // decompiled from Move bytecode v6
}

