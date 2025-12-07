module 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver {
    struct Resolver has key {
        id: 0x2::object::UID,
        is_enabled: bool,
    }

    struct ResolverCap has store, key {
        id: 0x2::object::UID,
        resolver_id: 0x2::object::ID,
    }

    struct Resolution has drop {
        query_id: 0x2::object::ID,
        resolver_id: 0x2::object::ID,
        data: vector<u8>,
        resolved_at_ms: u64,
    }

    struct DisputeTicket<phantom T0> {
        query_id: 0x2::object::ID,
        disputer: address,
        resolver_id: 0x2::object::ID,
        disputed_at_ms: u64,
        fee: 0x2::balance::Balance<T0>,
        verification_bond_amount: u64,
    }

    struct ResolverEnabled has copy, drop {
        resolver_id: 0x2::object::ID,
    }

    struct ResolverDisabled has copy, drop {
        resolver_id: 0x2::object::ID,
    }

    public fun cap_resolver_id(arg0: &ResolverCap) : 0x2::object::ID {
        arg0.resolver_id
    }

    public fun create<T0: drop>(arg0: T0, arg1: 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) : (Resolver, ResolverCap) {
        assert!(0x2::package::from_module<T0>(&arg1), 0);
        0x2::package::burn_publisher(arg1);
        let v0 = Resolver{
            id         : 0x2::object::new(arg2),
            is_enabled : false,
        };
        let v1 = ResolverCap{
            id          : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"RESOLVER_CAP"),
            resolver_id : 0x2::object::uid_to_inner(&v0.id),
        };
        (v0, v1)
    }

    public fun disable(arg0: &mut Resolver, arg1: &0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::protocol::ProtocolCap) {
        arg0.is_enabled = false;
        let v0 = ResolverDisabled{resolver_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<ResolverDisabled>(v0);
    }

    public fun enable(arg0: &mut Resolver, arg1: &0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::protocol::ProtocolCap) {
        arg0.is_enabled = true;
        let v0 = ResolverEnabled{resolver_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<ResolverEnabled>(v0);
    }

    public fun id(arg0: &Resolver) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun is_enabled(arg0: &Resolver) : bool {
        arg0.is_enabled
    }

    public fun make_resolution(arg0: &Resolver, arg1: &ResolverCap, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock) : Resolution {
        assert!(arg0.is_enabled, 2);
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.resolver_id, 1);
        Resolution{
            query_id       : arg2,
            resolver_id    : 0x2::object::uid_to_inner(&arg0.id),
            data           : arg3,
            resolved_at_ms : 0x2::clock::timestamp_ms(arg4),
        }
    }

    public(friend) fun new_dispute_ticket<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>, arg3: address, arg4: u64, arg5: u64) : DisputeTicket<T0> {
        DisputeTicket<T0>{
            query_id                 : arg0,
            disputer                 : arg3,
            resolver_id              : arg1,
            disputed_at_ms           : arg4,
            fee                      : arg2,
            verification_bond_amount : arg5,
        }
    }

    public fun resolution_data(arg0: &Resolution) : vector<u8> {
        arg0.data
    }

    public fun resolution_query_id(arg0: &Resolution) : 0x2::object::ID {
        arg0.query_id
    }

    public fun resolution_resolved_at_ms(arg0: &Resolution) : u64 {
        arg0.resolved_at_ms
    }

    public fun resolution_resolver_id(arg0: &Resolution) : 0x2::object::ID {
        arg0.resolver_id
    }

    public fun share(arg0: Resolver) {
        0x2::transfer::share_object<Resolver>(arg0);
    }

    public fun unpack_dispute_ticket<T0>(arg0: DisputeTicket<T0>, arg1: &ResolverCap) : (0x2::object::ID, 0x2::object::ID, 0x2::balance::Balance<T0>, address, u64, u64) {
        let DisputeTicket {
            query_id                 : v0,
            disputer                 : v1,
            resolver_id              : v2,
            disputed_at_ms           : v3,
            fee                      : v4,
            verification_bond_amount : v5,
        } = arg0;
        assert!(arg1.resolver_id == v2, 1);
        (v0, v2, v4, v1, v3, v5)
    }

    // decompiled from Move bytecode v6
}

