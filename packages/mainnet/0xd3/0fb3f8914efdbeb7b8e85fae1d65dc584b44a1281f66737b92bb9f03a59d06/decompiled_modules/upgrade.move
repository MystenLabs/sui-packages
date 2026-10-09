module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::upgrade {
    struct Upgrade has copy, drop, store {
        digest: vector<u8>,
        exclusive: bool,
    }

    struct UpgradeAuthorization {
        exclusive: bool,
    }

    struct PackageUpgraded has copy, drop {
        package: 0x2::object::ID,
        version: u64,
    }

    entry fun execute(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : (0x2::package::UpgradeTicket, UpgradeAuthorization) {
        let Upgrade {
            digest    : v0,
            exclusive : v1,
        } = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::execute<Upgrade>(arg0, arg1, arg2);
        let v2 = UpgradeAuthorization{exclusive: v1};
        (0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::authorize_upgrade(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning_mut(arg0), v0), v2)
    }

    entry fun finalize_upgrade(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0x2::package::UpgradeReceipt, arg2: UpgradeAuthorization) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let UpgradeAuthorization { exclusive: v0 } = arg2;
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::commit_upgrade(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning_mut(arg0), arg1, v0);
        let v1 = PackageUpgraded{
            package : 0x2::package::receipt_package(&arg1),
            version : 0x2::package::version(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::upgrade_cap(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0))),
        };
        0x2::event::emit<PackageUpgraded>(v1);
    }

    entry fun propose(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<u8>, arg3: bool, arg4: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        let v0 = Upgrade{
            digest    : arg2,
            exclusive : arg3,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposal::create<Upgrade>(arg0, arg1, v0, 6667, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

