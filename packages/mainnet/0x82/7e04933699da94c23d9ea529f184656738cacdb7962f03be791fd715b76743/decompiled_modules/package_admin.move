module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::UpgradeCustody<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::BLAST_FUN>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::authorize_upgrade<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun make_immutable(arg0: &mut PackageAdmin, arg1: &0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::UpgradeAdmin>) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_current(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::make_immutable<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::assert_next(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::commit_upgrade<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::BLAST_FUN>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::advance(arg1);
    }

    public fun wrap(arg0: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::Bootstrap, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::destroy(arg0);
        let v2 = 0x2::object::new(arg2);
        let v3 = PackageAdmin{
            id      : v2,
            custody : 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::new<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::BLAST_FUN>(0x2::object::uid_to_inner(&v2), v0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v3);
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun::share_version(v1, arg2);
    }

    // decompiled from Move bytecode v7
}

