module 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bluefin {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct Venue has drop {
        dummy_field: bool,
    }

    public fun migrate<T0, T1>(arg0: &mut 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::Presale<T0, T1>, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg2: &0x2::coin_registry::Currency<T0>, arg3: &0x2::coin_registry::Currency<T1>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::pool_tier<T0, T1>(arg0);
        let v2 = Witness{dummy_field: false};
        let (v3, v4) = 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::migrate<T0, T1, Witness>(arg0, arg1, v2, arg6, arg7);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0x2::balance::value<T0>(&v6);
        let v8 = 0x2::balance::value<T1>(&v5);
        let (v9, v10) = full_range(arg4, v0);
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::create_pool_and_get_object<T0, T1, 0x2::sui::SUI>(arg6, arg4, pool_name<T0, T1>(arg2, arg3), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg2)), 0x2::coin_registry::decimals<T0>(arg2), b"", 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg3)), 0x2::coin_registry::decimals<T1>(arg3), 0x1::string::into_bytes(0x2::coin_registry::icon_url<T1>(arg3)), v0, v1, 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::migration_math::sqrt_price_x64(v7, v8, true), 0x2::coin::into_balance<0x2::sui::SUI>(arg5), arg7);
        let v12 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg4, &mut v11, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v9), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v10), arg7);
        let v13 = fixes_meme<T0, T1>(&v11, v9, v10, v7, v8);
        let v14 = if (v13) {
            v7
        } else {
            v8
        };
        let (_, _, v17, v18) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg6, arg4, &mut v11, &mut v12, v6, v5, v14, v13);
        let v19 = Venue{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::create<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v19, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(&v12), v12, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v12), v17, v18, arg7);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::share_pool_object<T0, T1>(v11);
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::coin_registry::Currency<T0>, arg2: u64, arg3: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg4: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg5: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg6: bool, arg7: u64, arg8: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg9: u64, arg10: u64, arg11: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::EligibilityPolicy, arg12: 0x1::option::Option<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::UncappedPhase>, arg13: vector<0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::RecipientShare>, arg14: 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::bps::Bps, arg15: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::creation_policy::CreationPolicy, arg16: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg17: u32, arg18: u64, arg19: &mut 0x2::tx_context::TxContext) : (0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::Presale<T0, T1>, 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::PresaleCap) {
        let v0 = if (arg17 > 0) {
            if (arg17 <= 400) {
                if (arg18 > 0) {
                    arg18 <= 20000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835339723532730374);
        let v1 = 0x2::coin_registry::symbol<T0>(arg1);
        assert!(0x1::string::length(&v1) <= 32, 13835621207099506696);
        let v2 = Witness{dummy_field: false};
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::blast_presale::new<T0, T1, Witness>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, v2, arg17, arg18, arg13, arg14, arg15, arg16, arg19)
    }

    public fun collect_fees<T0, T1>(arg0: &mut 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::PresaleVault<T0, T1>, arg1: &0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::fee_policy::FeePolicy, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::pool_id<T0, T1>(arg0) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg3), 13835058721002291204);
        let v0 = Venue{dummy_field: false};
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg4, arg2, arg3, 0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::position_mut<T0, T1, Venue, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(arg0, &v0));
        0x76cb0508fc94234fddd910b5616248f8a42998048a28e55f5fe1cc89e7b98400::presale_vault::split_fees<T0, T1>(arg0, arg1, v3, v4, arg5);
    }

    fun fixes_meme<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u64, arg4: u64) : bool {
        let v0 = arg3 >= arg4;
        let v1 = if (v0) {
            arg3
        } else {
            arg4
        };
        let (_, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(arg1, arg2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0), v1, v0);
        v3 <= arg3 && v4 <= arg4 && v0 || !v0
    }

    fun full_range(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg1: u32) : (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) {
        let (v0, v1) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::get_tick_range(arg0);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(arg1);
        (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v0, v2), v2), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::mul(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::div(v1, v2), v2))
    }

    fun pool_name<T0, T1>(arg0: &0x2::coin_registry::Currency<T0>, arg1: &0x2::coin_registry::Currency<T1>) : vector<u8> {
        let v0 = 0x1::string::into_bytes(0x2::coin_registry::symbol<T0>(arg0));
        0x1::vector::append<u8>(&mut v0, b"-");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x2::coin_registry::symbol<T1>(arg1)));
        v0
    }

    // decompiled from Move bytecode v7
}

