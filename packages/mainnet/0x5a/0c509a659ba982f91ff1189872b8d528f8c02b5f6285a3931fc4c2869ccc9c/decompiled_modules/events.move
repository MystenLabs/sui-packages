module 0x26eb7ee8688da02c5f671679524e379f0b837a12f1d1d799f255b7eea260ad27::events {
    struct SiteCreatedEvent has copy, drop {
        site_id: 0x2::object::ID,
    }

    struct SiteBurnedEvent has copy, drop {
        site_id: 0x2::object::ID,
    }

    public(friend) fun emit_site_burned(arg0: 0x2::object::ID) {
        let v0 = SiteBurnedEvent{site_id: arg0};
        0x2::event::emit<SiteBurnedEvent>(v0);
    }

    public(friend) fun emit_site_created(arg0: 0x2::object::ID) {
        let v0 = SiteCreatedEvent{site_id: arg0};
        0x2::event::emit<SiteCreatedEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

