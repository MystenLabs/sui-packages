module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_config {
    public(friend) fun init_defaults(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"mpc_weight_reduction_allowed_delta", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(800));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"mpc_max_faulty_in_basis_points", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(3333));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(arg0, b"mpc_nonce_accumulation_window_ms", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(2000));
    }

    public(friend) fun is_consistent(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : bool {
        weight_reduction_allowed_delta(arg0) < max_faulty_in_basis_points(arg0)
    }

    public(friend) fun is_valid_value(arg0: &0x1::string::String, arg1: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = b"mpc_threshold_in_basis_points";
        if (v0 == &v1) {
            false
        } else {
            let v3 = b"mpc_weight_reduction_allowed_delta";
            if (v0 == &v3) {
                0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::is_u64(arg1) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(*arg1) <= 10000
            } else {
                let v4 = b"mpc_max_faulty_in_basis_points";
                if (v0 == &v4) {
                    if (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::is_u64(arg1)) {
                        if (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(*arg1) > 0) {
                            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(*arg1) <= 3333
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    let v5 = b"mpc_nonce_generation_protocol";
                    if (v0 == &v5) {
                        false
                    } else {
                        let v6 = b"mpc_nonce_accumulation_window_ms";
                        v0 == &v6 && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::is_u64(arg1) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(*arg1) <= 10000 || true
                    }
                }
            }
        }
    }

    public(friend) fun max_faulty_in_basis_points(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::try_get(arg0, b"mpc_max_faulty_in_basis_points");
        let v1 = if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::destroy_some<u64>(v2)
        } else {
            0x1::option::destroy_none<u64>(v2);
            3333
        }
    }

    public(friend) fun nonce_accumulation_window_ms(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::try_get(arg0, b"mpc_nonce_accumulation_window_ms");
        let v1 = if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::destroy_some<u64>(v2)
        } else {
            0x1::option::destroy_none<u64>(v2);
            2000
        }
    }

    public(friend) fun weight_reduction_allowed_delta(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config) : u64 {
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::try_get(arg0, b"mpc_weight_reduction_allowed_delta");
        let v1 = if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_u64(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        if (0x1::option::is_some<u64>(&v2)) {
            0x1::option::destroy_some<u64>(v2)
        } else {
            0x1::option::destroy_none<u64>(v2);
            800
        }
    }

    // decompiled from Move bytecode v7
}

