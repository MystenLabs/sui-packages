module 0x30068756e7f2e05d773897a170719a96397a1bfa2f8faeaed89e8d707d9e9ff::rewards {
    struct Setup has key {
        id: 0x2::object::UID,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        source: 0x2::object::ID,
        checkpoint: u64,
        checkpoint_digest: vector<u8>,
    }

    struct AssetKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Entitlement has store {
        total: u64,
        claimed: bool,
    }

    struct Distribution<phantom T0> has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        manifest: vector<u8>,
        root: vector<u8>,
        initial: u64,
        funds: 0x2::balance::Balance<T0>,
        accounts: 0x2::table::Table<address, Entitlement>,
    }

    struct Published<phantom T0> has copy, drop {
        registry: 0x2::object::ID,
        distribution: 0x2::object::ID,
        manifest: vector<u8>,
        root: vector<u8>,
        amount: u64,
    }

    struct PeriodAllocated<phantom T0> has copy, drop {
        distribution: 0x2::object::ID,
        owner: address,
        period: u32,
        amount: u64,
    }

    struct Claimed<phantom T0> has copy, drop {
        distribution: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Allocation has drop {
        registry: 0x2::object::ID,
        source: 0x2::object::ID,
        checkpoint: u64,
        checkpoint_digest: vector<u8>,
        asset: 0x1::type_name::TypeName,
        manifest: vector<u8>,
        owner: address,
        periods: vector<u32>,
        amounts: vector<u64>,
    }

    fun check_distribution<T0>(arg0: &Registry, arg1: &Distribution<T0>) {
        assert!(arg0.version == 1, 1);
        assert!(0x2::object::id<Registry>(arg0) == arg1.registry, 2);
    }

    public fun claim<T0>(arg0: &Registry, arg1: &mut Distribution<T0>, arg2: vector<u32>, arg3: vector<u64>, arg4: u64, arg5: vector<vector<u8>>, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, Entitlement>(&arg1.accounts, 0x2::tx_context::sender(arg6))) {
            register<T0>(arg0, arg1, 0x2::tx_context::sender(arg6), arg2, arg3, arg4, arg5);
        };
        withdraw<T0>(arg0, arg1, arg6);
    }

    public fun entitlement<T0>(arg0: &Distribution<T0>, arg1: address) : (u64, bool) {
        if (!0x2::table::contains<address, Entitlement>(&arg0.accounts, arg1)) {
            return (0, false)
        };
        let v0 = 0x2::table::borrow<address, Entitlement>(&arg0.accounts, arg1);
        (v0.total, v0.claimed)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Setup{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Setup>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun leaf<T0>(arg0: &Registry, arg1: vector<u8>, arg2: address, arg3: vector<u32>, arg4: vector<u64>) : vector<u8> {
        let v0 = b"veHAEDAL/legacy/account/1";
        let v1 = Allocation{
            registry          : 0x2::object::id<Registry>(arg0),
            source            : arg0.source,
            checkpoint        : arg0.checkpoint,
            checkpoint_digest : arg0.checkpoint_digest,
            asset             : 0x1::type_name::with_defining_ids<T0>(),
            manifest          : arg1,
            owner             : arg2,
            periods           : arg3,
            amounts           : arg4,
        };
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<Allocation>(&v1));
        0x1::hash::sha3_256(v0)
    }

    public fun migrate_version(arg0: &mut Registry, arg1: &RegistryAdminCap) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun publish<T0>(arg0: &mut Registry, arg1: &RegistryAdminCap, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 1);
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 2);
        let v0 = if (0x1::vector::length<u8>(&arg2) == 32) {
            if (0x1::vector::length<u8>(&arg3) == 32) {
                if (arg4 > 0) {
                    0x2::coin::value<T0>(&arg5) == arg4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 3);
        let v1 = AssetKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<AssetKey<T0>>(&arg0.id, v1), 4);
        let v2 = Distribution<T0>{
            id       : 0x2::object::new(arg6),
            registry : 0x2::object::id<Registry>(arg0),
            manifest : arg2,
            root     : arg3,
            initial  : arg4,
            funds    : 0x2::coin::into_balance<T0>(arg5),
            accounts : 0x2::table::new<address, Entitlement>(arg6),
        };
        0x2::dynamic_field::add<AssetKey<T0>, 0x2::object::ID>(&mut arg0.id, v1, 0x2::object::id<Distribution<T0>>(&v2));
        let v3 = Published<T0>{
            registry     : v2.registry,
            distribution : 0x2::object::id<Distribution<T0>>(&v2),
            manifest     : arg2,
            root         : arg3,
            amount       : arg4,
        };
        0x2::event::emit<Published<T0>>(v3);
        0x2::transfer::share_object<Distribution<T0>>(v2);
    }

    public fun register<T0>(arg0: &Registry, arg1: &mut Distribution<T0>, arg2: address, arg3: vector<u32>, arg4: vector<u64>, arg5: u64, arg6: vector<vector<u8>>) {
        check_distribution<T0>(arg0, arg1);
        if (0x2::table::contains<address, Entitlement>(&arg1.accounts, arg2)) {
            return
        };
        let v0 = if (arg2 != @0x0) {
            if (!0x1::vector::is_empty<u32>(&arg3)) {
                if (0x1::vector::length<u32>(&arg3) <= (81 as u64) + 1) {
                    if (0x1::vector::length<u32>(&arg3) == 0x1::vector::length<u64>(&arg4)) {
                        0x1::vector::length<vector<u8>>(&arg6) <= 64
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
        assert!(v0, 5);
        let v1 = leaf<T0>(arg0, arg1.manifest, arg2, arg3, arg4);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg6)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg6, v2);
            assert!(0x1::vector::length<u8>(&v3) == 32, 5);
            let v4 = x"ff";
            if (arg5 % 2 == 0) {
                0x1::vector::append<u8>(&mut v4, v1);
                0x1::vector::append<u8>(&mut v4, v3);
            } else {
                0x1::vector::append<u8>(&mut v4, v3);
                0x1::vector::append<u8>(&mut v4, v1);
            };
            v1 = 0x1::hash::sha3_256(v4);
            arg5 = arg5 / 2;
            v2 = v2 + 1;
        };
        assert!(arg5 == 0 && v1 == arg1.root, 5);
        let v5 = 0;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u32>(&arg3)) {
            let v7 = *0x1::vector::borrow<u32>(&arg3, v6);
            let v8 = *0x1::vector::borrow<u64>(&arg4, v6);
            let v9 = if (v6 == 0 || v7 > 0) {
                if (v7 <= 81) {
                    v8 > 0
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v9, 3);
            v5 = v5 + v8;
            let v10 = PeriodAllocated<T0>{
                distribution : 0x2::object::id<Distribution<T0>>(arg1),
                owner        : arg2,
                period       : v7,
                amount       : v8,
            };
            0x2::event::emit<PeriodAllocated<T0>>(v10);
            v6 = v6 + 1;
        };
        let v11 = Entitlement{
            total   : v5,
            claimed : false,
        };
        0x2::table::add<address, Entitlement>(&mut arg1.accounts, arg2, v11);
    }

    public fun setup(arg0: Setup, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::object::id_to_address(&arg1) != @0x0) {
            if (arg4 != @0x0) {
                if (arg2 > 0) {
                    0x1::vector::length<u8>(&arg3) == 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let Setup { id: v1 } = arg0;
        0x2::object::delete(v1);
        let v2 = Registry{
            id                : 0x2::object::new(arg5),
            version           : 1,
            source            : arg1,
            checkpoint        : arg2,
            checkpoint_digest : arg3,
        };
        let v3 = RegistryAdminCap{
            id       : 0x2::object::new(arg5),
            registry : 0x2::object::id<Registry>(&v2),
        };
        0x2::transfer::transfer<RegistryAdminCap>(v3, arg4);
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun withdraw<T0>(arg0: &Registry, arg1: &mut Distribution<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        check_distribution<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Entitlement>(&arg1.accounts, v0), 5);
        let v1 = 0x2::table::borrow_mut<address, Entitlement>(&mut arg1.accounts, v0);
        assert!(!v1.claimed, 6);
        v1.claimed = true;
        let v2 = v1.total;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.funds, v2), arg2), v0);
        let v3 = Claimed<T0>{
            distribution : 0x2::object::id<Distribution<T0>>(arg1),
            owner        : v0,
            amount       : v2,
        };
        0x2::event::emit<Claimed<T0>>(v3);
    }

    // decompiled from Move bytecode v7
}

