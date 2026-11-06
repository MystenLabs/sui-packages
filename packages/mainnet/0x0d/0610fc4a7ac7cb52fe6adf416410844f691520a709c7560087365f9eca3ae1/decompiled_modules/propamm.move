module 0xd0610fc4a7ac7cb52fe6adf416410844f691520a709c7560087365f9eca3ae1::propamm {
    struct Snapshot has copy, drop {
        concentration: u64,
        x: u64,
        y: u64,
        mx: u64,
        my: u64,
        vx: u64,
        ry: u64,
        locked: bool,
        fee: u64,
        fx: u64,
        fy: u64,
        updated: u64,
        life: u64,
    }

    fun amount_out(arg0: &Snapshot, arg1: u64, arg2: bool, arg3: u64) : u64 {
        if (arg1 == 0 || !executable(arg0, arg3)) {
            return 0
        };
        let v0 = (arg0.vx as u256) * (arg0.concentration as u256);
        let v1 = v0 * v0;
        if (arg0.mx != 0 && v1 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / (arg0.mx as u256)) {
            return 0
        };
        let v2 = v1 * (arg0.mx as u256) / (arg0.my as u256);
        let v3 = v0 + (arg0.x as u256);
        if (v3 > 340282366920938463463374607431768211455 || v3 < (arg0.vx as u256)) {
            return 0
        };
        let v4 = v3 - (arg0.vx as u256);
        if (v4 == 0) {
            return 0
        };
        let v5 = if (arg2) {
            v2 / v4 - v2 / (v4 + (arg1 as u256))
        } else {
            let v6 = v2 / v4;
            if (v6 > 115792089237316195423570985008687907853269984665640564039457584007913129639935 - (arg1 as u256)) {
                return 0
            };
            let v7 = v6 + (arg1 as u256);
            if (v7 == 0) {
                return 0
            };
            let v8 = v2 / v7;
            if (v8 >= v4) {
                0
            } else {
                v4 - v8
            }
        };
        let (v9, v10, v11) = if (arg2) {
            (arg0.x, arg0.y, arg0.fy)
        } else {
            (arg0.y, arg0.x, arg0.fx)
        };
        let v12 = if (v5 > 18446744073709551615) {
            true
        } else if (v5 >= (v10 as u256)) {
            true
        } else {
            (v9 as u256) + (arg1 as u256) > 18446744073709551615
        };
        if (v12) {
            return 0
        };
        let v13 = v5 * (arg0.fee as u256) / 1000000;
        if (v13 >= v5 || v13 + (v11 as u256) > 18446744073709551615) {
            return 0
        };
        ((v5 - v13) as u64)
    }

    fun executable(arg0: &Snapshot, arg1: u64) : bool {
        let v0 = if (arg0.locked) {
            true
        } else if (arg1 < arg0.updated) {
            true
        } else if (arg1 - arg0.updated >= arg0.life) {
            true
        } else {
            arg0.my == 0
        };
        if (v0) {
            return false
        };
        let v1 = (arg0.x as u256) * (arg0.mx as u256) + (arg0.y as u256) * (arg0.my as u256);
        let v2 = (arg0.vx as u256) * (arg0.mx as u256);
        if (v1 < v2) {
            return false
        };
        let v3 = (v1 - v2) / (arg0.my as u256);
        if (v3 > 18446744073709551615) {
            return false
        };
        let v4 = (arg0.ry as u256);
        let v5 = v3 < v4 && (v4 - v3) * 10000 / v4 > 500;
        !v5
    }

    public fun quote<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>, arg2: &0x2::clock::Clock, arg3: bool) {
        let v0 = snapshot<T1, T2>(arg1);
        let v1 = vector[];
        let v2 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            0x1::vector::push_back<u64>(&mut v1, amount_out(&v0, 0x1::vector::pop_back<u64>(&mut v2), arg3, 0x2::clock::timestamp_ms(arg2)));
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>>(arg1), arg3, v1, vector[], vector[]);
    }

    fun snapshot<T0, T1>(arg0: &0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>) : Snapshot {
        let v0 = 0x2::bcs::to_bytes<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T0, T1>>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 163, 1);
        let v1 = 0x2::bcs::new(v0);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_address(&mut v1);
        0x2::bcs::peel_u8(&mut v1);
        0x2::bcs::peel_u8(&mut v1);
        Snapshot{
            concentration : 0x2::bcs::peel_u64(&mut v1),
            x             : 0x2::bcs::peel_u64(&mut v1),
            y             : 0x2::bcs::peel_u64(&mut v1),
            mx            : 0x2::bcs::peel_u64(&mut v1),
            my            : 0x2::bcs::peel_u64(&mut v1),
            vx            : 0x2::bcs::peel_u64(&mut v1),
            ry            : 0x2::bcs::peel_u64(&mut v1),
            locked        : 0x2::bcs::peel_bool(&mut v1),
            fee           : 0x2::bcs::peel_u64(&mut v1),
            fx            : 0x2::bcs::peel_u64(&mut v1),
            fy            : 0x2::bcs::peel_u64(&mut v1),
            updated       : 0x2::bcs::peel_u64(&mut v1),
            life          : 0x2::bcs::peel_u64(&mut v1),
        }
    }

    public fun swap_a2b<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T2>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_x_2_y<T1, T2>(arg1, 0, arg3, arg2, arg4);
        let v2 = v1;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>>(arg1), true, 0x2::balance::value<T2>(&v2));
        (v2, v0)
    }

    public fun swap_b2a<T0, T1, T2>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<T2>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T2>) {
        let (v0, v1) = 0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::swap_y_2_x<T1, T2>(arg1, 0, arg3, arg2, arg4);
        let v2 = v0;
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0x56f72145f18db9709dc328f3e016d84cb775877527d1b3da2d8e740d60537795::saturation_curve::Pool<T1, T2>>(arg1), false, 0x2::balance::value<T1>(&v2));
        (v2, v1)
    }

    // decompiled from Move bytecode v7
}

