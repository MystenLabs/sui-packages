module 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird_entries {
    public fun breakEgg(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::breakEgg(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun change_admin(arg0: 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::BirdAdminCap, arg1: address, arg2: &mut 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::version::Version) {
        0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::change_admin(arg0, arg1, arg2);
    }

    public fun checkIn(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::BirdStore, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird::checkIn(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

