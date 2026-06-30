module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::relayer_registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RelayerInfo has copy, drop, store {
        endpoint_hash: vector<u8>,
        active: bool,
        registered_at_ms: u64,
        last_status_change_ms: u64,
    }

    struct RelayerRegistry has key {
        id: 0x2::object::UID,
        relayers: 0x2::table::Table<address, RelayerInfo>,
        total_registered: u64,
        active_count: u64,
    }

    struct RelayerApproved has copy, drop {
        relayer: address,
        endpoint_hash: vector<u8>,
        registered_at_ms: u64,
    }

    struct RelayerDeactivated has copy, drop {
        relayer: address,
        at_ms: u64,
    }

    struct RelayerReactivated has copy, drop {
        relayer: address,
        at_ms: u64,
    }

    struct RelayerEndpointUpdated has copy, drop {
        relayer: address,
        old_hash: vector<u8>,
        new_hash: vector<u8>,
    }

    public fun active_count(arg0: &RelayerRegistry) : u64 {
        arg0.active_count
    }

    public(friend) entry fun approve(arg0: &AdminCap, arg1: &mut RelayerRegistry, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2 != @0x0, 1);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 7);
        assert!(!0x2::table::contains<address, RelayerInfo>(&arg1.relayers, arg2), 2);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = RelayerInfo{
            endpoint_hash         : arg3,
            active                : true,
            registered_at_ms      : v0,
            last_status_change_ms : 0,
        };
        0x2::table::add<address, RelayerInfo>(&mut arg1.relayers, arg2, v1);
        arg1.total_registered = arg1.total_registered + 1;
        arg1.active_count = arg1.active_count + 1;
        let v2 = RelayerApproved{
            relayer          : arg2,
            endpoint_hash    : 0x2::table::borrow<address, RelayerInfo>(&arg1.relayers, arg2).endpoint_hash,
            registered_at_ms : v0,
        };
        0x2::event::emit<RelayerApproved>(v2);
    }

    public(friend) entry fun deactivate(arg0: &AdminCap, arg1: &mut RelayerRegistry, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg1.relayers, arg2), 3);
        let v0 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg1.relayers, arg2);
        assert!(v0.active, 4);
        v0.active = false;
        v0.last_status_change_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.active_count = arg1.active_count - 1;
        let v1 = RelayerDeactivated{
            relayer : arg2,
            at_ms   : v0.last_status_change_ms,
        };
        0x2::event::emit<RelayerDeactivated>(v1);
    }

    public fun endpoint_hash(arg0: &RelayerRegistry, arg1: address) : vector<u8> {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1), 3);
        0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).endpoint_hash
    }

    public fun info_active(arg0: &RelayerInfo) : bool {
        arg0.active
    }

    public fun info_endpoint_hash(arg0: &RelayerInfo) : &vector<u8> {
        &arg0.endpoint_hash
    }

    public fun info_last_status_change_ms(arg0: &RelayerInfo) : u64 {
        arg0.last_status_change_ms
    }

    public fun info_registered_at_ms(arg0: &RelayerInfo) : u64 {
        arg0.registered_at_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RelayerRegistry{
            id               : 0x2::object::new(arg0),
            relayers         : 0x2::table::new<address, RelayerInfo>(arg0),
            total_registered : 0,
            active_count     : 0,
        };
        0x2::transfer::share_object<RelayerRegistry>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &RelayerRegistry, arg1: address) : bool {
        0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1) && 0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).active
    }

    public fun is_registered(arg0: &RelayerRegistry, arg1: address) : bool {
        0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1)
    }

    public(friend) entry fun reactivate(arg0: &AdminCap, arg1: &mut RelayerRegistry, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg1.relayers, arg2), 6);
        let v0 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg1.relayers, arg2);
        assert!(!v0.active, 5);
        v0.active = true;
        v0.last_status_change_ms = 0x2::clock::timestamp_ms(arg3);
        arg1.active_count = arg1.active_count + 1;
        let v1 = RelayerReactivated{
            relayer : arg2,
            at_ms   : v0.last_status_change_ms,
        };
        0x2::event::emit<RelayerReactivated>(v1);
    }

    public fun registered_at_ms(arg0: &RelayerRegistry, arg1: address) : u64 {
        assert!(0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1), 3);
        0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1).registered_at_ms
    }

    public fun relayer_info(arg0: &RelayerRegistry, arg1: address) : 0x1::option::Option<RelayerInfo> {
        if (0x2::table::contains<address, RelayerInfo>(&arg0.relayers, arg1)) {
            0x1::option::some<RelayerInfo>(*0x2::table::borrow<address, RelayerInfo>(&arg0.relayers, arg1))
        } else {
            0x1::option::none<RelayerInfo>()
        }
    }

    public fun total_registered(arg0: &RelayerRegistry) : u64 {
        arg0.total_registered
    }

    public(friend) entry fun update_endpoint(arg0: &AdminCap, arg1: &mut RelayerRegistry, arg2: address, arg3: vector<u8>) {
        assert!(!0x1::vector::is_empty<u8>(&arg3), 7);
        assert!(0x2::table::contains<address, RelayerInfo>(&arg1.relayers, arg2), 3);
        let v0 = 0x2::table::borrow_mut<address, RelayerInfo>(&mut arg1.relayers, arg2);
        v0.endpoint_hash = arg3;
        let v1 = RelayerEndpointUpdated{
            relayer  : arg2,
            old_hash : v0.endpoint_hash,
            new_hash : arg3,
        };
        0x2::event::emit<RelayerEndpointUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

