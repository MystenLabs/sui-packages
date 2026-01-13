module 0x4206504008b86bfeae99df779e5c970c83980bedfc9c7cef1d8b4252e06a6702::x {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        members: 0x2::vec_set::VecSet<address>,
    }

    public entry fun add_member(arg0: &AdminCap, arg1: &mut Vault, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.members, arg2);
    }

    // decompiled from Move bytecode v6
}

