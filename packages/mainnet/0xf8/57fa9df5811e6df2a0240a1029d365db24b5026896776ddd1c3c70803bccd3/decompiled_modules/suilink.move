module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink {
    struct SUILINK has drop {
        dummy_field: bool,
    }

    struct SuiLink<phantom T0> has key {
        id: 0x2::object::UID,
        network_address: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiLinkRegistry has key {
        id: 0x2::object::UID,
        registry: 0x2::vec_set::VecSet<vector<u8>>,
    }

    public fun delete<T0>(arg0: &mut SuiLinkRegistry, arg1: SuiLink<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, 0x2::address::to_bytes(0x2::tx_context::sender(arg2)));
        0x1::vector::push_back<vector<u8>>(v1, *0x1::string::bytes(&arg1.network_address));
        let v2 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v0);
        let v3 = 0x2::hash::blake2b256(&v2);
        0x2::vec_set::remove<vector<u8>>(&mut arg0.registry, &v3);
        let SuiLink {
            id              : v4,
            network_address : _,
            timestamp_ms    : _,
        } = arg1;
        0x2::object::delete(v4);
    }

    fun init(arg0: SUILINK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUILINK>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = SuiLinkRegistry{
            id       : 0x2::object::new(arg1),
            registry : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<SuiLinkRegistry>(v1);
    }

    public(friend) fun mint<T0>(arg0: &mut SuiLinkRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = &mut v1;
        0x1::vector::push_back<vector<u8>>(v2, 0x2::bcs::to_bytes<address>(&v0));
        0x1::vector::push_back<vector<u8>>(v2, *0x1::string::bytes(&arg1));
        let v3 = 0x2::bcs::to_bytes<vector<vector<u8>>>(&v1);
        let v4 = 0x2::hash::blake2b256(&v3);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.registry, &v4), 0);
        0x2::vec_set::insert<vector<u8>>(&mut arg0.registry, v4);
        let v5 = SuiLink<T0>{
            id              : 0x2::object::new(arg3),
            network_address : arg1,
            timestamp_ms    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::transfer<SuiLink<T0>>(v5, v0);
    }

    // decompiled from Move bytecode v6
}

