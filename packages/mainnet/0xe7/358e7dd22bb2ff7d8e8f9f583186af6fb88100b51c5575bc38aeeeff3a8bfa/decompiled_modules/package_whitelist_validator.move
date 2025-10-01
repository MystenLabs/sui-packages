module 0xe7358e7dd22bb2ff7d8e8f9f583186af6fb88100b51c5575bc38aeeeff3a8bfa::package_whitelist_validator {
    struct Validator has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct WhitelistAddedEvent has copy, drop {
        package: address,
    }

    public fun add_whitelist<T0: drop>(arg0: &mut Validator, arg1: T0) {
        assert_witness_pattern<T0>();
        let v0 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<T0>();
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
        let v5 = 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::create(v1);
        assert!(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::read_bytes_until_end(0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::buffer_reader::skip(&mut v5, v4 - v3)) == v2, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Validator{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_v2::EndpointV2>());
        0x1::vector::push_back<address>(v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x54bb7dd5dc12abfaf82616f245e9d4f0e3f737b48699371d17556eaaf874eda1::blocked_message_lib::BlockedMessageLib>());
        0x1::vector::push_back<address>(v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x36c149cb51ec8654906de6ec5a51417113e6117819e0d066ea0a28082df21be1::simple_message_lib::SimpleMessageLib>());
        0x1::vector::push_back<address>(v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0x3ce7457bed48ad23ee5d611dd3172ae4fbd0a22ea0e846782a7af224d905dbb0::uln_302::Uln302>());
        0x1::vector::push_back<address>(v2, 0x245ba36f7a1cc643a2b037450dff1e4399e18069c6545fb5fcaaf37d39d7dc::package::package_of_type<0xc26c5b4189f046e7c0866b29be102e4dae63da8df95c28ea08ae244b814fdf1::treasury::Treasury>());
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

