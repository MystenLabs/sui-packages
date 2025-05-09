module 0x66c6830a8f44a154b055b1ce2a1bd9b9fa65da6584d5c04b75db23fab1008b5e::acl {
    struct ACL has store {
        permissions: 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        abort 0
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        abort 0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        abort 0
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        abort 0
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        abort 0
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        abort 0
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        abort 0
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

