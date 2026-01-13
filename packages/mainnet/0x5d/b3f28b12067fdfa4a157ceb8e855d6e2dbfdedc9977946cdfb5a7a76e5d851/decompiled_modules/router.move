module 0x5db3f28b12067fdfa4a157ceb8e855d6e2dbfdedc9977946cdfb5a7a76e5d851::router {
    struct ROUTER has drop {
        dummy_field: bool,
    }

    struct RouterObject has key {
        id: 0x2::object::UID,
    }

    struct OnRampSet has copy, drop {
        dest_chain_selector: u64,
        on_ramp_package_id: address,
    }

    struct RouterState has key {
        id: 0x2::object::UID,
        on_ramp_package_ids: 0x2::vec_map::VecMap<u64, address>,
    }

    struct RouterStatePointer has store, key {
        id: 0x2::object::UID,
        router_object_id: address,
    }

    public fun get_dest_chains(arg0: &RouterState) : vector<u64> {
        0x2::vec_map::keys<u64, address>(&arg0.on_ramp_package_ids)
    }

    public fun get_on_ramp(arg0: &RouterState, arg1: u64) : address {
        assert!(0x2::vec_map::contains<u64, address>(&arg0.on_ramp_package_ids, &arg1), 1);
        *0x2::vec_map::get<u64, address>(&arg0.on_ramp_package_ids, &arg1)
    }

    fun init(arg0: ROUTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = RouterObject{id: 0x2::object::new(arg1)};
        let v1 = RouterState{
            id                  : 0x2::derived_object::claim<vector<u8>>(&mut v0.id, b"RouterState"),
            on_ramp_package_ids : 0x2::vec_map::empty<u64, address>(),
        };
        let v2 = RouterStatePointer{
            id               : 0x2::object::new(arg1),
            router_object_id : 0x2::object::id_address<RouterObject>(&v0),
        };
        let v3 = 0x1::type_name::with_original_ids<ROUTER>();
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::address_string(&v3));
        0x2::transfer::share_object<RouterState>(v1);
        0x2::transfer::share_object<RouterObject>(v0);
        0x2::transfer::transfer<RouterStatePointer>(v2, 0x2::address::from_ascii_bytes(&v4));
    }

    public fun is_chain_supported(arg0: &RouterState, arg1: u64) : bool {
        0x2::vec_map::contains<u64, address>(&arg0.on_ramp_package_ids, &arg1)
    }

    public fun set_on_ramps(arg0: &mut RouterState, arg1: vector<u64>, arg2: vector<address>) {
        assert!(0x1::vector::length<u64>(&arg1) == 0x1::vector::length<address>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1)) {
            let v1 = *0x1::vector::borrow<u64>(&arg1, v0);
            let v2 = *0x1::vector::borrow<address>(&arg2, v0);
            assert!(v2 != @0x0, 3);
            if (0x2::vec_map::contains<u64, address>(&arg0.on_ramp_package_ids, &v1)) {
                let (_, _) = 0x2::vec_map::remove<u64, address>(&mut arg0.on_ramp_package_ids, &v1);
            };
            0x2::vec_map::insert<u64, address>(&mut arg0.on_ramp_package_ids, v1, v2);
            let v5 = OnRampSet{
                dest_chain_selector : v1,
                on_ramp_package_id  : v2,
            };
            0x2::event::emit<OnRampSet>(v5);
            v0 = v0 + 1;
        };
    }

    public fun type_and_version() : 0x1::string::String {
        0x1::string::utf8(b"Router 1.6.0")
    }

    // decompiled from Move bytecode v6
}

