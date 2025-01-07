module 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        registry_cap: 0x2::object::ID,
        version: u64,
        domain_tld: 0x1::ascii::String,
        treasury_wallet: address,
        affiliate_basis_points: u64,
        total_domains: u64,
        timestamp: u64,
    }

    struct RegistryCap has key {
        id: 0x2::object::UID,
    }

    struct REGISTRY has drop {
        dummy_field: bool,
    }

    public entry fun new(arg0: &0x2::package::Publisher, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Registry>(arg0), 1);
        0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::util::assert_name_valid(&arg1);
        let v0 = RegistryCap{id: 0x2::object::new(arg5)};
        let v1 = Registry{
            id                     : 0x2::object::new(arg5),
            registry_cap           : 0x2::object::uid_to_inner(&v0.id),
            version                : 1,
            domain_tld             : arg1,
            treasury_wallet        : arg2,
            affiliate_basis_points : arg3,
            total_domains          : 0,
            timestamp              : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::transfer::transfer<RegistryCap>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::share_object<Registry>(v1);
    }

    public fun id(arg0: &Registry) : &0x2::object::UID {
        &arg0.id
    }

    public fun cap_id(arg0: &RegistryCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun create_domain(arg0: &mut Registry, arg1: 0x1::ascii::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::Domain {
        0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::util::assert_name_valid(&arg1);
        let v0 = 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::new(arg1, arg0.domain_tld, 0x2::clock::timestamp_ms(arg2), arg3);
        assert!(!0x2::dynamic_field::exists_<0x1::ascii::String>(&mut arg0.id, 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::domain_name(&v0)), 2);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.id, 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::domain_name(&v0), 0x2::object::uid_to_inner(0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::id(&v0)));
        arg0.total_domains = arg0.total_domains + 1;
        v0
    }

    public fun domain_tld(arg0: &Registry) : 0x1::ascii::String {
        arg0.domain_tld
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REGISTRY>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun registry_cap(arg0: &Registry) : 0x2::object::ID {
        arg0.registry_cap
    }

    public fun timestamp(arg0: &Registry) : u64 {
        arg0.timestamp
    }

    public fun total_domains(arg0: &Registry) : u64 {
        arg0.total_domains
    }

    // decompiled from Move bytecode v6
}

