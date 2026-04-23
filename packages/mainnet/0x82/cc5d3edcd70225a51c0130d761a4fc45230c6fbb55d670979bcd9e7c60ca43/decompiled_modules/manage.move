module 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::manage {
    public fun lottery_admin_set_active<T0>(arg0: &0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::dapp::AdminCap, arg1: &mut 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::Lottery<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::admin_set_active<T0>(arg1, arg2);
    }

    public fun lottery_create_default<T0>(arg0: &0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::dapp::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::create_default<T0>(1000000000, 10000, arg1);
    }

    public fun lottery_set_admin<T0>(arg0: &0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::dapp::AdminCap, arg1: &mut 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::Lottery<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::set_admin<T0>(arg1, arg2);
    }

    public fun lottery_upgrade_version<T0>(arg0: &0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::dapp::AdminCap, arg1: &mut 0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::Lottery<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x56ee956e8784a11c548990367c2cf164474cf843ecbbe918cab634916aa5384f::lottery::upgrade_version<T0>(arg1);
    }

    // decompiled from Move bytecode v7
}

