module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::add_config {
    struct AddConfig has copy, drop, store {
        epoch: bool,
        entries: 0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>,
    }

    fun assert_valid_entries(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: bool, arg2: &0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>) {
        let v0 = if (arg1) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::epoch_config(arg0)
        } else {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)
        };
        let (v1, v2) = 0x2::vec_map::into_keys_values<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(*arg2);
        let v3 = v1;
        let v4 = v2;
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v4);
        assert!(0x1::vector::length<0x1::string::String>(&v3) == 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v4), 13906834646789783551);
        0x1::vector::reverse<0x1::string::String>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let v6 = 0x1::vector::pop_back<0x1::string::String>(&mut v3);
            let v7 = 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v4);
            assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::is_governable_key(&v6) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::is_governable_key(&v6), 13835902969839026184);
            assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::contains(v0, *0x1::string::as_bytes(&v6)), 13835058553498435586);
            assert!(!arg1 || 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_config::is_valid_value(&v6, &v7), 13835340032770244612);
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v3);
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v4);
    }

    entry fun execute(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let AddConfig {
            epoch   : v0,
            entries : v1,
        } = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::execute<AddConfig>(arg0, arg1, arg2);
        let v2 = v1;
        assert_valid_entries(arg0, v0, &v2);
        let (v3, v4) = 0x2::vec_map::into_keys_values<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v2);
        let v5 = if (v0) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::epoch_config_mut(arg0)
        } else {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config_mut(arg0)
        };
        let v6 = v3;
        let v7 = v4;
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v7);
        assert!(0x1::vector::length<0x1::string::String>(&v6) == 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v7), 13906834582365274111);
        0x1::vector::reverse<0x1::string::String>(&mut v6);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x1::string::String>(&v6)) {
            let v9 = 0x1::vector::pop_back<0x1::string::String>(&mut v6);
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(v5, *0x1::string::as_bytes(&v9), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v7));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v6);
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v7);
        if (v0) {
            assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_config::is_consistent(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::epoch_config(arg0)), 13836184376096391178);
        };
    }

    entry fun propose(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: bool, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(!0x2::vec_map::is_empty<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg3), 13835621318768525318);
        assert_valid_entries(arg0, arg2, &arg3);
        let v0 = AddConfig{
            epoch   : arg2,
            entries : arg3,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::create<AddConfig>(arg0, arg1, v0, 6667, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

