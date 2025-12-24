module 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::cetus {
    struct CetusContext {
        wrap_id: 0x2::object::ID,
        swap_ctx: 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext,
    }

    public fun confirm_swap<T0>(arg0: &mut 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::GlobalConfig, arg1: 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::WrapContext, arg2: CetusContext, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_package_version(arg0);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_pause(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::destroy_wrap_context(arg1);
        let CetusContext {
            wrap_id  : v6,
            swap_ctx : v7,
        } = arg2;
        assert!(v0 == v6, 3);
        let v8 = 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::confirm_swap<T0>(v7, arg3);
        let (v9, v10) = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::deduct_fee<T0>(arg0, v8, arg3);
        let v11 = v9;
        assert!(0x2::coin::value<T0>(&v11) >= v4, 2);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::emit_confirm_swap_event(0x2::tx_context::sender(arg3), v1, v2, v3, 0x2::coin::value<T0>(&v8), v4, v10, v5);
        v11
    }

    public fun borrow_swap_ctx_mut(arg0: &mut CetusContext) : &mut 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext {
        &mut arg0.swap_ctx
    }

    public fun new_context<T0, T1>(arg0: &mut 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::GlobalConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::WrapContext, CetusContext) {
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_package_version(arg0);
        0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        let v1 = 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::new_wrap_context(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg2, b"CETUS", arg5);
        let v2 = CetusContext{
            wrap_id  : 0xd51acd6ee3e148c55468e6fa345448e4481023a31e49e760b6fdfa8ffcef3840::config::get_wrap_context_id(&v1),
            swap_ctx : 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::new_swap_context<T0, T1>(arg1, arg2, arg3, arg4, 0, @0x0, arg5),
        };
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

