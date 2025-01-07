module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist {
    struct Certificate has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
    }

    public fun new(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Certificate {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        Certificate{
            id         : 0x2::object::new(arg2),
            listing_id : 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing>(arg0),
            venue_id   : arg1,
        }
    }

    public fun assert_certificate(arg0: &Certificate, arg1: 0x2::object::ID) {
        assert!(arg0.venue_id == arg1, 1);
    }

    public fun assert_whitelist(arg0: &Certificate, arg1: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_whitelisted(arg1);
        assert_certificate(arg0, 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(arg1));
    }

    public entry fun burn(arg0: Certificate) {
        let Certificate {
            id         : v0,
            listing_id : _,
            venue_id   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun issue(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Certificate>(new(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

