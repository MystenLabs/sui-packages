module 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project_entries {
    public entry fun add_milestone<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::add_milestone<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun add_whitelist<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: vector<address>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::add_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x9acccedc9409023c1eaa33f66616be6d45d90553ef6f1592f4822a913d8f2d86::kyc::Kyc, arg5: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::buy<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun change_admin(arg0: 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: address, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::change_admin(arg0, arg1, arg2);
    }

    public entry fun change_owner<T0, T1>(arg0: address, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::change_owner<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_refund<T0, T1>(arg0: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::claim_refund<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun claim_token<T0, T1>(arg0: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::claim_token<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_project<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: bool, arg10: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::create_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun deposit_token<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::deposit_token<T0, T1>(v0, arg1, arg2, arg3, arg4);
    }

    public entry fun distribute_raised_fund<T0, T1>(arg0: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::distribute_raised_fund<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun end_fund_raising<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::end_fund_raising<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun refund_token_to_owner<T0, T1>(arg0: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::refund_token_to_owner<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: vector<address>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::remove_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun reset_milestone<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::reset_milestone<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun setCliffTime<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: u64, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::setCliffTime<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun setup_project<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: u8, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::setup_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun start_fund_raising<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::start_fund_raising<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun vote<T0, T1>(arg0: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg1: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::vote<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun add_max_allocate<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg4: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::add_max_allocations<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun remove_max_allocate<T0, T1>(arg0: &0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::AdminCap, arg1: vector<address>, arg2: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::Project<T0, T1>, arg3: &mut 0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xe74d8d8235c7dbf9054a4af7c4f9d4ca0a8ab9ad3e7246ad2f44faf6d4d04551::project::clear_max_allocate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

