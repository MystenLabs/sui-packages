module 0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::agent {
    struct Aion has key {
        id: 0x2::object::UID,
        owner: address,
        owner_cap_id: 0x2::object::ID,
        key_id: 0x1::option::Option<0x1::string::String>,
        balance_accounting: u64,
        walks: u64,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::object::new(arg0);
        let v2 = Aion{
            id                 : 0x2::object::new(arg0),
            owner              : v0,
            owner_cap_id       : 0x2::object::uid_to_inner(&v1),
            key_id             : 0x1::option::none<0x1::string::String>(),
            balance_accounting : 0,
            walks              : 0,
        };
        let v3 = 0x2::object::id<Aion>(&v2);
        let v4 = OwnerCap{
            id       : v1,
            agent_id : v3,
        };
        0x670f3f97acf3e6a9a7e8a090e84e5c76d42d596ecf4e6178483aa1c091da9403::events::emit_agent_created(v3, v0);
        0x2::transfer::share_object<Aion>(v2);
        0x2::transfer::transfer<OwnerCap>(v4, v0);
    }

    fun assert_owner(arg0: &Aion, arg1: &OwnerCap) {
        assert!(arg1.agent_id == 0x2::object::id<Aion>(arg0), 1);
    }

    public fun assert_owner_cap(arg0: &Aion, arg1: &OwnerCap) {
        assert_owner(arg0, arg1);
    }

    public fun balance(arg0: &Aion) : u64 {
        arg0.balance_accounting
    }

    public(friend) fun bind_issuer_key(arg0: &mut Aion, arg1: 0x1::string::String) {
        arg0.key_id = 0x1::option::some<0x1::string::String>(arg1);
    }

    public(friend) fun check_owner(arg0: &Aion, arg1: &OwnerCap) {
        assert_owner(arg0, arg1);
    }

    public fun identity(arg0: &Aion) : &0x2::object::UID {
        &arg0.id
    }

    public fun key_id(arg0: &Aion) : &0x1::option::Option<0x1::string::String> {
        &arg0.key_id
    }

    public fun owner(arg0: &Aion) : address {
        arg0.owner
    }

    public fun owner_cap_id(arg0: &Aion) : 0x2::object::ID {
        arg0.owner_cap_id
    }

    public(friend) fun uid(arg0: &Aion) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut Aion) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun walks(arg0: &Aion) : u64 {
        arg0.walks
    }

    // decompiled from Move bytecode v7
}

