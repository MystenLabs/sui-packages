module 0xd409df53c7b8f1d93c15b4cf1be47960648f729c536ec92114caaddda73c7e0::faith {
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
        let (v0, v1) = find_bucket_index(&arg3.owners, arg0);
        if (v0) {
            let v2 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg3.buckets, v1);
            let v3 = v2.raw;
            let v4 = v3 + arg1;
            if (v4 == 0) {
                v2.raw = 0;
                v2.index_snap = arg2.index_accum;
            } else {
                v2.raw = v4;
                v2.index_snap = ((v3 as u128) * v2.index_snap + (arg1 as u128) * arg2.index_accum) / (v4 as u128);
            };
        } else {
            0x1::vector::push_back<address>(&mut arg3.owners, arg0);
            let v5 = Unclaimed{
                id         : 0x2::object::new(arg4),
                owner      : arg0,
                raw        : arg1,
                index_snap : arg2.index_accum,
            };
            0x1::vector::push_back<Unclaimed>(&mut arg3.buckets, v5);
        };
    }

    public fun bump_radiance_index(arg0: u128, arg1: &mut RadianceIndex) {
        arg1.index_accum = arg1.index_accum + arg0;
    }

    public fun claim_if_any(arg0: address, arg1: u64, arg2: &mut SupplyCap, arg3: &mut RadianceIndex, arg4: &mut Buckets) : u64 {
        let (v0, v1) = find_bucket_index(&arg4.owners, arg0);
        if (!v0) {
            return 0
        };
        let v2 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg4.buckets, v1);
        let v3 = refine_amount(v2.raw, v2.index_snap, arg3.index_accum);
        if (v3 == 0) {
            return 0
        };
        let v4 = v3 * (arg1 as u128) / 10000;
        let v5 = (v4 as u64);
        let v6 = mint_with_cap(arg2, ((v3 - v4) as u64));
        bump_radiance_index((v5 as u128), arg3);
        v2.raw = 0;
        v2.index_snap = arg3.index_accum;
        let v7 = RadianceClaimed{
            owner   : arg0,
            refined : v6,
            fee     : v5,
        };
        0x2::event::emit<RadianceClaimed>(v7);
        v6
    }

    public fun claim_if_any_with_multiplier(arg0: address, arg1: u64, arg2: u64, arg3: &mut SupplyCap, arg4: &mut RadianceIndex, arg5: &mut Buckets) : u64 {
        let (v0, v1) = find_bucket_index(&arg5.owners, arg0);
        if (!v0) {
            return 0
        };
        let v2 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg5.buckets, v1);
        let v3 = refine_amount(v2.raw, v2.index_snap, arg4.index_accum);
        if (v3 == 0) {
            return 0
        };
        let v4 = v3 * (arg1 as u128) / 10000;
        let v5 = (v4 as u64);
        let v6 = mint_with_cap(arg3, (((v3 - v4) * (arg2 as u128) / 10000) as u64));
        bump_radiance_index((v5 as u128), arg4);
        v2.raw = 0;
        v2.index_snap = arg4.index_accum;
        let v7 = RadianceClaimed{
            owner   : arg0,
            refined : v6,
            fee     : v5,
        };
        0x2::event::emit<RadianceClaimed>(v7);
        v6
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (SupplyCap, RadianceIndex, Buckets) {
        let v0 = SupplyCap{
            id     : 0x2::object::new(arg1),
            cap    : arg0,
            minted : 0,
        };
        let v1 = RadianceIndex{
            id          : 0x2::object::new(arg1),
            index_accum : 1000000000,
        };
        let v2 = Buckets{
            id      : 0x2::object::new(arg1),
            owners  : 0x1::vector::empty<address>(),
            buckets : 0x1::vector::empty<Unclaimed>(),
        };
        (v0, v1, v2)
    }

    public entry fun create_and_transfer(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = create(arg0, arg1);
        0x2::transfer::public_transfer<SupplyCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<RadianceIndex>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<Buckets>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun emit_radiance_snapshot(arg0: &SupplyCap, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v0 < 0x1::vector::length<Unclaimed>(&arg2.buckets)) {
            let v3 = 0x1::vector::borrow<Unclaimed>(&arg2.buckets, v0);
            let v4 = v3.raw;
            v1 = v1 + v4;
            if (v4 > 0) {
                v2 = v2 + refine_amount(v4, v3.index_snap, arg1.index_accum);
            };
            v0 = v0 + 1;
        };
        let v5 = if (v2 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v2 as u64)
        };
        let v6 = RadianceSnapshot{
            ts_ms         : arg3,
            index_accum   : arg1.index_accum,
            total_raw     : v1,
            total_refined : v5,
        };
        0x2::event::emit<RadianceSnapshot>(v6);
    }

    fun find_bucket_index(arg0: &vector<address>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    fun init(arg0: FAITH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FAITH>(arg0, 9, 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"Test of Faith"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAITH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FAITH>>(0x2::coin_registry::finalize<FAITH>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun mint_with_cap(arg0: &mut SupplyCap, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = arg0.minted;
        let v1 = arg0.cap;
        if (v0 >= v1) {
            return 0
        };
        let v2 = v1 - v0;
        let v3 = if (arg1 > v2) {
            v2
        } else {
            arg1
        };
        arg0.minted = v0 + v3;
        v3
    }

    public fun preview_refinement(arg0: address, arg1: &RadianceIndex, arg2: &Buckets, arg3: u64) : (u64, u64, u64) {
        let (v0, v1) = find_bucket_index(&arg2.owners, arg0);
        if (!v0) {
            return (0, 0, 0)
        };
        let v2 = 0x1::vector::borrow<Unclaimed>(&arg2.buckets, v1);
        let v3 = v2.raw;
        if (v3 == 0) {
            return (0, 0, 0)
        };
        let v4 = (v3 as u128) * arg1.index_accum / v2.index_snap;
        if (v4 == 0) {
            return (v3, 0, 0)
        };
        let v5 = (v4 as u64);
        (v3, v5, v5 - ((v4 * (arg3 as u128) / 10000) as u64))
    }

    fun refine_amount(arg0: u64, arg1: u128, arg2: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 as u128) * arg2 / arg1
        }
    }

    // decompiled from Move bytecode v6
}

