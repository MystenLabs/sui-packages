module 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader_cap {
    struct OverNetwork has drop {
        dummy_field: bool,
    }

    struct FoundingLeaderCapCreatedEvent has copy, drop {
        leader_cap: 0x2::object::ID,
        network: 0x2::object::ID,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<OverNetwork> {
        let v0 = 0x2::object::new(arg0);
        let v1 = OverNetwork{dummy_field: false};
        let v2 = 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::new_cloneable_drop<OverNetwork>(v1, &v0, arg0);
        0x2::object::delete(v0);
        let v3 = FoundingLeaderCapCreatedEvent{
            leader_cap : 0x2::object::id<0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<OverNetwork>>(&v2),
            network    : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::what_for<OverNetwork>(&v2),
        };
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::event::emit<FoundingLeaderCapCreatedEvent>(v3);
        v2
    }

    // decompiled from Move bytecode v6
}

