module 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list {
    struct PartnerList has store {
        parent: 0x2::object::ID,
        acceptance_ends_at_ms: 0x2::table::Table<0x2::object::ID, u64>,
    }

    struct PartnerAdded has copy, drop {
        parent: 0x2::object::ID,
        partner_id: 0x2::object::ID,
    }

    struct PartnerRemoved has copy, drop {
        parent: 0x2::object::ID,
        partner_id: 0x2::object::ID,
        acceptance_ends_at_ms: u64,
    }

    struct PartnerListDestroyed has copy, drop {
        parent: 0x2::object::ID,
    }

    public fun length(arg0: &PartnerList) : u64 {
        0x2::table::length<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms)
    }

    public fun add(arg0: &mut PartnerList, arg1: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner) {
        let v0 = 0x2::object::id<0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner>(arg1);
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms, v0)) {
            let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.acceptance_ends_at_ms, v0);
            assert!(*v1 != 18446744073709551615, 2);
            *v1 = 18446744073709551615;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.acceptance_ends_at_ms, v0, 18446744073709551615);
        };
        let v2 = PartnerAdded{
            parent     : arg0.parent,
            partner_id : v0,
        };
        0x2::event::emit<PartnerAdded>(v2);
    }

    public fun contains(arg0: &PartnerList, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms, arg1)
    }

    public fun new(arg0: &0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) : PartnerList {
        PartnerList{
            parent                : 0x2::object::uid_to_inner(arg0),
            acceptance_ends_at_ms : 0x2::table::new<0x2::object::ID, u64>(arg1),
        }
    }

    public fun acceptance_ends_at_ms(arg0: &PartnerList, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms, arg1)
    }

    public fun assert_accepted(arg0: &PartnerList, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        assert_accepted_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    fun assert_accepted_at(arg0: &PartnerList, arg1: 0x2::object::ID, arg2: u64) {
        assert!(is_accepted_at(arg0, arg1, arg2), 4);
    }

    public fun destroy(arg0: PartnerList) {
        let PartnerList {
            parent                : v0,
            acceptance_ends_at_ms : v1,
        } = arg0;
        0x2::table::drop<0x2::object::ID, u64>(v1);
        let v2 = PartnerListDestroyed{parent: v0};
        0x2::event::emit<PartnerListDestroyed>(v2);
    }

    public fun is_accepted(arg0: &PartnerList, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        is_accepted_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2))
    }

    fun is_accepted_at(arg0: &PartnerList, arg1: 0x2::object::ID, arg2: u64) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms, arg1) && arg2 < *0x2::table::borrow<0x2::object::ID, u64>(&arg0.acceptance_ends_at_ms, arg1)
    }

    public fun parent(arg0: &PartnerList) : 0x2::object::ID {
        arg0.parent
    }

    public fun remove(arg0: &mut PartnerList, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert_accepted_at(arg0, arg1, v0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.acceptance_ends_at_ms, arg1);
        assert!(*v1 == 18446744073709551615, 2);
        let v2 = v0 + 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::delay_ms();
        *v1 = v2;
        let v3 = PartnerRemoved{
            parent                : arg0.parent,
            partner_id            : arg1,
            acceptance_ends_at_ms : v2,
        };
        0x2::event::emit<PartnerRemoved>(v3);
    }

    // decompiled from Move bytecode v7
}

