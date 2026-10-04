module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        current: u64,
    }

    struct GenerationKey has copy, drop, store {
        version: u64,
    }

    struct MigrationAuditV1 has store {
        source_generation: u64,
        expected_custody: vector<0x1::type_name::TypeName>,
        verified_custody: vector<0x1::type_name::TypeName>,
        expected_reserve: vector<0x1::type_name::TypeName>,
        verified_reserve: vector<0x1::type_name::TypeName>,
    }

    struct StateV1 has store {
        status: u8,
        custody: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody,
        reserve: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::Reserve,
        treasury: 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>,
        accounting: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting,
        prices: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices,
        composition: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition,
        policy: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy,
        authorities: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::Authorities,
        rebalance: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::RebalanceState,
        emergency: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::EmergencyState,
        migration_audit: vector<MigrationAuditV1>,
    }

    struct MigrationAuditV2 has store {
        source_generation: u64,
        expected_custody: vector<0x1::type_name::TypeName>,
        verified_custody: vector<0x1::type_name::TypeName>,
        expected_reserve: vector<0x1::type_name::TypeName>,
        verified_reserve: vector<0x1::type_name::TypeName>,
    }

    struct StateV2 has store {
        status: u8,
        custody: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody,
        reserve: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::Reserve,
        treasury: 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>,
        accounting: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting,
        prices: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices,
        composition: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition,
        policy: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy,
        authorities: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::Authorities,
        rebalance: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::RebalanceState,
        emergency: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::EmergencyState,
        migration_audit: vector<MigrationAuditV2>,
        schema_generation: u64,
    }

    public(friend) fun accounting(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting {
        &arg0.accounting
    }

    public(friend) fun authorities(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::Authorities {
        &arg0.authorities
    }

    public(friend) fun composition(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition {
        &arg0.composition
    }

    public(friend) fun custody(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody {
        &arg0.custody
    }

    public(friend) fun policy(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy {
        &arg0.policy
    }

    public(friend) fun prices(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices {
        &arg0.prices
    }

    public(friend) fun accounting_and_treasury(arg0: &StateV2) : (&0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting, &0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>) {
        (&arg0.accounting, &arg0.treasury)
    }

    public(friend) fun accounting_and_treasury_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting, &mut 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>) {
        (&mut arg0.accounting, &mut arg0.treasury)
    }

    public(friend) fun accounting_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::Accounting {
        &mut arg0.accounting
    }

    public fun assert_emergency_cap(arg0: &Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::EmergencyUpgradeCap) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_emergency(&resolve_ro(arg0).authorities, arg1);
    }

    public fun assert_governance_cap(arg0: &Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(&resolve_ro(arg0).authorities, arg1);
    }

    fun audit_complete(arg0: &MigrationAuditV1) : bool {
        if (arg0.source_generation != 1) {
            return false
        };
        if (0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_custody) != 0x1::vector::length<0x1::type_name::TypeName>(&arg0.verified_custody)) {
            return false
        };
        if (0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_reserve) != 0x1::vector::length<0x1::type_name::TypeName>(&arg0.verified_reserve)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_custody)) {
            if (!contains_type(&arg0.verified_custody, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.expected_custody, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.expected_reserve)) {
            if (!contains_type(&arg0.verified_reserve, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.expected_reserve, v0))) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun authorities_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::Authorities {
        &mut arg0.authorities
    }

    public(friend) fun composition_and_policy_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.composition, &arg0.policy)
    }

    public(friend) fun composition_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition {
        &mut arg0.composition
    }

    public(friend) fun composition_mut_and_prices(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices) {
        (&mut arg0.composition, &arg0.prices)
    }

    public(friend) fun composition_policy_and_prices_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices) {
        (&mut arg0.composition, &arg0.policy, &arg0.prices)
    }

    fun contains_type(arg0: &vector<0x1::type_name::TypeName>, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun current_generation(arg0: &Registry) : u64 {
        arg0.current
    }

    public(friend) fun custody_and_policy_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.custody, &arg0.policy)
    }

    public(friend) fun custody_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody {
        &mut arg0.custody
    }

    public(friend) fun custody_prices_policy_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::Custody, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.custody, &arg0.prices, &arg0.composition, &arg0.policy)
    }

    public(friend) fun emergency(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::EmergencyState {
        &arg0.emergency
    }

    public(friend) fun emergency_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::EmergencyState {
        &mut arg0.emergency
    }

    public(friend) fun genesis(arg0: 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>, arg1: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy, arg2: 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::Authorities, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5>(&arg0) == 0, 4);
        let v0 = Registry{
            id      : 0x2::object::new(arg3),
            current : 2,
        };
        let v1 = GenerationKey{version: 2};
        let v2 = StateV2{
            status            : 3,
            custody           : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::new(arg3),
            reserve           : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::new(arg3),
            treasury          : arg0,
            accounting        : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::new(),
            prices            : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::new(arg3),
            composition       : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::new(),
            policy            : arg1,
            authorities       : arg2,
            rebalance         : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::new(arg3),
            emergency         : 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::new(arg3),
            migration_audit   : 0x1::vector::empty<MigrationAuditV2>(),
            schema_generation : 2,
        };
        0x2::dynamic_field::add<GenerationKey, StateV2>(&mut v0.id, v1, v2);
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun inner(arg0: &Registry) : &StateV2 {
        resolve_ro(arg0)
    }

    public(friend) fun inner_mut(arg0: &mut Registry) : &mut StateV2 {
        let v0 = resolve(arg0);
        assert!(v0.status == 0, 2);
        v0
    }

    public(friend) fun inner_mut_config(arg0: &mut Registry) : &mut StateV2 {
        let v0 = resolve(arg0);
        assert!(v0.status <= 3, 6);
        v0
    }

    public(friend) fun inner_mut_for_exit(arg0: &mut Registry) : &mut StateV2 {
        let v0 = resolve(arg0);
        let v1 = if (v0.status == 0) {
            true
        } else if (v0.status == 1) {
            true
        } else {
            v0.status == 2
        };
        assert!(v1, 3);
        v0
    }

    public(friend) fun inner_mut_frozen(arg0: &mut Registry) : &mut StateV2 {
        let v0 = resolve(arg0);
        assert!(v0.status == 3, 6);
        v0
    }

    public entry fun migrate_v1_to_v2(arg0: &mut Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap) {
        assert!(2 == 2, 1);
        assert!(arg0.current == 1, 1708);
        let v0 = GenerationKey{version: 2};
        assert!(!0x2::dynamic_field::exists<GenerationKey>(&arg0.id, v0), 1709);
        let v1 = GenerationKey{version: 1};
        let v2 = 0x2::dynamic_field::borrow<GenerationKey, StateV1>(&arg0.id, v1);
        assert!(v2.status == 4, 6);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_migration(&v2.authorities, arg1);
        assert!(0x1::vector::length<MigrationAuditV1>(&v2.migration_audit) == 1, 9);
        let v3 = 0x1::vector::borrow<MigrationAuditV1>(&v2.migration_audit, 0);
        assert!(audit_complete(v3), 12);
        let v4 = &v3.expected_custody;
        let v5 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::custody::discovered(&v2.custody);
        assert!(same_types(v4, &v5), 1710);
        let v6 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::denominations(&v2.reserve);
        assert!(same_types(&v3.expected_reserve, &v6), 1710);
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::has_pending(&v2.composition), 1704);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::pending_count(&v2.prices) == 0, 1705);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::pending_holder_count(&v2.policy) == 0, 1711);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::pending_rotation_count(&v2.authorities) == 0, 1714);
        assert!(!0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::in_flight(&v2.rebalance), 1706);
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::emergency_state::announced_count(&v2.emergency) == 0, 1707);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::accounting::assert_supply_matches(&v2.accounting, &v2.treasury);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::assert_migration_valid(&v2.composition, &v2.policy);
        let v7 = 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::tokens(&v2.composition);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::assert_migration_valid(&v2.prices, &v7, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::numeraire(&v2.policy));
        let v8 = GenerationKey{version: 1};
        let StateV1 {
            status          : _,
            custody         : v10,
            reserve         : v11,
            treasury        : v12,
            accounting      : v13,
            prices          : v14,
            composition     : v15,
            policy          : v16,
            authorities     : v17,
            rebalance       : v18,
            emergency       : v19,
            migration_audit : v20,
        } = 0x2::dynamic_field::remove<GenerationKey, StateV1>(&mut arg0.id, v8);
        let v21 = v20;
        let MigrationAuditV1 {
            source_generation : _,
            expected_custody  : _,
            verified_custody  : _,
            expected_reserve  : _,
            verified_reserve  : _,
        } = 0x1::vector::pop_back<MigrationAuditV1>(&mut v21);
        0x1::vector::destroy_empty<MigrationAuditV1>(v21);
        let v27 = GenerationKey{version: 2};
        let v28 = StateV2{
            status            : 3,
            custody           : v10,
            reserve           : v11,
            treasury          : v12,
            accounting        : v13,
            prices            : v14,
            composition       : v15,
            policy            : v16,
            authorities       : v17,
            rebalance         : v18,
            emergency         : v19,
            migration_audit   : 0x1::vector::empty<MigrationAuditV2>(),
            schema_generation : 2,
        };
        0x2::dynamic_field::add<GenerationKey, StateV2>(&mut arg0.id, v27, v28);
        arg0.current = 2;
    }

    public fun migration_ready_v1(arg0: &Registry) : bool {
        false
    }

    public(friend) fun policy_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy {
        &mut arg0.policy
    }

    public(friend) fun prices_and_policy_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.prices, &arg0.policy)
    }

    public(friend) fun prices_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::prices::AcceptedPrices {
        &mut arg0.prices
    }

    public(friend) fun rebalance(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::RebalanceState {
        &arg0.rebalance
    }

    public(friend) fun rebalance_and_config_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::RebalanceState, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::composition::Composition, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.rebalance, &arg0.composition, &arg0.policy)
    }

    public(friend) fun rebalance_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::rebalance_state::RebalanceState {
        &mut arg0.rebalance
    }

    public(friend) fun reserve(arg0: &StateV2) : &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::Reserve {
        &arg0.reserve
    }

    public(friend) fun reserve_and_policy_mut(arg0: &mut StateV2) : (&mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::Reserve, &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::policy::Policy) {
        (&mut arg0.reserve, &arg0.policy)
    }

    public(friend) fun reserve_mut(arg0: &mut StateV2) : &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::reserve::Reserve {
        &mut arg0.reserve
    }

    fun resolve(arg0: &mut Registry) : &mut StateV2 {
        assert!(arg0.current == 2, 1);
        let v0 = GenerationKey{version: 2};
        let v1 = 0x2::dynamic_field::borrow_mut<GenerationKey, StateV2>(&mut arg0.id, v0);
        assert!(v1.schema_generation == 2, 1712);
        v1
    }

    fun resolve_ro(arg0: &Registry) : &StateV2 {
        assert!(arg0.current == 2, 1);
        let v0 = GenerationKey{version: 2};
        let v1 = 0x2::dynamic_field::borrow<GenerationKey, StateV2>(&arg0.id, v0);
        assert!(v1.schema_generation == 2, 1712);
        v1
    }

    fun same_types(arg0: &vector<0x1::type_name::TypeName>, arg1: &vector<0x1::type_name::TypeName>) : bool {
        if (0x1::vector::length<0x1::type_name::TypeName>(arg0) != 0x1::vector::length<0x1::type_name::TypeName>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(arg0)) {
            if (*0x1::vector::borrow<0x1::type_name::TypeName>(arg0, v0) != *0x1::vector::borrow<0x1::type_name::TypeName>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public(friend) fun set_status(arg0: &mut Registry, arg1: u8) {
        let v0 = resolve(arg0);
        assert!(v0.status <= 3, 6);
        assert!(arg1 <= 3, 6);
        assert!(arg1 <= v0.status, 1713);
        v0.status = arg1;
    }

    public fun status(arg0: &Registry) : u8 {
        resolve_ro(arg0).status
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_deposits_halted() : u8 {
        1
    }

    public fun status_frozen() : u8 {
        3
    }

    public(friend) fun status_of(arg0: &StateV2) : u8 {
        arg0.status
    }

    public fun status_prepared() : u8 {
        4
    }

    public fun status_withdraw_only() : u8 {
        2
    }

    public(friend) fun tighten(arg0: &mut Registry, arg1: u8) {
        let v0 = resolve(arg0);
        assert!(v0.status <= 3, 6);
        assert!(arg1 > v0.status, 7);
        assert!(arg1 <= 3, 6);
        v0.status = arg1;
    }

    public(friend) fun treasury(arg0: &StateV2) : &0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5> {
        &arg0.treasury
    }

    public(friend) fun treasury_mut(arg0: &mut StateV2) : &mut 0x2::coin::TreasuryCap<0x70ef0dc73670dea7707f3dace42f682cbb8578d19ba2dbf1c51047fbab398e32::suix5::SUIX5> {
        &mut arg0.treasury
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

