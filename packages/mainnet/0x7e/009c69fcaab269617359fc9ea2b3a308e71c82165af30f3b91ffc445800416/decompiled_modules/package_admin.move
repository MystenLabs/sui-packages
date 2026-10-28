module 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::UpgradeCustody<0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::BLAST_FUN_MIGRATORS>,
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::UpgradeAdmin>, arg3: vector<u8>) : 0x2::package::UpgradeTicket {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_current(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::authorize_upgrade<0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::BLAST_FUN_MIGRATORS>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3)
    }

    public fun commit_upgrade_and_advance(arg0: &mut PackageAdmin, arg1: &mut 0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::PackageVersion, arg2: &0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::blast_acl::AdminWitness<0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_fun_domain::UpgradeAdmin>, arg3: 0x2::package::UpgradeReceipt) {
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::assert_next(arg1);
        0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::commit_upgrade<0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::BLAST_FUN_MIGRATORS>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg3);
        0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::advance(arg1);
    }

    public fun wrap(arg0: 0x2::package::Publisher, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = PackageAdmin{
            id      : v0,
            custody : 0x2136ba8efa373b04d237c4eb5154d240f526e65f27a06164e88e9513d28f50df::upgrade_custody::new<0x7e009c69fcaab269617359fc9ea2b3a308e71c82165af30f3b91ffc445800416::blast_fun_migrators::BLAST_FUN_MIGRATORS>(0x2::object::uid_to_inner(&v0), arg0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v1);
    }

    // decompiled from Move bytecode v7
}

