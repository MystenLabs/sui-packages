module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config {
    struct Config has copy, drop, store {
        config: 0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>,
    }

    public(friend) fun empty() : Config {
        Config{config: 0x2::vec_map::empty<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>()}
    }

    public(friend) fun contains(arg0: &Config, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(arg1);
        0x2::vec_map::contains<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, &v0)
    }

    public(friend) fun get(arg0: &Config, arg1: vector<u8>) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value {
        let v0 = 0x1::string::utf8(arg1);
        *0x2::vec_map::get<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, &v0)
    }

    public(friend) fun create() : Config {
        let v0 = empty();
        let v1 = &mut v0;
        upsert(v1, b"paused", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_bool(false));
        let v2 = &mut v0;
        upsert(v2, b"reconfig_hold", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_bool(false));
        let v3 = &mut v0;
        upsert(v3, b"governance_emergency_pause_threshold_bps", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(500));
        let v4 = &mut v0;
        upsert(v4, b"governance_emergency_unpause_threshold_bps", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_u64(6667));
        v0
    }

    public(friend) fun emergency_pause_threshold_bps(arg0: &Config) : u64 {
        let v0 = try_get(arg0, b"governance_emergency_pause_threshold_bps");
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
            500
        }
    }

    public(friend) fun emergency_unpause_threshold_bps(arg0: &Config) : u64 {
        let v0 = try_get(arg0, b"governance_emergency_unpause_threshold_bps");
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
            6667
        }
    }

    public(friend) fun guardian_btc_public_key(arg0: &Config) : 0x1::option::Option<vector<u8>> {
        let v0 = try_get(arg0, b"guardian_btc_public_key");
        if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<vector<u8>>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_bytes(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<vector<u8>>()
        }
    }

    public(friend) fun guardian_node_url(arg0: &Config) : 0x1::option::Option<0x1::string::String> {
        let v0 = try_get(arg0, b"guardian_node_url");
        if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<0x1::string::String>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_string(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<0x1::string::String>()
        }
    }

    public(friend) fun guardian_url(arg0: &Config) : 0x1::option::Option<0x1::string::String> {
        let v0 = try_get(arg0, b"guardian_url");
        if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<0x1::string::String>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_string(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<0x1::string::String>()
        }
    }

    public(friend) fun is_governable_key(arg0: &0x1::string::String) : bool {
        let v0 = b"guardian_btc_public_key";
        0x1::string::as_bytes(arg0) != &v0
    }

    public(friend) fun is_valid_config_update(arg0: &Config, arg1: &0x1::string::String, arg2: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value) : bool {
        if (!0x2::vec_map::contains<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, arg1)) {
            return false
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::same_variant(0x2::vec_map::get<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, arg1), arg2)
    }

    public(friend) fun paused(arg0: &Config) : bool {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_bool(get(arg0, b"paused"))
    }

    public(friend) fun reconfig_hold(arg0: &Config) : bool {
        let v0 = try_get(arg0, b"reconfig_hold");
        let v1 = if (0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v0)) {
            0x1::option::some<bool>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::as_bool(0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0)))
        } else {
            0x1::option::destroy_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
            0x1::option::none<bool>()
        };
        let v2 = v1;
        if (0x1::option::is_some<bool>(&v2)) {
            0x1::option::destroy_some<bool>(v2)
        } else {
            0x1::option::destroy_none<bool>(v2);
            false
        }
    }

    public(friend) fun set_guardian_btc_public_key(arg0: &mut Config, arg1: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13835058811197063179);
        let v0 = guardian_btc_public_key(arg0);
        if (0x1::option::is_some<vector<u8>>(&v0)) {
            assert!(0x1::option::destroy_some<vector<u8>>(v0) == arg1, 13835340299058806797);
        } else {
            0x1::option::destroy_none<vector<u8>>(v0);
        };
        upsert(arg0, b"guardian_btc_public_key", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_bytes(arg1));
    }

    public(friend) fun set_guardian_node_url(arg0: &mut Config, arg1: 0x1::string::String) {
        upsert(arg0, b"guardian_node_url", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_string(arg1));
    }

    public(friend) fun set_guardian_url(arg0: &mut Config, arg1: 0x1::string::String) {
        upsert(arg0, b"guardian_url", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_string(arg1));
    }

    public(friend) fun set_paused(arg0: &mut Config, arg1: bool) {
        upsert(arg0, b"paused", 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::new_bool(arg1));
    }

    public(friend) fun try_get(arg0: &Config, arg1: vector<u8>) : 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value> {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::vec_map::contains<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, &v0)) {
            0x1::option::some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(*0x2::vec_map::get<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, &v0))
        } else {
            0x1::option::none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>()
        }
    }

    public(friend) fun upsert(arg0: &mut Config, arg1: vector<u8>, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value) {
        let v0 = 0x1::string::utf8(arg1);
        if (0x2::vec_map::contains<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg0.config, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut arg0.config, &v0);
        };
        0x2::vec_map::insert<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut arg0.config, v0, arg2);
    }

    // decompiled from Move bytecode v7
}

