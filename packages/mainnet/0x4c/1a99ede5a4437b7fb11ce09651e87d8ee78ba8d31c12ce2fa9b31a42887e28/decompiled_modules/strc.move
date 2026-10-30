module 0x4c1a99ede5a4437b7fb11ce09651e87d8ee78ba8d31c12ce2fa9b31a42887e28::strc {
    struct STRC has drop {
        dummy_field: bool,
    }

    struct FundsKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ActiveCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ActiveCap has drop, store {
        id: 0x2::object::ID,
        expires_ms: u64,
    }

    struct CapRotated has copy, drop {
        old: 0x2::object::ID,
        new: 0x2::object::ID,
        expires_ms: u64,
    }

    struct LastSlotKey has copy, drop, store {
        h: address,
    }

    struct AttestKey has copy, drop, store {
        slot: u64,
    }

    struct SlotState has drop, store {
        attested_ms: u64,
        supply_at_attest: u64,
        declared: u64,
        paid: u64,
        batches: u64,
        strcx_micro: u64,
        dividend_ref: vector<u8>,
        filing_sha256: vector<u8>,
        price_micro: u64,
        price_ref: vector<u8>,
        rate_bps: u64,
    }

    struct AttestCap has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct AttestCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LastAttestKey has copy, drop, store {
        dummy_field: bool,
    }

    struct HolderRegistry has key {
        id: 0x2::object::UID,
        count: u64,
        bond: 0x2::balance::Balance<STRC>,
        pending: u64,
        pend_bond: 0x2::balance::Balance<STRC>,
    }

    struct PendKey has copy, drop, store {
        h: address,
    }

    struct CoolKey has copy, drop, store {
        h: address,
    }

    struct MinKey has copy, drop, store {
        h: address,
    }

    struct FloorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecBatchKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RecBatch has drop, store {
        slot: u64,
        sha: vector<u8>,
        dividend_ref: vector<u8>,
        total: u64,
        next: u64,
    }

    struct MoreMinimumsRecorded has copy, drop {
        slot: u64,
        start: u64,
        records: u64,
        next: u64,
        total: u64,
        artifact_sha256: vector<u8>,
    }

    struct RecSlotKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MinRec has copy, drop, store {
        min: u64,
        slot: u64,
    }

    struct Floor has drop, store {
        slot: u64,
        hs: vector<address>,
        mins: vector<u64>,
        next: u64,
    }

    struct RegistrationQueued has copy, drop {
        holder: address,
        pending: u64,
        ms: u64,
    }

    struct PendingRemoved has copy, drop {
        holder: address,
        pending: u64,
        expired: bool,
    }

    struct HolderEvicted has copy, drop {
        holder: address,
        by: address,
        holder_min: u64,
        newcomer_min: u64,
        slot: u64,
    }

    struct MinimumsRecorded has copy, drop {
        slot: u64,
        records: u64,
        floor: u64,
        artifact_sha256: vector<u8>,
        total: u64,
    }

    struct QueueFull has copy, drop {
        holder: address,
        ms: u64,
    }

    struct PendingPromoted has copy, drop {
        holder: address,
        pending: u64,
    }

    struct RegKey has copy, drop, store {
        h: address,
    }

    struct HolderRegistered has copy, drop {
        holder: address,
        n: u64,
    }

    struct HolderPruned has copy, drop {
        holder: address,
        n: u64,
    }

    struct HolderDeregistered has copy, drop {
        holder: address,
        n: u64,
    }

    struct DeskKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RefPriceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RefPrice has drop, store {
        price_micro: u64,
        set_ms: u64,
    }

    struct ReferencePriceReset has copy, drop {
        old_price_micro: u64,
        new_price_micro: u64,
        ms: u64,
        slot: u64,
        by: address,
    }

    struct ClaimVault has key {
        id: 0x2::object::UID,
        version: u64,
        coin: 0x1::option::Option<0x1::type_name::TypeName>,
        treasury: 0x2::coin::TreasuryCap<STRC>,
        credits: 0x2::table::Table<address, u64>,
        last_ms: 0x2::table::Table<address, u64>,
        total_credited: u64,
        total_claimed: u64,
        total_pushed: u64,
        max_supply: u64,
    }

    struct PayoutAdminCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct PayoutOwnerCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct OwnerKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PaidInSlot has copy, drop, store {
        slot: u64,
        h: address,
    }

    struct Attested has copy, drop {
        slot: u64,
        ms: u64,
        total_supply: u64,
        strcx_micro: u64,
        dividend_ref: vector<u8>,
        filing_sha256: vector<u8>,
        price_micro: u64,
        price_ref: vector<u8>,
        rate_bps: u64,
    }

    struct Pushed has copy, drop {
        slot: u64,
        holders: u64,
        amount: u64,
        declared: u64,
    }

    struct Credited has copy, drop {
        slot: u64,
        holders: u64,
        amount: u64,
        declared: u64,
    }

    struct Claimed has copy, drop {
        holder: address,
        amount: u64,
    }

    struct MinsPruned has copy, drop {
        slot: u64,
        pruned: u64,
    }

    public fun mint(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        gate_at(arg0, arg1, v0);
        assert!((0x2::coin::total_supply<STRC>(&arg1.treasury) as u128) + (arg3 as u128) <= (arg1.max_supply as u128), 10);
        let v1 = LastAttestKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<LastAttestKey>(&arg1.id, v1), 28);
        let v2 = LastAttestKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg1.id, v2);
        let v4 = slot_of(v0);
        assert!(v3 == v4 || v3 + 1 == v4, 28);
        let v5 = AttestKey{slot: v3};
        let v6 = 0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg1.id, v5);
        assert!(v0 >= v6.attested_ms && v0 - v6.attested_ms <= 86400000, 30);
        assert!((0x2::coin::total_supply<STRC>(&arg1.treasury) as u128) + (arg3 as u128) <= (v6.strcx_micro as u128), 29);
        0x2::transfer::public_transfer<0x2::coin::Coin<STRC>>(0x2::coin::mint<STRC>(&mut arg1.treasury, arg3, arg5), arg4);
    }

    public fun total_supply(arg0: &ClaimVault) : u64 {
        0x2::coin::total_supply<STRC>(&arg0.treasury)
    }

    public fun active_cap(arg0: &ClaimVault) : 0x1::option::Option<0x2::object::ID> {
        let v0 = ActiveCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ActiveCapKey>(&arg0.id, v0)) {
            let v2 = ActiveCapKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(0x2::dynamic_field::borrow<ActiveCapKey, ActiveCap>(&arg0.id, v2).id)
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun allowed_jump_bps(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg1 > arg0 + 1) {
            arg1 - arg0 - 1
        } else {
            0
        };
        let v1 = if (v0 >= 2) {
            3000
        } else {
            1000 + v0 * 1000
        };
        if (v1 > 3000) {
            3000
        } else {
            v1
        }
    }

    public fun attest(arg0: &AttestCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: vector<u8>, arg8: u64) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        attest_cap_ok(arg0, arg1);
        assert!(arg8 > 0 && arg8 <= 1500, 34);
        let v1 = if (arg6 > 0) {
            if (0x1::vector::length<u8>(&arg7) > 0) {
                0x1::vector::length<u8>(&arg7) <= 128
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 33);
        let v2 = LastAttestKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastAttestKey>(&arg1.id, v2)) {
            let v3 = LastAttestKey{dummy_field: false};
            let v4 = *0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg1.id, v3);
            let v5 = AttestKey{slot: v4};
            let v6 = 0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg1.id, v5);
            let v7 = if (arg8 >= v6.rate_bps) {
                arg8 - v6.rate_bps
            } else {
                v6.rate_bps - arg8
            };
            assert!(v7 <= 100, 35);
            let v8 = RefPriceKey{dummy_field: false};
            if (!0x2::dynamic_field::exists_<RefPriceKey>(&arg1.id, v8)) {
                let v9 = v6.price_micro;
                let v10 = if (arg6 >= v9) {
                    arg6 - v9
                } else {
                    v9 - arg6
                };
                assert!((v10 as u128) * 10000 <= (v9 as u128) * (allowed_jump_bps(v4, slot_of(v0)) as u128), 36);
            };
        };
        let v11 = RefPriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RefPriceKey>(&arg1.id, v11)) {
            let v12 = RefPriceKey{dummy_field: false};
            let v13 = 0x2::dynamic_field::remove<RefPriceKey, RefPrice>(&mut arg1.id, v12);
            let v14 = v13.price_micro;
            let v15 = if (arg6 >= v14) {
                arg6 - v14
            } else {
                v14 - arg6
            };
            assert!((v15 as u128) * 10000 <= (v14 as u128) * (1000 as u128), 36);
        };
        let v16 = slot_of(v0);
        let v17 = AttestKey{slot: v16};
        assert!(!0x2::dynamic_field::exists_<AttestKey>(&arg1.id, v17), 17);
        let v18 = 0x2::coin::total_supply<STRC>(&arg1.treasury);
        assert!(arg3 >= v18, 31);
        let v19 = if (0x1::vector::length<u8>(&arg4) > 0) {
            if (0x1::vector::length<u8>(&arg4) <= 64) {
                0x1::vector::length<u8>(&arg5) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v19, 31);
        let v20 = SlotState{
            attested_ms      : v0,
            supply_at_attest : v18,
            declared         : 0,
            paid             : 0,
            batches          : 0,
            strcx_micro      : arg3,
            dividend_ref     : arg4,
            filing_sha256    : arg5,
            price_micro      : arg6,
            price_ref        : arg7,
            rate_bps         : arg8,
        };
        0x2::dynamic_field::add<AttestKey, SlotState>(&mut arg1.id, v17, v20);
        let v21 = LastAttestKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastAttestKey>(&arg1.id, v21)) {
            let v22 = LastAttestKey{dummy_field: false};
            0x2::dynamic_field::remove<LastAttestKey, u64>(&mut arg1.id, v22);
        };
        let v23 = LastAttestKey{dummy_field: false};
        0x2::dynamic_field::add<LastAttestKey, u64>(&mut arg1.id, v23, v16);
        let v24 = Attested{
            slot          : v16,
            ms            : v0,
            total_supply  : v18,
            strcx_micro   : arg3,
            dividend_ref  : arg4,
            filing_sha256 : arg5,
            price_micro   : arg6,
            price_ref     : arg7,
            rate_bps      : arg8,
        };
        0x2::event::emit<Attested>(v24);
    }

    public fun attest_cap(arg0: &ClaimVault) : 0x1::option::Option<0x2::object::ID> {
        let v0 = AttestCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<AttestCapKey>(&arg0.id, v0)) {
            let v2 = AttestCapKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<AttestCapKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun attest_cap_ok(arg0: &AttestCap, arg1: &ClaimVault) {
        assert!(arg1.version == 2, 16);
        assert!(arg0.vault == 0x2::object::id<ClaimVault>(arg1), 32);
        let v0 = AttestCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<AttestCapKey>(&arg1.id, v0)) {
            let v2 = AttestCapKey{dummy_field: false};
            *0x2::dynamic_field::borrow<AttestCapKey, 0x2::object::ID>(&arg1.id, v2) == 0x2::object::id<AttestCap>(arg0)
        } else {
            false
        };
        assert!(v1, 32);
    }

    public fun attested(arg0: &ClaimVault, arg1: u64) : bool {
        let v0 = AttestKey{slot: arg1};
        0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)
    }

    public fun attested_strcx_base(arg0: &ClaimVault, arg1: &0x2::clock::Clock) : u64 {
        let v0 = LastAttestKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<LastAttestKey>(&arg0.id, v0)) {
            return 0
        };
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = LastAttestKey{dummy_field: false};
        let v3 = *0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg0.id, v2);
        let v4 = slot_of(v1);
        let v5 = v3 == v4 || v3 + 1 == v4;
        if (!v5) {
            return 0
        };
        let v6 = AttestKey{slot: v3};
        let v7 = 0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v6);
        if (v1 < v7.attested_ms || v1 - v7.attested_ms > 86400000) {
            return 0
        };
        v7.strcx_micro
    }

    public fun bonded(arg0: &HolderRegistry) : u64 {
        0x2::balance::value<STRC>(&arg0.bond)
    }

    public fun cancel_pending(arg0: &mut HolderRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PendKey{h: v0};
        assert!(0x2::dynamic_field::exists_<PendKey>(&arg0.id, v1), 44);
        unqueue(arg0, v0, false, arg1);
    }

    fun cap_ok(arg0: &PayoutAdminCap, arg1: &ClaimVault) {
        assert!(arg0.vault == 0x2::object::id<ClaimVault>(arg1), 5);
        let v0 = ActiveCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ActiveCapKey>(&arg1.id, v0)) {
            let v1 = ActiveCapKey{dummy_field: false};
            assert!(0x2::dynamic_field::borrow<ActiveCapKey, ActiveCap>(&arg1.id, v1).id == 0x2::object::id<PayoutAdminCap>(arg0), 20);
        };
    }

    fun check<T0>(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: u64, arg3: &vector<address>, arg4: &vector<u64>, arg5: &vector<u64>) : (u64, u64, u64) {
        gate_at(arg0, arg1, arg2);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg1.coin) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg1.coin) == 0x1::type_name::with_defining_ids<T0>(), 11);
        let v0 = 0x1::vector::length<address>(arg3);
        let v1 = if (v0 > 0) {
            if (0x1::vector::length<u64>(arg5) == v0) {
                0x1::vector::length<u64>(arg4) == v0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 1);
        let v2 = slot_of(arg2);
        let v3 = AttestKey{slot: v2};
        assert!(0x2::dynamic_field::exists_<AttestKey>(&arg1.id, v3), 13);
        assert!(mins_complete(arg1, v2), 57);
        let v4 = 0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg1.id, v3);
        let v5 = v4.price_micro;
        let v6 = v4.rate_bps;
        assert!(v5 > 0, 33);
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        while (v7 < v0) {
            assert!(*0x1::vector::borrow<u64>(arg5, v7) > 0 && *0x1::vector::borrow<u64>(arg4, v7) > 0, 6);
            assert!(*0x1::vector::borrow<u64>(arg5, v7) <= daily_cap(*0x1::vector::borrow<u64>(arg4, v7), v5, v6), 9);
            v9 = v9 + *0x1::vector::borrow<u64>(arg5, v7);
            v8 = v8 + *0x1::vector::borrow<u64>(arg4, v7);
            v7 = v7 + 1;
        };
        let v10 = 0x2::dynamic_field::borrow_mut<AttestKey, SlotState>(&mut arg1.id, v3);
        let v11 = v10.supply_at_attest;
        v10.declared = v10.declared + v8;
        v10.paid = v10.paid + v9;
        v10.batches = v10.batches + 1;
        assert!(v10.declared <= v11, 18);
        assert!(v10.paid <= daily_cap(v11, v5, v6), 14);
        let v12 = 0;
        while (v12 < v0) {
            let v13 = PaidInSlot{
                slot : v2,
                h    : *0x1::vector::borrow<address>(arg3, v12),
            };
            assert!(!0x2::dynamic_field::exists_<PaidInSlot>(&arg1.id, v13), 23);
            0x2::dynamic_field::add<PaidInSlot, bool>(&mut arg1.id, v13, true);
            v12 = v12 + 1;
        };
        (v9, v8, v2)
    }

    public fun claim<T0>(arg0: &mut ClaimVault, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.version == 2, 16);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&arg0.coin) && *0x1::option::borrow<0x1::type_name::TypeName>(&arg0.coin) == 0x1::type_name::with_defining_ids<T0>(), 11);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.credits, v0), 4);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.credits, v0);
        arg0.total_claimed = arg0.total_claimed + v1;
        let v2 = Claimed{
            holder : v0,
            amount : v1,
        };
        0x2::event::emit<Claimed>(v2);
        let v3 = FundsKey{dummy_field: false};
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::dynamic_field::borrow_mut<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v3), v1), arg1)
    }

    public fun credit_batch<T0>(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u64>) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2, v3) = check<T0>(arg0, arg1, v0, &arg4, &arg5, &arg6);
        assert!(0x2::coin::value<T0>(&arg3) == v1, 2);
        mark(arg1, v3, v0, &arg4);
        let v4 = FundsKey{dummy_field: false};
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FundsKey, 0x2::balance::Balance<T0>>(&mut arg1.id, v4), 0x2::coin::into_balance<T0>(arg3));
        let v5 = 0;
        while (v5 < 0x1::vector::length<address>(&arg4)) {
            let v6 = *0x1::vector::borrow<address>(&arg4, v5);
            if (0x2::table::contains<address, u64>(&arg1.credits, v6)) {
                let v7 = 0x2::table::borrow_mut<address, u64>(&mut arg1.credits, v6);
                *v7 = *v7 + *0x1::vector::borrow<u64>(&arg6, v5);
            } else {
                0x2::table::add<address, u64>(&mut arg1.credits, v6, *0x1::vector::borrow<u64>(&arg6, v5));
            };
            v5 = v5 + 1;
        };
        arg1.total_credited = arg1.total_credited + v1;
        let v8 = Credited{
            slot     : v3,
            holders  : 0x1::vector::length<address>(&arg4),
            amount   : v1,
            declared : v2,
        };
        0x2::event::emit<Credited>(v8);
    }

    public fun credit_of(arg0: &ClaimVault, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.credits, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.credits, arg1)
        } else {
            0
        }
    }

    public fun daily_cap(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg2 > 0 && arg2 <= 1500, 34);
        let v0 = if (arg1 > 161800000) {
            161800000
        } else {
            arg1
        };
        let v1 = 10000 * (365 as u128);
        (((arg0 as u128) * ((v0 as u128) * (arg2 as u128) + v1 - 1) / v1 / (1000000 as u128)) as u64)
    }

    public fun deregister(arg0: &mut HolderRegistry, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = RegKey{h: v0};
        assert!(0x2::dynamic_field::exists_<RegKey>(&arg0.id, v1), 39);
        unbond(arg0, v0, arg2);
        set_cooldown(arg0, v0, 0x2::clock::timestamp_ms(arg1) + 86400000);
        let v2 = HolderDeregistered{
            holder : v0,
            n      : arg0.count,
        };
        0x2::event::emit<HolderDeregistered>(v2);
    }

    fun drop_min(arg0: &mut HolderRegistry, arg1: address) {
        let v0 = MinKey{h: arg1};
        if (0x2::dynamic_field::exists_<MinKey>(&arg0.id, v0)) {
            let v1 = MinKey{h: arg1};
            0x2::dynamic_field::remove<MinKey, MinRec>(&mut arg0.id, v1);
        };
    }

    public fun expire_pending(arg0: &mut HolderRegistry, arg1: &0x2::clock::Clock, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = *0x1::vector::borrow<address>(&arg2, v0);
            let v2 = PendKey{h: v1};
            let v3 = if (0x2::dynamic_field::exists_<PendKey>(&arg0.id, v2)) {
                let v4 = PendKey{h: v1};
                0x2::clock::timestamp_ms(arg1) >= *0x2::dynamic_field::borrow<PendKey, u64>(&arg0.id, v4) + 604800000
            } else {
                false
            };
            if (v3) {
                unqueue(arg0, v1, true, arg3);
            };
            v0 = v0 + 1;
        };
    }

    fun gate(arg0: &PayoutAdminCap, arg1: &ClaimVault) {
        assert!(arg1.version == 2, 16);
        cap_ok(arg0, arg1);
    }

    fun gate_at(arg0: &PayoutAdminCap, arg1: &ClaimVault, arg2: u64) {
        gate(arg0, arg1);
        let v0 = ActiveCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<ActiveCapKey>(&arg1.id, v0)) {
            let v1 = ActiveCapKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<ActiveCapKey, ActiveCap>(&arg1.id, v1);
            assert!(v2.expires_ms == 0 || arg2 < v2.expires_ms, 21);
        };
    }

    fun init(arg0: STRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRC>(arg0, 6, b"STRC", b"STRC", b"Backed 1:1 by STRCX shares held in the Junction wallet", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRC>>(v1);
        let v2 = ClaimVault{
            id             : 0x2::object::new(arg1),
            version        : 2,
            coin           : 0x1::option::none<0x1::type_name::TypeName>(),
            treasury       : v0,
            credits        : 0x2::table::new<address, u64>(arg1),
            last_ms        : 0x2::table::new<address, u64>(arg1),
            total_credited : 0,
            total_claimed  : 0,
            total_pushed   : 0,
            max_supply     : 1000000000000,
        };
        let v3 = PayoutAdminCap{
            id    : 0x2::object::new(arg1),
            vault : 0x2::object::id<ClaimVault>(&v2),
        };
        let v4 = ActiveCapKey{dummy_field: false};
        let v5 = ActiveCap{
            id         : 0x2::object::id<PayoutAdminCap>(&v3),
            expires_ms : 0,
        };
        0x2::dynamic_field::add<ActiveCapKey, ActiveCap>(&mut v2.id, v4, v5);
        let v6 = PayoutOwnerCap{
            id    : 0x2::object::new(arg1),
            vault : 0x2::object::id<ClaimVault>(&v2),
        };
        let v7 = OwnerKey{dummy_field: false};
        0x2::dynamic_field::add<OwnerKey, 0x2::object::ID>(&mut v2.id, v7, 0x2::object::id<PayoutOwnerCap>(&v6));
        let v8 = AttestCap{
            id    : 0x2::object::new(arg1),
            vault : 0x2::object::id<ClaimVault>(&v2),
        };
        let v9 = AttestCapKey{dummy_field: false};
        0x2::dynamic_field::add<AttestCapKey, 0x2::object::ID>(&mut v2.id, v9, 0x2::object::id<AttestCap>(&v8));
        let v10 = DeskKey{dummy_field: false};
        0x2::dynamic_field::add<DeskKey, address>(&mut v2.id, v10, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<PayoutAdminCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<PayoutOwnerCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AttestCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<ClaimVault>(v2);
        let v11 = HolderRegistry{
            id        : 0x2::object::new(arg1),
            count     : 0,
            bond      : 0x2::balance::zero<STRC>(),
            pending   : 0,
            pend_bond : 0x2::balance::zero<STRC>(),
        };
        0x2::transfer::share_object<HolderRegistry>(v11);
    }

    public fun is_registered(arg0: &HolderRegistry, arg1: address) : bool {
        let v0 = RegKey{h: arg1};
        0x2::dynamic_field::exists_<RegKey>(&arg0.id, v0)
    }

    public fun last_attested_slot(arg0: &ClaimVault) : 0x1::option::Option<u64> {
        let v0 = LastAttestKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastAttestKey>(&arg0.id, v0)) {
            let v2 = LastAttestKey{dummy_field: false};
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg0.id, v2))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun last_paid_slot(arg0: &ClaimVault, arg1: address) : 0x1::option::Option<u64> {
        let v0 = LastSlotKey{h: arg1};
        if (0x2::dynamic_field::exists_<LastSlotKey>(&arg0.id, v0)) {
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<LastSlotKey, u64>(&arg0.id, v0))
        } else {
            0x1::option::none<u64>()
        }
    }

    fun mark(arg0: &mut ClaimVault, arg1: u64, arg2: u64, arg3: &vector<address>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg3)) {
            let v1 = *0x1::vector::borrow<address>(arg3, v0);
            if (0x2::table::contains<address, u64>(&arg0.last_ms, v1)) {
                let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.last_ms, v1);
                assert!(arg2 >= *v2 + 43200000, 15);
                *v2 = arg2;
            } else {
                0x2::table::add<address, u64>(&mut arg0.last_ms, v1, arg2);
            };
            let v3 = LastSlotKey{h: v1};
            if (0x2::dynamic_field::exists_<LastSlotKey>(&arg0.id, v3)) {
                let v4 = 0x2::dynamic_field::borrow_mut<LastSlotKey, u64>(&mut arg0.id, v3);
                assert!(arg1 > *v4, 8);
                *v4 = arg1;
                let v5 = PaidInSlot{
                    slot : *v4,
                    h    : v1,
                };
                if (0x2::dynamic_field::exists_<PaidInSlot>(&arg0.id, v5)) {
                    0x2::dynamic_field::remove<PaidInSlot, bool>(&mut arg0.id, v5);
                };
            } else {
                0x2::dynamic_field::add<LastSlotKey, u64>(&mut arg0.id, v3, arg1);
            };
            v0 = v0 + 1;
        };
    }

    public fun max_registered() : u64 {
        50000
    }

    public fun max_supply(arg0: &ClaimVault) : u64 {
        arg0.max_supply
    }

    public fun migrate(arg0: &PayoutAdminCap, arg1: &mut ClaimVault) {
        abort 25
    }

    public fun migrate_v2(arg0: &PayoutAdminCap, arg1: &0x2::package::UpgradeCap, arg2: &mut ClaimVault, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::upgrade_package(arg1);
        let v1 = 0x1::type_name::with_defining_ids<PayoutOwnerCap>();
        assert!(0x2::address::to_ascii_string(0x2::object::id_to_address(&v0)) == 0x1::type_name::address_string(&v1), 26);
        cap_ok(arg0, arg2);
        assert!(arg2.version < 2, 16);
        arg2.version = 2;
        let v2 = ActiveCapKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<ActiveCapKey>(&arg2.id, v2)) {
            let v3 = ActiveCapKey{dummy_field: false};
            let v4 = ActiveCap{
                id         : 0x2::object::id<PayoutAdminCap>(arg0),
                expires_ms : 0,
            };
            0x2::dynamic_field::add<ActiveCapKey, ActiveCap>(&mut arg2.id, v3, v4);
        };
        let v5 = OwnerKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<OwnerKey>(&arg2.id, v5)) {
            let v6 = PayoutOwnerCap{
                id    : 0x2::object::new(arg3),
                vault : 0x2::object::id<ClaimVault>(arg2),
            };
            let v7 = OwnerKey{dummy_field: false};
            0x2::dynamic_field::add<OwnerKey, 0x2::object::ID>(&mut arg2.id, v7, 0x2::object::id<PayoutOwnerCap>(&v6));
            0x2::transfer::public_transfer<PayoutOwnerCap>(v6, 0x2::tx_context::sender(arg3));
        };
    }

    public fun mins_complete(arg0: &ClaimVault, arg1: u64) : bool {
        let v0 = RecBatchKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<RecBatchKey>(&arg0.id, v0)) {
            return false
        };
        let v1 = RecBatchKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<RecBatchKey, RecBatch>(&arg0.id, v1);
        v2.slot == arg1 && v2.next == v2.total
    }

    public fun mins_recorded(arg0: &ClaimVault, arg1: u64) : bool {
        let v0 = RecBatchKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RecBatchKey>(&arg0.id, v0)) {
            let v2 = RecBatchKey{dummy_field: false};
            0x2::dynamic_field::borrow<RecBatchKey, RecBatch>(&arg0.id, v2).slot == arg1
        } else {
            false
        }
    }

    public fun owner_cap(arg0: &ClaimVault) : 0x1::option::Option<0x2::object::ID> {
        let v0 = OwnerKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<OwnerKey>(&arg0.id, v0)) {
            let v2 = OwnerKey{dummy_field: false};
            0x1::option::some<0x2::object::ID>(*0x2::dynamic_field::borrow<OwnerKey, 0x2::object::ID>(&arg0.id, v2))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    fun owner_ok(arg0: &PayoutOwnerCap, arg1: &ClaimVault) {
        assert!(arg1.version == 2, 16);
        assert!(arg0.vault == 0x2::object::id<ClaimVault>(arg1), 5);
        let v0 = OwnerKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<OwnerKey>(&arg1.id, v0)) {
            let v2 = OwnerKey{dummy_field: false};
            *0x2::dynamic_field::borrow<OwnerKey, 0x2::object::ID>(&arg1.id, v2) == 0x2::object::id<PayoutOwnerCap>(arg0)
        } else {
            false
        };
        assert!(v1, 24);
    }

    public fun paid_in_slot(arg0: &ClaimVault, arg1: u64, arg2: address) : bool {
        let v0 = PaidInSlot{
            slot : arg1,
            h    : arg2,
        };
        0x2::dynamic_field::exists_<PaidInSlot>(&arg0.id, v0)
    }

    public fun pay_batch<T0>(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: vector<address>, arg5: vector<u64>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2, v3) = check<T0>(arg0, arg1, v0, &arg4, &arg5, &arg6);
        assert!(0x2::coin::value<T0>(&arg3) == v1, 2);
        mark(arg1, v3, v0, &arg4);
        let v4 = 0;
        while (v4 < 0x1::vector::length<address>(&arg4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, *0x1::vector::borrow<u64>(&arg6, v4), arg7), *0x1::vector::borrow<address>(&arg4, v4));
            v4 = v4 + 1;
        };
        0x2::coin::destroy_zero<T0>(arg3);
        arg1.total_pushed = arg1.total_pushed + v1;
        let v5 = Pushed{
            slot     : v3,
            holders  : 0x1::vector::length<address>(&arg4),
            amount   : v1,
            declared : v2,
        };
        0x2::event::emit<Pushed>(v5);
    }

    public fun pin_coin<T0>(arg0: &PayoutAdminCap, arg1: &mut ClaimVault) {
        gate(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(*0x1::type_name::as_string(&v0) == 0x1::ascii::string(b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"), 19);
        pin_inner<T0>(arg1);
    }

    fun pin_inner<T0>(arg0: &mut ClaimVault) {
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.coin), 12);
        0x1::option::fill<0x1::type_name::TypeName>(&mut arg0.coin, 0x1::type_name::with_defining_ids<T0>());
        let v0 = FundsKey{dummy_field: false};
        0x2::dynamic_field::add<FundsKey, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::balance::zero<T0>());
    }

    public fun prune_holder(arg0: &PayoutAdminCap, arg1: &ClaimVault, arg2: &mut HolderRegistry, arg3: &0x2::clock::Clock, arg4: address, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        gate(arg0, arg1);
        let v0 = RegKey{h: arg4};
        assert!(0x2::dynamic_field::exists_<RegKey>(&arg2.id, v0), 39);
        unbond(arg2, arg4, arg6);
        if (arg5) {
            set_cooldown(arg2, arg4, 0x2::clock::timestamp_ms(arg3) + 604800000);
        };
        let v1 = HolderPruned{
            holder : arg4,
            n      : arg2.count,
        };
        0x2::event::emit<HolderPruned>(v1);
    }

    public fun prune_holders(arg0: &PayoutAdminCap, arg1: &ClaimVault, arg2: &mut HolderRegistry, arg3: &0x2::clock::Clock, arg4: vector<address>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) {
        gate(arg0, arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg4)) {
            let v1 = *0x1::vector::borrow<address>(&arg4, v0);
            let v2 = RegKey{h: v1};
            if (0x2::dynamic_field::exists_<RegKey>(&arg2.id, v2)) {
                unbond(arg2, v1, arg6);
                if (arg5) {
                    set_cooldown(arg2, v1, 0x2::clock::timestamp_ms(arg3) + 604800000);
                };
                let v3 = HolderPruned{
                    holder : v1,
                    n      : arg2.count,
                };
                0x2::event::emit<HolderPruned>(v3);
            };
            v0 = v0 + 1;
        };
    }

    public fun prune_slot(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: u64, arg4: vector<address>) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        gate_at(arg0, arg1, v0);
        assert!(slot_of(v0) >= arg3 + 7, 27);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg4)) {
            let v2 = PaidInSlot{
                slot : arg3,
                h    : *0x1::vector::borrow<address>(&arg4, v1),
            };
            if (0x2::dynamic_field::exists_<PaidInSlot>(&arg1.id, v2)) {
                0x2::dynamic_field::remove<PaidInSlot, bool>(&mut arg1.id, v2);
            };
            v1 = v1 + 1;
        };
    }

    public fun prune_stale_mins(arg0: &AttestCap, arg1: &ClaimVault, arg2: &mut HolderRegistry, arg3: &0x2::clock::Clock, arg4: vector<address>) {
        attest_cap_ok(arg0, arg1);
        let v0 = slot_of(0x2::clock::timestamp_ms(arg3));
        assert!(0x1::vector::length<address>(&arg4) <= 200, 52);
        let v1 = 0;
        let v2 = 0;
        while (v1 < 0x1::vector::length<address>(&arg4)) {
            let v3 = *0x1::vector::borrow<address>(&arg4, v1);
            let v4 = MinKey{h: v3};
            if (0x2::dynamic_field::exists_<MinKey>(&arg2.id, v4)) {
                let v5 = MinKey{h: v3};
                if (0x2::dynamic_field::borrow<MinKey, MinRec>(&arg2.id, v5).slot + 1 < v0) {
                    let v6 = MinKey{h: v3};
                    0x2::dynamic_field::remove<MinKey, MinRec>(&mut arg2.id, v6);
                    v2 = v2 + 1;
                };
            };
            v1 = v1 + 1;
        };
        let v7 = MinsPruned{
            slot   : v0,
            pruned : v2,
        };
        0x2::event::emit<MinsPruned>(v7);
    }

    public fun record_attested_mins(arg0: &AttestCap, arg1: &mut ClaimVault, arg2: &mut HolderRegistry, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u8>, arg10: vector<u8>, arg11: &mut 0x2::tx_context::TxContext) {
        attest_cap_ok(arg0, arg1);
        let v0 = slot_of(0x2::clock::timestamp_ms(arg3));
        let v1 = LastAttestKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists_<LastAttestKey>(&arg1.id, v1)) {
            let v3 = LastAttestKey{dummy_field: false};
            *0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg1.id, v3) == v0
        } else {
            false
        };
        assert!(v2, 13);
        let v4 = RecSlotKey{dummy_field: false};
        let v5 = if (!0x2::dynamic_field::exists_<RecSlotKey>(&arg2.id, v4)) {
            true
        } else {
            let v6 = RecSlotKey{dummy_field: false};
            *0x2::dynamic_field::borrow<RecSlotKey, u64>(&arg2.id, v6) != v0
        };
        assert!(v5, 47);
        let v7 = if (0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6)) {
            if (0x1::vector::length<address>(&arg7) == 0x1::vector::length<u64>(&arg8)) {
                0x1::vector::length<u8>(&arg9) == 32
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 1);
        assert!(0x1::vector::length<address>(&arg5) <= 200 && 0x1::vector::length<address>(&arg7) <= 100, 52);
        assert!(0x1::vector::length<address>(&arg5) <= arg4 && arg4 <= 1000, 52);
        assert!(arg10 == slot_dividend_ref(arg1, v0), 55);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&arg7)) {
            let v9 = RegKey{h: *0x1::vector::borrow<address>(&arg7, v8)};
            assert!(0x2::dynamic_field::exists_<RegKey>(&arg2.id, v9) && (v8 == 0 || *0x1::vector::borrow<u64>(&arg8, v8 - 1) <= *0x1::vector::borrow<u64>(&arg8, v8)), 52);
            v8 = v8 + 1;
        };
        let v10 = FloorKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<FloorKey>(&arg2.id, v10)) {
            let v11 = FloorKey{dummy_field: false};
            0x2::dynamic_field::remove<FloorKey, Floor>(&mut arg2.id, v11);
        };
        let v12 = FloorKey{dummy_field: false};
        let v13 = Floor{
            slot : v0,
            hs   : arg7,
            mins : arg8,
            next : 0,
        };
        0x2::dynamic_field::add<FloorKey, Floor>(&mut arg2.id, v12, v13);
        let v14 = RecSlotKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RecSlotKey>(&arg2.id, v14)) {
            let v15 = RecSlotKey{dummy_field: false};
            0x2::dynamic_field::remove<RecSlotKey, u64>(&mut arg2.id, v15);
        };
        let v16 = RecSlotKey{dummy_field: false};
        0x2::dynamic_field::add<RecSlotKey, u64>(&mut arg2.id, v16, v0);
        let v17 = RecBatchKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RecBatchKey>(&arg1.id, v17)) {
            let v18 = RecBatchKey{dummy_field: false};
            0x2::dynamic_field::remove<RecBatchKey, RecBatch>(&mut arg1.id, v18);
        };
        let v19 = RecBatchKey{dummy_field: false};
        let v20 = RecBatch{
            slot         : v0,
            sha          : arg9,
            dividend_ref : arg10,
            total        : arg4,
            next         : 0x1::vector::length<address>(&arg5),
        };
        0x2::dynamic_field::add<RecBatchKey, RecBatch>(&mut arg1.id, v19, v20);
        let v21 = MinimumsRecorded{
            slot            : v0,
            records         : 0x1::vector::length<address>(&arg5),
            floor           : 0x1::vector::length<address>(&arg7),
            artifact_sha256 : arg9,
            total           : arg4,
        };
        0x2::event::emit<MinimumsRecorded>(v21);
        write_and_promote(arg2, &arg5, &arg6, v0, 0x2::clock::timestamp_ms(arg3), arg11);
    }

    public fun record_more_mins(arg0: &AttestCap, arg1: &mut ClaimVault, arg2: &mut HolderRegistry, arg3: &0x2::clock::Clock, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        attest_cap_ok(arg0, arg1);
        let v0 = slot_of(0x2::clock::timestamp_ms(arg3));
        let v1 = RecBatchKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<RecBatchKey>(&arg1.id, v1), 53);
        assert!(0x1::vector::length<address>(&arg5) == 0x1::vector::length<u64>(&arg6), 1);
        assert!(0x1::vector::length<address>(&arg5) > 0 && 0x1::vector::length<address>(&arg5) <= 200, 52);
        let v2 = RecBatchKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<RecBatchKey, RecBatch>(&mut arg1.id, v2);
        assert!(v3.slot == v0, 53);
        assert!(v3.sha == arg7, 54);
        assert!(v3.dividend_ref == arg8, 55);
        assert!(arg4 == v3.next, 56);
        assert!(v3.next + 0x1::vector::length<address>(&arg5) <= v3.total, 52);
        v3.next = v3.next + 0x1::vector::length<address>(&arg5);
        let v4 = MoreMinimumsRecorded{
            slot            : v0,
            start           : arg4,
            records         : 0x1::vector::length<address>(&arg5),
            next            : v3.next,
            total           : v3.total,
            artifact_sha256 : arg7,
        };
        0x2::event::emit<MoreMinimumsRecorded>(v4);
        write_and_promote(arg2, &arg5, &arg6, v0, 0x2::clock::timestamp_ms(arg3), arg9);
    }

    public fun reference_price(arg0: &ClaimVault) : 0x1::option::Option<u64> {
        let v0 = RefPriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RefPriceKey>(&arg0.id, v0)) {
            let v2 = RefPriceKey{dummy_field: false};
            0x1::option::some<u64>(0x2::dynamic_field::borrow<RefPriceKey, RefPrice>(&arg0.id, v2).price_micro)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun refund_rest(arg0: 0x2::coin::Coin<STRC>, arg1: address) {
        if (0x2::coin::value<STRC>(&arg0) == 0) {
            0x2::coin::destroy_zero<STRC>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<STRC>>(arg0, arg1);
        };
    }

    public fun register_holder(arg0: &mut HolderRegistry, arg1: 0x2::coin::Coin<STRC>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(0x2::coin::value<STRC>(&arg1) >= 1000000, 37);
        let v2 = RegKey{h: v0};
        assert!(!0x2::dynamic_field::exists_<RegKey>(&arg0.id, v2), 38);
        let v3 = CoolKey{h: v0};
        if (0x2::dynamic_field::exists_<CoolKey>(&arg0.id, v3)) {
            let v4 = CoolKey{h: v0};
            assert!(v1 >= *0x2::dynamic_field::borrow<CoolKey, u64>(&arg0.id, v4), 43);
            let v5 = CoolKey{h: v0};
            0x2::dynamic_field::remove<CoolKey, u64>(&mut arg0.id, v5);
        };
        let v6 = if (arg0.count >= 50000) {
            let v7 = try_evict_for(arg0, v0, v1, arg3);
            !v7
        } else {
            false
        };
        if (v6) {
            let v8 = PendKey{h: v0};
            assert!(!0x2::dynamic_field::exists_<PendKey>(&arg0.id, v8), 50);
            if (arg0.pending >= 1000) {
                refund_rest(arg1, v0);
                let v9 = QueueFull{
                    holder : v0,
                    ms     : v1,
                };
                0x2::event::emit<QueueFull>(v9);
                return
            };
            0x2::balance::join<STRC>(&mut arg0.pend_bond, 0x2::balance::split<STRC>(0x2::coin::balance_mut<STRC>(&mut arg1), 1000000));
            refund_rest(arg1, v0);
            let v10 = PendKey{h: v0};
            0x2::dynamic_field::add<PendKey, u64>(&mut arg0.id, v10, v1);
            arg0.pending = arg0.pending + 1;
            let v11 = RegistrationQueued{
                holder  : v0,
                pending : arg0.pending,
                ms      : v1,
            };
            0x2::event::emit<RegistrationQueued>(v11);
            return
        };
        let v12 = PendKey{h: v0};
        if (0x2::dynamic_field::exists_<PendKey>(&arg0.id, v12)) {
            unqueue(arg0, v0, false, arg3);
        };
        0x2::balance::join<STRC>(&mut arg0.bond, 0x2::balance::split<STRC>(0x2::coin::balance_mut<STRC>(&mut arg1), 1000000));
        refund_rest(arg1, v0);
        let v13 = RegKey{h: v0};
        0x2::dynamic_field::add<RegKey, u64>(&mut arg0.id, v13, v1);
        arg0.count = arg0.count + 1;
        let v14 = HolderRegistered{
            holder : v0,
            n      : arg0.count,
        };
        0x2::event::emit<HolderRegistered>(v14);
    }

    public fun registered_count(arg0: &HolderRegistry) : u64 {
        arg0.count
    }

    public fun reset_reference_price(arg0: &PayoutAdminCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        gate_at(arg0, arg1, v0);
        let v1 = DeskKey{dummy_field: false};
        let v2 = if (0x2::dynamic_field::exists_<DeskKey>(&arg1.id, v1)) {
            let v3 = DeskKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DeskKey, address>(&arg1.id, v3) == 0x2::tx_context::sender(arg4)
        } else {
            false
        };
        assert!(v2, 40);
        assert!(arg3 > 0 && arg3 <= 161800000, 41);
        let v4 = LastAttestKey{dummy_field: false};
        let v5 = if (0x2::dynamic_field::exists_<LastAttestKey>(&arg1.id, v4)) {
            let v6 = LastAttestKey{dummy_field: false};
            let v7 = AttestKey{slot: *0x2::dynamic_field::borrow<LastAttestKey, u64>(&arg1.id, v6)};
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg1.id, v7).price_micro
        } else {
            0
        };
        let v8 = RefPriceKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<RefPriceKey>(&arg1.id, v8)) {
            let v9 = RefPriceKey{dummy_field: false};
            0x2::dynamic_field::remove<RefPriceKey, RefPrice>(&mut arg1.id, v9);
        };
        let v10 = RefPriceKey{dummy_field: false};
        let v11 = RefPrice{
            price_micro : arg3,
            set_ms      : v0,
        };
        0x2::dynamic_field::add<RefPriceKey, RefPrice>(&mut arg1.id, v10, v11);
        let v12 = ReferencePriceReset{
            old_price_micro : v5,
            new_price_micro : arg3,
            ms              : v0,
            slot            : slot_of(v0),
            by              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ReferencePriceReset>(v12);
    }

    public fun rotate_attest_cap(arg0: &PayoutOwnerCap, arg1: &mut ClaimVault, arg2: &mut 0x2::tx_context::TxContext) {
        owner_ok(arg0, arg1);
        let v0 = AttestCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<ClaimVault>(arg1),
        };
        let v1 = AttestCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<AttestCapKey>(&arg1.id, v1)) {
            let v2 = AttestCapKey{dummy_field: false};
            0x2::dynamic_field::remove<AttestCapKey, 0x2::object::ID>(&mut arg1.id, v2);
        };
        let v3 = AttestCapKey{dummy_field: false};
        0x2::dynamic_field::add<AttestCapKey, 0x2::object::ID>(&mut arg1.id, v3, 0x2::object::id<AttestCap>(&v0));
        0x2::transfer::transfer<AttestCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun rotate_cap(arg0: &PayoutOwnerCap, arg1: &mut ClaimVault, arg2: &0x2::clock::Clock, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        owner_ok(arg0, arg1);
        assert!(arg3 == 0 || arg3 > 0x2::clock::timestamp_ms(arg2), 22);
        let v0 = PayoutAdminCap{
            id    : 0x2::object::new(arg5),
            vault : 0x2::object::id<ClaimVault>(arg1),
        };
        let v1 = 0x2::object::id<PayoutAdminCap>(&v0);
        let v2 = ActiveCapKey{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists_<ActiveCapKey>(&arg1.id, v2)) {
            let v4 = ActiveCapKey{dummy_field: false};
            let v5 = 0x2::dynamic_field::remove<ActiveCapKey, ActiveCap>(&mut arg1.id, v4);
            v5.id
        } else {
            v1
        };
        let v6 = ActiveCapKey{dummy_field: false};
        let v7 = ActiveCap{
            id         : v1,
            expires_ms : arg3,
        };
        0x2::dynamic_field::add<ActiveCapKey, ActiveCap>(&mut arg1.id, v6, v7);
        let v8 = CapRotated{
            old        : v3,
            new        : v1,
            expires_ms : arg3,
        };
        0x2::event::emit<CapRotated>(v8);
        0x2::transfer::public_transfer<PayoutAdminCap>(v0, arg4);
    }

    fun set_cooldown(arg0: &mut HolderRegistry, arg1: address, arg2: u64) {
        let v0 = CoolKey{h: arg1};
        if (0x2::dynamic_field::exists_<CoolKey>(&arg0.id, v0)) {
            let v1 = CoolKey{h: arg1};
            0x2::dynamic_field::remove<CoolKey, u64>(&mut arg0.id, v1);
        };
        let v2 = CoolKey{h: arg1};
        0x2::dynamic_field::add<CoolKey, u64>(&mut arg0.id, v2, arg2);
    }

    public fun set_icon_url(arg0: &PayoutAdminCap, arg1: &ClaimVault, arg2: &mut 0x2::coin::CoinMetadata<STRC>, arg3: 0x1::ascii::String) {
        gate(arg0, arg1);
        0x2::coin::update_icon_url<STRC>(&arg1.treasury, arg2, arg3);
    }

    public fun slot_attested_ms(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).attested_ms
        } else {
            0
        }
    }

    public fun slot_batches(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).batches
        } else {
            0
        }
    }

    public fun slot_declared(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).declared
        } else {
            0
        }
    }

    public fun slot_dividend_ref(arg0: &ClaimVault, arg1: u64) : vector<u8> {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).dividend_ref
        } else {
            b""
        }
    }

    public fun slot_filing_sha256(arg0: &ClaimVault, arg1: u64) : vector<u8> {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).filing_sha256
        } else {
            b""
        }
    }

    public fun slot_of(arg0: u64) : u64 {
        if (arg0 < 36000000) {
            0
        } else {
            (arg0 - 36000000) / 86400000
        }
    }

    public fun slot_paid(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).paid
        } else {
            0
        }
    }

    public fun slot_price_micro(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).price_micro
        } else {
            0
        }
    }

    public fun slot_price_ref(arg0: &ClaimVault, arg1: u64) : vector<u8> {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).price_ref
        } else {
            b""
        }
    }

    public fun slot_rate_bps(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).rate_bps
        } else {
            0
        }
    }

    public fun slot_strcx_micro(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).strcx_micro
        } else {
            0
        }
    }

    public fun slot_supply_at_attest(arg0: &ClaimVault, arg1: u64) : u64 {
        let v0 = AttestKey{slot: arg1};
        if (0x2::dynamic_field::exists_<AttestKey>(&arg0.id, v0)) {
            0x2::dynamic_field::borrow<AttestKey, SlotState>(&arg0.id, v0).supply_at_attest
        } else {
            0
        }
    }

    public fun total_pushed(arg0: &ClaimVault) : u64 {
        arg0.total_pushed
    }

    fun try_evict_for(arg0: &mut HolderRegistry, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = slot_of(arg2);
        let v1 = FloorKey{dummy_field: false};
        let v2 = if (!0x2::dynamic_field::exists_<FloorKey>(&arg0.id, v1)) {
            true
        } else {
            let v3 = MinKey{h: arg1};
            !0x2::dynamic_field::exists_<MinKey>(&arg0.id, v3)
        };
        if (v2) {
            return false
        };
        let v4 = MinKey{h: arg1};
        let v5 = *0x2::dynamic_field::borrow<MinKey, MinRec>(&arg0.id, v4);
        let v6 = FloorKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow<FloorKey, Floor>(&arg0.id, v6);
        let v8 = v7.slot;
        let v9 = v7.next;
        if (v5.slot != v8 || v0 > v8 + 1) {
            return false
        };
        let v10 = @0x0;
        let v11 = 0;
        let v12 = false;
        while (v9 < 0x1::vector::length<address>(&v7.hs) && !v12) {
            let v13 = FloorKey{dummy_field: false};
            let v14 = 0x2::dynamic_field::borrow<FloorKey, Floor>(&arg0.id, v13);
            let v15 = *0x1::vector::borrow<address>(&v14.hs, v9);
            let v16 = RegKey{h: v15};
            if (0x2::dynamic_field::exists_<RegKey>(&arg0.id, v16)) {
                v10 = v15;
                v11 = *0x1::vector::borrow<u64>(&v14.mins, v9);
                v12 = true;
                continue
            };
            v9 = v9 + 1;
        };
        let v17 = FloorKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FloorKey, Floor>(&mut arg0.id, v17).next = v9;
        if (!v12 || v5.min <= v11) {
            return false
        };
        let v18 = FloorKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FloorKey, Floor>(&mut arg0.id, v18).next = v9 + 1;
        drop_min(arg0, arg1);
        unbond(arg0, v10, arg3);
        let v19 = HolderEvicted{
            holder       : v10,
            by           : arg1,
            holder_min   : v11,
            newcomer_min : v5.min,
            slot         : v0,
        };
        0x2::event::emit<HolderEvicted>(v19);
        true
    }

    fun unbond(arg0: &mut HolderRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RegKey{h: arg1};
        0x2::dynamic_field::remove<RegKey, u64>(&mut arg0.id, v0);
        arg0.count = arg0.count - 1;
        drop_min(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<STRC>>(0x2::coin::from_balance<STRC>(0x2::balance::split<STRC>(&mut arg0.bond, 1000000), arg2), arg1);
    }

    fun unqueue(arg0: &mut HolderRegistry, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PendKey{h: arg1};
        0x2::dynamic_field::remove<PendKey, u64>(&mut arg0.id, v0);
        arg0.pending = arg0.pending - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<STRC>>(0x2::coin::from_balance<STRC>(0x2::balance::split<STRC>(&mut arg0.pend_bond, 1000000), arg3), arg1);
        let v1 = PendingRemoved{
            holder  : arg1,
            pending : arg0.pending,
            expired : arg2,
        };
        0x2::event::emit<PendingRemoved>(v1);
    }

    public fun vault_balance<T0>(arg0: &ClaimVault) : u64 {
        let v0 = FundsKey{dummy_field: false};
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<FundsKey, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    public fun version(arg0: &ClaimVault) : u64 {
        arg0.version
    }

    fun write_and_promote(arg0: &mut HolderRegistry, arg1: &vector<address>, arg2: &vector<u64>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1)) {
            let v1 = *0x1::vector::borrow<address>(arg1, v0);
            drop_min(arg0, v1);
            let v2 = MinKey{h: v1};
            let v3 = MinRec{
                min  : *0x1::vector::borrow<u64>(arg2, v0),
                slot : arg3,
            };
            0x2::dynamic_field::add<MinKey, MinRec>(&mut arg0.id, v2, v3);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg1) && arg0.count >= 50000) {
            let v4 = *0x1::vector::borrow<address>(arg1, v0);
            let v5 = PendKey{h: v4};
            let v6 = if (0x2::dynamic_field::exists_<PendKey>(&arg0.id, v5)) {
                try_evict_for(arg0, v4, arg4, arg5)
            } else {
                false
            };
            if (v6) {
                let v7 = PendKey{h: v4};
                0x2::dynamic_field::remove<PendKey, u64>(&mut arg0.id, v7);
                arg0.pending = arg0.pending - 1;
                0x2::balance::join<STRC>(&mut arg0.bond, 0x2::balance::split<STRC>(&mut arg0.pend_bond, 1000000));
                let v8 = RegKey{h: v4};
                0x2::dynamic_field::add<RegKey, u64>(&mut arg0.id, v8, arg4);
                arg0.count = arg0.count + 1;
                let v9 = PendingPromoted{
                    holder  : v4,
                    pending : arg0.pending,
                };
                0x2::event::emit<PendingPromoted>(v9);
                let v10 = HolderRegistered{
                    holder : v4,
                    n      : arg0.count,
                };
                0x2::event::emit<HolderRegistered>(v10);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

