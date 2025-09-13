module 0x51581fb8c0980849c66aadd3914bce68090cf7378683016b6fc51bcdcf6991fe::worker_common {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminRegistry has store {
        active_admins: 0x2::vec_set::VecSet<address>,
        admin_to_admin_cap_id: 0x2::table::Table<address, address>,
        admin_cap_status: 0x2::table::Table<address, bool>,
    }

    struct Worker has store {
        deposit_address: address,
        worker_fee_lib: address,
        price_feed: address,
        default_multiplier_bps: u16,
        paused: bool,
        allowlist: 0x2::vec_set::VecSet<address>,
        denylist: 0x2::vec_set::VecSet<address>,
        supported_option_types: 0x2::table::Table<u32, vector<u8>>,
        worker_cap: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap,
        admin_registry: AdminRegistry,
        owner_cap_id: address,
    }

    struct PausedEvent has copy, drop {
        worker: address,
    }

    struct SetAdminEvent has copy, drop {
        worker: address,
        admin: address,
        active: bool,
    }

    struct SetAllowlistEvent has copy, drop {
        worker: address,
        oapp: address,
        allowed: bool,
    }

    struct SetDefaultMultiplierBpsEvent has copy, drop {
        worker: address,
        multiplier_bps: u16,
    }

    struct SetDenylistEvent has copy, drop {
        worker: address,
        oapp: address,
        denied: bool,
    }

    struct SetDepositAddressEvent has copy, drop {
        worker: address,
        deposit_address: address,
    }

    struct SetPriceFeedEvent has copy, drop {
        worker: address,
        price_feed: address,
    }

    struct SetSupportedOptionTypesEvent has copy, drop {
        worker: address,
        dst_eid: u32,
        option_types: vector<u8>,
    }

    struct SetWorkerFeeLibEvent has copy, drop {
        worker: address,
        fee_lib: address,
    }

    struct UnpausedEvent has copy, drop {
        worker: address,
    }

    public fun admins(arg0: &Worker) : 0x2::vec_set::VecSet<address> {
        arg0.admin_registry.active_admins
    }

    public fun allowlist_size(arg0: &Worker) : u64 {
        0x2::vec_set::size<address>(&arg0.allowlist)
    }

    public fun assert_acl(arg0: &Worker, arg1: address) {
        assert!(has_acl(arg0, arg1), 9);
    }

    public fun assert_admin(arg0: &Worker, arg1: &AdminCap) {
        assert!(is_admin(arg0, arg1), 13);
    }

    public fun assert_owner(arg0: &Worker, arg1: &OwnerCap) {
        assert!(arg0.owner_cap_id == 0x2::object::id_address<OwnerCap>(arg1), 13);
    }

    public fun assert_worker_unpaused(arg0: &Worker) {
        assert!(!arg0.paused, 7);
    }

    public fun create_worker(arg0: 0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap, arg1: address, arg2: address, arg3: address, arg4: u16, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) : (Worker, OwnerCap) {
        assert!(!0x1::vector::is_empty<address>(&arg5), 8);
        assert!(arg1 != @0x0, 6);
        let v0 = OwnerCap{id: 0x2::object::new(arg6)};
        let v1 = AdminRegistry{
            active_admins         : 0x2::vec_set::empty<address>(),
            admin_to_admin_cap_id : 0x2::table::new<address, address>(arg6),
            admin_cap_status      : 0x2::table::new<address, bool>(arg6),
        };
        let v2 = Worker{
            deposit_address        : arg1,
            worker_fee_lib         : arg3,
            price_feed             : arg2,
            default_multiplier_bps : arg4,
            paused                 : false,
            allowlist              : 0x2::vec_set::empty<address>(),
            denylist               : 0x2::vec_set::empty<address>(),
            supported_option_types : 0x2::table::new<u32, vector<u8>>(arg6),
            worker_cap             : arg0,
            admin_registry         : v1,
            owner_cap_id           : 0x2::object::id_address<OwnerCap>(&v0),
        };
        0x1::vector::reverse<address>(&mut arg5);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg5)) {
            let v4 = &mut v2;
            set_admin(v4, &v0, 0x1::vector::pop_back<address>(&mut arg5), true, arg6);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(arg5);
        (v2, v0)
    }

    public fun default_multiplier_bps(arg0: &Worker) : u16 {
        arg0.default_multiplier_bps
    }

    public fun deposit_address(arg0: &Worker) : address {
        arg0.deposit_address
    }

    public fun get_admin_cap_id(arg0: &Worker, arg1: address) : address {
        let v0 = &arg0.admin_registry.admin_to_admin_cap_id;
        assert!(0x2::table::contains<address, address>(v0, arg1), 2);
        *0x2::table::borrow<address, address>(v0, arg1)
    }

    public fun get_native_decimals_rate() : u64 {
        1000000000
    }

    public fun get_supported_option_types(arg0: &Worker, arg1: u32) : vector<u8> {
        let v0 = &arg0.supported_option_types;
        let v1 = if (0x2::table::contains<u32, vector<u8>>(v0, arg1)) {
            0x2::table::borrow<u32, vector<u8>>(v0, arg1)
        } else {
            let v2 = 0x1::vector::empty<u8>();
            &v2
        };
        *v1
    }

    public fun has_acl(arg0: &Worker, arg1: address) : bool {
        is_on_denylist(arg0, arg1) && false || 0x2::vec_set::size<address>(&arg0.allowlist) == 0 || is_on_allowlist(arg0, arg1)
    }

    public fun is_admin(arg0: &Worker, arg1: &AdminCap) : bool {
        let v0 = 0x2::object::id_address<AdminCap>(arg1);
        let v1 = &arg0.admin_registry.admin_cap_status;
        let v2 = if (0x2::table::contains<address, bool>(v1, v0)) {
            0x2::table::borrow<address, bool>(v1, v0)
        } else {
            let v3 = false;
            &v3
        };
        *v2
    }

    public fun is_admin_address(arg0: &Worker, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admin_registry.active_admins, &arg1)
    }

    public fun is_on_allowlist(arg0: &Worker, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.allowlist, &arg1)
    }

    public fun is_on_denylist(arg0: &Worker, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.denylist, &arg1)
    }

    public fun is_paused(arg0: &Worker) : bool {
        arg0.paused
    }

    public fun price_feed(arg0: &Worker) : address {
        arg0.price_feed
    }

    public fun set_admin(arg0: &mut Worker, arg1: &OwnerCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg1);
        let v0 = &mut arg0.admin_registry;
        if (arg3) {
            assert!(!0x2::vec_set::contains<address>(&v0.active_admins, &arg2), 1);
            if (0x2::table::contains<address, address>(&v0.admin_to_admin_cap_id, arg2)) {
                *0x2::table::borrow_mut<address, bool>(&mut v0.admin_cap_status, *0x2::table::borrow<address, address>(&v0.admin_to_admin_cap_id, arg2)) = true;
            } else {
                let v1 = AdminCap{id: 0x2::object::new(arg4)};
                let v2 = 0x2::object::id_address<AdminCap>(&v1);
                0x2::table::add<address, address>(&mut v0.admin_to_admin_cap_id, arg2, v2);
                0x2::table::add<address, bool>(&mut v0.admin_cap_status, v2, true);
                0x2::transfer::transfer<AdminCap>(v1, arg2);
            };
            0x2::vec_set::insert<address>(&mut v0.active_admins, arg2);
        } else {
            assert!(0x2::vec_set::contains<address>(&v0.active_admins, &arg2), 2);
            0x2::vec_set::remove<address>(&mut v0.active_admins, &arg2);
            *0x2::table::borrow_mut<address, bool>(&mut v0.admin_cap_status, *0x2::table::borrow<address, address>(&v0.admin_to_admin_cap_id, arg2)) = false;
            assert!(0x2::vec_set::size<address>(&v0.active_admins) > 0, 5);
        };
        let v3 = SetAdminEvent{
            worker : worker_cap_address(arg0),
            admin  : arg2,
            active : arg3,
        };
        0x2::event::emit<SetAdminEvent>(v3);
    }

    public fun set_allowlist(arg0: &mut Worker, arg1: &OwnerCap, arg2: address, arg3: bool) {
        assert_owner(arg0, arg1);
        if (arg3) {
            assert!(!is_on_allowlist(arg0, arg2), 3);
            0x2::vec_set::insert<address>(&mut arg0.allowlist, arg2);
        } else {
            assert!(is_on_allowlist(arg0, arg2), 10);
            0x2::vec_set::remove<address>(&mut arg0.allowlist, &arg2);
        };
        let v0 = SetAllowlistEvent{
            worker  : worker_cap_address(arg0),
            oapp    : arg2,
            allowed : arg3,
        };
        0x2::event::emit<SetAllowlistEvent>(v0);
    }

    public fun set_default_multiplier_bps(arg0: &mut Worker, arg1: &AdminCap, arg2: u16) {
        assert_admin(arg0, arg1);
        arg0.default_multiplier_bps = arg2;
        let v0 = SetDefaultMultiplierBpsEvent{
            worker         : worker_cap_address(arg0),
            multiplier_bps : arg2,
        };
        0x2::event::emit<SetDefaultMultiplierBpsEvent>(v0);
    }

    public fun set_denylist(arg0: &mut Worker, arg1: &OwnerCap, arg2: address, arg3: bool) {
        assert_owner(arg0, arg1);
        if (arg3) {
            assert!(!is_on_denylist(arg0, arg2), 4);
            0x2::vec_set::insert<address>(&mut arg0.denylist, arg2);
        } else {
            assert!(is_on_denylist(arg0, arg2), 11);
            0x2::vec_set::remove<address>(&mut arg0.denylist, &arg2);
        };
        let v0 = SetDenylistEvent{
            worker : worker_cap_address(arg0),
            oapp   : arg2,
            denied : arg3,
        };
        0x2::event::emit<SetDenylistEvent>(v0);
    }

    public fun set_deposit_address(arg0: &mut Worker, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        assert!(arg2 != @0x0, 6);
        arg0.deposit_address = arg2;
        let v0 = SetDepositAddressEvent{
            worker          : worker_cap_address(arg0),
            deposit_address : arg2,
        };
        0x2::event::emit<SetDepositAddressEvent>(v0);
    }

    public fun set_paused(arg0: &mut Worker, arg1: &OwnerCap, arg2: bool) {
        assert_owner(arg0, arg1);
        assert!(arg0.paused != arg2, 12);
        arg0.paused = arg2;
        if (arg2) {
            let v0 = PausedEvent{worker: worker_cap_address(arg0)};
            0x2::event::emit<PausedEvent>(v0);
        } else {
            let v1 = UnpausedEvent{worker: worker_cap_address(arg0)};
            0x2::event::emit<UnpausedEvent>(v1);
        };
    }

    public fun set_price_feed(arg0: &mut Worker, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        arg0.price_feed = arg2;
        let v0 = SetPriceFeedEvent{
            worker     : worker_cap_address(arg0),
            price_feed : arg2,
        };
        0x2::event::emit<SetPriceFeedEvent>(v0);
    }

    public fun set_supported_option_types(arg0: &mut Worker, arg1: &AdminCap, arg2: u32, arg3: vector<u8>) {
        assert_admin(arg0, arg1);
        let v0 = &mut arg0.supported_option_types;
        if (0x2::table::contains<u32, vector<u8>>(v0, arg2)) {
            *0x2::table::borrow_mut<u32, vector<u8>>(v0, arg2) = arg3;
        } else {
            0x2::table::add<u32, vector<u8>>(v0, arg2, arg3);
        };
        let v1 = SetSupportedOptionTypesEvent{
            worker       : worker_cap_address(arg0),
            dst_eid      : arg2,
            option_types : arg3,
        };
        0x2::event::emit<SetSupportedOptionTypesEvent>(v1);
    }

    public fun set_worker_fee_lib(arg0: &mut Worker, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        arg0.worker_fee_lib = arg2;
        let v0 = SetWorkerFeeLibEvent{
            worker  : worker_cap_address(arg0),
            fee_lib : arg2,
        };
        0x2::event::emit<SetWorkerFeeLibEvent>(v0);
    }

    public fun worker_cap(arg0: &Worker) : &0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::CallCap {
        &arg0.worker_cap
    }

    public fun worker_cap_address(arg0: &Worker) : address {
        0x55576da4cc1df447f860ea67e706c7b3c31c5ce48550b89ed3e8130c2bf7ea83::call_cap::id(&arg0.worker_cap)
    }

    public fun worker_fee_lib(arg0: &Worker) : address {
        arg0.worker_fee_lib
    }

    // decompiled from Move bytecode v6
}

