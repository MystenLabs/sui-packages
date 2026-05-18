module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::sponsorship {
    struct SponsorshipPoolCreated has copy, drop {
        form_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sponsor_address: address,
        created_by: address,
    }

    struct SponsorshipPoolDeactivated has copy, drop {
        form_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        deactivated_by: address,
    }

    struct SponsorshipPoolReactivated has copy, drop {
        form_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        reactivated_by: address,
    }

    struct SponsorshipPool has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        sponsor_address: address,
        is_active: bool,
        created_at: u64,
    }

    entry fun create_sponsorship_pool(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = SponsorshipPool{
            id              : 0x2::object::new(arg3),
            form_id         : v0,
            sponsor_address : arg2,
            is_active       : true,
            created_at      : 0x2::tx_context::epoch(arg3),
        };
        let v3 = SponsorshipPoolCreated{
            form_id         : v0,
            pool_id         : 0x2::object::uid_to_inner(&v2.id),
            sponsor_address : arg2,
            created_by      : v1,
        };
        0x2::event::emit<SponsorshipPoolCreated>(v3);
        0x2::transfer::public_transfer<SponsorshipPool>(v2, v1);
    }

    public fun created_at(arg0: &SponsorshipPool) : u64 {
        arg0.created_at
    }

    entry fun deactivate_sponsorship_pool(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &mut SponsorshipPool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 2);
        arg1.is_active = false;
        let v0 = SponsorshipPoolDeactivated{
            form_id        : arg1.form_id,
            pool_id        : 0x2::object::uid_to_inner(&arg1.id),
            deactivated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SponsorshipPoolDeactivated>(v0);
    }

    public fun form_id(arg0: &SponsorshipPool) : 0x2::object::ID {
        arg0.form_id
    }

    public fun is_active(arg0: &SponsorshipPool) : bool {
        arg0.is_active
    }

    entry fun reactivate_sponsorship_pool(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &mut SponsorshipPool, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.form_id == 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::cap_form_id(arg0), 2);
        arg1.is_active = true;
        let v0 = SponsorshipPoolReactivated{
            form_id        : arg1.form_id,
            pool_id        : 0x2::object::uid_to_inner(&arg1.id),
            reactivated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SponsorshipPoolReactivated>(v0);
    }

    public fun sponsor_address(arg0: &SponsorshipPool) : address {
        arg0.sponsor_address
    }

    public(friend) fun verify_sponsorship(arg0: &SponsorshipPool, arg1: address) {
        assert!(arg0.is_active, 19);
        assert!(arg0.sponsor_address == arg1, 20);
    }

    // decompiled from Move bytecode v6
}

