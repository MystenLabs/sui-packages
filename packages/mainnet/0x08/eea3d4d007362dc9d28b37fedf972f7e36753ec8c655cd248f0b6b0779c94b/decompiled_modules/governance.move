module 0x8eea3d4d007362dc9d28b37fedf972f7e36753ec8c655cd248f0b6b0779c94b::governance {
    struct ProtocolOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct ProtocolOwnerCreated has copy, drop {
        owner_cap_id: 0x2::object::ID,
        owner: address,
    }

    struct ProtocolOwnerTransferred has copy, drop {
        owner_cap_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
    }

    public fun assert_owner(arg0: &ProtocolOwnerCap) {
    }

    public fun get_owner_cap_id(arg0: &ProtocolOwnerCap) : 0x2::object::ID {
        0x2::object::id<ProtocolOwnerCap>(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolOwnerCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = ProtocolOwnerCreated{
            owner_cap_id : 0x2::object::id<ProtocolOwnerCap>(&v0),
            owner        : v1,
        };
        0x2::event::emit<ProtocolOwnerCreated>(v2);
        0x2::transfer::transfer<ProtocolOwnerCap>(v0, v1);
    }

    entry fun transfer_owner(arg0: ProtocolOwnerCap, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        let v0 = ProtocolOwnerTransferred{
            owner_cap_id : 0x2::object::id<ProtocolOwnerCap>(&arg0),
            old_owner    : 0x2::tx_context::sender(arg2),
            new_owner    : arg1,
        };
        0x2::event::emit<ProtocolOwnerTransferred>(v0);
        0x2::transfer::transfer<ProtocolOwnerCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

