module 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::authority {
    public fun authorize(arg0: &mut 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::OracleAggregatorPythIntegration, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>) {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::add_authorization(0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    public fun deauthorize(arg0: &mut 0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::OracleAggregatorPythIntegration, arg1: &0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::AuthorityCap<0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::PACKAGE, 0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::ADMIN>) {
        0x823642674a8ea1b44355c320af2992081cf3b75221b336abe7a7b32f09b34574::authority::remove_authorization(0xf192a8b05a4fcb766f95a998e6fbe1075e6cdfd09a08e51e44e7fb5fce7da31d::pyth::borrow_mut_id(arg0, arg1), arg1);
    }

    // decompiled from Move bytecode v6
}

