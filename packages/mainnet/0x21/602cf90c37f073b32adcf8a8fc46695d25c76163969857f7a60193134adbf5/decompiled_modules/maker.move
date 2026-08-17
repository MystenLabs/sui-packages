module 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::maker {
    struct L has copy, drop, store {
        o: u128,
        c: u64,
        x: u64,
        q: u64,
        m: u8,
        t: u64,
        k: u64,
        f: bool,
    }

    struct MakerKernel<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        cfg: 0x2::object::ID,
        v: 0x2::object::ID,
        ve: u8,
        b: L,
        a: L,
        p: vector<u64>,
        n: u64,
        cy: u64,
        z: bool,
    }

    public fun assert_kernel<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig) {
        assert!(arg0.v == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_kernel_mismatch());
        assert!(arg0.cfg == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_kernel_mismatch());
    }

    fun ax(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg1 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        az(arg2);
        let v0 = arg0 % arg1;
        if (v0 == 0) {
            return arg0
        };
        if (arg2 == 1) {
            arg0 - v0
        } else {
            arg0 - v0 + arg1
        }
    }

    fun az(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_side());
    }

    fun ci(arg0: u64, arg1: u64, arg2: u64, arg3: u8) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return arg0
        };
        if (arg3 == 1) {
            if (arg1 <= arg2) {
                return 0
            };
            let v1 = ax(arg1 - arg2, arg2, 1);
            if (arg0 < v1) {
                arg0
            } else {
                v1
            }
        } else {
            let v2 = ax(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg1, arg2), arg2, 2);
            if (arg0 > v2) {
                arg0
            } else {
                v2
            }
        }
    }

    public fun client_order_id(arg0: u64, arg1: u8) : u64 {
        az(arg1);
        if (arg1 == 1) {
            arg0 << 1
        } else {
            arg0 << 1 | 1
        }
    }

    public fun committed_quote<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0.b.k, arg0.a.k)
    }

    public fun create_kernel<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        share_kernel<T0, T1>(new_kernel<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8));
    }

    public fun cycles<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        arg0.cy
    }

    public(friend) fun d1<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: bool) : (u64, u8, bool) {
        let v0 = lx(arg6, arg4, pv<T0, T1>(arg0, 2), pv<T0, T1>(arg0, 3));
        let v1 = mo(v0, arg5);
        let v2 = pv<T0, T1>(arg0, 7);
        let v3 = if (v1 == 2) {
            px_b(arg3, v2, arg1)
        } else if (v1 == 3) {
            px_c(arg2, v2, arg4, pv<T0, T1>(arg0, 1), arg1)
        } else {
            px_a(arg2, v2, (pv<T0, T1>(arg0, 0) as u8), arg1)
        };
        (ci(v3, arg3, v2, arg1), v1, v0)
    }

    public(friend) fun d2<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u8, arg5: u64) : bool {
        let v0 = leg<T0, T1>(arg0, arg1);
        sx(&v0, arg2, arg3, arg4, arg5, pv<T0, T1>(arg0, 4))
    }

    public fun decode_offset(arg0: u8) : (bool, u64) {
        if (arg0 >= 128) {
            (false, ((arg0 - 128) as u64))
        } else {
            (true, ((128 - arg0) as u64))
        }
    }

    public fun decode_status(arg0: u64, arg1: u64, arg2: u64) : u32 {
        (((arg2 ^ mx(arg0, arg1)) & 4294967295) as u32)
    }

    fun el() : L {
        L{
            o : 0,
            c : 0,
            x : 0,
            q : 0,
            m : 0,
            t : 0,
            k : 0,
            f : false,
        }
    }

    public fun encode_offset(arg0: u64, arg1: bool) : u8 {
        assert!(arg0 <= (32 as u64), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_offset());
        if (arg1) {
            128 - (arg0 as u8)
        } else {
            128 + (arg0 as u8)
        }
    }

    public(friend) fun g1<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        pv<T0, T1>(arg0, 4)
    }

    public(friend) fun g2<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        let v0 = committed_quote<T0, T1>(arg0);
        let v1 = pv<T0, T1>(arg0, 6);
        if (v0 >= v1) {
            0
        } else {
            v1 - v0
        }
    }

    public(friend) fun g3(arg0: u64, arg1: u64, arg2: u8) : u64 {
        ax(arg0, arg1, arg2)
    }

    public fun is_paused<T0, T1>(arg0: &MakerKernel<T0, T1>) : bool {
        arg0.z
    }

    public fun kernel_id<T0, T1>(arg0: &MakerKernel<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun kernel_vault_id<T0, T1>(arg0: &MakerKernel<T0, T1>) : 0x2::object::ID {
        arg0.v
    }

    public fun kernel_venue<T0, T1>(arg0: &MakerKernel<T0, T1>) : u8 {
        arg0.ve
    }

    public fun last_sequence<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        arg0.n
    }

    public fun leg<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u8) : L {
        az(arg1);
        if (arg1 == 1) {
            arg0.b
        } else {
            arg0.a
        }
    }

    public fun leg_client_order_id(arg0: &L) : u64 {
        arg0.c
    }

    public fun leg_committed_quote(arg0: &L) : u64 {
        arg0.k
    }

    public fun leg_is_latched(arg0: &L) : bool {
        arg0.f
    }

    public fun leg_is_resting(arg0: &L) : bool {
        arg0.o != 0
    }

    public fun leg_mode(arg0: &L) : u8 {
        arg0.m
    }

    public fun leg_order_id(arg0: &L) : u128 {
        arg0.o
    }

    public fun leg_placed_at_ms(arg0: &L) : u64 {
        arg0.t
    }

    public fun leg_price(arg0: &L) : u64 {
        arg0.x
    }

    public fun leg_quantity(arg0: &L) : u64 {
        arg0.q
    }

    public fun leg_quote_size<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        pv<T0, T1>(arg0, 5)
    }

    fun lx(arg0: bool, arg1: u64, arg2: u64, arg3: u64) : bool {
        arg0 && arg1 > arg3 || arg1 >= arg2
    }

    public fun max_offset_ticks() : u8 {
        32
    }

    public fun max_size_pct() : u64 {
        200
    }

    fun mo(arg0: bool, arg1: bool) : u8 {
        if (arg0) {
            3
        } else if (arg1) {
            2
        } else {
            1
        }
    }

    public fun mode_a() : u8 {
        1
    }

    public fun mode_b() : u8 {
        2
    }

    public fun mode_c() : u8 {
        3
    }

    public fun mode_none() : u8 {
        0
    }

    fun mx(arg0: u64, arg1: u64) : u64 {
        ((((arg0 as u128) * 11400714819323198485 % 18446744073709551616 + (arg1 as u128) * 13787848793156543929 % 18446744073709551616) % 18446744073709551616) as u64)
    }

    public fun new_kernel<T0, T1>(arg0: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : MakerKernel<T0, T1> {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg2, arg3);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg0, arg1);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::config_id<T1>(arg0) == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::vault_mismatch());
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::venue::assert_catalog_venue(arg4);
        assert!(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::is_venue_allowed(arg2, arg4), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::venue_not_allowed());
        assert!(arg5 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg6 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg7 >= arg6, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u64>(&mut v0, 0);
            v1 = v1 + 1;
        };
        *0x1::vector::borrow_mut<u64>(&mut v0, 0) = (128 as u64);
        *0x1::vector::borrow_mut<u64>(&mut v0, 1) = 5;
        *0x1::vector::borrow_mut<u64>(&mut v0, 2) = 50;
        *0x1::vector::borrow_mut<u64>(&mut v0, 3) = 25;
        *0x1::vector::borrow_mut<u64>(&mut v0, 4) = 600000;
        *0x1::vector::borrow_mut<u64>(&mut v0, 5) = arg6;
        *0x1::vector::borrow_mut<u64>(&mut v0, 6) = arg7;
        *0x1::vector::borrow_mut<u64>(&mut v0, 7) = arg5;
        MakerKernel<T0, T1>{
            id  : 0x2::object::new(arg8),
            cfg : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::id(arg2),
            v   : 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg0),
            ve  : arg4,
            b   : el(),
            a   : el(),
            p   : v0,
            n   : 0,
            cy  : 0,
            z   : false,
        }
    }

    public fun offset_zero() : u8 {
        128
    }

    public fun p_count() : u64 {
        8
    }

    public fun pack_inputs(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: bool) : u64 {
        assert!(arg1 <= 65535, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg2 <= 65535, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        let v0 = if (arg3) {
            1
        } else {
            0
        };
        let v1 = if (arg4) {
            2
        } else {
            0
        };
        (arg1 | arg2 << 16 | (v0 | v1) << 32) ^ mx(arg0, arg0)
    }

    public fun pack_inputs2(arg0: u64, arg1: u64, arg2: u64, arg3: bool, arg4: bool, arg5: bool, arg6: bool, arg7: u64, arg8: u64) : u64 {
        assert!(arg1 <= 65535, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg2 <= 65535, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg7 <= 200, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(arg8 <= 200, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        let v0 = if (arg3) {
            1
        } else {
            0
        };
        let v1 = if (arg4) {
            2
        } else {
            0
        };
        let v2 = if (arg5) {
            4
        } else {
            0
        };
        let v3 = if (arg6) {
            8
        } else {
            0
        };
        (arg1 | arg2 << 16 | (v0 | v1 | v2 | v3) << 32 | arg7 << 36 | arg8 << 44) ^ mx(arg0, arg0)
    }

    public fun param<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u64) : u64 {
        pv<T0, T1>(arg0, arg1)
    }

    fun pv<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u64) : u64 {
        assert!(arg1 < 8, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        *0x1::vector::borrow<u64>(&arg0.p, arg1)
    }

    fun px_a(arg0: u64, arg1: u64, arg2: u8, arg3: u8) : u64 {
        assert!(arg0 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_no_book());
        az(arg3);
        let (v0, v1) = decode_offset(arg2);
        let v2 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::mul(arg1, v1);
        let v3 = if (arg3 == 1 && !v0 || !!v0) {
            if (arg0 <= v2) {
                return 0
            };
            arg0 - v2
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0, v2)
        };
        ax(v3, arg1, arg3)
    }

    fun px_b(arg0: u64, arg1: u64, arg2: u8) : u64 {
        assert!(arg0 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_no_book());
        if (arg2 == 1) {
            if (arg0 <= arg1) {
                return 0
            };
            ax(arg0 - arg1, arg1, 1)
        } else {
            ax(0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0, arg1), arg1, 2)
        }
    }

    fun px_c(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8) : u64 {
        assert!(arg0 > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_no_book());
        az(arg4);
        let v0 = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::bps(arg0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg2, arg3));
        let v1 = if (arg4 == 1) {
            assert!(arg0 > v0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_price_underflow());
            arg0 - v0
        } else {
            0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0, v0)
        };
        ax(v1, arg1, arg4)
    }

    public fun r_ask_at_best() : u32 {
        2048
    }

    public fun r_ask_cancelled() : u32 {
        32
    }

    public fun r_ask_dust() : u32 {
        65536
    }

    public fun r_ask_filled() : u32 {
        1048576
    }

    public fun r_ask_kept() : u32 {
        8
    }

    public fun r_ask_latched() : u32 {
        128
    }

    public fun r_ask_placed() : u32 {
        2
    }

    public fun r_ask_retry() : u32 {
        512
    }

    public fun r_ask_suppressed() : u32 {
        262144
    }

    public fun r_ask_unfunded() : u32 {
        16384
    }

    public fun r_bid_at_best() : u32 {
        1024
    }

    public fun r_bid_cancelled() : u32 {
        16
    }

    public fun r_bid_dust() : u32 {
        32768
    }

    public fun r_bid_filled() : u32 {
        524288
    }

    public fun r_bid_kept() : u32 {
        4
    }

    public fun r_bid_latched() : u32 {
        64
    }

    public fun r_bid_placed() : u32 {
        1
    }

    public fun r_bid_retry() : u32 {
        256
    }

    public fun r_bid_suppressed() : u32 {
        131072
    }

    public fun r_bid_unfunded() : u32 {
        8192
    }

    public fun r_untracked_cancelled() : u32 {
        4096
    }

    public fun set_paused<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: bool) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg1, arg2);
        assert!(arg0.v == 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::id<T1>(arg1), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_kernel_mismatch());
        arg0.z = arg3;
    }

    public fun share_kernel<T0, T1>(arg0: MakerKernel<T0, T1>) {
        0x2::transfer::share_object<MakerKernel<T0, T1>>(arg0);
    }

    public fun side_ask() : u8 {
        2
    }

    public fun side_bid() : u8 {
        1
    }

    fun sx(arg0: &L, arg1: u64, arg2: u64, arg3: u8, arg4: u64, arg5: u64) : bool {
        if (arg0.o != 0) {
            if (arg0.x == arg1) {
                if (arg0.q == arg2) {
                    if (arg0.m == arg3) {
                        if (arg4 >= arg0.t) {
                            arg4 - arg0.t < arg5
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun tick_size<T0, T1>(arg0: &MakerKernel<T0, T1>) : u64 {
        pv<T0, T1>(arg0, 7)
    }

    public fun tune<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::Vault<T1>, arg2: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::VaultAdminCap<T1>, arg3: &0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::LotusConfig, arg4: u64, arg5: vector<u64>) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::config::assert_governance_active(arg3, arg4);
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::vault::assert_admin<T1>(arg1, arg2);
        assert_kernel<T0, T1>(arg0, arg1, arg3);
        assert!(0x1::vector::length<u64>(&arg5) == 8, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        let (_, v1) = decode_offset((*0x1::vector::borrow<u64>(&arg5, 0) as u8));
        assert!(v1 <= (32 as u64), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_offset());
        assert!(*0x1::vector::borrow<u64>(&arg5, 3) < *0x1::vector::borrow<u64>(&arg5, 2), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(*0x1::vector::borrow<u64>(&arg5, 4) > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(*0x1::vector::borrow<u64>(&arg5, 5) > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(*0x1::vector::borrow<u64>(&arg5, 7) > 0, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        assert!(*0x1::vector::borrow<u64>(&arg5, 6) >= *0x1::vector::borrow<u64>(&arg5, 5), 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_bad_param());
        arg0.p = arg5;
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mk(0x2::object::uid_to_inner(&arg0.id), arg0.n, 0);
    }

    public(friend) fun u1<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: u64) {
        assert!(arg1 > arg0.n, 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::errors::maker_replay());
        arg0.n = arg1;
        arg0.cy = 0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::math::add(arg0.cy, 1);
    }

    public(friend) fun u2<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: u8, arg2: bool) {
        if (arg1 == 1) {
            arg0.b.f = arg2;
        } else {
            arg0.a.f = arg2;
        };
    }

    public(friend) fun u3<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: u8, arg2: u128, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64) {
        let v0 = arg1 == 1 && arg0.b.f || arg0.a.f;
        let v1 = L{
            o : arg2,
            c : arg3,
            x : arg4,
            q : arg5,
            m : arg6,
            t : arg8,
            k : arg7,
            f : v0,
        };
        if (arg1 == 1) {
            arg0.b = v1;
        } else {
            arg0.a = v1;
        };
    }

    public(friend) fun u4<T0, T1>(arg0: &mut MakerKernel<T0, T1>, arg1: u8) : u64 {
        let v0 = arg1 == 1 && arg0.b.f || arg0.a.f;
        let v1 = if (arg1 == 1) {
            arg0.b.k
        } else {
            arg0.a.k
        };
        let v2 = el();
        v2.f = v0;
        if (arg1 == 1) {
            arg0.b = v2;
        } else {
            arg0.a = v2;
        };
        v1
    }

    public(friend) fun u5<T0, T1>(arg0: &MakerKernel<T0, T1>, arg1: u32) {
        0x9cac37ad544a16120a128a1237363766b9348f511d853f15794f1bfd5a9e0f53::events::emit_mk(0x2::object::uid_to_inner(&arg0.id), arg0.n, (arg1 as u64) ^ mx(arg0.n, arg0.cy));
    }

    public fun unpack_inputs(arg0: u64, arg1: u64) : (u64, u64, bool, bool) {
        let v0 = arg1 ^ mx(arg0, arg0);
        let v1 = v0 >> 32 & 3;
        (v0 & 65535, v0 >> 16 & 65535, v1 & 1 != 0, v1 & 2 != 0)
    }

    public fun unpack_inputs2(arg0: u64, arg1: u64) : (u64, u64, bool, bool, bool, bool, u64, u64) {
        let v0 = arg1 ^ mx(arg0, arg0);
        let v1 = v0 >> 32 & 15;
        let v2 = v0 >> 36 & 255;
        let v3 = v2;
        let v4 = v0 >> 44 & 255;
        let v5 = v4;
        if (v2 == 0) {
            v3 = 100;
        };
        if (v4 == 0) {
            v5 = 100;
        };
        (v0 & 65535, v0 >> 16 & 65535, v1 & 1 != 0, v1 & 2 != 0, v1 & 4 != 0, v1 & 8 != 0, v3, v5)
    }

    // decompiled from Move bytecode v7
}

