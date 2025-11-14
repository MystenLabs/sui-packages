module 0x6ab6188534da5b40e54141ab9df82cbc5e46e7d513557d2bb4fc6f14132a33b6::faith {
    struct FAITH has drop {
        dummy_field: bool,
    }

    struct SupplyCap has store, key {
        id: 0x2::object::UID,
        cap: u64,
        minted: u64,
    }

    struct RefiningIndex has store, key {
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

    struct RefineClaimed has copy, drop {
        owner: address,
        refined: u64,
        fee: u64,
    }

    public fun accrue_to(arg0: address, arg1: u64, arg2: &mut SupplyCap, arg3: &RefiningIndex, arg4: &mut Buckets, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.minted + arg1 <= arg2.cap, 0x6ab6188534da5b40e54141ab9df82cbc5e46e7d513557d2bb4fc6f14132a33b6::errors::E_SUPPLY_CAP());
        arg2.minted = arg2.minted + arg1;
        let (v0, v1) = find_bucket_index(&arg4.owners, arg0);
        if (v0) {
            let v2 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg4.buckets, v1);
            let v3 = v2.raw;
            let v4 = v3 + arg1;
            if (v4 == 0) {
                v2.raw = 0;
                v2.index_snap = arg3.index_accum;
            } else {
                v2.raw = v4;
                v2.index_snap = ((v3 as u128) * v2.index_snap + (arg1 as u128) * arg3.index_accum) / (v4 as u128);
            };
        } else {
            0x1::vector::push_back<address>(&mut arg4.owners, arg0);
            let v5 = Unclaimed{
                id         : 0x2::object::new(arg5),
                owner      : arg0,
                raw        : arg1,
                index_snap : arg3.index_accum,
            };
            0x1::vector::push_back<Unclaimed>(&mut arg4.buckets, v5);
        };
    }

    public fun bump_index(arg0: u128, arg1: &mut RefiningIndex) {
        arg1.index_accum = arg1.index_accum + arg0;
    }

    public fun claim(arg0: address, arg1: u64, arg2: &mut SupplyCap, arg3: &mut RefiningIndex, arg4: &mut Buckets) : u64 {
        let (v0, v1) = find_bucket_index(&arg4.owners, arg0);
        assert!(v0, 0x6ab6188534da5b40e54141ab9df82cbc5e46e7d513557d2bb4fc6f14132a33b6::errors::E_NOTHING_TO_CLAIM());
        let v2 = 0x1::vector::borrow_mut<Unclaimed>(&mut arg4.buckets, v1);
        let v3 = refine_amount(v2.raw, v2.index_snap, arg3.index_accum);
        assert!(v3 > 0, 0x6ab6188534da5b40e54141ab9df82cbc5e46e7d513557d2bb4fc6f14132a33b6::errors::E_NOTHING_TO_CLAIM());
        let v4 = ((v3 * (arg1 as u128) / 10000) as u64);
        let v5 = ((v3 - (v4 as u128)) as u64);
        bump_index((v4 as u128), arg3);
        v2.raw = 0;
        v2.index_snap = arg3.index_accum;
        let v6 = RefineClaimed{
            owner   : arg0,
            refined : v5,
            fee     : v4,
        };
        0x2::event::emit<RefineClaimed>(v6);
        v5
    }

    public fun create(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : (SupplyCap, RefiningIndex, Buckets) {
        let v0 = SupplyCap{
            id     : 0x2::object::new(arg1),
            cap    : arg0,
            minted : 0,
        };
        let v1 = RefiningIndex{
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
        0x2::transfer::public_transfer<RefiningIndex>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<Buckets>(v2, 0x2::tx_context::sender(arg1));
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
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FAITH>(arg0, 9, 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"FAITH"), 0x1::string::utf8(b"Belief-backed utility"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAITH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FAITH>>(0x2::coin_registry::finalize<FAITH>(v0, arg1), 0x2::tx_context::sender(arg1));
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

