module 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::market_whitelist {
    struct Whitelist has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
        list: 0x2::vec_set::VecSet<address>,
    }

    struct Certificate has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        venue_id: 0x2::object::ID,
    }

    public fun new(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Certificate {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin_or_member(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        Certificate{
            id         : 0x2::object::new(arg2),
            listing_id : 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing>(arg0),
            venue_id   : arg1,
        }
    }

    public fun add_addresses(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin_or_member(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_whitelist_mut<Whitelist>(arg0, arg1);
        let v1 = 0x1::vector::length<address>(&arg2);
        while (v1 > 0) {
            0x2::vec_set::insert<address>(&mut v0.list, 0x1::vector::pop_back<address>(&mut arg2));
            v1 = v1 - 1;
        };
    }

    public fun add_whitelist(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin_or_member(arg0, arg2);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_whitelisted(0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_venue(arg0, arg1));
        let v0 = Whitelist{
            id         : 0x2::object::new(arg2),
            listing_id : 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing>(arg0),
            venue_id   : arg1,
            list       : 0x2::vec_set::empty<address>(),
        };
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::add_whitelist_internal<Whitelist>(arg0, arg1, v0);
    }

    public fun assert_certificate(arg0: &Certificate, arg1: 0x2::object::ID) {
        assert!(arg0.venue_id == arg1, 1);
    }

    public fun assert_whitelist(arg0: &Certificate, arg1: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::assert_is_whitelisted(arg1);
        assert_certificate(arg0, 0x2::object::id<0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::venue::Venue>(arg1));
    }

    public fun assert_wl_address(arg0: &Whitelist, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.list, &arg1), 2);
    }

    public entry fun burn(arg0: Certificate) {
        let Certificate {
            id         : v0,
            listing_id : _,
            venue_id   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun check_in_address(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : Certificate {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_whitelist_mut<Whitelist>(arg0, arg1);
        assert_wl_address(v1, v0);
        0x2::vec_set::remove<address>(&mut v1.list, &v0);
        Certificate{
            id         : 0x2::object::new(arg2),
            listing_id : v1.listing_id,
            venue_id   : v1.venue_id,
        }
    }

    public entry fun issue(arg0: &0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Certificate>(new(arg0, arg1, arg3), arg2);
    }

    public fun remove_addresses(arg0: &mut 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::Listing, arg1: 0x2::object::ID, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_listing_admin_or_member(arg0, arg3);
        0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::assert_venue(arg0, arg1);
        let v0 = 0xc74531639fadfb02d30f05f37de4cf1e1149ed8d23658edd089004830068180b::listing::borrow_whitelist_mut<Whitelist>(arg0, arg1);
        let v1 = 0x1::vector::length<address>(&arg2);
        while (v1 > 0) {
            let v2 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::vec_set::remove<address>(&mut v0.list, &v2);
            v1 = v1 - 1;
        };
    }

    // decompiled from Move bytecode v6
}

