module 0x26c0f80bb0909ef83c5d9376c8ed84ff8f6001beada12adab25730fef448f695::kriya {
    struct KriyaSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap<T0, T1>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, u64, u64) {
        if (arg6) {
            let v0 = if (arg5) {
                0x2::coin::value<T0>(&arg3)
            } else {
                0x2::coin::value<T1>(&arg4)
            };
            arg1 = v0;
        };
        let v1 = if (arg5) {
            assert!(0x2::coin::value<T0>(&arg3) >= arg1, 1);
            let v2 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg3, arg1, arg7), arg1, arg2, arg7);
            assert!(0x2::coin::value<T1>(&v2) >= arg2, 0);
            let v3 = 0x2::coin::value<T1>(&v2);
            let v4 = KriyaSwapEvent{
                pool         : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
                amount_in    : arg1,
                amount_out   : v3,
                a2b          : arg5,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<KriyaSwapEvent>(v4);
            0x2::coin::join<T1>(&mut arg4, v2);
            v3
        } else {
            assert!(0x2::coin::value<T1>(&arg4) >= arg1, 1);
            let v5 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, 0x2::coin::split<T1>(&mut arg4, arg1, arg7), arg1, arg2, arg7);
            assert!(0x2::coin::value<T0>(&v5) >= arg2, 0);
            let v6 = 0x2::coin::value<T0>(&v5);
            let v7 = KriyaSwapEvent{
                pool         : 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0),
                amount_in    : arg1,
                amount_out   : v6,
                a2b          : arg5,
                by_amount_in : true,
                coin_a       : 0x1::type_name::get<T0>(),
                coin_b       : 0x1::type_name::get<T1>(),
            };
            0x2::event::emit<KriyaSwapEvent>(v7);
            0x2::coin::join<T0>(&mut arg3, v5);
            v6
        };
        (arg3, arg4, arg1, v1)
    }

    // decompiled from Move bytecode v6
}

