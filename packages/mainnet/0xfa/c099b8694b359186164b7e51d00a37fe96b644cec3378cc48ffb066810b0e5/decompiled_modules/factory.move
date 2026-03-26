module 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::factory {
    struct Factory has key {
        id: 0x2::object::UID,
        mint_cap: 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor::MintCap,
        write_cap: 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::registry::WriteCap,
    }

    struct LaunchCompleted has copy, drop {
        anchor_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        token_name: 0x1::string::String,
        token_symbol: 0x1::string::String,
        total_supply: u64,
        peg_sui: u64,
        creator: address,
    }

    public fun create_factory(arg0: 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor::MintCap, arg1: 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::registry::WriteCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id        : 0x2::object::new(arg2),
            mint_cap  : arg0,
            write_cap : arg1,
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    public fun finalize_launch<T0>(arg0: &Factory, arg1: &mut 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::registry::Registry, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u8, arg7: u64, arg8: 0x1::string::String, arg9: u64, arg10: u64, arg11: 0x2::coin::Coin<0x2::sui::SUI>, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::tx_context::sender(arg13);
        let v2 = arg7 / 1000000000;
        let v3 = 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor::mint(&arg0.mint_cap, v0, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg2, arg12, arg13);
        let v4 = 0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor::anchor_id(&v3);
        0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::registry::register(&arg0.write_cap, arg1, v4, arg2, v0, arg3, arg4, v2, v1, arg11, arg12, arg13);
        let v5 = LaunchCompleted{
            anchor_id    : v4,
            pool_id      : arg2,
            token_type   : v0,
            token_name   : arg3,
            token_symbol : arg4,
            total_supply : arg5,
            peg_sui      : v2,
            creator      : v1,
        };
        0x2::event::emit<LaunchCompleted>(v5);
        0xfac099b8694b359186164b7e51d00a37fe96b644cec3378cc48ffb066810b0e5::launch_anchor::freeze_anchor(v3);
    }

    public fun mint_full_supply<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 200);
        assert!(0x2::coin::total_supply<T0>(&arg0) == 0, 201);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<T0>>(arg0);
        0x2::coin::mint<T0>(&mut arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

