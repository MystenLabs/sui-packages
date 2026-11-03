module 0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::package_admin {
    struct PackageAdmin has key {
        id: 0x2::object::UID,
        custody: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::upgrade_custody::UpgradeCustody<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>,
    }

    public fun activate_upgrade(arg0: &mut 0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::Protocol, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x1e952ddf74692433ce8c36164d7b625c1f9d6b921d4900c7fba2abf1f9ca8cd4::blast_boosts_core::UpgradeAdmin>) {
        0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::activate(arg0);
    }

    public fun authorize_upgrade(arg0: &mut PackageAdmin, arg1: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x1e952ddf74692433ce8c36164d7b625c1f9d6b921d4900c7fba2abf1f9ca8cd4::blast_boosts_core::UpgradeAdmin>, arg2: vector<u8>) : 0x2::package::UpgradeTicket {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::upgrade_custody::authorize_upgrade<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg2)
    }

    public fun commit_upgrade(arg0: &mut PackageAdmin, arg1: 0x2::package::UpgradeReceipt) {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::upgrade_custody::commit_upgrade<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id), arg1);
    }

    public fun make_immutable(arg0: &mut PackageAdmin, arg1: &0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::Protocol, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x1e952ddf74692433ce8c36164d7b625c1f9d6b921d4900c7fba2abf1f9ca8cd4::blast_boosts_core::UpgradeAdmin>) {
        0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::assert_current(arg1);
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::upgrade_custody::make_immutable<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&mut arg0.custody, 0x2::object::uid_to_inner(&arg0.id));
    }

    public fun wrap(arg0: 0x2::package::Publisher, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(&arg0), 0);
        let v0 = 0x2::object::new(arg2);
        let v1 = PackageAdmin{
            id      : v0,
            custody : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::upgrade_custody::new<0x9c7dae2711c81ada1747768de2b20bbbec474f8c6bcfb28b510f2dc4935e83c5::blast_boosts_aftermath::BLAST_BOOSTS_AFTERMATH>(0x2::object::uid_to_inner(&v0), arg0, arg1),
        };
        0x2::transfer::share_object<PackageAdmin>(v1);
    }

    // decompiled from Move bytecode v7
}

