module 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::entries {
    public entry fun add_whitelist<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: bool, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::add_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun buy<T0, T1>(arg0: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg1: bool, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::buy<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun claim<T0, T1>(arg0: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::claim<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun distribute_fund_to_owner<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::distribute_fund_to_owner<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun new_project<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: address, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::new_project<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public entry fun refund<T0, T1>(arg0: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::refund<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public entry fun remove_whitelist<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: bool, arg3: vector<address>, arg4: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::remove_whitelist<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun setup_project_launch_info<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::update_round_info<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public entry fun trigger_project_status<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: bool, arg3: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::trigger_project_status<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_liquidity_fund<T0, T1>(arg0: &0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::AdminCap, arg1: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::Project<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x3194ddba23b96d324c3583c38065abfb058cba322f41e344b638aa13c9b08ba::project::withdraw_liquidity_fund<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

