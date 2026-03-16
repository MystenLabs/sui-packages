module 0x56dd1789976cf838cd5040f957a54117d05daf51c6696aa74bd84a016830e177::conditional_coin_utils {
    public fun assert_zero_supply<T0>(arg0: &0x2::coin::TreasuryCap<T0>) {
        assert!(0x2::coin::total_supply<T0>(arg0) == 0, 0);
    }

    public fun build_conditional_description(arg0: &0x1::ascii::String, arg1: u64, arg2: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Conditional coin for ");
        0x1::string::append_utf8(&mut v0, *0x1::ascii::as_bytes(arg0));
        0x1::string::append_utf8(&mut v0, b". Outcome ");
        0x1::string::append_utf8(&mut v0, u64_to_string(arg1));
        0x1::string::append_utf8(&mut v0, b" redeemable for ");
        0x1::string::append(&mut v0, *arg2);
        0x1::string::append_utf8(&mut v0, b" if this outcome wins.");
        v0
    }

    public fun build_conditional_name(arg0: u64, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Conditional ");
        0x1::string::append_utf8(&mut v0, u64_to_string(arg0));
        0x1::string::append_utf8(&mut v0, b": ");
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public fun build_conditional_symbol(arg0: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::ConditionalCoinConfig, arg1: u64, arg2: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        let v1 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::coin_name_prefix(arg0);
        if (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x1::ascii::String>(v1);
            0x1::string::append_utf8(&mut v0, *0x1::ascii::as_bytes(&v2));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(v1);
        };
        if (0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::use_outcome_index(arg0)) {
            0x1::string::append_utf8(&mut v0, u64_to_string(arg1));
            0x1::string::append_utf8(&mut v0, b"_");
        };
        0x1::string::append(&mut v0, *arg2);
        v0
    }

    public fun build_conditional_symbol_ascii(arg0: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::ConditionalCoinConfig, arg1: u64, arg2: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::coin_name_prefix(arg0);
        if (0x1::option::is_some<0x1::ascii::String>(&v1)) {
            let v2 = 0x1::option::destroy_some<0x1::ascii::String>(v1);
            0x1::vector::append<u8>(&mut v0, *0x1::ascii::as_bytes(&v2));
        } else {
            0x1::option::destroy_none<0x1::ascii::String>(v1);
        };
        if (0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::use_outcome_index(arg0)) {
            0x1::vector::append<u8>(&mut v0, u64_to_string(arg1));
            0x1::vector::push_back<u8>(&mut v0, 95);
        };
        0x1::vector::append<u8>(&mut v0, *0x1::ascii::as_bytes(arg2));
        0x1::ascii::string(v0)
    }

    public fun is_supply_zero<T0>(arg0: &0x2::coin::TreasuryCap<T0>) : bool {
        0x2::coin::total_supply<T0>(arg0) == 0
    }

    public fun u64_to_ascii(arg0: u64) : 0x1::ascii::String {
        0x1::ascii::string(u64_to_string(arg0))
    }

    public fun u64_to_string(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun update_conditional_metadata<T0>(arg0: &mut 0x2::coin_registry::Currency<T0>, arg1: &0x2::coin_registry::MetadataCap<T0>, arg2: &0xb531dc736197e5da808ab10d7d010978e7160547362ed8f8d93baca4e24069a::dao_config::ConditionalCoinConfig, arg3: u64, arg4: &0x1::ascii::String, arg5: &0x1::string::String, arg6: &0x1::ascii::String, arg7: &0x1::ascii::String) {
        0x2::coin_registry::set_name<T0>(arg0, arg1, build_conditional_name(arg3, arg5));
        0x2::coin_registry::set_description<T0>(arg0, arg1, build_conditional_description(arg4, arg3, arg5));
        if (!0x1::ascii::is_empty(arg7)) {
            0x2::coin_registry::set_icon_url<T0>(arg0, arg1, 0x1::string::utf8(*0x1::ascii::as_bytes(arg7)));
        };
    }

    // decompiled from Move bytecode v6
}

