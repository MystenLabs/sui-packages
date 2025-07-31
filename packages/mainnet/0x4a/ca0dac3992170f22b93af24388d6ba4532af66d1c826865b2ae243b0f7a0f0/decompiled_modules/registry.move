module 0x84e9c31d961436709798f0c4b69e2b9cf4e006517f2e3b4245349b2358d2a7d9::registry {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollectorCap has store, key {
        id: 0x2::object::UID,
        name: 0x1::ascii::String,
    }

    struct CapRegistry has key {
        id: 0x2::object::UID,
        revoked_caps: 0x2::table::Table<address, bool>,
    }

    struct FeeCollectorCapCreated has copy, drop {
        name: 0x1::ascii::String,
    }

    struct FeeCollectorCapRevoked has copy, drop {
        name: 0x1::ascii::String,
    }

    public entry fun create_fee_collector_cap(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorCap{
            id   : 0x2::object::new(arg3),
            name : 0x1::ascii::string(arg1),
        };
        let v1 = FeeCollectorCapCreated{name: v0.name};
        0x2::event::emit<FeeCollectorCapCreated>(v1);
        0x2::transfer::transfer<FeeCollectorCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CapRegistry{
            id           : 0x2::object::new(arg0),
            revoked_caps : 0x2::table::new<address, bool>(arg0),
        };
        0x2::transfer::share_object<CapRegistry>(v1);
    }

    public fun is_cap_revoked(arg0: &CapRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.revoked_caps, arg1)
    }

    public fun is_collector_cap_revoked(arg0: &CapRegistry, arg1: &FeeCollectorCap) : bool {
        0x2::table::contains<address, bool>(&arg0.revoked_caps, 0x2::object::id_address<FeeCollectorCap>(arg1))
    }

    public fun issue_cap_registry_table(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CapRegistry{
            id           : 0x2::object::new(arg1),
            revoked_caps : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<CapRegistry>(v0);
    }

    public fun name(arg0: &FeeCollectorCap) : 0x1::ascii::String {
        arg0.name
    }

    public entry fun revoke_fee_collector_cap(arg0: &AdminCap, arg1: FeeCollectorCap, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun revoke_fee_collector_cap_safe(arg0: &AdminCap, arg1: &mut CapRegistry, arg2: &FeeCollectorCap, arg3: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun revoke_fee_collector_cap_safe_with_cap_registry(arg0: &AdminCap, arg1: &mut CapRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<address, bool>(&mut arg1.revoked_caps, arg2, true);
        let v0 = FeeCollectorCapRevoked{name: 0x2::address::to_ascii_string(arg2)};
        0x2::event::emit<FeeCollectorCapRevoked>(v0);
    }

    // decompiled from Move bytecode v6
}

