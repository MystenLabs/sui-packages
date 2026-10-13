module 0xfa22548da71d2614a8d09bbd0c510e7f00d2524a631bb1a90817a7188613e85c::vesting {
    struct UpgradeGovernance has key {
        id: 0x2::object::UID,
        bound: bool,
        upgrade_cap_id: 0x2::object::ID,
        authorized_version: u64,
    }

    struct Project<phantom T0> has key {
        id: 0x2::object::UID,
        treasury: address,
        coin_type: 0x1::string::String,
        admin_cap_id: 0x2::object::ID,
        admin_address: address,
        version: u64,
        grant_count: u64,
        grant_ids: 0x2::table::Table<u64, 0x2::object::ID>,
        allocation_ids: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        owner: address,
    }

    struct Installment has copy, drop, store {
        unlock_at_ms: u64,
        amount: u64,
    }

    struct Grant<phantom T0> has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        allocation_id: 0x1::string::String,
        kind: u8,
        beneficiary: address,
        treasury: address,
        coin_type: 0x1::string::String,
        total: u64,
        claimed: u64,
        refunded: u64,
        schedule: vector<Installment>,
        pause_mode: u8,
        pause_started_at_ms: u64,
        vested_at_pause: u64,
        revoked: bool,
        vested_at_revoke: u64,
        claim_frozen_after_revoke: bool,
        balance: 0x2::balance::Balance<T0>,
        version: u64,
        schedule_revision: u64,
    }

    struct ProjectCreated has copy, drop {
        project_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        admin: address,
        treasury: address,
        coin_type: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct GrantCreated has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        allocation_id: 0x1::string::String,
        kind: u8,
        beneficiary: address,
        treasury: address,
        coin_type: 0x1::string::String,
        total: u64,
        schedule: vector<Installment>,
        timestamp_ms: u64,
    }

    struct Claimed has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        beneficiary: address,
        coin_type: 0x1::string::String,
        amount: u64,
        claimed: u64,
        remaining: u64,
        timestamp_ms: u64,
    }

    struct Revoked has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        beneficiary: address,
        treasury: address,
        coin_type: 0x1::string::String,
        vested_at_revoke: u64,
        refunded: u64,
        claimed: u64,
        remaining: u64,
        claim_frozen: bool,
        timestamp_ms: u64,
    }

    struct ScheduleUpdated has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        revision: u64,
        boundary_ms: u64,
        paused: bool,
        new_schedule: vector<Installment>,
        timestamp_ms: u64,
    }

    struct BeneficiaryChanged has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        old_beneficiary: address,
        new_beneficiary: address,
        timestamp_ms: u64,
    }

    struct PauseChanged has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        old_mode: u8,
        new_mode: u8,
        pause_started_at_ms: u64,
        vested_at_pause: u64,
        timestamp_ms: u64,
    }

    struct Resumed has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        pause_started_at_ms: u64,
        pause_duration_ms: u64,
        revision: u64,
        timestamp_ms: u64,
    }

    struct ClaimFreezeReleased has copy, drop {
        project_id: 0x2::object::ID,
        grant_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct AdminTransferred has copy, drop {
        project_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
        timestamp_ms: u64,
    }

    struct GovernanceBound has copy, drop {
        governance_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        version: u64,
        timestamp_ms: u64,
    }

    struct VersionActivated has copy, drop {
        governance_id: 0x2::object::ID,
        upgrade_cap_id: 0x2::object::ID,
        previous_version: u64,
        version: u64,
        timestamp_ms: u64,
    }

    struct ObjectMigrated has copy, drop {
        object_id: 0x2::object::ID,
        object_kind: u8,
        previous_version: u64,
        version: u64,
        timestamp_ms: u64,
    }

    public fun balance<T0>(arg0: &Grant<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    fun activate(arg0: &mut UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: u64, arg3: u64) {
        assert_upgrade_cap(arg0, arg1);
        assert!(arg2 > arg0.authorized_version, 27);
        arg0.authorized_version = arg2;
        let v0 = VersionActivated{
            governance_id    : 0x2::object::id<UpgradeGovernance>(arg0),
            upgrade_cap_id   : 0x2::object::id<0x2::package::UpgradeCap>(arg1),
            previous_version : arg0.authorized_version,
            version          : arg2,
            timestamp_ms     : arg3,
        };
        0x2::event::emit<VersionActivated>(v0);
    }

    public fun activate_version(arg0: &mut UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        activate(arg0, arg1, 1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun allocation_grant_id<T0>(arg0: &Project<T0>, arg1: 0x1::string::String) : 0x2::object::ID {
        *0x2::table::borrow<0x1::string::String, 0x2::object::ID>(&arg0.allocation_ids, arg1)
    }

    public fun allocation_id<T0>(arg0: &Grant<T0>) : &0x1::string::String {
        &arg0.allocation_id
    }

    fun assert_active(arg0: &UpgradeGovernance) {
        assert_active_at(arg0, 1);
    }

    fun assert_active_at(arg0: &UpgradeGovernance, arg1: u64) {
        assert!(arg0.bound, 22);
        assert!(arg0.authorized_version == arg1, 25);
    }

    fun assert_grant_active<T0>(arg0: &UpgradeGovernance, arg1: &Grant<T0>) {
        assert_active(arg0);
        assert!(arg1.version == 1, 26);
    }

    fun assert_grant_admin<T0>(arg0: &Grant<T0>, arg1: &AdminCap, arg2: address) {
        assert!(arg1.project_id == arg0.project_id && 0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 1);
        assert!(arg1.owner == arg2, 15);
    }

    public fun assert_grant_snapshot<T0>(arg0: &UpgradeGovernance, arg1: &Grant<T0>, arg2: u64, arg3: u64, arg4: u64) {
        assert_grant_active<T0>(arg0, arg1);
        let v0 = if (arg1.schedule_revision == arg2) {
            if (arg1.claimed == arg3) {
                arg1.version == arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 29);
    }

    fun assert_mode(arg0: u8) {
        assert!(arg0 == 1 || arg0 == 2, 11);
    }

    fun assert_project_active<T0>(arg0: &UpgradeGovernance, arg1: &Project<T0>) {
        assert_active(arg0);
        assert!(arg1.version == 1, 26);
    }

    fun assert_project_admin<T0>(arg0: &Project<T0>, arg1: &AdminCap, arg2: address) {
        assert!(arg1.project_id == 0x2::object::id<Project<T0>>(arg0) && 0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 1);
        assert!(arg1.owner == arg2, 15);
    }

    fun assert_upgrade_cap(arg0: &UpgradeGovernance, arg1: &0x2::package::UpgradeCap) {
        assert!(arg0.bound, 22);
        assert!(0x2::object::id<0x2::package::UpgradeCap>(arg1) == arg0.upgrade_cap_id, 24);
    }

    public fun authorized_version(arg0: &UpgradeGovernance) : u64 {
        arg0.authorized_version
    }

    public fun beneficiary<T0>(arg0: &Grant<T0>) : address {
        arg0.beneficiary
    }

    fun bind(arg0: &mut UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: 0x2::object::ID, arg3: u64) {
        assert!(!arg0.bound, 23);
        assert!(0x2::package::upgrade_package(arg1) == arg2, 24);
        arg0.bound = true;
        arg0.upgrade_cap_id = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
        arg0.authorized_version = 1;
        let v0 = GovernanceBound{
            governance_id  : 0x2::object::id<UpgradeGovernance>(arg0),
            upgrade_cap_id : 0x2::object::id<0x2::package::UpgradeCap>(arg1),
            version        : 1,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<GovernanceBound>(v0);
    }

    public fun bind_upgrade_cap(arg0: &mut UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        bind(arg0, arg1, original_package_id(), 0x2::clock::timestamp_ms(arg2));
    }

    public fun bound_upgrade_cap_id(arg0: &UpgradeGovernance) : 0x2::object::ID {
        arg0.upgrade_cap_id
    }

    fun bump_revision<T0>(arg0: &mut Grant<T0>) {
        arg0.schedule_revision = arg0.schedule_revision + 1;
    }

    public fun cap_owner(arg0: &AdminCap) : address {
        arg0.owner
    }

    public fun cap_project_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.project_id
    }

    public fun change_beneficiary<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg5));
        assert!(arg3 != @0x0, 0);
        let v0 = arg1.beneficiary;
        arg1.beneficiary = arg3;
        bump_revision<T0>(arg1);
        let v1 = BeneficiaryChanged{
            project_id      : arg1.project_id,
            grant_id        : 0x2::object::id<Grant<T0>>(arg1),
            old_beneficiary : v0,
            new_beneficiary : arg3,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<BeneficiaryChanged>(v1);
    }

    public fun claim<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == arg1.beneficiary, 7);
        pay_claim<T0>(arg1, arg2, arg3);
    }

    public fun claim_by_admin<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg4));
        pay_claim<T0>(arg1, arg3, arg4);
    }

    public fun claim_frozen<T0>(arg0: &Grant<T0>) : bool {
        arg0.pause_mode == 2 || arg0.claim_frozen_after_revoke
    }

    public fun claimable<T0>(arg0: &Grant<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (claim_frozen<T0>(arg0)) {
            0
        } else {
            vested<T0>(arg0, arg1) - arg0.claimed
        }
    }

    public fun claimed<T0>(arg0: &Grant<T0>) : u64 {
        arg0.claimed
    }

    fun coin_type<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())))
    }

    public fun create_grant<T0>(arg0: &UpgradeGovernance, arg1: &mut Project<T0>, arg2: &AdminCap, arg3: 0x2::coin::Coin<T0>, arg4: 0x1::string::String, arg5: u8, arg6: address, arg7: vector<u64>, arg8: vector<u64>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_project_active<T0>(arg0, arg1);
        assert_project_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg10));
        assert!(arg6 != @0x0, 0);
        assert!(arg5 <= 1, 2);
        assert!(0x1::string::length(&arg4) > 0 && 0x1::string::length(&arg4) <= 128, 5);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg1.allocation_ids, arg4), 6);
        let (v0, v1) = make_schedule(arg7, arg8);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 > 0 && v1 == v2, 4);
        let v3 = Grant<T0>{
            id                        : 0x2::object::new(arg10),
            project_id                : 0x2::object::id<Project<T0>>(arg1),
            admin_cap_id              : arg1.admin_cap_id,
            allocation_id             : arg4,
            kind                      : arg5,
            beneficiary               : arg6,
            treasury                  : arg1.treasury,
            coin_type                 : arg1.coin_type,
            total                     : v2,
            claimed                   : 0,
            refunded                  : 0,
            schedule                  : v0,
            pause_mode                : 0,
            pause_started_at_ms       : 0,
            vested_at_pause           : 0,
            revoked                   : false,
            vested_at_revoke          : 0,
            claim_frozen_after_revoke : false,
            balance                   : 0x2::coin::into_balance<T0>(arg3),
            version                   : 1,
            schedule_revision         : 0,
        };
        let v4 = 0x2::object::id<Grant<T0>>(&v3);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.grant_ids, arg1.grant_count, v4);
        arg1.grant_count = arg1.grant_count + 1;
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg1.allocation_ids, arg4, v4);
        let v5 = GrantCreated{
            project_id    : v3.project_id,
            grant_id      : v4,
            allocation_id : arg4,
            kind          : arg5,
            beneficiary   : arg6,
            treasury      : v3.treasury,
            coin_type     : v3.coin_type,
            total         : v2,
            schedule      : v3.schedule,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg9),
        };
        0x2::event::emit<GrantCreated>(v5);
        0x2::transfer::share_object<Grant<T0>>(v3);
    }

    public fun create_project<T0>(arg0: &UpgradeGovernance, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert!(arg1 != @0x0, 0);
        let v0 = Project<T0>{
            id             : 0x2::object::new(arg3),
            treasury       : arg1,
            coin_type      : coin_type<T0>(),
            admin_cap_id   : 0x2::object::id_from_address(@0x0),
            admin_address  : 0x2::tx_context::sender(arg3),
            version        : 1,
            grant_count    : 0,
            grant_ids      : 0x2::table::new<u64, 0x2::object::ID>(arg3),
            allocation_ids : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg3),
        };
        let v1 = AdminCap{
            id         : 0x2::object::new(arg3),
            project_id : 0x2::object::id<Project<T0>>(&v0),
            owner      : 0x2::tx_context::sender(arg3),
        };
        v0.admin_cap_id = 0x2::object::id<AdminCap>(&v1);
        let v2 = ProjectCreated{
            project_id   : 0x2::object::id<Project<T0>>(&v0),
            admin_cap_id : 0x2::object::id<AdminCap>(&v1),
            admin        : 0x2::tx_context::sender(arg3),
            treasury     : arg1,
            coin_type    : v0.coin_type,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProjectCreated>(v2);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<Project<T0>>(v0);
    }

    fun emit_pause<T0>(arg0: &Grant<T0>, arg1: u8, arg2: u64) {
        let v0 = PauseChanged{
            project_id          : arg0.project_id,
            grant_id            : 0x2::object::id<Grant<T0>>(arg0),
            old_mode            : arg1,
            new_mode            : arg0.pause_mode,
            pause_started_at_ms : arg0.pause_started_at_ms,
            vested_at_pause     : arg0.vested_at_pause,
            timestamp_ms        : arg2,
        };
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun get_grant_ids<T0>(arg0: &Project<T0>, arg1: u64, arg2: u64) : vector<0x2::object::ID> {
        assert!(arg2 <= 100, 28);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        while (arg1 < arg0.grant_count && 0x1::vector::length<0x2::object::ID>(&v0) < arg2) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.grant_ids, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun governance_bound(arg0: &UpgradeGovernance) : bool {
        arg0.bound
    }

    public fun grant_count<T0>(arg0: &Project<T0>) : u64 {
        arg0.grant_count
    }

    public fun grant_project_id<T0>(arg0: &Grant<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun grant_version<T0>(arg0: &Grant<T0>) : u64 {
        arg0.version
    }

    public fun has_allocation<T0>(arg0: &Project<T0>, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.allocation_ids, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UpgradeGovernance{
            id                 : 0x2::object::new(arg0),
            bound              : false,
            upgrade_cap_id     : 0x2::object::id_from_address(@0x0),
            authorized_version : 0,
        };
        0x2::transfer::share_object<UpgradeGovernance>(v0);
    }

    public fun installment_amount(arg0: &Installment) : u64 {
        arg0.amount
    }

    public fun installment_time(arg0: &Installment) : u64 {
        arg0.unlock_at_ms
    }

    public fun kind<T0>(arg0: &Grant<T0>) : u8 {
        arg0.kind
    }

    fun make_schedule(arg0: vector<u64>, arg1: vector<u64>) : (vector<Installment>, u64) {
        assert!(0x1::vector::length<u64>(&arg0) == 0x1::vector::length<u64>(&arg1), 3);
        assert!(0x1::vector::length<u64>(&arg0) <= 120, 16);
        let v0 = 0x1::vector::empty<Installment>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            assert!(*0x1::vector::borrow<u64>(&arg1, v2) > 0, 3);
            if (v2 > 0) {
                assert!(*0x1::vector::borrow<u64>(&arg0, v2) > *0x1::vector::borrow<u64>(&arg0, v2 - 1), 3);
            };
            let v3 = v1 + (*0x1::vector::borrow<u64>(&arg1, v2) as u128);
            v1 = v3;
            assert!(v3 <= (18446744073709551615 as u128), 17);
            let v4 = Installment{
                unlock_at_ms : *0x1::vector::borrow<u64>(&arg0, v2),
                amount       : *0x1::vector::borrow<u64>(&arg1, v2),
            };
            0x1::vector::push_back<Installment>(&mut v0, v4);
            v2 = v2 + 1;
        };
        (v0, (v1 as u64))
    }

    public fun max_installments() : u64 {
        120
    }

    public fun migrate_grant<T0>(arg0: &UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &mut Grant<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        migrate_grant_to<T0>(arg0, arg1, arg2, 1, 0x2::clock::timestamp_ms(arg3));
    }

    fun migrate_grant_to<T0>(arg0: &UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &mut Grant<T0>, arg3: u64, arg4: u64) {
        assert_upgrade_cap(arg0, arg1);
        assert_active_at(arg0, arg3);
        assert!(arg2.version < arg3, 26);
        arg2.version = arg3;
        let v0 = ObjectMigrated{
            object_id        : 0x2::object::id<Grant<T0>>(arg2),
            object_kind      : 1,
            previous_version : arg2.version,
            version          : arg3,
            timestamp_ms     : arg4,
        };
        0x2::event::emit<ObjectMigrated>(v0);
    }

    public fun migrate_project<T0>(arg0: &UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &mut Project<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        migrate_project_to<T0>(arg0, arg1, arg2, 1, 0x2::clock::timestamp_ms(arg3));
    }

    fun migrate_project_to<T0>(arg0: &UpgradeGovernance, arg1: &0x2::package::UpgradeCap, arg2: &mut Project<T0>, arg3: u64, arg4: u64) {
        assert_upgrade_cap(arg0, arg1);
        assert_active_at(arg0, arg3);
        assert!(arg2.version < arg3, 26);
        arg2.version = arg3;
        let v0 = ObjectMigrated{
            object_id        : 0x2::object::id<Project<T0>>(arg2),
            object_kind      : 0,
            previous_version : arg2.version,
            version          : arg3,
            timestamp_ms     : arg4,
        };
        0x2::event::emit<ObjectMigrated>(v0);
    }

    public fun module_version() : u64 {
        1
    }

    public fun original_package_id() : 0x2::object::ID {
        0x2::object::id_from_address(0x1::type_name::original_id<UpgradeGovernance>())
    }

    public fun pause<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg5));
        assert!(!arg1.revoked, 9);
        assert!(arg1.pause_mode == 0, 12);
        assert_mode(arg3);
        arg1.vested_at_pause = vested<T0>(arg1, arg4);
        arg1.pause_started_at_ms = 0x2::clock::timestamp_ms(arg4);
        arg1.pause_mode = arg3;
        bump_revision<T0>(arg1);
        emit_pause<T0>(arg1, 0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun pause_mode<T0>(arg0: &Grant<T0>) : u8 {
        arg0.pause_mode
    }

    public fun pause_started_at_ms<T0>(arg0: &Grant<T0>) : u64 {
        arg0.pause_started_at_ms
    }

    fun pay_claim<T0>(arg0: &mut Grant<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!claim_frozen<T0>(arg0), 10);
        let v0 = claimable<T0>(arg0, arg1);
        assert!(v0 > 0, 8);
        arg0.claimed = arg0.claimed + v0;
        let v1 = Claimed{
            project_id   : arg0.project_id,
            grant_id     : 0x2::object::id<Grant<T0>>(arg0),
            beneficiary  : arg0.beneficiary,
            coin_type    : arg0.coin_type,
            amount       : v0,
            claimed      : arg0.claimed,
            remaining    : 0x2::balance::value<T0>(&arg0.balance),
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<Claimed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, v0, arg2), arg0.beneficiary);
    }

    public fun project_admin<T0>(arg0: &Project<T0>) : address {
        arg0.admin_address
    }

    public fun project_treasury<T0>(arg0: &Project<T0>) : address {
        arg0.treasury
    }

    public fun project_version<T0>(arg0: &Project<T0>) : u64 {
        arg0.version
    }

    public fun refunded<T0>(arg0: &Grant<T0>) : u64 {
        arg0.refunded
    }

    public fun release_claim_freeze<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg4));
        assert!(arg1.revoked, 20);
        assert!(arg1.claim_frozen_after_revoke, 21);
        arg1.claim_frozen_after_revoke = false;
        bump_revision<T0>(arg1);
        let v0 = ClaimFreezeReleased{
            project_id   : arg1.project_id,
            grant_id     : 0x2::object::id<Grant<T0>>(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ClaimFreezeReleased>(v0);
    }

    public fun resume<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg4));
        assert!(!arg1.revoked, 9);
        assert!(arg1.pause_mode != 0, 13);
        let v0 = arg1.pause_started_at_ms;
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0, 19);
        let v2 = v1 - v0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Installment>(&arg1.schedule)) {
            let v4 = 0x1::vector::borrow_mut<Installment>(&mut arg1.schedule, v3);
            if (v4.unlock_at_ms > v0) {
                assert!(v4.unlock_at_ms <= 18446744073709551615 - v2, 18);
                v4.unlock_at_ms = v4.unlock_at_ms + v2;
            };
            v3 = v3 + 1;
        };
        arg1.pause_mode = 0;
        arg1.pause_started_at_ms = 0;
        arg1.vested_at_pause = 0;
        bump_revision<T0>(arg1);
        let v5 = Resumed{
            project_id          : arg1.project_id,
            grant_id            : 0x2::object::id<Grant<T0>>(arg1),
            pause_started_at_ms : v0,
            pause_duration_ms   : v2,
            revision            : arg1.schedule_revision,
            timestamp_ms        : v1,
        };
        0x2::event::emit<Resumed>(v5);
    }

    public fun revoke<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg4));
        assert!(!arg1.revoked, 9);
        let v0 = vested<T0>(arg1, arg3);
        let v1 = arg1.total - v0;
        arg1.claim_frozen_after_revoke = arg1.pause_mode == 2;
        arg1.revoked = true;
        arg1.vested_at_revoke = v0;
        arg1.refunded = v1;
        arg1.pause_mode = 0;
        arg1.pause_started_at_ms = 0;
        arg1.vested_at_pause = 0;
        bump_revision<T0>(arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, v1, arg4), arg1.treasury);
        };
        let v2 = Revoked{
            project_id       : arg1.project_id,
            grant_id         : 0x2::object::id<Grant<T0>>(arg1),
            beneficiary      : arg1.beneficiary,
            treasury         : arg1.treasury,
            coin_type        : arg1.coin_type,
            vested_at_revoke : v0,
            refunded         : v1,
            claimed          : arg1.claimed,
            remaining        : 0x2::balance::value<T0>(&arg1.balance),
            claim_frozen     : arg1.claim_frozen_after_revoke,
            timestamp_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<Revoked>(v2);
    }

    public fun revoked<T0>(arg0: &Grant<T0>) : bool {
        arg0.revoked
    }

    public fun schedule<T0>(arg0: &Grant<T0>) : &vector<Installment> {
        &arg0.schedule
    }

    public fun schedule_revision<T0>(arg0: &Grant<T0>) : u64 {
        arg0.schedule_revision
    }

    fun schedule_vested(arg0: &vector<Installment>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Installment>(arg0)) {
            let v2 = 0x1::vector::borrow<Installment>(arg0, v1);
            if (v2.unlock_at_ms > arg1) {
                break
            };
            v0 = v0 + v2.amount;
            v1 = v1 + 1;
        };
        v0
    }

    public fun set_pause_mode<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg5));
        assert!(!arg1.revoked, 9);
        assert!(arg1.pause_mode != 0, 13);
        assert_mode(arg3);
        let v0 = arg1.pause_mode;
        arg1.pause_mode = arg3;
        bump_revision<T0>(arg1);
        emit_pause<T0>(arg1, v0, 0x2::clock::timestamp_ms(arg4));
    }

    public fun total<T0>(arg0: &Grant<T0>) : u64 {
        arg0.total
    }

    public fun transfer_admin<T0>(arg0: &UpgradeGovernance, arg1: &mut Project<T0>, arg2: AdminCap, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_project_active<T0>(arg0, arg1);
        assert_project_admin<T0>(arg1, &arg2, 0x2::tx_context::sender(arg5));
        assert!(arg3 != @0x0, 0);
        arg2.owner = arg3;
        arg1.admin_address = arg3;
        let v0 = AdminTransferred{
            project_id   : 0x2::object::id<Project<T0>>(arg1),
            admin_cap_id : 0x2::object::id<AdminCap>(&arg2),
            old_admin    : arg2.owner,
            new_admin    : arg3,
            timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<AdminTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg2, arg3);
    }

    public fun treasury<T0>(arg0: &Grant<T0>) : address {
        arg0.treasury
    }

    public fun update_schedule<T0>(arg0: &UpgradeGovernance, arg1: &mut Grant<T0>, arg2: &AdminCap, arg3: vector<u64>, arg4: vector<u64>, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_grant_active<T0>(arg0, arg1);
        assert_grant_admin<T0>(arg1, arg2, 0x2::tx_context::sender(arg7));
        assert!(!arg1.revoked, 9);
        assert!(arg1.schedule_revision == arg5, 14);
        let v0 = arg1.pause_mode != 0;
        let v1 = if (v0) {
            arg1.pause_started_at_ms
        } else {
            0x2::clock::timestamp_ms(arg6)
        };
        let (v2, v3) = make_schedule(arg3, arg4);
        let v4 = v2;
        assert!(v3 == arg1.total - vested<T0>(arg1, arg6), 4);
        let v5 = 0x1::vector::empty<Installment>();
        let v6 = 0;
        while (v6 < 0x1::vector::length<Installment>(&arg1.schedule)) {
            let v7 = *0x1::vector::borrow<Installment>(&arg1.schedule, v6);
            if (v7.unlock_at_ms <= v1) {
                0x1::vector::push_back<Installment>(&mut v5, v7);
            };
            v6 = v6 + 1;
        };
        v6 = 0;
        while (v6 < 0x1::vector::length<Installment>(&v4)) {
            assert!(0x1::vector::borrow<Installment>(&v4, v6).unlock_at_ms > v1, 3);
            0x1::vector::push_back<Installment>(&mut v5, *0x1::vector::borrow<Installment>(&v4, v6));
            v6 = v6 + 1;
        };
        assert!(0x1::vector::length<Installment>(&v5) <= 120, 16);
        arg1.schedule = v5;
        bump_revision<T0>(arg1);
        let v8 = ScheduleUpdated{
            project_id   : arg1.project_id,
            grant_id     : 0x2::object::id<Grant<T0>>(arg1),
            revision     : arg1.schedule_revision,
            boundary_ms  : v1,
            paused       : v0,
            new_schedule : arg1.schedule,
            timestamp_ms : 0x2::clock::timestamp_ms(arg6),
        };
        0x2::event::emit<ScheduleUpdated>(v8);
    }

    public fun vested<T0>(arg0: &Grant<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (arg0.revoked) {
            arg0.vested_at_revoke
        } else if (arg0.pause_mode != 0) {
            arg0.vested_at_pause
        } else {
            schedule_vested(&arg0.schedule, 0x2::clock::timestamp_ms(arg1))
        }
    }

    public fun vested_at_pause<T0>(arg0: &Grant<T0>) : u64 {
        arg0.vested_at_pause
    }

    public fun vested_at_revoke<T0>(arg0: &Grant<T0>) : u64 {
        arg0.vested_at_revoke
    }

    // decompiled from Move bytecode v7
}

