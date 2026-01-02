module 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith {
    struct FAITH has drop {
        dummy_field: bool,
    }

    struct SupplyCap has store, key {
        id: 0x2::object::UID,
        cap: u64,
        minted: u64,
    }

    struct RadianceIndex has store, key {
        id: 0x2::object::UID,
        index_accum: u128,
    }

    struct Unclaimed has store, key {
        id: 0x2::object::UID,
        owner: address,
        raw: u64,
        index_snap: u128,
    }

    struct Buckets has store, key {
        id: 0x2::object::UID,
        owners: vector<address>,
        buckets: vector<Unclaimed>,
    }

    struct RadianceClaimed has copy, drop {
        owner: address,
        refined: u64,
        fee: u64,
    }

    struct RadianceSnapshot has copy, drop {
        ts_ms: u64,
        index_accum: u128,
        total_raw: u64,
        total_refined: u64,
    }

    public fun accrue_to(arg0: address, arg1: u64, arg2: &RadianceIndex, arg3: &mut Buckets, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public(friend) fun accrue_to_internal(arg0: address, arg1: u64, arg2: &RadianceIndex, arg3: &mut Buckets, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = &arg3.owners;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (0x1::vector::borrow<address>(v0, v1) == &arg0) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                let (v3, v4) = if (0x1::option::is_some<u64>(&v2)) {
                    (true, 0x1::option::destroy_some<u64>(v2))
                } else {
                    (false, 0)
                };
                if (v3) {
                    let v5 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg3.buckets, v4);
                    let v6 = v5.raw;
                    let v7 = v6 + arg1;
                    if (v7 == 0) {
                        v5.raw = 0;
                        v5.index_snap = arg2.index_accum;
                    } else {
                        v5.raw = v7;
                        v5.index_snap = ((v6 as u128) * v5.index_snap + (arg1 as u128) * arg2.index_accum) / (v7 as u128);
                    };
                } else {
                    0x1::vector::push_back<address>(&mut arg3.owners, arg0);
                    let v8 = Unclaimed{
                        id         : 0x2::object::new(arg4),
                        owner      : arg0,
                        raw        : arg1,
                        index_snap : arg2.index_accum,
                    };
                    0x1::vector::push_back<Unclaimed>(&mut arg3.buckets, v8);
                };
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun bump_radiance_index(arg0: u128, arg1: &mut RadianceIndex) {
        abort 0
    }

    fun bump_radiance_index_internal(arg0: u128, arg1: &mut RadianceIndex) {
        arg1.index_accum = arg1.index_accum + arg0;
    }

    public fun claim_if_any(arg0: address, arg1: u64, arg2: &mut SupplyCap, arg3: &mut RadianceIndex, arg4: &mut Buckets) : u64 {
        abort 0
    }

    public fun claim_if_any_with_multiplier(arg0: address, arg1: u64, arg2: u64, arg3: &mut SupplyCap, arg4: &mut RadianceIndex, arg5: &mut Buckets) : u64 {
        abort 0
    }

    public(friend) fun claim_if_any_with_multiplier_internal(arg0: address, arg1: u64, arg2: u64, arg3: &mut SupplyCap, arg4: &mut RadianceIndex, arg5: &mut Buckets) : u64 {
        let v0 = &arg5.owners;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (0x1::vector::borrow<address>(v0, v1) == &arg0) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                let (v3, v4) = if (0x1::option::is_some<u64>(&v2)) {
                    (true, 0x1::option::destroy_some<u64>(v2))
                } else {
                    (false, 0)
                };
                if (!v3) {
                    return 0
                };
                let v5 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg5.buckets, v4);
                let v6 = ((((v5.raw as u128) * (arg4.index_accum as u128) / (v5.index_snap as u128)) as u64) as u128);
                if (v6 == 0) {
                    return 0
                };
                let v7 = (((v6 as u128) * (arg1 as u128) / 10000) as u128);
                let v8 = mint_with_cap(arg3, (((((v6 - v7) as u128) * (arg2 as u128) / 10000) as u128) as u64));
                bump_radiance_index_internal(v7, arg4);
                v5.raw = 0;
                v5.index_snap = arg4.index_accum;
                let v9 = RadianceClaimed{
                    owner   : arg0,
                    refined : v8,
                    fee     : (v7 as u64),
                };
                0x2::event::emit<RadianceClaimed>(v9);
                return v8
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (SupplyCap, RadianceIndex, Buckets) {
        abort 0
    }

    public entry fun create_and_transfer(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun emit_radiance_snapshot(arg0: &SupplyCap, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) {
        abort 0
    }

    public(friend) fun emit_radiance_snapshot_internal(arg0: &SupplyCap, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = &arg2.buckets;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Unclaimed>(v2)) {
            let v4 = 0x1::vector::borrow<Unclaimed>(v2, v3);
            let v5 = v4.raw;
            v0 = v0 + v5;
            if (v5 > 0) {
                v1 = v1 + ((((v5 as u128) * (arg1.index_accum as u128) / (v4.index_snap as u128)) as u64) as u128);
            };
            v3 = v3 + 1;
        };
        let v6 = RadianceSnapshot{
            ts_ms         : arg3,
            index_accum   : arg1.index_accum,
            total_raw     : v0,
            total_refined : (0x1::u128::min(v1, 18446744073709551615) as u64),
        };
        0x2::event::emit<RadianceSnapshot>(v6);
    }

    fun init(arg0: FAITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FAITH>(arg0, 9, 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"Test of Faith"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAITH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FAITH>>(0x2::coin_registry::finalize<FAITH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint_with_cap(arg0: &mut SupplyCap, arg1: u64) : u64 {
        let v0 = arg0.minted;
        let v1 = arg0.cap;
        if (arg1 == 0 || v0 >= v1) {
            return 0
        };
        let v2 = 0x1::u64::min(arg1, v1 - v0);
        arg0.minted = v0 + v2;
        v2
    }

    public fun preview_refinement(arg0: address, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) : (u64, u64, u64) {
        abort 0
    }

    public(friend) fun preview_refinement_internal(arg0: address, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) : (u64, u64, u64) {
        let v0 = &arg2.owners;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (0x1::vector::borrow<address>(v0, v1) == &arg0) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                let (v3, v4) = if (0x1::option::is_some<u64>(&v2)) {
                    (true, 0x1::option::destroy_some<u64>(v2))
                } else {
                    (false, 0)
                };
                if (!v3) {
                    return (0, 0, 0)
                };
                let v5 = 0x1::vector::borrow<Unclaimed>(&arg2.buckets, v4);
                let v6 = v5.raw;
                if (v6 == 0) {
                    return (0, 0, 0)
                };
                let v7 = (((v6 as u128) * (arg1.index_accum as u128) / (v5.index_snap as u128)) as u64);
                if (v7 == 0) {
                    return (v6, 0, 0)
                };
                return (v6, v7, v7 - (((v7 as u128) * (arg3 as u128) / 10000) as u64))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

