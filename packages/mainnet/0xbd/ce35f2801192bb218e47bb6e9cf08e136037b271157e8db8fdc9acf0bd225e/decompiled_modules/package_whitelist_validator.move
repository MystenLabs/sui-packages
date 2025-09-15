module 0xbdce35f2801192bb218e47bb6e9cf08e136037b271157e8db8fdc9acf0bd225e::package_whitelist_validator {
    struct Validator has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct WhitelistAddedEvent has copy, drop {
        package: address,
    }

    public fun add_whitelist<T0: drop>(arg0: &mut Validator, arg1: T0) {
        assert_witness_pattern<T0>();
        let v0 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<T0>();
        0x2::table::add<address, bool>(&mut arg0.whitelist, v0, true);
        let v1 = WhitelistAddedEvent{package: v0};
        0x2::event::emit<WhitelistAddedEvent>(v1);
    }

    fun assert_witness_pattern<T0>() {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 1);
        let v1 = 0x1::ascii::into_bytes(0x1::type_name::into_string(v0));
        let v2 = b"_witness::LayerZeroWitness";
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = 0x1::vector::length<u8>(&v1);
        assert!(v4 >= v3, 1);
        let v5 = 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::create(v1);
        assert!(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::read_bytes_until_end(0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::buffer_reader::skip(&mut v5, v4 - v3)) == v2, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Validator{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0xf625a8bde20d64850a4ec7b01c1918d9a0a29495546de7a0144440275f9b933c::endpoint_v2::EndpointV2>());
        0x1::vector::push_back<address>(v2, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x9f6107b708d7650b1484ae10cb98340af343f46bd63793ea91c2379bab9a7abb::blocked_message_lib::BlockedMessageLib>());
        0x1::vector::push_back<address>(v2, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0x83651370065f70112b20007137c7235a2a243055d9f59cb5e162c00c4a1680a7::simple_message_lib::SimpleMessageLib>());
        0x1::vector::push_back<address>(v2, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0xd73c9d588717c32fa327335d9beaf59b983b808577a382e013d8c7161a323d8e::uln_302::Uln302>());
        0x1::vector::push_back<address>(v2, 0xcdad05867c25d6461e5813071116fa3f26d56a9b52ad053747457efb79d45714::package::package_of_type<0xcb8bc76ad2dde43cb83fe4f27a702df0874e99c047317251ee878893c17c83c5::treasury::Treasury>());
        0x1::vector::reverse<address>(&mut v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&v1)) {
            let v4 = 0x1::vector::pop_back<address>(&mut v1);
            let v5 = &mut v0.whitelist;
            if (0x2::table::contains<address, bool>(v5, v4)) {
                *0x2::table::borrow_mut<address, bool>(v5, v4) = true;
            } else {
                0x2::table::add<address, bool>(v5, v4, true);
            };
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        0x2::transfer::share_object<Validator>(v0);
    }

    public fun is_whitelisted(arg0: &Validator, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.whitelist, arg1)
    }

    public fun validate(arg0: &Validator, arg1: vector<address>) : bool {
        let v0 = &arg1;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<address>(v0)) {
            if (!is_whitelisted(arg0, *0x1::vector::borrow<address>(v0, v1))) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    // decompiled from Move bytecode v6
}

