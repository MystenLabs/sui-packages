module 0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::market_whitelist {
    struct Certificate has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
    }

    public fun new(arg0: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Certificate {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::assert_listing_admin(arg0, arg2);
        Certificate{
            id         : 0x2::object::new(arg2),
            listing_id : 0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::Listing>(arg0),
            venue_id   : arg1,
        }
    }

    public fun assert_certificate(arg0: &Certificate, arg1: 0x2::object::ID) {
        assert!(arg0.venue_id == arg1, 1);
    }

    public fun assert_whitelist(arg0: &Certificate, arg1: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue) {
        0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::assert_is_whitelisted(arg1);
        assert_certificate(arg0, 0x2::object::id<0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::venue::Venue>(arg1));
    }

    public entry fun burn(arg0: Certificate) {
        let Certificate {
            id         : v0,
            listing_id : _,
            venue_id   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun issue(arg0: &0x2be8c4a1a3cea4d3255d870d367c87838a8cc2bfe4f216a6b67b153027087a7::listing::Listing, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Certificate>(new(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

