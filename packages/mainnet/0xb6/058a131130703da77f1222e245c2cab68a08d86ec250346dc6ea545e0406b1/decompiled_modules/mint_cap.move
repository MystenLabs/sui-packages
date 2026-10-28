module 0xb6058a131130703da77f1222e245c2cab68a08d86ec250346dc6ea545e0406b1::mint_cap {
    struct MintCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FloorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GainKey has copy, drop, store {
        epoch: u64,
    }

    struct ProvKey has copy, drop, store {
        epoch: u64,
    }

    struct LossKey has copy, drop, store {
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

    struct FloorCfg has copy, drop, store {
        floor: u64,
        debt_cap: u64,
        debt: u64,
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

    struct MintEpochFinalizedEventV2 has copy, drop {
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
        debt: u64,
        debt_added: u64,
        loss_basis: u128,
    }

    struct MintCapParamsEventV2 has copy, drop {
        exchange_id: 0x2::object::ID,
        k: u64,
        window: u64,
        floor: u64,
        debt_cap: u64,
    }

    struct MintDebtUnwoundEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        removed: u64,
        repaid: u64,
        debt: u64,
    }

    fun assert_floor_within_tenth(arg0: u64, arg1: u64) {
        assert!((arg0 as u128) * 10 <= (arg1 as u128), 1);
    }

    public fun default_debt_cap() : u64 {
        10000000000000000
    }

    public fun default_floor() : u64 {
        10
    }

    fun ensure<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v0, v1)) {
            assert_floor_within_tenth(10, 100);
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

    public fun epoch_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : u128 {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
        let v1 = LossKey{epoch: arg1};
        if (!0x2::dynamic_field::exists<LossKey>(v0, v1)) {
            return 0
        };
        let v2 = LossKey{epoch: arg1};
        *0x2::dynamic_field::borrow<LossKey, u128>(v0, v2)
    }

    public fun epoch_of(arg0: u64) : u64 {
        arg0 / 86400000
    }

    public fun epoch_status<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : (u128, u128, u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
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

    public fun finalize_epoch<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x2::clock::Clock) : bool {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        let v0 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = MintCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<MintCapKey>(v1, v2)) {
            return false
        };
        let v3 = MintCapKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow<MintCapKey, MintCap>(v1, v3);
        let v5 = v4.next_epoch;
        let v6 = v4.k;
        let v7 = v4.window;
        if ((v5 + 1) * 86400000 > 0x2::clock::timestamp_ms(arg2)) {
            return false
        };
        let v8 = load_floor(v1);
        let v9 = GainKey{epoch: v5};
        let v10 = if (0x2::dynamic_field::exists<GainKey>(v1, v9)) {
            let v11 = GainKey{epoch: v5};
            0x2::dynamic_field::remove<GainKey, Gain>(v1, v11)
        } else {
            Gain{up: 0, down: 0}
        };
        let v12 = v10;
        let v13 = ProvKey{epoch: v5};
        let v14 = if (0x2::dynamic_field::exists<ProvKey>(v1, v13)) {
            let v15 = ProvKey{epoch: v5};
            0x2::dynamic_field::remove<ProvKey, u64>(v1, v15)
        } else {
            0
        };
        let v16 = LossKey{epoch: v5};
        let v17 = if (0x2::dynamic_field::exists<LossKey>(v1, v16)) {
            let v18 = LossKey{epoch: v5};
            0x2::dynamic_field::remove<LossKey, u128>(v1, v18)
        } else {
            0
        };
        let v19 = if (v12.up > v12.down) {
            let v20 = (v12.up - v12.down) * ((v6 * 1000) as u128);
            if (v20 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v20 as u64)
            }
        } else {
            0
        };
        let v21 = v6 / 10;
        let v22 = if (v8.floor > v21) {
            v21
        } else {
            v8.floor
        };
        let v23 = v17 * (v22 as u128) * (1000 as u128);
        let v24 = (v14 as u128);
        let v25 = if (v23 < v24) {
            v23
        } else {
            v24
        };
        let v26 = 0;
        let v27 = 0;
        let v28 = MintCapKey{dummy_field: false};
        let v29 = 0x2::dynamic_field::borrow_mut<MintCapKey, MintCap>(v1, v28);
        while (!0x1::vector::is_empty<Carry>(&v29.carry) && 0x1::vector::borrow<Carry>(&v29.carry, 0).epoch + v7 < v5) {
            0x1::vector::remove<Carry>(&mut v29.carry, 0);
        };
        let v30 = &v29.carry;
        let v31 = 0;
        while (v31 < 0x1::vector::length<Carry>(v30)) {
            v27 = v27 + (0x1::vector::borrow<Carry>(v30, v31).room as u128);
            v31 = v31 + 1;
        };
        let v32 = if (v8.debt < v19) {
            v8.debt
        } else {
            v19
        };
        let v33 = v8.debt - v32;
        let v34 = v19 - v32;
        let v35 = v27 + (v34 as u128);
        let v36 = if (v35 < (v14 as u128)) {
            v35
        } else {
            (v14 as u128)
        };
        let v37 = v35 + ((v8.debt_cap - v33) as u128);
        let v38 = if (v25 < v37) {
            v25
        } else {
            v37
        };
        let v39 = if (v36 > v38) {
            v36
        } else {
            v38
        };
        let v40 = if (v14 == 0 || v39 >= (v14 as u128)) {
            1000000
        } else {
            ((v39 * (1000000 as u128) / (v14 as u128)) as u64)
        };
        let v41 = if (v40 == 1000000) {
            v39
        } else {
            (v14 as u128) * (v40 as u128) / (1000000 as u128)
        };
        let v42 = if (v41 < v35) {
            v41
        } else {
            v35
        };
        let v43 = v41 - v42;
        let v44 = v33 + (v43 as u64);
        let v45 = v42;
        while (v45 > 0 && !0x1::vector::is_empty<Carry>(&v29.carry)) {
            let v46 = 0x1::vector::borrow_mut<Carry>(&mut v29.carry, 0);
            if ((v46.room as u128) <= v45) {
                v45 = v45 - (v46.room as u128);
                0x1::vector::remove<Carry>(&mut v29.carry, 0);
                continue
            };
            v46.room = v46.room - (v45 as u64);
            v45 = 0;
        };
        let v47 = v34 - (v45 as u64);
        if (v47 > 0) {
            let v48 = Carry{
                epoch : v5,
                room  : v47,
            };
            0x1::vector::push_back<Carry>(&mut v29.carry, v48);
        };
        while (0x1::vector::length<Carry>(&v29.carry) > v7) {
            0x1::vector::remove<Carry>(&mut v29.carry, 0);
        };
        let v49 = &v29.carry;
        let v50 = 0;
        while (v50 < 0x1::vector::length<Carry>(v49)) {
            v26 = v26 + (0x1::vector::borrow<Carry>(v49, v50).room as u128);
            v50 = v50 + 1;
        };
        v29.next_epoch = v5 + 1;
        let v51 = (v41 as u64);
        let v52 = FloorCfg{
            floor    : v8.floor,
            debt_cap : v8.debt_cap,
            debt     : v44,
        };
        store_floor(v1, v52);
        if (v14 > 0 && v40 < 1000000) {
            let v53 = ScaleKey{epoch: v5};
            0x2::dynamic_field::add<ScaleKey, u64>(v1, v53, v40);
        };
        let v54 = MintEpochFinalizedEventV1{
            exchange_id : v0,
            epoch       : v5,
            gain_up     : v12.up,
            gain_down   : v12.down,
            room        : v19,
            carry_in    : v27,
            provisional : v14,
            used        : v51,
            scale_ppm   : v40,
            carry_out   : v26,
        };
        let v55 = Event<MintEpochFinalizedEventV1>{pos0: v54};
        0x2::event::emit<Event<MintEpochFinalizedEventV1>>(v55);
        let v56 = MintEpochFinalizedEventV2{
            exchange_id : v0,
            epoch       : v5,
            gain_up     : v12.up,
            gain_down   : v12.down,
            room        : v19,
            carry_in    : v27,
            provisional : v14,
            used        : v51,
            scale_ppm   : v40,
            carry_out   : v26,
            debt        : v44,
            debt_added  : (v43 as u64),
            loss_basis  : v17,
        };
        let v57 = Event<MintEpochFinalizedEventV2>{pos0: v56};
        0x2::event::emit<Event<MintEpochFinalizedEventV2>>(v57);
        true
    }

    fun load_floor(arg0: &0x2::object::UID) : FloorCfg {
        let v0 = FloorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FloorKey>(arg0, v0)) {
            FloorCfg{floor: 10, debt_cap: 10000000000000000, debt: 0}
        } else {
            let v2 = FloorKey{dummy_field: false};
            *0x2::dynamic_field::borrow<FloorKey, FloorCfg>(arg0, v2)
        }
    }

    public fun note_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = epoch_of(arg2);
        ensure<T0>(arg0, arg1, v0);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = LossKey{epoch: v0};
        if (!0x2::dynamic_field::exists<LossKey>(v1, v2)) {
            0x2::dynamic_field::add<LossKey, u128>(v1, v2, 0);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<LossKey, u128>(v1, v2);
        *v3 = *v3 + (arg3 as u128);
    }

    public fun note_mint<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        let v0 = epoch_of(arg2);
        ensure<T0>(arg0, arg1, v0);
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = ProvKey{epoch: v0};
        if (!0x2::dynamic_field::exists<ProvKey>(v1, v2)) {
            0x2::dynamic_field::add<ProvKey, u64>(v1, v2, 0);
        };
        let v3 = 0x2::dynamic_field::borrow_mut<ProvKey, u64>(v1, v2);
        *v3 = *v3 + arg3;
    }

    public fun note_pnl<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64, arg4: u64) {
        if (arg3 == 0 && arg4 == 0) {
            return
        };
        let v0 = epoch_of(arg2);
        let v1 = v0;
        ensure<T0>(arg0, arg1, v0);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
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

    public fun params<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : (u64, u64, u64, u128) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
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

    public fun params_v2<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : (u64, u64, u64, u128, u64, u64, u64) {
        let (v0, v1, v2, v3) = params<T0>(arg0);
        let v4 = load_floor(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0));
        (v0, v1, v2, v3, v4.floor, v4.debt_cap, v4.debt)
    }

    public fun scale_of<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: u64) : (bool, u64) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0);
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

    public fun set_params<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        let v0 = if (arg4 >= 1) {
            if (arg4 <= 1000) {
                if (arg5 >= 1) {
                    arg5 <= 30
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
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg1);
        let v2 = MintCapKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<MintCapKey>(v1, v2)) {
            let v4 = load_floor(v1);
            v4.floor
        } else {
            10
        };
        assert_floor_within_tenth(v3, arg4);
        ensure<T0>(arg0, arg1, epoch_of(0x2::clock::timestamp_ms(arg6)));
        let v5 = MintCapKey{dummy_field: false};
        let v6 = 0x2::dynamic_field::borrow_mut<MintCapKey, MintCap>(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v5);
        v6.k = arg4;
        v6.window = arg5;
        let v7 = MintCapParamsEventV1{
            exchange_id : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1),
            k           : arg4,
            window      : arg5,
        };
        let v8 = Event<MintCapParamsEventV1>{pos0: v7};
        0x2::event::emit<Event<MintCapParamsEventV1>>(v8);
    }

    public fun set_params_v2<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg2), arg3);
        let v0 = if (arg4 >= 1) {
            if (arg4 <= 1000) {
                if (arg5 >= 1) {
                    if (arg5 <= 30) {
                        arg6 <= arg4
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
        };
        assert!(v0, 0);
        assert_floor_within_tenth(arg6, arg4);
        ensure<T0>(arg0, arg1, epoch_of(0x2::clock::timestamp_ms(arg8)));
        let v1 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v2 = load_floor(v1);
        assert!(arg7 >= v2.debt, 0);
        let v3 = MintCapKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<MintCapKey, MintCap>(v1, v3);
        v4.k = arg4;
        v4.window = arg5;
        let v5 = FloorCfg{
            floor    : arg6,
            debt_cap : arg7,
            debt     : v2.debt,
        };
        store_floor(v1, v5);
        let v6 = MintCapParamsEventV2{
            exchange_id : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1),
            k           : arg4,
            window      : arg5,
            floor       : arg6,
            debt_cap    : arg7,
        };
        let v7 = Event<MintCapParamsEventV2>{pos0: v6};
        0x2::event::emit<Event<MintCapParamsEventV2>>(v7);
    }

    fun store_floor(arg0: &mut 0x2::object::UID, arg1: FloorCfg) {
        let v0 = FloorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<FloorKey>(arg0, v0)) {
            let v1 = FloorKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<FloorKey, FloorCfg>(arg0, v1) = arg1;
        } else {
            let v2 = FloorKey{dummy_field: false};
            0x2::dynamic_field::add<FloorKey, FloorCfg>(arg0, v2, arg1);
        };
    }

    public fun unnote_loss<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = LossKey{epoch: arg2};
        if (!0x2::dynamic_field::exists<LossKey>(v0, v1)) {
            return 0
        };
        let v2 = 0x2::dynamic_field::borrow_mut<LossKey, u128>(v0, v1);
        let v3 = (arg3 as u128);
        let v4 = if (*v2 > v3) {
            v3
        } else {
            *v2
        };
        *v2 = *v2 - v4;
        (v4 as u64)
    }

    public fun unnote_mint<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let (v0, v1) = scale_of<T0>(arg1, arg2);
        if (v0) {
            unwind_debt<T0>(arg0, arg1, (((arg3 as u128) * (v1 as u128) / (1000000 as u128)) as u64));
            return
        };
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v3 = ProvKey{epoch: arg2};
        if (!0x2::dynamic_field::exists<ProvKey>(v2, v3)) {
            return
        };
        let v4 = 0x2::dynamic_field::borrow_mut<ProvKey, u64>(v2, v3);
        let v5 = if (*v4 > arg3) {
            *v4 - arg3
        } else {
            0
        };
        *v4 = v5;
    }

    public(friend) fun unwind_debt<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1);
        let v1 = FloorKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<FloorKey>(v0, v1)) {
            return
        };
        let v2 = FloorKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<FloorKey, FloorCfg>(v0, v2);
        if (v3.debt == 0) {
            return
        };
        let v4 = 0x1::u64::min(v3.debt, arg2);
        v3.debt = v3.debt - v4;
        let v5 = MintDebtUnwoundEventV1{
            exchange_id : 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg1),
            removed     : arg2,
            repaid      : v4,
            debt        : v3.debt,
        };
        let v6 = Event<MintDebtUnwoundEventV1>{pos0: v5};
        0x2::event::emit<Event<MintDebtUnwoundEventV1>>(v6);
    }

    // decompiled from Move bytecode v7
}

