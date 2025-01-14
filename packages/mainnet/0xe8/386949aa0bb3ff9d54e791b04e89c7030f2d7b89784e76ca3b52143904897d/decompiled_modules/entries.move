module 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::entries {
    public entry fun add_whitelist<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: vector<address>, arg3: vector<u64>, arg4: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::add_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun buy<T0, T1>(arg0: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::buy<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun claim<T0, T1>(arg0: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::claim<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun distribute_fund_to_owner<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::distribute_fund_to_owner<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public entry fun new_project<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: address, arg2: u8, arg3: 0x2::coin::TreasuryCap<T1>, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg9: &mut 0x2::tx_context::TxContext) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::new_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun refund<T0, T1>(arg0: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::refund<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: vector<address>, arg3: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::remove_whitelist<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun setup_project_launch_info<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::setup_project_launch_state<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public entry fun trigger_project_status<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: bool, arg3: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::trigger_project_status<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_liquidity_fund<T0, T1>(arg0: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::AdminCap, arg1: &mut 0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0xe8386949aa0bb3ff9d54e791b04e89c7030f2d7b89784e76ca3b52143904897d::project::withdraw_liquidity_fund<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

