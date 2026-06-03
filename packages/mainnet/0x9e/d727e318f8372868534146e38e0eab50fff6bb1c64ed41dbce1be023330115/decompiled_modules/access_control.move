module 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::access_control {
    struct Auth<phantom T0> has drop {
        addr: address,
    }

    struct AccessControl<phantom T0> has store, key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<0x1::type_name::TypeName, RoleData>,
        protected_root: 0x1::type_name::TypeName,
        default_admin: 0x1::option::Option<address>,
        pending_default_admin: 0x1::option::Option<PendingAdminTransfer>,
        pending_default_admin_delay_change: 0x1::option::Option<PendingDelayChange>,
        default_admin_delay_ms: u64,
    }

    struct RoleData has store {
        members: 0x2::vec_set::VecSet<address>,
        admin_role: 0x1::type_name::TypeName,
    }

    struct PendingAdminTransfer has drop, store {
        new_admin: 0x1::option::Option<address>,
        execute_after_ms: u64,
    }

    struct PendingDelayChange has drop, store {
        new_delay_ms: u64,
        schedule_after_ms: u64,
    }

    struct RoleGranted<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        account: address,
    }

    struct RoleRevoked<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        account: address,
    }

    struct RoleAdminChanged<phantom T0> has copy, drop {
        role: 0x1::type_name::TypeName,
        previous_admin_role: 0x1::type_name::TypeName,
        new_admin_role: 0x1::type_name::TypeName,
    }

    struct DefaultAdminTransferScheduled<phantom T0> has copy, drop {
        new_admin: address,
        execute_after_ms: u64,
    }

    struct DefaultAdminRenounceScheduled<phantom T0> has copy, drop {
        execute_after_ms: u64,
    }

    struct DefaultAdminTransferCancelled<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct DefaultAdminRenounceCancelled<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    struct DefaultAdminDelayChangeScheduled<phantom T0> has copy, drop {
        new_delay_ms: u64,
        schedule_after_ms: u64,
    }

    struct DefaultAdminDelayChangeCancelled<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public fun new<T0: drop>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AccessControl<T0> {
        let v0 = 0x2::tx_context::sender(arg2);
        new_with_admin<T0>(arg0, v0, arg1, arg2)
    }

    public fun accept_default_admin_renounce<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_default_admin), 13835624131972038661);
        let v0 = 0x1::option::borrow<PendingAdminTransfer>(&arg0.pending_default_admin);
        assert!(0x1::option::is_none<address>(&v0.new_admin), 13837594473989799955);
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg2)), 13835061212083126273);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.execute_after_ms, 13836187116285460489);
        0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_default_admin);
        arg0.default_admin = 0x1::option::none<address>();
        let v1 = RoleRevoked<T0>{
            role    : arg0.protected_root,
            account : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RoleRevoked<T0>>(v1);
    }

    public fun accept_default_admin_transfer<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_default_admin), 13835623784079687685);
        let v0 = 0x1::option::borrow<PendingAdminTransfer>(&arg0.pending_default_admin);
        assert!(0x1::option::is_some<address>(&v0.new_admin), 13837312659710541841);
        let v1 = *0x1::option::borrow<address>(&v0.new_admin);
        assert!(v1 == 0x2::tx_context::sender(arg2), 13835905297711235079);
        assert!(0x2::clock::timestamp_ms(arg1) >= v0.execute_after_ms, 13836186776983044105);
        0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_default_admin);
        let v2 = arg0.protected_root;
        let v3 = RoleRevoked<T0>{
            role    : v2,
            account : *0x1::option::borrow<address>(&arg0.default_admin),
        };
        0x2::event::emit<RoleRevoked<T0>>(v3);
        arg0.default_admin = 0x1::option::some<address>(v1);
        let v4 = RoleGranted<T0>{
            role    : v2,
            account : v1,
        };
        0x2::event::emit<RoleGranted<T0>>(v4);
    }

    public fun assert_has_role<T0, T1>(arg0: &AccessControl<T0>, arg1: address) {
        assert!(has_role<T0, T1>(arg0, arg1), 13835059906413068289);
    }

    fun assert_home_module<T0, T1>() {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1) && 0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1), 13837033246318002191);
    }

    public fun auth_addr<T0>(arg0: &Auth<T0>) : address {
        arg0.addr
    }

    public fun begin_default_admin_delay_change<T0>(arg0: &mut AccessControl<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg3)), 13835061517025804289);
        assert!(arg1 <= 5184000000, 13836468896204980235);
        refresh_default_admin_delay<T0>(arg0, arg2);
        let v0 = arg0.default_admin_delay_ms;
        let v1 = if (arg1 > v0) {
            0x1::u64::min(arg1, 172800000)
        } else {
            v0 - arg1
        };
        let v2 = 0x2::clock::timestamp_ms(arg2) + v1;
        if (0x1::option::is_some<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            let v3 = DefaultAdminDelayChangeCancelled<T0>{dummy_field: false};
            0x2::event::emit<DefaultAdminDelayChangeCancelled<T0>>(v3);
        };
        let v4 = PendingDelayChange{
            new_delay_ms      : arg1,
            schedule_after_ms : v2,
        };
        arg0.pending_default_admin_delay_change = 0x1::option::some<PendingDelayChange>(v4);
        let v5 = DefaultAdminDelayChangeScheduled<T0>{
            new_delay_ms      : arg1,
            schedule_after_ms : v2,
        };
        0x2::event::emit<DefaultAdminDelayChangeScheduled<T0>>(v5);
    }

    public fun begin_default_admin_renounce<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg2)), 13835061040284434433);
        refresh_default_admin_delay<T0>(arg0, arg1);
        let v0 = 0x2::clock::timestamp_ms(arg1) + arg0.default_admin_delay_ms;
        cancel_pending_default_admin<T0>(arg0);
        let v1 = PendingAdminTransfer{
            new_admin        : 0x1::option::none<address>(),
            execute_after_ms : v0,
        };
        arg0.pending_default_admin = 0x1::option::some<PendingAdminTransfer>(v1);
        let v2 = DefaultAdminRenounceScheduled<T0>{execute_after_ms: v0};
        0x2::event::emit<DefaultAdminRenounceScheduled<T0>>(v2);
    }

    public fun begin_default_admin_transfer<T0>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg3)), 13835060683802148865);
        assert!(arg1 != @0x0, 13838156912842375191);
        assert!(arg1 != 0x2::tx_context::sender(arg3), 13838438392114184217);
        refresh_default_admin_delay<T0>(arg0, arg2);
        let v0 = 0x2::clock::timestamp_ms(arg2) + arg0.default_admin_delay_ms;
        cancel_pending_default_admin<T0>(arg0);
        let v1 = PendingAdminTransfer{
            new_admin        : 0x1::option::some<address>(arg1),
            execute_after_ms : v0,
        };
        arg0.pending_default_admin = 0x1::option::some<PendingAdminTransfer>(v1);
        let v2 = DefaultAdminTransferScheduled<T0>{
            new_admin        : arg1,
            execute_after_ms : v0,
        };
        0x2::event::emit<DefaultAdminTransferScheduled<T0>>(v2);
    }

    public fun cancel_default_admin_delay_change<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_active_pending_default_admin_delay_change<T0>(arg0, arg1), 13837876447182848021);
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg2)), 13835061701709398017);
        0x1::option::extract<PendingDelayChange>(&mut arg0.pending_default_admin_delay_change);
        let v0 = DefaultAdminDelayChangeCancelled<T0>{dummy_field: false};
        0x2::event::emit<DefaultAdminDelayChangeCancelled<T0>>(v0);
    }

    public fun cancel_default_admin_transfer<T0>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_default_admin), 13835624278000926725);
        assert!(has_role_by_name<T0>(arg0, arg0.protected_root, 0x2::tx_context::sender(arg1)), 13835061332342210561);
        cancel_pending_default_admin<T0>(arg0);
    }

    fun cancel_pending_default_admin<T0>(arg0: &mut AccessControl<T0>) {
        if (0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_default_admin)) {
            return
        };
        let v0 = 0x1::option::extract<PendingAdminTransfer>(&mut arg0.pending_default_admin);
        if (0x1::option::is_some<address>(&v0.new_admin)) {
            let v1 = DefaultAdminTransferCancelled<T0>{dummy_field: false};
            0x2::event::emit<DefaultAdminTransferCancelled<T0>>(v1);
        } else {
            let v2 = DefaultAdminRenounceCancelled<T0>{dummy_field: false};
            0x2::event::emit<DefaultAdminRenounceCancelled<T0>>(v2);
        };
    }

    public fun default_admin<T0>(arg0: &AccessControl<T0>) : 0x1::option::Option<address> {
        arg0.default_admin
    }

    public fun default_admin_delay_ms<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : u64 {
        effective_default_admin_delay_ms<T0>(arg0, arg1)
    }

    fun effective_default_admin_delay_ms<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : u64 {
        if (0x1::option::is_some<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            let v0 = 0x1::option::borrow<PendingDelayChange>(&arg0.pending_default_admin_delay_change);
            if (0x2::clock::timestamp_ms(arg1) >= v0.schedule_after_ms) {
                return v0.new_delay_ms
            };
        };
        arg0.default_admin_delay_ms
    }

    public fun get_role_admin<T0, T1>(arg0: &AccessControl<T0>) : 0x1::type_name::TypeName {
        assert_home_module<T0, T1>();
        get_role_admin_name<T0>(arg0, 0x1::type_name::with_original_ids<T1>())
    }

    fun get_role_admin_name<T0>(arg0: &AccessControl<T0>, arg1: 0x1::type_name::TypeName) : 0x1::type_name::TypeName {
        if (!0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, arg1)) {
            return arg0.protected_root
        };
        0x2::table::borrow<0x1::type_name::TypeName, RoleData>(&arg0.roles, arg1).admin_role
    }

    public fun grant_role<T0, T1>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_home_module<T0, T1>();
        assert!(arg1 != @0x0, 13838156242827477015);
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(v0 != arg0.protected_root, 13835341501648994307);
        assert!(has_role_by_name<T0>(arg0, get_role_admin_name<T0>(arg0, v0), 0x2::tx_context::sender(arg2)), 13835060030967119873);
        if (!0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, v0)) {
            let v1 = RoleData{
                members    : 0x2::vec_set::empty<address>(),
                admin_role : arg0.protected_root,
            };
            0x2::table::add<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v0);
        if (0x2::vec_set::contains<address>(&v2.members, &arg1)) {
            return
        };
        0x2::vec_set::insert<address>(&mut v2.members, arg1);
        let v3 = RoleGranted<T0>{
            role    : v0,
            account : arg1,
        };
        0x2::event::emit<RoleGranted<T0>>(v3);
    }

    fun has_active_pending_default_admin_delay_change<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            return false
        };
        0x2::clock::timestamp_ms(arg1) < 0x1::option::borrow<PendingDelayChange>(&arg0.pending_default_admin_delay_change).schedule_after_ms
    }

    public fun has_pending_default_admin_delay_change<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : bool {
        has_active_pending_default_admin_delay_change<T0>(arg0, arg1)
    }

    public fun has_pending_default_admin_transfer<T0>(arg0: &AccessControl<T0>) : bool {
        0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_default_admin)
    }

    public fun has_role<T0, T1>(arg0: &AccessControl<T0>, arg1: address) : bool {
        has_role_by_name<T0>(arg0, 0x1::type_name::with_original_ids<T1>(), arg1)
    }

    fun has_role_by_name<T0>(arg0: &AccessControl<T0>, arg1: 0x1::type_name::TypeName, arg2: address) : bool {
        if (arg1 == arg0.protected_root) {
            return arg0.default_admin == 0x1::option::some<address>(arg2)
        };
        if (!0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, arg1)) {
            return false
        };
        0x2::vec_set::contains<address>(&0x2::table::borrow<0x1::type_name::TypeName, RoleData>(&arg0.roles, arg1).members, &arg2)
    }

    public fun is_pending_default_admin_renounce<T0>(arg0: &AccessControl<T0>) : bool {
        if (0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_default_admin)) {
            return false
        };
        0x1::option::is_none<address>(&0x1::option::borrow<PendingAdminTransfer>(&arg0.pending_default_admin).new_admin)
    }

    public fun max_default_admin_delay_ms() : u64 {
        5184000000
    }

    public fun max_delay_increase_wait_ms() : u64 {
        172800000
    }

    public fun new_auth<T0, T1>(arg0: &AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) : Auth<T1> {
        assert_home_module<T0, T1>();
        assert_has_role<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        Auth<T1>{addr: 0x2::tx_context::sender(arg1)}
    }

    public fun new_with_admin<T0: drop>(arg0: T0, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AccessControl<T0> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 13836748468511309837);
        assert!(arg2 <= 5184000000, 13836466997829435403);
        assert!(arg1 != @0x0, 13838155851985453079);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = AccessControl<T0>{
            id                                 : 0x2::object::new(arg3),
            roles                              : 0x2::table::new<0x1::type_name::TypeName, RoleData>(arg3),
            protected_root                     : v0,
            default_admin                      : 0x1::option::some<address>(arg1),
            pending_default_admin              : 0x1::option::none<PendingAdminTransfer>(),
            pending_default_admin_delay_change : 0x1::option::none<PendingDelayChange>(),
            default_admin_delay_ms             : arg2,
        };
        let v2 = RoleGranted<T0>{
            role    : v0,
            account : arg1,
        };
        0x2::event::emit<RoleGranted<T0>>(v2);
        v1
    }

    public fun pending_default_admin_delay_change_new_delay_ms<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0x1::option::borrow<PendingDelayChange>(&arg0.pending_default_admin_delay_change);
        if (0x2::clock::timestamp_ms(arg1) >= v0.schedule_after_ms) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v0.new_delay_ms)
    }

    public fun pending_default_admin_delay_change_schedule_after_ms<T0>(arg0: &AccessControl<T0>, arg1: &0x2::clock::Clock) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            return 0x1::option::none<u64>()
        };
        let v0 = 0x1::option::borrow<PendingDelayChange>(&arg0.pending_default_admin_delay_change);
        if (0x2::clock::timestamp_ms(arg1) >= v0.schedule_after_ms) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(v0.schedule_after_ms)
    }

    public fun pending_default_admin_execute_after_ms<T0>(arg0: &AccessControl<T0>) : 0x1::option::Option<u64> {
        if (0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_default_admin)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(0x1::option::borrow<PendingAdminTransfer>(&arg0.pending_default_admin).execute_after_ms)
    }

    public fun pending_default_admin_new_admin<T0>(arg0: &AccessControl<T0>) : 0x1::option::Option<address> {
        if (0x1::option::is_none<PendingAdminTransfer>(&arg0.pending_default_admin)) {
            return 0x1::option::none<address>()
        };
        let v0 = 0x1::option::borrow<PendingAdminTransfer>(&arg0.pending_default_admin);
        if (0x1::option::is_none<address>(&v0.new_admin)) {
            return 0x1::option::none<address>()
        };
        0x1::option::some<address>(*0x1::option::borrow<address>(&v0.new_admin))
    }

    public fun protected_root<T0>(arg0: &AccessControl<T0>) : 0x1::type_name::TypeName {
        arg0.protected_root
    }

    fun refresh_default_admin_delay<T0>(arg0: &mut AccessControl<T0>, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<PendingDelayChange>(&arg0.pending_default_admin_delay_change)) {
            return false
        };
        let v0 = 0x1::option::borrow<PendingDelayChange>(&arg0.pending_default_admin_delay_change);
        if (0x2::clock::timestamp_ms(arg1) < v0.schedule_after_ms) {
            return false
        };
        0x1::option::extract<PendingDelayChange>(&mut arg0.pending_default_admin_delay_change);
        arg0.default_admin_delay_ms = v0.new_delay_ms;
        true
    }

    public fun renounce_role<T0, T1>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_home_module<T0, T1>();
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_original_ids<T1>();
        assert!(v1 != arg0.protected_root, 13835341802296705027);
        if (!0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, v1)) {
            return
        };
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v1);
        if (!0x2::vec_set::contains<address>(&v2.members, &v0)) {
            return
        };
        0x2::vec_set::remove<address>(&mut v2.members, &v0);
        let v3 = RoleRevoked<T0>{
            role    : v1,
            account : v0,
        };
        0x2::event::emit<RoleRevoked<T0>>(v3);
    }

    public fun revoke_role<T0, T1>(arg0: &mut AccessControl<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_home_module<T0, T1>();
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(v0 != arg0.protected_root, 13835341669152718851);
        assert!(has_role_by_name<T0>(arg0, get_role_admin_name<T0>(arg0, v0), 0x2::tx_context::sender(arg2)), 13835060198470844417);
        if (!0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, v0)) {
            return
        };
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v0);
        if (!0x2::vec_set::contains<address>(&v1.members, &arg1)) {
            return
        };
        0x2::vec_set::remove<address>(&mut v1.members, &arg1);
        let v2 = RoleRevoked<T0>{
            role    : v0,
            account : arg1,
        };
        0x2::event::emit<RoleRevoked<T0>>(v2);
    }

    public fun set_role_admin<T0, T1, T2>(arg0: &mut AccessControl<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_home_module<T0, T1>();
        assert_home_module<T0, T2>();
        let v0 = 0x1::type_name::with_original_ids<T1>();
        assert!(v0 != arg0.protected_root, 13835341939735658499);
        let v1 = get_role_admin_name<T0>(arg0, v0);
        assert!(has_role_by_name<T0>(arg0, v1, 0x2::tx_context::sender(arg1)), 13835060477643718657);
        let v2 = 0x1::type_name::with_original_ids<T2>();
        if (0x2::table::contains<0x1::type_name::TypeName, RoleData>(&arg0.roles, v0)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v0).admin_role = v2;
        } else {
            let v3 = RoleData{
                members    : 0x2::vec_set::empty<address>(),
                admin_role : v2,
            };
            0x2::table::add<0x1::type_name::TypeName, RoleData>(&mut arg0.roles, v0, v3);
        };
        let v4 = RoleAdminChanged<T0>{
            role                : v0,
            previous_admin_role : v1,
            new_admin_role      : v2,
        };
        0x2::event::emit<RoleAdminChanged<T0>>(v4);
    }

    // decompiled from Move bytecode v7
}

