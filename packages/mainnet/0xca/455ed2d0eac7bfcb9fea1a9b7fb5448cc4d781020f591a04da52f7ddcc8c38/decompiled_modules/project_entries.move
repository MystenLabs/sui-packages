module 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project_entries {
    public entry fun add_milestone<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::add_milestone<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun add_whitelist<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: vector<address>, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::add_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x796f7746cc6727c64c4642bf348e5bfdb7b93b96b696d1d99630944340a0b31d::kyc::Kyc, arg5: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg0);
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::buy<T0, T1>(v0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun change_admin(arg0: 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: address, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::change_admin(arg0, arg1, arg2);
    }

    public entry fun change_owner<T0, T1>(arg0: address, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::change_owner<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_refund<T0, T1>(arg0: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::claim_refund<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun claim_token<T0, T1>(arg0: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::claim_token<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_project<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u8, arg9: bool, arg10: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::create_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun deposit_token<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: u64, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v0, arg0);
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::deposit_token<T0, T1>(v0, arg1, arg2, arg3, arg4);
    }

    public entry fun distribute_raised_fund<T0, T1>(arg0: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::distribute_raised_fund<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun end_fund_raising<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::end_fund_raising<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun refund_token_to_owner<T0, T1>(arg0: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::refund_token_to_owner<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: vector<address>, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::remove_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun reset_milestone<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::reset_milestone<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun setup_project<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: u8, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::setup_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    }

    public entry fun start_fund_raising<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::start_fund_raising<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun vote<T0, T1>(arg0: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg1: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::vote<T0, T1>(arg0, arg1, arg2);
    }

    public entry fun add_max_allocate<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg4: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::add_max_allocations<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun remove_max_allocate<T0, T1>(arg0: &0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::AdminCap, arg1: vector<address>, arg2: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::Project<T0, T1>, arg3: &mut 0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xca455ed2d0eac7bfcb9fea1a9b7fb5448cc4d781020f591a04da52f7ddcc8c38::project::clear_max_allocate<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

