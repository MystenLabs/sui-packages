module 0xe983aa06c3794bb2f3a723ffbefcbdf6118f888e7b8dfeb75eb0f3f65c948f71::withdraw {
    public fun withdraw_if_non_zero<T0, T1, T2>(arg0: &mut 0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::MarginManager<T0, T1>, arg1: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_registry::MarginRegistry, arg2: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T0>, arg3: &0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_pool::MarginPool<T1>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0xe37c5fc3882eaa43d3e670c2e9ca6884461dc398b0fe4d185d5343754bb23820::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        if (arg7 == 0) {
            return 0x2::coin::zero<T2>(arg9)
        };
        0xdd550d2ab9e31e41f45444b1fb882e3dbdacde7fbb85f39b85ec4fa1d069006c::margin_manager::withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    // decompiled from Move bytecode v6
}

