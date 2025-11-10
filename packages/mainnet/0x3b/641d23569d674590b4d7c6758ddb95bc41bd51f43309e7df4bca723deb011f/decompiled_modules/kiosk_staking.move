module 0x3b641d23569d674590b4d7c6758ddb95bc41bd51f43309e7df4bca723deb011f::kiosk_staking {
    struct KIOSK_STAKING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        min_staking_duration_ms: u64,
        staked: 0x2::table::Table<0x2::object::ID, StakedItemInfo>,
        stakes_per_staker: 0x2::table::Table<address, u64>,
        supported_types: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        staking_kiosk_id: 0x2::object::ID,
        staking_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct StakedItemInfo has drop, store {
        kiosk_id: 0x2::object::ID,
        staker: address,
        staked_at: u64,
        item_type: 0x1::type_name::TypeName,
    }

    struct Staked has copy, drop, store {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        at: u64,
        staker: address,
        lock_duration_ms: u64,
        item_type: 0x1::type_name::TypeName,
    }

    struct Unstaked has copy, drop, store {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        at: u64,
        staker: address,
        duration_ms: u64,
        item_type: 0x1::type_name::TypeName,
    }

    struct ForceUnstaked has copy, drop, store {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        at: u64,
        staker: address,
        duration_ms: u64,
        admin: address,
        item_type: 0x1::type_name::TypeName,
    }

    public fun active_stakes_of(arg0: &Global, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.stakes_per_staker, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.stakes_per_staker, arg1)
        } else {
            0
        }
    }

    public fun admin_add_supported_type<T0: store + key>(arg0: &AdminCap, arg1: &mut Global) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.supported_types, v0)) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg1.supported_types, v0, true);
        };
    }

    public fun admin_force_unstake<T0: store + key>(arg0: &AdminCap, arg1: &mut Global, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg1.staked, arg3), 2);
        assert_staking_kiosk(arg1, arg2);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg1.staked, arg3);
        assert_type_matches<T0>(v0);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = v1 - v0.staked_at;
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg2, arg3), 7);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg2, &arg1.staking_cap, arg3), v0.staker);
        let v3 = 0x2::table::remove<0x2::object::ID, StakedItemInfo>(&mut arg1.staked, arg3);
        dec_active(arg1, v3.staker);
        let v4 = ForceUnstaked{
            kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            item        : arg3,
            at          : v1,
            staker      : v3.staker,
            duration_ms : v2,
            admin       : 0x2::tx_context::sender(arg5),
            item_type   : v3.item_type,
        };
        0x2::event::emit<ForceUnstaked>(v4);
    }

    public fun admin_purge_if_missing<T0: store + key>(arg0: &AdminCap, arg1: &mut Global, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg1.staked, arg3), 2);
        assert_staking_kiosk(arg1, arg2);
        assert_type_matches<T0>(0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg1.staked, arg3));
        assert!(!0x2::kiosk::has_item_with_type<T0>(arg2, arg3), 5);
        let v0 = 0x2::table::remove<0x2::object::ID, StakedItemInfo>(&mut arg1.staked, arg3);
        dec_active(arg1, v0.staker);
    }

    public fun admin_remove_supported_type<T0: store + key>(arg0: &AdminCap, arg1: &mut Global) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg1.supported_types, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg1.supported_types, v0);
        };
    }

    public fun admin_set_enabled(arg0: &AdminCap, arg1: &mut Global, arg2: bool) {
        arg1.enabled = arg2;
    }

    public fun admin_set_min_staking_duration(arg0: &AdminCap, arg1: &mut Global, arg2: u64) {
        arg1.min_staking_duration_ms = arg2;
    }

    fun assert_staking_kiosk(arg0: &Global, arg1: &0x2::kiosk::Kiosk) {
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == arg0.staking_kiosk_id, 6);
    }

    fun assert_type_matches<T0: store + key>(arg0: &StakedItemInfo) {
        assert!(arg0.item_type == 0x1::type_name::with_original_ids<T0>(), 9);
    }

    fun dec_active(arg0: &mut Global, arg1: address) {
        if (!0x2::table::contains<address, u64>(&arg0.stakes_per_staker, arg1)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.stakes_per_staker, arg1);
        if (*v0 == 1) {
            *v0 = 0;
            0x2::table::remove<address, u64>(&mut arg0.stakes_per_staker, arg1);
            return
        };
        *v0 = *v0 - 1;
    }

    fun ensure_supported<T0: store + key>(arg0: &Global) : 0x1::type_name::TypeName {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.supported_types, v0), 8);
        v0
    }

    public fun get_min_staking_duration(arg0: &Global) : u64 {
        arg0.min_staking_duration_ms
    }

    public fun get_staked_item_type(arg0: &Global, arg1: 0x2::object::ID) : 0x1::type_name::TypeName {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg1), 2);
        0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg1).item_type
    }

    public fun get_staking_info(arg0: &Global, arg1: 0x2::object::ID) : (0x2::object::ID, address, u64) {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg1), 2);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg1);
        (v0.kiosk_id, v0.staker, v0.staked_at)
    }

    fun inc_active(arg0: &mut Global, arg1: address) {
        if (0x2::table::contains<address, u64>(&arg0.stakes_per_staker, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.stakes_per_staker, arg1);
            *v0 = *v0 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.stakes_per_staker, arg1, 1);
        };
    }

    fun init(arg0: KIOSK_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let (v1, v2) = 0x2::kiosk::new(arg1);
        let v3 = v1;
        let v4 = Global{
            id                      : 0x2::object::new(arg1),
            enabled                 : true,
            min_staking_duration_ms : 1209600000,
            staked                  : 0x2::table::new<0x2::object::ID, StakedItemInfo>(arg1),
            stakes_per_staker       : 0x2::table::new<address, u64>(arg1),
            supported_types         : 0x2::table::new<0x1::type_name::TypeName, bool>(arg1),
            staking_kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            staking_cap             : v2,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_share_object<Global>(v4);
    }

    public fun is_staked(arg0: &Global, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg1)
    }

    public fun is_type_supported<T0: store + key>(arg0: &Global) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.supported_types, 0x1::type_name::with_original_ids<T0>())
    }

    public fun owner_cleanup_orphan<T0: store + key>(arg0: &mut Global, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg2), 2);
        assert_staking_kiosk(arg0, arg1);
        assert_type_matches<T0>(0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg2));
        assert!(!0x2::kiosk::has_item_with_type<T0>(arg1, arg2), 5);
        let v0 = 0x2::table::remove<0x2::object::ID, StakedItemInfo>(&mut arg0.staked, arg2);
        dec_active(arg0, v0.staker);
    }

    public fun stake<T0: store + key>(arg0: &mut Global, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 1);
        let v0 = ensure_supported<T0>(arg0);
        assert_staking_kiosk(arg0, arg3);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg4), 2);
        assert!(0x2::kiosk::is_locked(arg1, arg4), 5);
        assert!(!0x2::kiosk::is_listed(arg1, arg4), 7);
        assert!(!0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg4), 4);
        0x2::kiosk::place<T0>(arg3, &arg0.staking_cap, 0x2::kiosk::take<T0>(arg1, arg2, arg4));
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg3);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = 0x2::clock::timestamp_ms(arg5);
        let v4 = StakedItemInfo{
            kiosk_id  : v1,
            staker    : v2,
            staked_at : v3,
            item_type : v0,
        };
        0x2::table::add<0x2::object::ID, StakedItemInfo>(&mut arg0.staked, arg4, v4);
        inc_active(arg0, v2);
        let v5 = Staked{
            kiosk            : v1,
            item             : arg4,
            at               : v3,
            staker           : v2,
            lock_duration_ms : arg0.min_staking_duration_ms,
            item_type        : v0,
        };
        0x2::event::emit<Staked>(v5);
    }

    public fun unstake<T0: store + key>(arg0: &mut Global, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg2), 2);
        assert_staking_kiosk(arg0, arg1);
        let v0 = 0x2::table::borrow<0x2::object::ID, StakedItemInfo>(&arg0.staked, arg2);
        assert_type_matches<T0>(v0);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = v1 - v0.staked_at;
        assert!(v2 >= arg0.min_staking_duration_ms, 3);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg1, arg2), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg2), 7);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, &arg0.staking_cap, arg2), v0.staker);
        let v3 = 0x2::table::remove<0x2::object::ID, StakedItemInfo>(&mut arg0.staked, arg2);
        dec_active(arg0, v3.staker);
        let v4 = Unstaked{
            kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            item        : arg2,
            at          : v1,
            staker      : v3.staker,
            duration_ms : v2,
            item_type   : v3.item_type,
        };
        0x2::event::emit<Unstaked>(v4);
    }

    // decompiled from Move bytecode v6
}

