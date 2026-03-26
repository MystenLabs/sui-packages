module 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::killmail_registry {
    struct KillmailRegistry has key {
        id: 0x2::object::UID,
    }

    public fun id(arg0: &KillmailRegistry) : 0x2::object::ID {
        0x2::object::id<KillmailRegistry>(arg0)
    }

    public(friend) fun borrow_registry_id(arg0: &mut KillmailRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KillmailRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<KillmailRegistry>(v0);
    }

    public fun object_exists(arg0: &KillmailRegistry, arg1: 0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId) : bool {
        0x2::derived_object::exists<0x90179caad5686477002196af0f1e1107038eedc9dd529418add5d9b644e42b4::in_game_id::TenantItemId>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

