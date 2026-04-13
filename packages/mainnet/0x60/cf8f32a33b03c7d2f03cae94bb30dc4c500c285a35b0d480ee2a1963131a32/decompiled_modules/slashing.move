module 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::slashing {
    struct OverSlashing has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<OverSlashing> {
        let v0 = 0x2::object::new(arg0);
        let v1 = OverSlashing{dummy_field: false};
        0x2::object::delete(v0);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::new_cloneable_drop<OverSlashing>(v1, &v0, arg0)
    }

    // decompiled from Move bytecode v6
}

