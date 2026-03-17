module 0x9de5bfb1384ab65dec70bab89f47c4aeb16beec99b38b561a2cc5f27fc014f8f::snapshot {
    struct SnapshotRegistry has key {
        id: 0x2::object::UID,
        proposal_id: 0x2::object::ID,
        registration_closes_ms: u64,
        powers: 0x2::table::Table<address, u64>,
        total_registered: u64,
    }

    struct VoterRegistered has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        power: u64,
        snapshot_at_ms: u64,
    }

    struct RegistrationUpdated has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        old_power: u64,
        new_power: u64,
    }

    public(friend) fun create_registry_raw(arg0: 0x2::object::ID, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg2);
        let v1 = SnapshotRegistry{
            id                     : v0,
            proposal_id            : arg0,
            registration_closes_ms : arg1,
            powers                 : 0x2::table::new<address, u64>(arg2),
            total_registered       : 0,
        };
        0x2::transfer::share_object<SnapshotRegistry>(v1);
        0x2::object::uid_to_inner(&v0)
    }

    public fun has_registered(arg0: &SnapshotRegistry, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.powers, arg1)
    }

    public fun peek_power(arg0: &SnapshotRegistry, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.powers, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.powers, arg1)
        } else {
            0
        }
    }

    public fun proposal_id(arg0: &SnapshotRegistry) : 0x2::object::ID {
        arg0.proposal_id
    }

    public fun register_voting_power<T0>(arg0: &mut SnapshotRegistry, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::coin::value<T0>(arg1);
        assert!(v0 < arg0.registration_closes_ms, 300);
        assert!(!0x2::table::contains<address, u64>(&arg0.powers, v1), 301);
        assert!(v2 > 0, 305);
        0x2::table::add<address, u64>(&mut arg0.powers, v1, v2);
        arg0.total_registered = arg0.total_registered + v2;
        let v3 = VoterRegistered{
            proposal_id    : arg0.proposal_id,
            voter          : v1,
            power          : v2,
            snapshot_at_ms : v0,
        };
        0x2::event::emit<VoterRegistered>(v3);
    }

    public(friend) fun registered_power(arg0: &SnapshotRegistry, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.registration_closes_ms, 303);
        assert!(0x2::table::contains<address, u64>(&arg0.powers, arg1), 302);
        *0x2::table::borrow<address, u64>(&arg0.powers, arg1)
    }

    public fun registration_closes_ms(arg0: &SnapshotRegistry) : u64 {
        arg0.registration_closes_ms
    }

    public fun total_registered(arg0: &SnapshotRegistry) : u64 {
        arg0.total_registered
    }

    public fun update_registration<T0>(arg0: &mut SnapshotRegistry, arg1: &0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.registration_closes_ms, 300);
        assert!(0x2::table::contains<address, u64>(&arg0.powers, v0), 302);
        assert!(v1 > 0, 305);
        let v2 = *0x2::table::borrow<address, u64>(&arg0.powers, v0);
        arg0.total_registered = arg0.total_registered - v2 + v1;
        *0x2::table::borrow_mut<address, u64>(&mut arg0.powers, v0) = v1;
        let v3 = RegistrationUpdated{
            proposal_id : arg0.proposal_id,
            voter       : v0,
            old_power   : v2,
            new_power   : v1,
        };
        0x2::event::emit<RegistrationUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

