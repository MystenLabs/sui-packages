module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::update_config {
    struct UpdateConfig has copy, drop, store {
        entries: 0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>,
    }

    entry fun execute(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        let UpdateConfig { entries: v0 } = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::execute<UpdateConfig>(arg0, arg1, arg2);
        assert_valid_entries(arg0, &v0);
        let (v1, v2) = 0x2::vec_map::into_keys_values<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v0);
        let v3 = v1;
        let v4 = v2;
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v4);
        assert!(0x1::vector::length<0x1::string::String>(&v3) == 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v4), 13906834505055862783);
        0x1::vector::reverse<0x1::string::String>(&mut v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0x1::string::String>(&v3)) {
            let v6 = 0x1::vector::pop_back<0x1::string::String>(&mut v3);
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::upsert(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config_mut(arg0), *0x1::string::as_bytes(&v6), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v4));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v3);
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v4);
    }

    fun assert_valid_entries(arg0: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>) {
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(*arg1);
        let v2 = v0;
        let v3 = v1;
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v3);
        assert!(0x1::vector::length<0x1::string::String>(&v2) == 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&v3), 13906834552300503039);
        0x1::vector::reverse<0x1::string::String>(&mut v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::string::String>(&v2)) {
            let v5 = 0x1::vector::pop_back<0x1::string::String>(&mut v2);
            let v6 = 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&mut v3);
            assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::is_governable_key(&v5) && 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::is_governable_key(&v5), 13906834560890765318);
            assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::is_valid_config_update(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0), &v5, &v6), 13906834569480437762);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<0x1::string::String>(v2);
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(v3);
    }

    entry fun propose(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(!0x2::vec_map::is_empty<0x1::string::String, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config_value::Value>(&arg2), 13906834419156713476);
        assert_valid_entries(arg0, &arg2);
        let v0 = UpdateConfig{entries: arg2};
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::create<UpdateConfig>(arg0, arg1, v0, 6667, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

