module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::ignore_member {
    struct IgnoreMember has copy, drop, store {
        validator_address: address,
        ignored: bool,
    }

    entry fun execute(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let IgnoreMember {
            validator_address : v0,
            ignored           : v1,
        } = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::execute<IgnoreMember>(arg0, arg1, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::set_member_ignored(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set_mut(arg0), v0, v1);
    }

    entry fun propose(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: address, arg3: bool, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::has_member(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg2), 13835058351634972674);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::is_member_ignored(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0), arg2) != arg3, 13835339839496716292);
        let v0 = IgnoreMember{
            validator_address : arg2,
            ignored           : arg3,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::create<IgnoreMember>(arg0, arg1, v0, 6667, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

