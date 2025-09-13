module 0xe95fe44edd1433c4cb3d0d54d721269348190865a3b585018e4a4346f3f1866f::package_whitelist_validator {
    struct Validator has key {
        id: 0x2::object::UID,
        whitelist: 0x2::table::Table<address, bool>,
    }

    struct WhitelistAddedEvent has copy, drop {
        package: address,
    }

    public fun add_whitelist<T0: drop>(arg0: &mut Validator, arg1: T0) {
        assert_witness_pattern<T0>();
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<T0>();
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
        let v5 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(v1);
        assert!(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_bytes_until_end(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::skip(&mut v5, v4 - v3)) == v2, 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Validator{
            id        : 0x2::object::new(arg0),
            whitelist : 0x2::table::new<address, bool>(arg0),
        };
        let v1 = 0x1::vector::empty<address>();
        let v2 = &mut v1;
        0x1::vector::push_back<address>(v2, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xa83c62421e71813eeeb8df090f5efb2b1ee47156753447063a4f6c4711904d17::endpoint_v2::EndpointV2>());
        0x1::vector::push_back<address>(v2, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xcc7b3b92261f2bf5484c534e52df550903afa98984641096d507a58013848665::blocked_message_lib::BlockedMessageLib>());
        0x1::vector::push_back<address>(v2, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xe7abf8f9a807d14c91f04dcb4ee3dd3c40559fbd7e54ae3408349ea9a36394e4::simple_message_lib::SimpleMessageLib>());
        0x1::vector::push_back<address>(v2, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xf9a0a4fbe4f83e870fb6c9293018da8584030caa06e2fcc10bc85c09a1bb67be::uln_302::Uln302>());
        0x1::vector::push_back<address>(v2, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::package::package_of_type<0xc8241ec5be82f02e6b0d1bb7fdaed0ba4ae9cc423fe67545fa52466ca80f87cb::treasury::Treasury>());
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

