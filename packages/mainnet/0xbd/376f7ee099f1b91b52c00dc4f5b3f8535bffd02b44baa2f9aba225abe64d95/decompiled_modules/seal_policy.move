module 0xbd376f7ee099f1b91b52c00dc4f5b3f8535bffd02b44baa2f9aba225abe64d95::seal_policy {
    struct FormPolicy has key {
        id: 0x2::object::UID,
        owner: address,
        admins: vector<address>,
        created_at_ms: u64,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        owner: address,
    }

    struct AdminAdded has copy, drop {
        policy_id: 0x2::object::ID,
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        policy_id: 0x2::object::ID,
        admin: address,
    }

    entry fun add_admin(arg0: &mut FormPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(!0x1::vector::contains<address>(&arg0.admins, &arg1), 2);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v0 = AdminAdded{
            policy_id : 0x2::object::id<FormPolicy>(arg0),
            admin     : arg1,
        };
        0x2::event::emit<AdminAdded>(v0);
    }

    public fun admins(arg0: &FormPolicy) : vector<address> {
        arg0.admins
    }

    entry fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = FormPolicy{
            id            : 0x2::object::new(arg0),
            owner         : v0,
            admins        : vector[],
            created_at_ms : 0,
        };
        let v2 = PolicyCreated{
            policy_id : 0x2::object::id<FormPolicy>(&v1),
            owner     : v0,
        };
        0x2::event::emit<PolicyCreated>(v2);
        0x2::transfer::share_object<FormPolicy>(v1);
    }

    public fun is_authorized(arg0: &FormPolicy, arg1: address) : bool {
        arg1 == arg0.owner || 0x1::vector::contains<address>(&arg0.admins, &arg1)
    }

    public fun owner(arg0: &FormPolicy) : address {
        arg0.owner
    }

    entry fun remove_admin(arg0: &mut FormPolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admins, &arg1);
        assert!(v0, 3);
        0x1::vector::remove<address>(&mut arg0.admins, v1);
        let v2 = AdminRemoved{
            policy_id : 0x2::object::id<FormPolicy>(arg0),
            admin     : arg1,
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    entry fun seal_approve_decrypt(arg0: vector<u8>, arg1: &FormPolicy, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<FormPolicy>(arg1);
        assert!(arg0 == 0x2::object::id_to_bytes(&v0), 4);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(v1 == arg1.owner || 0x1::vector::contains<address>(&arg1.admins, &v1), 1);
    }

    // decompiled from Move bytecode v7
}

