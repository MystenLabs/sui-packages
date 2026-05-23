module 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::manage {
    public fun history_batch_import(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::history::HistoryStore, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::history::batch_import_users(arg1, arg2, arg3, arg4);
    }

    public fun history_set_robot(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::history::HistoryStore, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::history::set_robot(arg1, arg2);
    }

    public fun init_contract<T0>(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::sunset::init_contract<T0>(arg1, arg2);
    }

    public fun lottery_create_default<T0>(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::create_default<T0>(1000000000, 10000, arg1);
    }

    public fun lottery_set_admin<T0>(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::Lottery<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::set_admin<T0>(arg1, arg2);
    }

    public fun lottery_set_prize_weights_bps<T0>(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::Lottery<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::admin_set_prize_weights_bps<T0>(arg1, arg2);
    }

    public fun lottery_upgrade_version<T0>(arg0: &0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::owner::OwnerCap, arg1: &mut 0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::Lottery<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x348ee392e8c34b98b3d0d0c6b976f76eeb2ee205b68e153b3e6373c989a94c61::lottery::upgrade_version<T0>(arg1);
    }

    // decompiled from Move bytecode v7
}

