module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::mint_cap {
    struct MintCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GainKey has copy, drop, store {
        epoch: u64,
    }

    struct ProvKey has copy, drop, store {
        epoch: u64,
    }

    struct ScaleKey has copy, drop, store {
        epoch: u64,
    }

    struct Carry has copy, drop, store {
        epoch: u64,
        room: u64,
    }

    struct MintCap has store {
        k: u64,
        window: u64,
        next_epoch: u64,
        carry: vector<Carry>,
    }

    struct Gain has copy, drop, store {
        up: u128,
        down: u128,
    }

    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct MintEpochFinalizedEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        epoch: u64,
        gain_up: u128,
        gain_down: u128,
        room: u64,
        carry_in: u128,
        provisional: u64,
        used: u64,
        scale_ppm: u64,
        carry_out: u128,
    }

    struct MintCapParamsEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        k: u64,
        window: u64,
    }

    fun ensure<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: u64) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v0, v1)) {
            let v2 = MintCapKey{dummy_field: false};
            let v3 = MintCap{
                k          : 100,
                window     : 7,
                next_epoch : arg2,
                carry      : 0x1::vector::empty<Carry>(),
            };
            0x2::dynamic_field::add<MintCapKey, MintCap>(v0, v2, v3);
        };
    }

    public fun epoch_of(arg0: u64) : u64 {
        arg0 / 86400000
    }

    public fun epoch_status<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u64) : (u128, u128, u64) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = GainKey{epoch: arg1};
        let (v2, v3) = if (0x2::dynamic_field::exists<GainKey>(v0, v1)) {
            let v4 = GainKey{epoch: arg1};
            let v5 = 0x2::dynamic_field::borrow<GainKey, Gain>(v0, v4);
            (v5.up, v5.down)
        } else {
            (0, 0)
        };
        let v6 = ProvKey{epoch: arg1};
        let v7 = if (0x2::dynamic_field::exists<ProvKey>(v0, v6)) {
            let v8 = ProvKey{epoch: arg1};
            *0x2::dynamic_field::borrow<ProvKey, u64>(v0, v8)
        } else {
            0
        };
        (v2, v3, v7)
    }

    public fun finalize_epoch<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x2::clock::Clock) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0);
        let v2 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v1, v2)) {
            return false
        };
        let v3 = MintCapKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<MintCapKey, MintCap>(v1, v3);
        let v5 = v4.next_epoch;
        let v6 = v4.window;
        if ((v5 + 1) * 86400000 > 0x2::clock::timestamp_ms(arg1)) {
            return false
        };
        let v7 = GainKey{epoch: v5};
        let v8 = if (0x2::dynamic_field::exists<GainKey>(v1, v7)) {
            let v9 = GainKey{epoch: v5};
            0x2::dynamic_field::remove<GainKey, Gain>(v1, v9)
        } else {
            Gain{up: 0, down: 0}
        };
        let v10 = v8;
        let v11 = ProvKey{epoch: v5};
        let v12 = if (0x2::dynamic_field::exists<ProvKey>(v1, v11)) {
            let v13 = ProvKey{epoch: v5};
            0x2::dynamic_field::remove<ProvKey, u64>(v1, v13)
        } else {
            0
        };
        let v14 = if (v10.up > v10.down) {
            let v15 = (v10.up - v10.down) * ((v4.k * 1000) as u128);
            if (v15 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v15 as u64)
            }
        } else {
            0
        };
        let v16 = MintCapKey{dummy_field: false};
        let v17 = 0x2::dynamic_field::borrow_mut<MintCapKey, MintCap>(v1, v16);
        while (!0x1::vector::is_empty<Carry>(&v17.carry) && 0x1::vector::borrow<Carry>(&v17.carry, 0).epoch + v6 < v5) {
            0x1::vector::remove<Carry>(&mut v17.carry, 0);
        };
        let v18 = 0;
        let v19 = &v17.carry;
        let v20 = 0;
        while (v20 < 0x1::vector::length<Carry>(v19)) {
            v18 = v18 + (0x1::vector::borrow<Carry>(v19, v20).room as u128);
            v20 = v20 + 1;
        };
        let v21 = v18 + (v14 as u128);
        let v22 = if (v12 == 0 || v21 >= (v12 as u128)) {
            1000000
        } else {
            ((v21 * (1000000 as u128) / (v12 as u128)) as u64)
        };
        let v23 = if (v21 < (v12 as u128)) {
            v21
        } else {
            (v12 as u128)
        };
        let v24 = v23;
        while (v24 > 0 && !0x1::vector::is_empty<Carry>(&v17.carry)) {
            let v25 = 0x1::vector::borrow_mut<Carry>(&mut v17.carry, 0);
            if ((v25.room as u128) <= v24) {
                v24 = v24 - (v25.room as u128);
                0x1::vector::remove<Carry>(&mut v17.carry, 0);
                continue
            };
            v25.room = v25.room - (v24 as u64);
            v24 = 0;
        };
        let v26 = v14 - (v24 as u64);
        if (v26 > 0) {
            let v27 = Carry{
                epoch : v5,
                room  : v26,
            };
            0x1::vector::push_back<Carry>(&mut v17.carry, v27);
        };
        while (0x1::vector::length<Carry>(&v17.carry) > v6) {
            0x1::vector::remove<Carry>(&mut v17.carry, 0);
        };
        let v28 = 0;
        let v29 = &v17.carry;
        let v30 = 0;
        while (v30 < 0x1::vector::length<Carry>(v29)) {
            v28 = v28 + (0x1::vector::borrow<Carry>(v29, v30).room as u128);
            v30 = v30 + 1;
        };
        v17.next_epoch = v5 + 1;
        if (v12 > 0 && v22 < 1000000) {
            let v31 = ScaleKey{epoch: v5};
            0x2::dynamic_field::add<ScaleKey, u64>(v1, v31, v22);
        };
        let v32 = MintEpochFinalizedEventV1{
            exchange_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0),
            epoch       : v5,
            gain_up     : v10.up,
            gain_down   : v10.down,
            room        : v14,
            carry_in    : v18,
            provisional : v12,
            used        : (v23 as u64),
            scale_ppm   : v22,
            carry_out   : v28,
        };
        let v33 = Event<MintEpochFinalizedEventV1>{pos0: v32};
        0x2::event::emit<Event<MintEpochFinalizedEventV1>>(v33);
        true
    }

    public(friend) fun note_mint<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        let v0 = epoch_of(arg2);
        ensure<T0>(arg0, arg1, v0);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = ProvKey{epoch: v0};
        if (!0x2::dynamic_field::exists<ProvKey>(v1, v2)) {
            0x2::dynamic_field::add<ProvKey, u64>(v1, v2, 0);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<ProvKey, u64>(v1, v2);
        *v3 = *v3 + arg3;
    }

    public(friend) fun note_pnl<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: u64, arg3: u64, arg4: u64) {
        if (arg3 == 0 && arg4 == 0) {
            return
        };
        let v0 = epoch_of(arg2);
        let v1 = v0;
        ensure<T0>(arg0, arg1, v0);
        let v2 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v3 = MintCapKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<MintCapKey, MintCap>(v2, v3).next_epoch;
        if (v0 < v4) {
            v1 = v4;
        };
        let v5 = GainKey{epoch: v1};
        if (!0x2::dynamic_field::exists<GainKey>(v2, v5)) {
            let v6 = Gain{
                up   : 0,
                down : 0,
            };
            0x2::dynamic_field::add<GainKey, Gain>(v2, v5, v6);
        };
        let v7 = 0x2::dynamic_field::borrow_mut<GainKey, Gain>(v2, v5);
        v7.up = v7.up + (arg3 as u128);
        v7.down = v7.down + (arg4 as u128);
    }

    public fun params<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>) : (u64, u64, u64, u128) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v0, v1)) {
            return (100, 7, 0, 0)
        };
        let v2 = MintCapKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow<MintCapKey, MintCap>(v0, v2);
        let v4 = 0;
        let v5 = &v3.carry;
        let v6 = 0;
        while (v6 < 0x1::vector::length<Carry>(v5)) {
            v4 = v4 + (0x1::vector::borrow<Carry>(v5, v6).room as u128);
            v6 = v6 + 1;
        };
        (v3.k, v3.window, v3.next_epoch, v4)
    }

    public fun scale_of<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u64) : (bool, u64) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0);
        let v1 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v0, v1)) {
            return (false, 0)
        };
        let v2 = MintCapKey{dummy_field: false};
        if (arg1 >= 0x2::dynamic_field::borrow<MintCapKey, MintCap>(v0, v2).next_epoch) {
            return (false, 0)
        };
        let v3 = ScaleKey{epoch: arg1};
        if (!0x2::dynamic_field::exists<ScaleKey>(v0, v3)) {
            return (true, 1000000)
        };
        let v4 = ScaleKey{epoch: arg1};
        (true, *0x2::dynamic_field::borrow<ScaleKey, u64>(v0, v4))
    }

    public fun set_params<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        let v0 = if (arg3 >= 1) {
            if (arg3 <= 1000) {
                if (arg4 >= 1) {
                    arg4 <= 30
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        let v1 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue_on<T0>(arg1, arg0);
        ensure<T0>(&v1, arg0, epoch_of(0x2::clock::timestamp_ms(arg5)));
        let v2 = MintCapKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<MintCapKey, MintCap>(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v1, arg0), v2);
        v3.k = arg3;
        v3.window = arg4;
        let v4 = MintCapParamsEventV1{
            exchange_id : 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0),
            k           : arg3,
            window      : arg4,
        };
        let v5 = Event<MintCapParamsEventV1>{pos0: v4};
        0x2::event::emit<Event<MintCapParamsEventV1>>(v5);
    }

    public(friend) fun unnote_mint<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::access::Auth, arg1: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        let v0 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = ProvKey{epoch: arg2};
        if (arg3 == 0 || !0x2::dynamic_field::exists<ProvKey>(v0, v1)) {
            return
        };
        let v2 = 0x2::dynamic_field::borrow_mut<ProvKey, u64>(v0, v1);
        let v3 = if (*v2 > arg3) {
            *v2 - arg3
        } else {
            0
        };
        *v2 = v3;
    }

    // decompiled from Move bytecode v7
}

