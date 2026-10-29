module 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::economics {
    struct Config<phantom T0> has key {
        id: 0x2::object::UID,
        revision: u64,
        primary_bps: u16,
        secondary_bps: u16,
        complete_fee: u64,
        recipient: address,
        paused: bool,
        income: 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::Ledger<T0>,
        schema: u16,
        enabled: bool,
        payment_coin: 0x1::type_name::TypeName,
        original_package: 0x2::object::ID,
        callable_package: 0x2::object::ID,
        commitment: vector<u8>,
        native_binding: 0x1::option::Option<NativeBindingSnapshot>,
        release_binding: 0x1::option::Option<ReleaseBindingSnapshot>,
        minimum_release: u64,
        roles: 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::State,
    }

    struct NativeBindingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct NativeBindingHistoryKey has copy, drop, store {
        generation: u64,
    }

    struct NativeBindingSnapshot has copy, drop, store {
        catalog: 0x2::object::ID,
        generation: u64,
        original_package: 0x2::object::ID,
        callable_package: 0x2::object::ID,
        commitment: vector<u8>,
    }

    struct ProtocolRevision1 has drop {
        dummy_field: bool,
    }

    struct ProtocolRevision2 has drop {
        dummy_field: bool,
    }

    struct MarketGatesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MarketGates has copy, drop, store {
        primary: bool,
        secondary: bool,
    }

    struct SourceRegistryKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SourceRegistryLocation has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct SourceRevisionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SourceRevisionChanged has copy, drop {
        config: 0x2::object::ID,
        registry: 0x2::object::ID,
        revision: u64,
        source: 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision,
        commitment: vector<u8>,
    }

    struct OperationalSnapshot has copy, drop, store {
        domain: vector<u8>,
        config: ConfigSnapshot,
        gates: MarketGates,
    }

    struct OperationalConfigurationChanged has copy, drop {
        snapshot: OperationalSnapshot,
        commitment: vector<u8>,
    }

    struct ConfigSnapshot has copy, drop, store {
        domain: vector<u8>,
        schema: u16,
        config: 0x2::object::ID,
        revision: u64,
        enabled: bool,
        paused: bool,
        payment_coin: 0x1::type_name::TypeName,
        original_package: 0x2::object::ID,
        callable_package: 0x2::object::ID,
        income_root: 0x2::object::ID,
        primary_bps: u16,
        secondary_bps: u16,
        complete_fee: u64,
        recipient: address,
        native_binding: 0x1::option::Option<NativeBindingSnapshot>,
        release_binding: 0x1::option::Option<ReleaseBindingSnapshot>,
        minimum_release: u64,
        roles: 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::State,
    }

    struct ConfigurationChanged has copy, drop {
        snapshot: ConfigSnapshot,
        commitment: vector<u8>,
    }

    struct Authority has key {
        id: 0x2::object::UID,
    }

    struct Admin has store, key {
        id: 0x2::object::UID,
        config: 0x2::object::ID,
    }

    struct Installation<phantom T0, phantom T1> {
        config: 0x2::object::ID,
        revision: u64,
        commitment: vector<u8>,
        kind: u8,
        original: 0x2::object::ID,
        callable: 0x2::object::ID,
        marker: 0x1::type_name::TypeName,
        value: 0x2::object::ID,
        generation: u64,
        value_commitment: vector<u8>,
    }

    struct PrimaryPolicy has copy, drop, store {
        schema: u16,
        config: 0x2::object::ID,
        snapshot_revision: u64,
        platform: address,
        bps: u16,
        complete_fee: u64,
    }

    struct PrimaryReceipt has copy, drop, store {
        policy: PrimaryPolicy,
        operational_revision: u64,
        subject: 0x2::object::ID,
        commitment: vector<u8>,
        actor: address,
        attempt: vector<u8>,
        expiry: u64,
        gross: u64,
        primary_amount: u64,
        fixed: u64,
        total: u64,
        beneficiary: address,
        net: u64,
        revenue: 0x1::option::Option<0x2::object::ID>,
    }

    struct PrimarySettled has copy, drop {
        receipt: PrimaryReceipt,
    }

    struct MarketPolicy has copy, drop, store {
        schema: u16,
        config: 0x2::object::ID,
        snapshot_revision: u64,
        platform: address,
        control_fee_bps: u16,
        equipment_fee_bps: u16,
        control_royalty_bps: u16,
        creator: address,
    }

    struct MarketReceipt has copy, drop, store {
        lane: u8,
        config: 0x2::object::ID,
        operational_revision: u64,
        policy: MarketPolicy,
        gross: u64,
        seller_amount: u64,
        platform_amount: u64,
        creator_amount: u64,
        seller: address,
    }

    struct MarketSettled has copy, drop {
        subject: 0x2::object::ID,
        attempt: vector<u8>,
        payer: address,
        receipt: MarketReceipt,
    }

    struct Paid has copy, drop {
        subject: 0x2::object::ID,
        attempt: vector<u8>,
        payer: address,
        gross: u64,
        fee: u64,
        beneficiary: address,
    }

    struct ManufacturingCreatorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ManufacturingCreator has copy, drop, store {
        creator: address,
    }

    struct ReleaseBindingKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReleaseHistoryKey has copy, drop, store {
        generation: u64,
    }

    struct ReleaseBindingSnapshot has copy, drop, store {
        catalog: 0x2::object::ID,
        generation: u64,
        original_package: 0x2::object::ID,
        callable_package: 0x2::object::ID,
        marker: 0x1::type_name::TypeName,
        commitment: vector<u8>,
    }

    struct ManufacturingActivation {
        config: 0x2::object::ID,
        revision: u64,
        commitment: vector<u8>,
        original: 0x2::object::ID,
        callable: 0x2::object::ID,
    }

    public fun activate_manufacturing_identity<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: T1, arg5: T2, arg6: ManufacturingActivation, arg7: 0x2::object::ID) {
        let ManufacturingActivation {
            config     : v0,
            revision   : v1,
            commitment : v2,
            original   : v3,
            callable   : v4,
        } = arg6;
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        assert_current_package<T0>(arg0);
        let v5 = if (!arg0.paused) {
            let v6 = MarketGatesKey{dummy_field: false};
            0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v6)
        } else {
            false
        };
        assert!(v5, 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_identity(&arg0.roles, 2, v3, v4);
        let v7 = if (v0 == 0x2::object::id<Config<T0>>(arg0)) {
            if (v1 == arg2) {
                if (v2 == arg3) {
                    let v8 = role<T0>(arg0, 1);
                    if (0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v8)) {
                        let v9 = role<T0>(arg0, 2);
                        if (0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v9)) {
                            if (0x1::option::is_some<ReleaseBindingSnapshot>(&arg0.release_binding)) {
                                let v10 = ReleaseBindingKey{dummy_field: false};
                                if (0x2::dynamic_object_field::exists_<ReleaseBindingKey>(&arg0.id, v10)) {
                                    arg7 == 0x1::option::borrow<ReleaseBindingSnapshot>(&arg0.release_binding).catalog
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
            } else {
                false
            }
        } else {
            false
        };
        assert!(v7, 1);
        arg0.enabled = true;
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    fun assert_admin<T0>(arg0: &Config<T0>, arg1: &Admin) {
        assert!(arg1.config == 0x2::object::id<Config<T0>>(arg0), 1);
    }

    public fun assert_business<T0, T1: drop, T2: drop>(arg0: &Config<T0>, arg1: u8, arg2: T1, arg3: T2) {
        assert!(arg1 >= 2 && arg1 < 6, 1);
        if (arg1 == 2 || arg1 == 5) {
            assert_primary<T0>(arg0);
        } else {
            assert_secondary<T0>(arg0);
        };
        let v0 = 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::role(&arg0.roles, arg1);
        assert!(0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v0), 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, arg1);
    }

    fun assert_current_package<T0>(arg0: &Config<T0>) {
        assert!(arg0.callable_package == current_callable_package() && arg0.minimum_release <= current_release(), 1);
    }

    public fun assert_enabled<T0>(arg0: &Config<T0>) {
        assert_recovery_identity<T0>(arg0);
        assert_enabled_after_recovery<T0>(arg0);
    }

    fun assert_enabled_after_recovery<T0>(arg0: &Config<T0>) {
        assert_current_package<T0>(arg0);
        assert_native_current<T0>(arg0);
        let v0 = if (arg0.enabled) {
            if (!arg0.paused) {
                let v1 = MarketGatesKey{dummy_field: false};
                0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun assert_exact_snapshot<T0>(arg0: &Config<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>) {
        assert_enabled<T0>(arg0);
        let v0 = if (0x2::object::id<Config<T0>>(arg0) == arg1) {
            if (arg0.revision == arg2) {
                arg0.commitment == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun assert_install_admin<T0>(arg0: &Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        let v0 = if (!arg0.enabled) {
            if (arg0.revision == arg2) {
                arg0.commitment == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun assert_live<T0>(arg0: &Config<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_enabled<T0>(arg0);
        assert_live_fields<T0>(arg0, arg1, arg2, arg3);
    }

    fun assert_live_fields<T0>(arg0: &Config<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg0.revision == arg1, 1);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 3);
    }

    public fun assert_manufacturing_business<T0, T1: drop, T2: drop>(arg0: &Config<T0>, arg1: T1, arg2: T2) {
        assert_manufacturing_primary<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, 2);
    }

    public fun assert_manufacturing_enabled<T0>(arg0: &Config<T0>) {
        assert_operation<T0>(arg0);
        let v0 = if (0x1::option::is_some<ReleaseBindingSnapshot>(&arg0.release_binding)) {
            let v1 = ReleaseBindingKey{dummy_field: false};
            if (0x2::dynamic_object_field::exists_<ReleaseBindingKey>(&arg0.id, v1)) {
                let v2 = role<T0>(arg0, 1);
                if (0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v2)) {
                    let v3 = role<T0>(arg0, 2);
                    0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v4 = 0x1::option::borrow<ReleaseBindingSnapshot>(&arg0.release_binding);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_identity(&arg0.roles, 1, v4.original_package, v4.callable_package);
        let v5 = role<T0>(arg0, 1);
        assert!(0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::marker(&v5) == 0x1::option::some<0x1::type_name::TypeName>(v4.marker) && is_nonzero_hash(&v4.commitment), 1);
    }

    public fun assert_manufacturing_live<T0>(arg0: &Config<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_manufacturing_primary<T0>(arg0);
        assert!(arg0.revision == arg1, 1);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg2, 3);
    }

    public fun assert_manufacturing_primary<T0>(arg0: &Config<T0>) {
        assert_manufacturing_enabled<T0>(arg0);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_manufacturing_snapshot<T0>(arg0: &Config<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>) {
        assert_manufacturing_primary<T0>(arg0);
        let v0 = if (0x2::object::id<Config<T0>>(arg0) == arg1) {
            if (arg0.revision == arg2) {
                arg0.commitment == arg3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    fun assert_native_current<T0>(arg0: &Config<T0>) {
        let v0 = if (0x1::option::is_some<NativeBindingSnapshot>(&arg0.native_binding)) {
            let v1 = NativeBindingKey{dummy_field: false};
            0x2::dynamic_object_field::exists_<NativeBindingKey>(&arg0.id, v1)
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = 0x1::option::borrow<NativeBindingSnapshot>(&arg0.native_binding);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_identity(&arg0.roles, 0, v2.original_package, v2.callable_package);
        assert!(is_nonzero_hash(&v2.commitment), 1);
    }

    public fun assert_operation<T0>(arg0: &Config<T0>) {
        assert_recovery_identity<T0>(arg0);
        assert_current_package<T0>(arg0);
        let v0 = if (arg0.enabled) {
            if (!arg0.paused) {
                let v1 = MarketGatesKey{dummy_field: false};
                0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun assert_primary<T0>(arg0: &Config<T0>) {
        assert_enabled<T0>(arg0);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_primary_live<T0>(arg0: &Config<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_live<T0>(arg0, arg1, arg2, arg3);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_primary_snapshot<T0>(arg0: &Config<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>) {
        assert_exact_snapshot<T0>(arg0, arg1, arg2, arg3);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_recovery_identity<T0>(arg0: &Config<T0>) {
        let v0 = if (arg0.schema == 3) {
            if (arg0.original_package == current_original_package()) {
                arg0.payment_coin == 0x1::type_name::with_original_ids<T0>()
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::root<T0>(&arg0.income);
        let v2 = 0x2::object::id<Config<T0>>(arg0);
        assert!(v1 == v2, 1);
        let v3 = MarketGatesKey{dummy_field: false};
        let v4 = ConfigSnapshot{
            domain           : b"soulidity-protocol-config-v3",
            schema           : arg0.schema,
            config           : v2,
            revision         : arg0.revision,
            enabled          : arg0.enabled,
            paused           : arg0.paused,
            payment_coin     : arg0.payment_coin,
            original_package : arg0.original_package,
            callable_package : arg0.callable_package,
            income_root      : v1,
            primary_bps      : arg0.primary_bps,
            secondary_bps    : arg0.secondary_bps,
            complete_fee     : arg0.complete_fee,
            recipient        : arg0.recipient,
            native_binding   : arg0.native_binding,
            release_binding  : arg0.release_binding,
            minimum_release  : arg0.minimum_release,
            roles            : arg0.roles,
        };
        let v5 = if (0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v3)) {
            let v6 = MarketGatesKey{dummy_field: false};
            let v7 = OperationalSnapshot{
                domain : b"soulidity-protocol-operational-v4",
                config : v4,
                gates  : *0x2::dynamic_field::borrow<MarketGatesKey, MarketGates>(&arg0.id, v6),
            };
            operational_snapshot_hash(&v7)
        } else {
            snapshot_hash(&v4)
        };
        assert!(arg0.commitment == v5, 1);
    }

    public fun assert_role_primary_live<T0, T1, T2>(arg0: &Config<T0>, arg1: u8, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_role_types<T0, T1, T2>(arg0, arg1);
        assert_enabled_after_recovery<T0>(arg0);
        assert_live_fields<T0>(arg0, arg2, arg3, arg4);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_role_primary_snapshot<T0, T1, T2>(arg0: &Config<T0>, arg1: u8, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>) {
        assert_role_types<T0, T1, T2>(arg0, arg1);
        assert_enabled_after_recovery<T0>(arg0);
        let v0 = if (0x2::object::id<Config<T0>>(arg0) == arg2) {
            if (arg0.revision == arg3) {
                arg0.commitment == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(primary_enabled<T0>(arg0), 1);
    }

    public fun assert_role_types<T0, T1, T2>(arg0: &Config<T0>, arg1: u8) {
        assert_recovery_identity<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, arg1);
    }

    public fun assert_secondary<T0>(arg0: &Config<T0>) {
        assert_enabled<T0>(arg0);
        assert!(secondary_enabled<T0>(arg0), 1);
    }

    public fun assert_secondary_live<T0>(arg0: &Config<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_live<T0>(arg0, arg1, arg2, arg3);
        assert!(secondary_enabled<T0>(arg0), 1);
    }

    public fun assert_source_revision<T0, T1, T2, T3: key>(arg0: &Config<T0>) {
        assert_recovery_identity<T0>(arg0);
        let v0 = source_revision<T0, T3>(arg0);
        assert!(0x1::option::is_some<0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&v0), 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::assert_types<T1, T2, T3>(0x1::option::borrow<0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&v0));
    }

    public fun authorize_installation<T0, T1: drop, T2: drop, T3: store + key>(arg0: &Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: T1, arg6: T2, arg7: &T3, arg8: u64, arg9: vector<u8>) : Installation<T0, T3> {
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        assert_current_package<T0>(arg0);
        assert!(arg4 <= 1, 1);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        let v1 = 0x1::type_name::with_original_ids<T3>();
        let v2 = if (arg4 == 0) {
            b"native_binding"
        } else {
            b"maker_release"
        };
        let v3 = if (arg4 == 0) {
            b"NativeInstaller1"
        } else {
            b"ReleaseInstaller1"
        };
        let v4 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                is_nonzero_hash(&arg9)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 1);
        let v5 = 0x1::type_name::module_string(&v0);
        let v6 = if (*0x1::ascii::as_bytes(&v5) == v2) {
            let v7 = 0x1::type_name::datatype_string(&v0);
            if (*0x1::ascii::as_bytes(&v7) == v3) {
                let v8 = 0x1::type_name::module_string(&v1);
                if (*0x1::ascii::as_bytes(&v8) == v2) {
                    let v9 = 0x1::type_name::datatype_string(&v1);
                    *0x1::ascii::as_bytes(&v9) == b"Catalog"
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 1);
        assert!(0x1::type_name::original_id<T3>() == 0x1::type_name::original_id<T1>(), 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, arg4);
        Installation<T0, T3>{
            config           : 0x2::object::id<Config<T0>>(arg0),
            revision         : arg0.revision,
            commitment       : arg0.commitment,
            kind             : arg4,
            original         : 0x2::object::id_from_address(0x1::type_name::original_id<T1>()),
            callable         : 0x2::object::id_from_address(0x1::type_name::defining_id<T2>()),
            marker           : 0x1::type_name::with_defining_ids<T2>(),
            value            : 0x2::object::id<T3>(arg7),
            generation       : arg8,
            value_commitment : arg9,
        }
    }

    public fun authorize_manufacturing_activation<T0, T1: drop, T2: drop>(arg0: &Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: T1, arg5: T2) : ManufacturingActivation {
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        assert_current_package<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, 2);
        let v0 = role<T0>(arg0, 2);
        assert!(0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v0), 1);
        ManufacturingActivation{
            config     : 0x2::object::id<Config<T0>>(arg0),
            revision   : arg2,
            commitment : arg3,
            original   : 0x2::object::id_from_address(0x1::type_name::original_id<T1>()),
            callable   : 0x2::object::id_from_address(0x1::type_name::defining_id<T2>()),
        }
    }

    public fun callable_package<T0>(arg0: &Config<T0>) : 0x2::object::ID {
        arg0.callable_package
    }

    public fun collect_manufacturing_primary<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: PrimaryReceipt, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_manufacturing_business<T0, T1, T2>(arg0, arg1, arg2);
        assert_live_fields<T0>(arg0, arg3.operational_revision, arg3.expiry, arg5);
        collect_primary_value<T0>(arg0, arg3, arg4, arg6)
    }

    public fun collect_primary<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: PrimaryReceipt, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_business<T0, T1, T2>(arg0, 2, arg1, arg2);
        assert_live_fields<T0>(arg0, arg3.operational_revision, arg3.expiry, arg5);
        collect_primary_value<T0>(arg0, arg3, arg4, arg6)
    }

    fun collect_primary_value<T0>(arg0: &mut Config<T0>, arg1: PrimaryReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = if (0x1::option::is_some<0x2::object::ID>(&arg1.revenue)) {
            if (arg1.policy.config == 0x2::object::id<Config<T0>>(arg0)) {
                0x2::tx_context::sender(arg3) == arg1.actor
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(0x2::coin::value<T0>(&arg2) == arg1.total, 2);
        let v1 = arg1.primary_amount + arg1.fixed;
        if (v1 > 0) {
            0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::deposit<T0>(&arg0.id, &mut arg0.income, 0x2::coin::split<T0>(&mut arg2, v1, arg3));
        };
        assert!(0x2::coin::value<T0>(&arg2) == arg1.net, 2);
        let v2 = PrimarySettled{receipt: arg1};
        0x2::event::emit<PrimarySettled>(v2);
        arg2
    }

    public fun commitment<T0>(arg0: &Config<T0>) : vector<u8> {
        arg0.commitment
    }

    public fun complete_fee<T0>(arg0: &Config<T0>) : u64 {
        arg0.complete_fee
    }

    public fun configure<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: u16, arg4: u16, arg5: u64, arg6: address, arg7: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        if (!arg7) {
            assert_current_package<T0>(arg0);
        };
        let v0 = if (arg0.revision == arg2) {
            if (arg3 <= 10000) {
                if (arg4 <= 10000) {
                    arg6 != @0x0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        arg0.primary_bps = arg3;
        arg0.secondary_bps = arg4;
        arg0.complete_fee = arg5;
        arg0.recipient = arg6;
        arg0.paused = arg7;
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    fun consume_installation<T0, T1: store + key>(arg0: &Config<T0>, arg1: &mut Admin, arg2: Installation<T0, T1>, arg3: u8, arg4: &T1, arg5: u64, arg6: &vector<u8>) : (0x2::object::ID, 0x2::object::ID, 0x1::type_name::TypeName) {
        let Installation {
            config           : v0,
            revision         : v1,
            commitment       : v2,
            kind             : v3,
            original         : v4,
            callable         : v5,
            marker           : v6,
            value            : v7,
            generation       : v8,
            value_commitment : v9,
        } = arg2;
        assert_install_admin<T0>(arg0, arg1, v1, v2);
        assert_current_package<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_identity(&arg0.roles, arg3, v4, v5);
        let v10 = if (v0 == 0x2::object::id<Config<T0>>(arg0)) {
            if (v3 == arg3) {
                if (v7 == 0x2::object::id<T1>(arg4)) {
                    if (v8 == arg5) {
                        v9 == *arg6
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
        assert!(v10, 1);
        (v4, v5, v6)
    }

    public fun control_fee_bps(arg0: &MarketPolicy) : u16 {
        arg0.control_fee_bps
    }

    public fun control_royalty_bps(arg0: &MarketPolicy) : u16 {
        arg0.control_royalty_bps
    }

    public fun create<T0>(arg0: &Authority, arg1: u16, arg2: u16, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let (v0, v1) = new_config<T0>(arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        0x2::transfer::public_transfer<Admin>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<Config<T0>>(v2);
        0x2::object::id<Config<T0>>(&v2)
    }

    public fun current_callable_package() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::defining_id<ProtocolRevision2>())
    }

    public fun current_original_package() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::original_id<Authority>())
    }

    public fun current_release() : u64 {
        2
    }

    public fun deposit_income<T0>(arg0: &mut Config<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_enabled<T0>(arg0);
        assert!(0x2::coin::value<T0>(&arg1) > 0, 2);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::deposit<T0>(&arg0.id, &mut arg0.income, arg1);
    }

    public fun enabled<T0>(arg0: &Config<T0>) : bool {
        arg0.enabled
    }

    public fun equipment_fee_bps(arg0: &MarketPolicy) : u16 {
        arg0.equipment_fee_bps
    }

    public fun fee(arg0: u64, arg1: u16) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    public fun finalize_manufacturing_instance<T0>(arg0: Config<T0>, arg1: Admin, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(manufacturing_creator<T0>(&arg0) == 0x2::tx_context::sender(arg2), 1);
        share_config<T0>(arg0, arg1, arg2)
    }

    public fun freeze_role<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: u8) {
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::freeze_role(&mut arg0.roles, arg4);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun income<T0>(arg0: &Config<T0>) : &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::Ledger<T0> {
        &arg0.income
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Authority{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Authority>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun install_manufacturing_release<T0, T1: store + key>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: Installation<T0, T1>, arg3: T1, arg4: u64, arg5: vector<u8>) {
        let (v0, v1, v2) = consume_installation<T0, T1>(arg0, arg1, arg2, 1, &arg3, arg4, &arg5);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pin(&mut arg0.roles, 1, v2);
        assert!(!arg0.enabled && is_nonzero_hash(&arg5), 1);
        assert_current_package<T0>(arg0);
        if (0x1::option::is_none<ReleaseBindingSnapshot>(&arg0.release_binding)) {
            assert!(arg4 == 0, 1);
        } else {
            let v3 = 0x1::option::destroy_some<ReleaseBindingSnapshot>(arg0.release_binding);
            assert!(arg4 == v3.generation + 1, 1);
            let v4 = ReleaseBindingKey{dummy_field: false};
            let v5 = 0x2::dynamic_object_field::remove<ReleaseBindingKey, T1>(&mut arg0.id, v4);
            assert!(0x2::object::id<T1>(&v5) == v3.catalog, 1);
            let v6 = ReleaseHistoryKey{generation: v3.generation};
            0x2::dynamic_object_field::add<ReleaseHistoryKey, T1>(&mut arg0.id, v6, v5);
        };
        let v7 = ReleaseBindingKey{dummy_field: false};
        0x2::dynamic_object_field::add<ReleaseBindingKey, T1>(&mut arg0.id, v7, arg3);
        let v8 = ReleaseBindingSnapshot{
            catalog          : 0x2::object::id<T1>(&arg3),
            generation       : arg4,
            original_package : v0,
            callable_package : v1,
            marker           : v2,
            commitment       : arg5,
        };
        arg0.release_binding = 0x1::option::some<ReleaseBindingSnapshot>(v8);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun install_native<T0, T1: store + key>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: Installation<T0, T1>, arg3: T1, arg4: u64, arg5: vector<u8>) {
        let (v0, v1, v2) = consume_installation<T0, T1>(arg0, arg1, arg2, 0, &arg3, arg4, &arg5);
        install_native_value<T0, T1>(arg0, arg3, arg4, v0, v1, v2, arg5);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    fun install_native_value<T0, T1: store + key>(arg0: &mut Config<T0>, arg1: T1, arg2: u64, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::type_name::TypeName, arg6: vector<u8>) {
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_identity(&arg0.roles, 0, arg3, arg4);
        let v0 = if (!arg0.enabled) {
            if (arg0.minimum_release <= current_release()) {
                is_nonzero_hash(&arg6)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pin(&mut arg0.roles, 0, arg5);
        arg0.minimum_release = current_release();
        if (0x1::option::is_none<NativeBindingSnapshot>(&arg0.native_binding)) {
            assert!(arg2 == 0, 1);
        } else {
            let v1 = 0x1::option::destroy_some<NativeBindingSnapshot>(arg0.native_binding);
            assert!(arg2 == v1.generation + 1, 1);
            let v2 = NativeBindingKey{dummy_field: false};
            let v3 = 0x2::dynamic_object_field::remove<NativeBindingKey, T1>(&mut arg0.id, v2);
            assert!(0x2::object::id<T1>(&v3) == v1.catalog, 1);
            let v4 = NativeBindingHistoryKey{generation: v1.generation};
            0x2::dynamic_object_field::add<NativeBindingHistoryKey, T1>(&mut arg0.id, v4, v3);
        };
        let v5 = NativeBindingKey{dummy_field: false};
        0x2::dynamic_object_field::add<NativeBindingKey, T1>(&mut arg0.id, v5, arg1);
        let v6 = NativeBindingSnapshot{
            catalog          : 0x2::object::id<T1>(&arg1),
            generation       : arg2,
            original_package : arg3,
            callable_package : arg4,
            commitment       : arg6,
        };
        arg0.native_binding = 0x1::option::some<NativeBindingSnapshot>(v6);
        refresh_commitment<T0>(arg0);
    }

    public fun install_release<T0, T1: store + key>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: Installation<T0, T1>, arg3: T1, arg4: u64, arg5: vector<u8>) {
        assert_native_current<T0>(arg0);
        install_manufacturing_release<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun is_nonzero_hash(arg0: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) == 32) {
            let v0 = 0;
            let v1;
            while (v0 < 0x1::vector::length<u8>(arg0)) {
                let v2 = 0;
                if (0x1::vector::borrow<u8>(arg0, v0) != &v2) {
                    v1 = true;
                    /* label 8 */
                    return v1
                };
                v0 = v0 + 1;
            };
            v1 = false;
            /* goto 8 */
        } else {
            return false
        };
    }

    public fun manufacturing_creator<T0>(arg0: &Config<T0>) : address {
        let v0 = ManufacturingCreatorKey{dummy_field: false};
        0x2::dynamic_field::borrow<ManufacturingCreatorKey, ManufacturingCreator>(&arg0.id, v0).creator
    }

    public fun manufacturing_market_policy<T0>(arg0: &Config<T0>, arg1: u16, arg2: &0x2::tx_context::TxContext) : MarketPolicy {
        assert_manufacturing_enabled<T0>(arg0);
        market_policy_value<T0>(arg0, arg1, arg2)
    }

    public fun manufacturing_primary_policy<T0>(arg0: &Config<T0>) : PrimaryPolicy {
        assert_manufacturing_primary<T0>(arg0);
        primary_policy_value<T0>(arg0)
    }

    public fun manufacturing_primary_quote<T0>(arg0: &PrimaryPolicy, arg1: &Config<T0>, arg2: u64, arg3: bool, arg4: address, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: u64) : PrimaryReceipt {
        assert_manufacturing_primary<T0>(arg1);
        primary_quote_value<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun market_config(arg0: &MarketPolicy) : 0x2::object::ID {
        arg0.config
    }

    public fun market_creator(arg0: &MarketPolicy) : address {
        arg0.creator
    }

    public fun market_platform(arg0: &MarketPolicy) : address {
        arg0.platform
    }

    public fun market_policy<T0>(arg0: &Config<T0>, arg1: u16, arg2: &0x2::tx_context::TxContext) : MarketPolicy {
        assert_enabled<T0>(arg0);
        market_policy_value<T0>(arg0, arg1, arg2)
    }

    public fun market_policy_hash(arg0: &MarketPolicy) : vector<u8> {
        0x1::hash::sha2_256(0x1::bcs::to_bytes<MarketPolicy>(arg0))
    }

    fun market_policy_value<T0>(arg0: &Config<T0>, arg1: u16, arg2: &0x2::tx_context::TxContext) : MarketPolicy {
        assert!(arg1 <= 1000 && 0x2::tx_context::sender(arg2) != @0x0, 1);
        MarketPolicy{
            schema              : 1,
            config              : 0x2::object::id<Config<T0>>(arg0),
            snapshot_revision   : arg0.revision,
            platform            : arg0.recipient,
            control_fee_bps     : 250,
            equipment_fee_bps   : 250,
            control_royalty_bps : arg1,
            creator             : 0x2::tx_context::sender(arg2),
        }
    }

    public fun market_quote<T0>(arg0: &MarketPolicy, arg1: &Config<T0>, arg2: u8, arg3: u64, arg4: address) : MarketReceipt {
        assert_secondary<T0>(arg1);
        assert!(arg0.config == 0x2::object::id<Config<T0>>(arg1) && arg2 <= 1, 1);
        assert!(arg3 > 0 && arg4 != @0x0, 2);
        let v0 = if (arg2 == 0) {
            arg0.control_fee_bps
        } else {
            arg0.equipment_fee_bps
        };
        let v1 = if (arg2 == 0) {
            arg0.control_royalty_bps
        } else {
            0
        };
        let v2 = strict_share(arg3, v0);
        let v3 = strict_share(arg3, v1);
        let v4 = (v2 as u128) + (v3 as u128);
        assert!(v4 < (arg3 as u128), 2);
        MarketReceipt{
            lane                 : arg2,
            config               : arg0.config,
            operational_revision : arg1.revision,
            policy               : *arg0,
            gross                : arg3,
            seller_amount        : arg3 - (v4 as u64),
            platform_amount      : v2,
            creator_amount       : v3,
            seller               : arg4,
        }
    }

    public fun market_receipt_creator_amount(arg0: &MarketReceipt) : u64 {
        arg0.creator_amount
    }

    public fun market_receipt_gross(arg0: &MarketReceipt) : u64 {
        arg0.gross
    }

    public fun market_receipt_lane(arg0: &MarketReceipt) : u8 {
        arg0.lane
    }

    public fun market_receipt_platform_amount(arg0: &MarketReceipt) : u64 {
        arg0.platform_amount
    }

    public fun market_receipt_policy(arg0: &MarketReceipt) : MarketPolicy {
        arg0.policy
    }

    public fun market_receipt_revision(arg0: &MarketReceipt) : u64 {
        arg0.operational_revision
    }

    public fun market_receipt_seller(arg0: &MarketReceipt) : address {
        arg0.seller
    }

    public fun market_receipt_seller_amount(arg0: &MarketReceipt) : u64 {
        arg0.seller_amount
    }

    public fun market_revision(arg0: &MarketPolicy) : u64 {
        arg0.snapshot_revision
    }

    public fun market_settle<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: MarketReceipt, arg4: 0x2::coin::Coin<T0>, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_business<T0, T1, T2>(arg0, 3, arg1, arg2);
        assert_enabled<T0>(arg0);
        assert!(arg3.config == 0x2::object::id<Config<T0>>(arg0) && arg3.operational_revision == arg0.revision, 1);
        assert!(0x2::coin::value<T0>(&arg4) == arg3.gross, 2);
        if (arg3.platform_amount > 0) {
            deposit_income<T0>(arg0, 0x2::coin::split<T0>(&mut arg4, arg3.platform_amount, arg7));
        };
        if (arg3.creator_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg4, arg3.creator_amount, arg7), arg3.policy.creator);
        };
        assert!(0x2::coin::value<T0>(&arg4) == arg3.seller_amount && arg3.seller_amount > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg4, arg3.seller);
        let v0 = MarketSettled{
            subject : arg5,
            attempt : arg6,
            payer   : 0x2::tx_context::sender(arg7),
            receipt : arg3,
        };
        0x2::event::emit<MarketSettled>(v0);
    }

    public fun minimum_release<T0>(arg0: &Config<T0>) : u64 {
        arg0.minimum_release
    }

    public fun native_catalog(arg0: &NativeBindingSnapshot) : 0x2::object::ID {
        arg0.catalog
    }

    public fun native_commitment(arg0: &NativeBindingSnapshot) : vector<u8> {
        arg0.commitment
    }

    public fun native_generation(arg0: &NativeBindingSnapshot) : u64 {
        arg0.generation
    }

    public fun native_history<T0, T1: store + key>(arg0: &Config<T0>, arg1: u64) : &T1 {
        let v0 = NativeBindingHistoryKey{generation: arg1};
        0x2::dynamic_object_field::borrow<NativeBindingHistoryKey, T1>(&arg0.id, v0)
    }

    public fun native_object<T0, T1: store + key>(arg0: &Config<T0>) : &T1 {
        let v0 = NativeBindingKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<NativeBindingKey, T1>(&arg0.id, v0)
    }

    public fun native_primary_additional<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_business<T0, T1, T2>(arg0, 5, arg1, arg2);
        assert_primary<T0>(arg0);
        let v0 = native_primary_total<T0>(arg0, arg4);
        assert!(arg5 != @0x0 && 0x2::coin::value<T0>(&arg3) == v0, 2);
        let v1 = native_primary_fee<T0>(arg0, arg4);
        if (v1 > 0) {
            deposit_income<T0>(arg0, 0x2::coin::split<T0>(&mut arg3, v1, arg8));
        };
        let v2 = Paid{
            subject     : arg6,
            attempt     : arg7,
            payer       : 0x2::tx_context::sender(arg8),
            gross       : v0,
            fee         : v1,
            beneficiary : arg5,
        };
        0x2::event::emit<Paid>(v2);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg5);
    }

    public fun native_primary_fee<T0>(arg0: &Config<T0>, arg1: u64) : u64 {
        assert!(arg1 > 0, 1);
        right_fee(arg1, arg0.primary_bps)
    }

    public fun native_primary_total<T0>(arg0: &Config<T0>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) + (native_primary_fee<T0>(arg0, arg1) as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun native_sale_quote<T0>(arg0: &Config<T0>, arg1: u64, arg2: u16, arg3: u16) : (u64, u64, u64, u64) {
        assert!(arg1 > 0 && (arg0.secondary_bps as u64) + (arg2 as u64) + (arg3 as u64) <= 10000, 1);
        let v0 = right_fee(arg1, arg0.secondary_bps);
        let v1 = right_fee(arg1, arg2);
        let v2 = right_fee(arg1, arg3);
        let v3 = (arg1 as u128) + (v0 as u128) + (v1 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 1);
        (v0, v1, v2, (v3 as u64))
    }

    public fun native_sale_settle<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: address, arg7: u16, arg8: address, arg9: u16, arg10: 0x2::object::ID, arg11: vector<u8>, arg12: &mut 0x2::tx_context::TxContext) {
        assert_business<T0, T1, T2>(arg0, 3, arg1, arg2);
        assert_secondary<T0>(arg0);
        let (v0, v1, v2, v3) = native_sale_quote<T0>(arg0, arg4, arg7, arg9);
        let v4 = if (arg5 != @0x0) {
            if (arg6 != @0x0) {
                if (v2 == 0 || arg8 != @0x0) {
                    0x2::coin::value<T0>(&arg3) == v3
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 2);
        if (v0 > 0) {
            deposit_income<T0>(arg0, 0x2::coin::split<T0>(&mut arg3, v0, arg12));
        };
        if (v1 > 0 && arg6 != arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v1, arg12), arg6);
        };
        if (v2 > 0 && arg8 != arg5) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2, arg12), arg8);
        };
        let v5 = Paid{
            subject     : arg10,
            attempt     : arg11,
            payer       : 0x2::tx_context::sender(arg12),
            gross       : v3,
            fee         : v0,
            beneficiary : arg5,
        };
        0x2::event::emit<Paid>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg5);
    }

    public fun native_snapshot<T0>(arg0: &Config<T0>) : 0x1::option::Option<NativeBindingSnapshot> {
        arg0.native_binding
    }

    public(friend) fun new_config<T0>(arg0: u16, arg1: u16, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : (Config<T0>, Admin) {
        let v0 = if (arg0 <= 10000) {
            if (arg1 <= 10000) {
                arg3 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = 0x2::object::new(arg4);
        let v2 = Config<T0>{
            id               : v1,
            revision         : 0,
            primary_bps      : arg0,
            secondary_bps    : arg1,
            complete_fee     : arg2,
            recipient        : arg3,
            paused           : false,
            income           : 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::new<T0>(&v1, arg4),
            schema           : 3,
            enabled          : false,
            payment_coin     : 0x1::type_name::with_original_ids<T0>(),
            original_package : current_original_package(),
            callable_package : current_callable_package(),
            commitment       : b"",
            native_binding   : 0x1::option::none<NativeBindingSnapshot>(),
            release_binding  : 0x1::option::none<ReleaseBindingSnapshot>(),
            minimum_release  : current_release(),
            roles            : 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::initial(current_original_package(), current_callable_package()),
        };
        let v3 = &mut v2;
        refresh_commitment<T0>(v3);
        let v4 = Admin{
            id     : 0x2::object::new(arg4),
            config : 0x2::object::id<Config<T0>>(&v2),
        };
        (v2, v4)
    }

    public fun new_manufacturing_instance<T0, T1: drop, T2: drop, T3: drop, T4: drop>(arg0: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::RoleCertificate<T1, T2>, arg1: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::RoleCertificate<T3, T4>, arg2: T1, arg3: T2, arg4: T3, arg5: T4, arg6: u16, arg7: u16, arg8: u64, arg9: address, arg10: &mut 0x2::tx_context::TxContext) : (Config<T0>, Admin) {
        let v0 = 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::initial(current_original_package(), current_callable_package());
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::register_from_certificate<T1, T2>(&mut v0, 1, arg2, arg3, arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::register_from_certificate<T3, T4>(&mut v0, 2, arg4, arg5, arg1);
        let (v1, v2) = new_config<T0>(arg6, arg7, arg8, arg9, arg10);
        let v3 = v1;
        v3.roles = v0;
        let v4 = ManufacturingCreatorKey{dummy_field: false};
        let v5 = ManufacturingCreator{creator: 0x2::tx_context::sender(arg10)};
        0x2::dynamic_field::add<ManufacturingCreatorKey, ManufacturingCreator>(&mut v3.id, v4, v5);
        let v6 = &mut v3;
        refresh_commitment<T0>(v6);
        (v3, v2)
    }

    public fun operational_snapshot<T0>(arg0: &Config<T0>) : OperationalSnapshot {
        let v0 = MarketGatesKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v0), 1);
        let v1 = MarketGatesKey{dummy_field: false};
        OperationalSnapshot{
            domain : b"soulidity-protocol-operational-v4",
            config : snapshot<T0>(arg0),
            gates  : *0x2::dynamic_field::borrow<MarketGatesKey, MarketGates>(&arg0.id, v1),
        }
    }

    public fun operational_snapshot_hash(arg0: &OperationalSnapshot) : vector<u8> {
        0x1::hash::sha2_256(0x1::bcs::to_bytes<OperationalSnapshot>(arg0))
    }

    public fun original_package<T0>(arg0: &Config<T0>) : 0x2::object::ID {
        arg0.original_package
    }

    public fun paused<T0>(arg0: &Config<T0>) : bool {
        arg0.paused
    }

    public fun payment_coin<T0>(arg0: &Config<T0>) : 0x1::type_name::TypeName {
        arg0.payment_coin
    }

    public fun primary_additional<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_business<T0, T1, T2>(arg0, 5, arg1, arg2);
        let v0 = primary_total<T0>(arg0, arg4);
        assert!(arg5 != @0x0 && 0x2::coin::value<T0>(&arg3) == v0, 2);
        let v1 = fee(arg4, arg0.primary_bps);
        if (v1 > 0) {
            deposit_income<T0>(arg0, 0x2::coin::split<T0>(&mut arg3, v1, arg8));
        };
        let v2 = Paid{
            subject     : arg6,
            attempt     : arg7,
            payer       : 0x2::tx_context::sender(arg8),
            gross       : v0,
            fee         : v1,
            beneficiary : arg5,
        };
        0x2::event::emit<Paid>(v2);
        assert!(0x2::coin::value<T0>(&arg3) == arg4, 2);
        if (arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg5);
        };
    }

    public fun primary_bps<T0>(arg0: &Config<T0>) : u16 {
        arg0.primary_bps
    }

    public fun primary_enabled<T0>(arg0: &Config<T0>) : bool {
        let v0 = MarketGatesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v0)) {
            let v2 = MarketGatesKey{dummy_field: false};
            0x2::dynamic_field::borrow<MarketGatesKey, MarketGates>(&arg0.id, v2).primary
        } else {
            false
        }
    }

    public fun primary_fee<T0>(arg0: &Config<T0>, arg1: u64) : u64 {
        fee(arg1, arg0.primary_bps)
    }

    public fun primary_policy<T0>(arg0: &Config<T0>) : PrimaryPolicy {
        assert_primary<T0>(arg0);
        primary_policy_value<T0>(arg0)
    }

    public fun primary_policy_bps(arg0: &PrimaryPolicy) : u16 {
        arg0.bps
    }

    public fun primary_policy_config(arg0: &PrimaryPolicy) : 0x2::object::ID {
        arg0.config
    }

    public fun primary_policy_fee(arg0: &PrimaryPolicy, arg1: u64) : u64 {
        fee(arg1, arg0.bps)
    }

    public fun primary_policy_fixed(arg0: &PrimaryPolicy) : u64 {
        arg0.complete_fee
    }

    public fun primary_policy_hash(arg0: &PrimaryPolicy) : vector<u8> {
        0x1::hash::sha2_256(0x1::bcs::to_bytes<PrimaryPolicy>(arg0))
    }

    public fun primary_policy_platform(arg0: &PrimaryPolicy) : address {
        arg0.platform
    }

    public fun primary_policy_revision(arg0: &PrimaryPolicy) : u64 {
        arg0.snapshot_revision
    }

    fun primary_policy_value<T0>(arg0: &Config<T0>) : PrimaryPolicy {
        PrimaryPolicy{
            schema            : 1,
            config            : 0x2::object::id<Config<T0>>(arg0),
            snapshot_revision : arg0.revision,
            platform          : arg0.recipient,
            bps               : arg0.primary_bps,
            complete_fee      : arg0.complete_fee,
        }
    }

    public fun primary_quote<T0>(arg0: &PrimaryPolicy, arg1: &Config<T0>, arg2: u64, arg3: bool, arg4: address, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: u64) : PrimaryReceipt {
        assert_primary<T0>(arg1);
        primary_quote_value<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    fun primary_quote_value<T0>(arg0: &PrimaryPolicy, arg1: &Config<T0>, arg2: u64, arg3: bool, arg4: address, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: address, arg8: vector<u8>, arg9: u64) : PrimaryReceipt {
        let v0 = if (arg0.config == 0x2::object::id<Config<T0>>(arg1)) {
            if (arg4 != @0x0) {
                if (arg7 != @0x0) {
                    if (0x1::vector::length<u8>(&arg6) == 32) {
                        0x1::vector::length<u8>(&arg8) == 32
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
        assert!(v0, 1);
        let v1 = if (arg2 == 0) {
            0
        } else {
            strict_share(arg2, arg0.bps)
        };
        assert!(arg2 == 0 || v1 < arg2, 2);
        let v2 = if (arg3) {
            arg0.complete_fee
        } else {
            0
        };
        let v3 = (arg2 as u128) + (v2 as u128);
        assert!(v3 <= 18446744073709551615, 2);
        PrimaryReceipt{
            policy               : *arg0,
            operational_revision : arg1.revision,
            subject              : arg5,
            commitment           : arg6,
            actor                : arg7,
            attempt              : arg8,
            expiry               : arg9,
            gross                : arg2,
            primary_amount       : v1,
            fixed                : v2,
            total                : (v3 as u64),
            beneficiary          : arg4,
            net                  : arg2 - v1,
            revenue              : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun primary_receipt_actor(arg0: &PrimaryReceipt) : address {
        arg0.actor
    }

    public fun primary_receipt_attempt(arg0: &PrimaryReceipt) : vector<u8> {
        arg0.attempt
    }

    public fun primary_receipt_beneficiary(arg0: &PrimaryReceipt) : address {
        arg0.beneficiary
    }

    public fun primary_receipt_commitment(arg0: &PrimaryReceipt) : vector<u8> {
        arg0.commitment
    }

    public fun primary_receipt_fee(arg0: &PrimaryReceipt) : u64 {
        arg0.primary_amount
    }

    public fun primary_receipt_fixed(arg0: &PrimaryReceipt) : u64 {
        arg0.fixed
    }

    public fun primary_receipt_gross(arg0: &PrimaryReceipt) : u64 {
        arg0.gross
    }

    public fun primary_receipt_net(arg0: &PrimaryReceipt) : u64 {
        arg0.net
    }

    public fun primary_receipt_policy(arg0: &PrimaryReceipt) : PrimaryPolicy {
        arg0.policy
    }

    public fun primary_receipt_revenue(arg0: &PrimaryReceipt) : 0x1::option::Option<0x2::object::ID> {
        arg0.revenue
    }

    public fun primary_receipt_revision(arg0: &PrimaryReceipt) : u64 {
        arg0.operational_revision
    }

    public fun primary_receipt_subject(arg0: &PrimaryReceipt) : 0x2::object::ID {
        arg0.subject
    }

    public fun primary_receipt_total(arg0: &PrimaryReceipt) : u64 {
        arg0.total
    }

    public fun primary_total<T0>(arg0: &Config<T0>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) + (fee(arg1, arg0.primary_bps) as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun quote_collect_manufacturing_primary<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: &PrimaryPolicy, arg4: u64, arg5: bool, arg6: address, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: address, arg10: vector<u8>, arg11: u64, arg12: 0x2::object::ID, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (PrimaryReceipt, 0x2::coin::Coin<T0>) {
        assert_manufacturing_primary<T0>(arg0);
        let v0 = route_primary(primary_quote_value<T0>(arg3, arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg12);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, 2);
        assert_live_fields<T0>(arg0, v0.operational_revision, v0.expiry, arg14);
        (v0, collect_primary_value<T0>(arg0, v0, arg13, arg15))
    }

    public fun quote_collect_primary<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: &PrimaryPolicy, arg4: u64, arg5: bool, arg6: address, arg7: 0x2::object::ID, arg8: vector<u8>, arg9: address, arg10: vector<u8>, arg11: u64, arg12: 0x2::object::ID, arg13: 0x2::coin::Coin<T0>, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) : (PrimaryReceipt, 0x2::coin::Coin<T0>) {
        assert_primary<T0>(arg0);
        let v0 = route_primary(primary_quote_value<T0>(arg3, arg0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11), arg12);
        let v1 = 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::role(&arg0.roles, 2);
        assert!(0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::pinned(&v1), 1);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::assert_types<T1, T2>(&arg0.roles, 2);
        assert_live_fields<T0>(arg0, v0.operational_revision, v0.expiry, arg14);
        (v0, collect_primary_value<T0>(arg0, v0, arg13, arg15))
    }

    public fun rebind_current_package<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        let v0 = if (!arg0.enabled) {
            if (arg0.revision == arg2) {
                if (arg0.commitment == arg3) {
                    arg0.callable_package != current_callable_package()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        assert!(arg0.minimum_release <= current_release(), 1);
        arg0.callable_package = current_callable_package();
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun recipient<T0>(arg0: &Config<T0>) : address {
        arg0.recipient
    }

    fun refresh_commitment<T0>(arg0: &mut Config<T0>) {
        let v0 = MarketGatesKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v0)) {
            let v1 = MarketGatesKey{dummy_field: false};
            let v2 = MarketGates{
                primary   : false,
                secondary : false,
            };
            0x2::dynamic_field::add<MarketGatesKey, MarketGates>(&mut arg0.id, v1, v2);
        };
        let v3 = operational_snapshot<T0>(arg0);
        arg0.commitment = operational_snapshot_hash(&v3);
        let v4 = OperationalConfigurationChanged{
            snapshot   : operational_snapshot<T0>(arg0),
            commitment : arg0.commitment,
        };
        0x2::event::emit<OperationalConfigurationChanged>(v4);
    }

    public fun register_role<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: T1, arg6: T2, arg7: &0x2::package::Publisher, arg8: &0x2::package::UpgradeCap) {
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        assert_current_package<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::register<T1, T2>(&mut arg0.roles, arg4, arg5, arg6, arg7, arg8);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun register_role_from_certificate<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: u8, arg5: T1, arg6: T2, arg7: &0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::RoleCertificate<T1, T2>) {
        assert_install_admin<T0>(arg0, arg1, arg2, arg3);
        assert_current_package<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::register_from_certificate<T1, T2>(&mut arg0.roles, arg4, arg5, arg6, arg7);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun register_source_registry<T0, T1: drop, T2: key>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: T1, arg3: &T2, arg4: u64, arg5: vector<u8>) : 0x2::object::ID {
        assert_install_admin<T0>(arg0, arg1, arg4, arg5);
        assert_current_package<T0>(arg0);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        let v1 = 0x1::type_name::with_original_ids<T2>();
        let v2 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
                    if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                        let v3 = 0x1::type_name::datatype_string(&v0);
                        *0x1::ascii::as_bytes(&v3) == b"SoulProducer"
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
        assert!(v2, 1);
        let v4 = SourceRegistryKey<T2>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<SourceRegistryKey<T2>>(&arg0.id, v4), 1);
        let v5 = 0x2::object::id<T2>(arg3);
        let v6 = SourceRegistryLocation{id: v5};
        0x2::dynamic_field::add<SourceRegistryKey<T2>, SourceRegistryLocation>(&mut arg0.id, v4, v6);
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
        v5
    }

    public fun register_source_revision<T0, T1: drop, T2: drop, T3: key>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: T1, arg3: T2, arg4: &T3, arg5: &0x2::package::Publisher, arg6: &0x2::package::UpgradeCap, arg7: u64, arg8: vector<u8>) {
        assert_install_admin<T0>(arg0, arg1, arg7, arg8);
        assert_current_package<T0>(arg0);
        assert!(0x2::object::id<T3>(arg4) == source_registry_id<T0, T3>(arg0), 1);
        let v0 = 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::advance<T1, T2, T3>(source_revision<T0, T3>(arg0), arg2, arg3, arg5, arg6);
        set_source_revision<T0, T3>(arg0, arg4, v0);
    }

    public fun release_catalog(arg0: &ReleaseBindingSnapshot) : 0x2::object::ID {
        arg0.catalog
    }

    public fun release_commitment(arg0: &ReleaseBindingSnapshot) : vector<u8> {
        arg0.commitment
    }

    public fun release_generation(arg0: &ReleaseBindingSnapshot) : u64 {
        arg0.generation
    }

    public fun release_history<T0, T1: store + key>(arg0: &Config<T0>, arg1: u64) : &T1 {
        let v0 = ReleaseHistoryKey{generation: arg1};
        0x2::dynamic_object_field::borrow<ReleaseHistoryKey, T1>(&arg0.id, v0)
    }

    public fun release_object<T0, T1: store + key>(arg0: &Config<T0>) : &T1 {
        let v0 = ReleaseBindingKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<ReleaseBindingKey, T1>(&arg0.id, v0)
    }

    public fun release_snapshot<T0>(arg0: &Config<T0>) : 0x1::option::Option<ReleaseBindingSnapshot> {
        arg0.release_binding
    }

    public fun revision<T0>(arg0: &Config<T0>) : u64 {
        arg0.revision
    }

    fun right_fee(arg0: u64, arg1: u16) : u64 {
        ((((arg0 as u128) * (arg1 as u128) + 9999) / 10000) as u64)
    }

    public fun right_sale<T0, T1: drop, T2: drop>(arg0: &mut Config<T0>, arg1: T1, arg2: T2, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: address, arg6: 0x2::object::ID, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_business<T0, T1, T2>(arg0, 4, arg1, arg2);
        assert!(arg5 != @0x0 && 0x2::coin::value<T0>(&arg3) == right_total<T0>(arg0, arg4), 2);
        let v0 = right_fee(arg4, arg0.secondary_bps);
        if (v0 > 0) {
            deposit_income<T0>(arg0, 0x2::coin::split<T0>(&mut arg3, v0, arg8));
        };
        let v1 = Paid{
            subject     : arg6,
            attempt     : arg7,
            payer       : 0x2::tx_context::sender(arg8),
            gross       : arg4 + v0,
            fee         : v0,
            beneficiary : arg5,
        };
        0x2::event::emit<Paid>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, arg5);
    }

    public fun right_total<T0>(arg0: &Config<T0>, arg1: u64) : u64 {
        let v0 = (arg1 as u128) + (right_fee(arg1, arg0.secondary_bps) as u128);
        assert!(v0 <= 18446744073709551615, 1);
        (v0 as u64)
    }

    public fun role<T0>(arg0: &Config<T0>, arg1: u8) : 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::Role {
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::package_roles::role(&arg0.roles, arg1)
    }

    public fun route_primary(arg0: PrimaryReceipt, arg1: 0x2::object::ID) : PrimaryReceipt {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.revenue), 1);
        arg0.revenue = 0x1::option::some<0x2::object::ID>(arg1);
        arg0
    }

    public fun secondary_bps<T0>(arg0: &Config<T0>) : u16 {
        arg0.secondary_bps
    }

    public fun secondary_enabled<T0>(arg0: &Config<T0>) : bool {
        let v0 = MarketGatesKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v0)) {
            let v2 = MarketGatesKey{dummy_field: false};
            0x2::dynamic_field::borrow<MarketGatesKey, MarketGates>(&arg0.id, v2).secondary
        } else {
            false
        }
    }

    public fun set_enabled<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        let v0 = if (arg0.revision == arg2) {
            if (arg0.commitment == arg3) {
                arg0.enabled != arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        if (arg4) {
            assert_current_package<T0>(arg0);
            assert_native_current<T0>(arg0);
            assert!(!arg0.paused, 1);
        };
        arg0.enabled = arg4;
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    fun set_gate<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: bool, arg5: bool) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        assert_current_package<T0>(arg0);
        let v0 = if (arg0.revision == arg2) {
            if (arg0.commitment == arg3) {
                let v1 = MarketGatesKey{dummy_field: false};
                0x2::dynamic_field::exists_<MarketGatesKey>(&arg0.id, v1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v2 = MarketGatesKey{dummy_field: false};
        if (arg4) {
            0x2::dynamic_field::borrow_mut<MarketGatesKey, MarketGates>(&mut arg0.id, v2).primary = arg5;
        } else {
            0x2::dynamic_field::borrow_mut<MarketGatesKey, MarketGates>(&mut arg0.id, v2).secondary = arg5;
        };
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
    }

    public fun set_primary_enabled<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: bool) {
        set_gate<T0>(arg0, arg1, arg2, arg3, true, arg4);
    }

    public fun set_secondary_enabled<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: vector<u8>, arg4: bool) {
        set_gate<T0>(arg0, arg1, arg2, arg3, false, arg4);
    }

    fun set_source_revision<T0, T1: key>(arg0: &mut Config<T0>, arg1: &T1, arg2: 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision) {
        let v0 = SourceRevisionKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SourceRevisionKey<T1>, 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow_mut<SourceRevisionKey<T1>, 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&mut arg0.id, v0) = arg2;
        } else {
            0x2::dynamic_field::add<SourceRevisionKey<T1>, 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&mut arg0.id, v0, arg2);
        };
        arg0.revision = arg0.revision + 1;
        refresh_commitment<T0>(arg0);
        let v1 = SourceRevisionChanged{
            config     : 0x2::object::id<Config<T0>>(arg0),
            registry   : 0x2::object::id<T1>(arg1),
            revision   : arg0.revision,
            source     : arg2,
            commitment : arg0.commitment,
        };
        0x2::event::emit<SourceRevisionChanged>(v1);
    }

    public(friend) fun share_config<T0>(arg0: Config<T0>, arg1: Admin, arg2: &0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_admin<T0>(&arg0, &arg1);
        0x2::transfer::public_transfer<Admin>(arg1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Config<T0>>(arg0);
        0x2::object::id<Config<T0>>(&arg0)
    }

    public fun snapshot<T0>(arg0: &Config<T0>) : ConfigSnapshot {
        ConfigSnapshot{
            domain           : b"soulidity-protocol-config-v3",
            schema           : arg0.schema,
            config           : 0x2::object::id<Config<T0>>(arg0),
            revision         : arg0.revision,
            enabled          : arg0.enabled,
            paused           : arg0.paused,
            payment_coin     : arg0.payment_coin,
            original_package : arg0.original_package,
            callable_package : arg0.callable_package,
            income_root      : 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::root<T0>(&arg0.income),
            primary_bps      : arg0.primary_bps,
            secondary_bps    : arg0.secondary_bps,
            complete_fee     : arg0.complete_fee,
            recipient        : arg0.recipient,
            native_binding   : arg0.native_binding,
            release_binding  : arg0.release_binding,
            minimum_release  : arg0.minimum_release,
            roles            : arg0.roles,
        }
    }

    public fun snapshot_hash(arg0: &ConfigSnapshot) : vector<u8> {
        0x1::hash::sha2_256(0x1::bcs::to_bytes<ConfigSnapshot>(arg0))
    }

    public fun source_registry_id<T0, T1: key>(arg0: &Config<T0>) : 0x2::object::ID {
        let v0 = SourceRegistryKey<T1>{dummy_field: false};
        0x2::dynamic_field::borrow<SourceRegistryKey<T1>, SourceRegistryLocation>(&arg0.id, v0).id
    }

    public fun source_revision<T0, T1: key>(arg0: &Config<T0>) : 0x1::option::Option<0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision> {
        let v0 = SourceRevisionKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<SourceRevisionKey<T1>, 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&arg0.id, v0)) {
            0x1::option::some<0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(*0x2::dynamic_field::borrow<SourceRevisionKey<T1>, 0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>(&arg0.id, v0))
        } else {
            0x1::option::none<0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::source_authority::Revision>()
        }
    }

    public fun strict_share(arg0: u64, arg1: u16) : u64 {
        assert!(arg1 <= 10000, 1);
        let v0 = fee(arg0, arg1);
        assert!(arg1 == 0 || v0 > 0, 4);
        v0
    }

    public fun withdraw_income<T0>(arg0: &mut Config<T0>, arg1: &mut Admin, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        assert_recovery_identity<T0>(arg0);
        0xafa5264fb5176a1179acfe3e91f2dad2fd2aa139936d43ab541761c522509c2c::revenue::withdraw<T0>(&arg0.id, &mut arg0.income, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v7
}

