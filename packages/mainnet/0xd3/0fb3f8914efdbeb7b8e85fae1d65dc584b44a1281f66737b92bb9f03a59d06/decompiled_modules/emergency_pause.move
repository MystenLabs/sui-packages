module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::emergency_pause {
    struct EmergencyPause has copy, drop, store {
        pause: bool,
    }

    entry fun execute(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let EmergencyPause { pause: v0 } = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::execute<EmergencyPause>(arg0, arg1, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::set_paused(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config_mut(arg0), v0);
    }

    entry fun propose(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: bool, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = if (arg2) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::emergency_pause_threshold_bps(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0))
        } else {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::emergency_unpause_threshold_bps(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0))
        };
        let v1 = EmergencyPause{pause: arg2};
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::create<EmergencyPause>(arg0, arg1, v1, v0, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

