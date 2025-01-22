module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::address_tracker {
    struct InterchainAddressTracker has store {
        trusted_addresses: 0x2::table::Table<0x1::ascii::String, 0x1::ascii::String>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : InterchainAddressTracker {
        InterchainAddressTracker{trusted_addresses: 0x2::table::new<0x1::ascii::String, 0x1::ascii::String>(arg0)}
    }

    public(friend) fun is_trusted_address(arg0: &InterchainAddressTracker, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) : bool {
        0x2::table::contains<0x1::ascii::String, 0x1::ascii::String>(&arg0.trusted_addresses, arg1) && *0x2::table::borrow<0x1::ascii::String, 0x1::ascii::String>(&arg0.trusted_addresses, arg1) == arg2
    }

    public(friend) fun remove_trusted_address(arg0: &mut InterchainAddressTracker, arg1: 0x1::ascii::String) {
        assert!(0x1::ascii::length(&arg1) > 0, 9223372358977454083);
        0x2::table::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.trusted_addresses, arg1);
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::trusted_address_removed(arg1);
    }

    public(friend) fun set_trusted_address(arg0: &mut InterchainAddressTracker, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        assert!(0x1::ascii::length(&arg1) > 0, 9223372294552944643);
        assert!(0x1::ascii::length(&arg2) > 0, 9223372298848043013);
        if (0x2::table::contains<0x1::ascii::String, 0x1::ascii::String>(&arg0.trusted_addresses, arg1)) {
            *0x2::table::borrow_mut<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.trusted_addresses, arg1) = arg2;
        } else {
            0x2::table::add<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.trusted_addresses, arg1, arg2);
        };
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::events::trusted_address_set(arg1, arg2);
    }

    public(friend) fun trusted_address(arg0: &InterchainAddressTracker, arg1: 0x1::ascii::String) : &0x1::ascii::String {
        assert!(0x2::table::contains<0x1::ascii::String, 0x1::ascii::String>(&arg0.trusted_addresses, arg1), 9223372182883663873);
        0x2::table::borrow<0x1::ascii::String, 0x1::ascii::String>(&arg0.trusted_addresses, arg1)
    }

    // decompiled from Move bytecode v6
}

