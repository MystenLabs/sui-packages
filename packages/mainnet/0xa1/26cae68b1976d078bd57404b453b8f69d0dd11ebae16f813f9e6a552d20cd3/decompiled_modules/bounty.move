module 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::bounty {
    struct SponsoredBounty<phantom T0> has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        sponsor: address,
        payout: 0x2::balance::Balance<T0>,
        tiers: vector<u64>,
        paid: 0x2::table::Table<0x2::object::ID, address>,
    }

    struct BountySponsored has copy, drop {
        bounty_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
        tiers: vector<u64>,
    }

    struct BountyPaid has copy, drop {
        bounty_id: 0x2::object::ID,
        form_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        recipient: address,
        severity: u8,
        amount: u64,
    }

    struct BountyWithdrawn has copy, drop {
        bounty_id: 0x2::object::ID,
        sponsor: address,
        amount: u64,
    }

    public fun already_paid<T0>(arg0: &SponsoredBounty<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.paid, arg1)
    }

    public fun form_id<T0>(arg0: &SponsoredBounty<T0>) : 0x2::object::ID {
        arg0.form_id
    }

    public fun release<T0>(arg0: &mut SponsoredBounty<T0>, arg1: &0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form, arg2: &0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::owner(arg1) == 0x2::tx_context::sender(arg4), 1);
        assert!(arg0.form_id == 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::Form>(arg1), 6);
        assert!(0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::form_id(arg2) == arg0.form_id, 6);
        let v0 = 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::submitter(arg2);
        assert!(v0 != 0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::form_registry::owner(arg1), 3);
        let v1 = 0x2::object::id<0xa126cae68b1976d078bd57404b453b8f69d0dd11ebae16f813f9e6a552d20cd3::submission::Submission>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, address>(&arg0.paid, v1), 2);
        assert!((arg3 as u64) < 4, 7);
        let v2 = *0x1::vector::borrow<u64>(&arg0.tiers, (arg3 as u64));
        0x2::table::add<0x2::object::ID, address>(&mut arg0.paid, v1, v0);
        let v3 = BountyPaid{
            bounty_id     : 0x2::object::id<SponsoredBounty<T0>>(arg0),
            form_id       : arg0.form_id,
            submission_id : v1,
            recipient     : v0,
            severity      : arg3,
            amount        : v2,
        };
        0x2::event::emit<BountyPaid>(v3);
        if (v2 == 0) {
            return
        };
        assert!(0x2::balance::value<T0>(&arg0.payout) >= v2, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout, v2), arg4), v0);
    }

    public fun remaining<T0>(arg0: &SponsoredBounty<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.payout)
    }

    public fun sponsor<T0>(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) == 4, 4);
        let v0 = SponsoredBounty<T0>{
            id      : 0x2::object::new(arg3),
            form_id : arg0,
            sponsor : 0x2::tx_context::sender(arg3),
            payout  : 0x2::coin::into_balance<T0>(arg1),
            tiers   : arg2,
            paid    : 0x2::table::new<0x2::object::ID, address>(arg3),
        };
        let v1 = BountySponsored{
            bounty_id : 0x2::object::id<SponsoredBounty<T0>>(&v0),
            form_id   : arg0,
            sponsor   : v0.sponsor,
            amount    : 0x2::coin::value<T0>(&arg1),
            tiers     : arg2,
        };
        0x2::event::emit<BountySponsored>(v1);
        0x2::transfer::share_object<SponsoredBounty<T0>>(v0);
    }

    public fun sponsor_address<T0>(arg0: &SponsoredBounty<T0>) : address {
        arg0.sponsor
    }

    public fun tier_amount<T0>(arg0: &SponsoredBounty<T0>, arg1: u8) : u64 {
        assert!((arg1 as u64) < 4, 7);
        *0x1::vector::borrow<u64>(&arg0.tiers, (arg1 as u64))
    }

    public fun top_up<T0>(arg0: &mut SponsoredBounty<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.sponsor == 0x2::tx_context::sender(arg2), 1);
        0x2::balance::join<T0>(&mut arg0.payout, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw_remaining<T0>(arg0: &mut SponsoredBounty<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sponsor == 0x2::tx_context::sender(arg1), 1);
        let v0 = 0x2::balance::value<T0>(&arg0.payout);
        let v1 = BountyWithdrawn{
            bounty_id : 0x2::object::id<SponsoredBounty<T0>>(arg0),
            sponsor   : arg0.sponsor,
            amount    : v0,
        };
        0x2::event::emit<BountyWithdrawn>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.payout, v0), arg1), arg0.sponsor);
    }

    // decompiled from Move bytecode v6
}

