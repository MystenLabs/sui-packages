module 0x8e8cc7162b8b423546939227280508f897943d8e3b062bec3a13ec19fb37dd80::obligation {
    struct ObligationOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : ObligationOwnerCap {
        abort 0
    }

    // decompiled from Move bytecode v6
}

