module 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::referral {
    struct Referral has key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct ReferralCap has store, key {
        id: 0x2::object::UID,
        referral_id: 0x2::object::ID,
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (Referral, ReferralCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Referral{
            id       : 0x2::object::new(arg1),
            house_id : arg0,
            cap_id   : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = ReferralCap{
            id          : v0,
            referral_id : id(&v1),
        };
        (v1, v2)
    }

    public fun id(arg0: &Referral) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun referral_id(arg0: &ReferralCap) : 0x2::object::ID {
        arg0.referral_id
    }

    public fun share(arg0: Referral) {
        0x2::transfer::share_object<Referral>(arg0);
    }

    // decompiled from Move bytecode v6
}

