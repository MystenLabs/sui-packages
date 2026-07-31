module 0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::upgrades {
    struct UpgradeCap has store, key {
        id: 0x2::object::UID,
        cap: 0x2::package::UpgradeCap,
    }

    struct VersionGated {
        dummy_field: bool,
    }

    public fun authorize_upgrade(arg0: &mut UpgradeCap, arg1: vector<u8>) : 0x2::package::UpgradeTicket {
        0x2::package::authorize_upgrade(&mut arg0.cap, 0x2::package::upgrade_policy(&arg0.cap), arg1)
    }

    public fun commit_upgrade<T0>(arg0: &mut UpgradeCap, arg1: &mut 0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::state::State<T0>, arg2: 0x2::package::UpgradeReceipt) {
        0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::state::set_version<T0>(arg1, 0);
        0x2::package::commit_upgrade(&mut arg0.cap, arg2);
    }

    public fun check_version<T0>(arg0: VersionGated, arg1: &0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::state::State<T0>) {
        let VersionGated {  } = arg0;
        if (0xd8be17c7bcbc92cc57a737d60f1a047c5871108789603bdac56ea38d637938d8::state::get_version<T0>(arg1) != 0) {
            abort 13906834496465993730
        };
    }

    public fun new_upgrade_cap(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) : UpgradeCap {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::package_utils::assert_package_upgrade_cap<UpgradeCap>(&arg0, 0x2::package::compatible_policy(), 1);
        UpgradeCap{
            id  : 0x2::object::new(arg1),
            cap : arg0,
        }
    }

    public fun new_version_gated() : VersionGated {
        VersionGated{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

