module 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::upgrade_custody::UpgradeCustody<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>,
    }

    public fun activate_upgrade(arg0: &mut 0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::Protocol, arg1: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::UpgradeAdmin>) {
        0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::activate(arg0);
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::UpgradeAdmin>, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::upgrade_custody::authorize_upgrade<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg2)
    }

    public fun commit_upgrade(arg0: &mut PackageAdmin, arg1: 0x2::package::UpgradeReceipt) {
        0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::upgrade_custody::commit_upgrade<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public fun make_immutable(arg0: &mut PackageAdmin, arg1: &0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::Protocol, arg2: &0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::blast_acl::AdminWitness<0xda77d01152ec690f82fd23a92255e54d2de0d9c3f8559ea987d784e0f8a7f4bb::blast_boosts_core::UpgradeAdmin>) {
        0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::assert_current(arg1);
        0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::upgrade_custody::make_immutable<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun wrap(arg0: 0x2::package::Publisher, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&arg0), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = PackageAdmin{
            id      : v0,
            custody : 0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::upgrade_custody::new<0x18925d13848d526ff14d5226ee8327357471311bef4d8a4a259ef74083d1496e::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(0x2::object::uid_to_inner(&v0), arg0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v1);
    }

    // decompiled from Move bytecode v7
}

