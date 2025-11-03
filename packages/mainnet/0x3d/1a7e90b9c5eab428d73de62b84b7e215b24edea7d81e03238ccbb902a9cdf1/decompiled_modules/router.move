module 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::router {
    public fun cancel_redeem_lock(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>, arg5: &0x2::clock::Clock) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::cancel_redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun convert(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: vector<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>, arg4: u64, arg5: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg6: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::convert(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        if (0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v0) == 0) {
            0x2::coin::destroy_zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(v0, 0x2::tx_context::sender(arg6));
        };
    }

    public fun mint_and_convert(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: vector<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::mint_and_convert(arg0, arg1, arg2, arg3, arg4, arg5);
        if (0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v0) == 0) {
            0x2::coin::destroy_zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(v0, 0x2::tx_context::sender(arg5));
        };
    }

    public fun redeem(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::lock_coin::LockedCoin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        let v0 = 0x2::coin::from_balance<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::redeem(arg0, arg1, arg2, arg3, arg4, arg5, arg6), arg6);
        if (0x2::coin::value<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(&v0) == 0) {
            0x2::coin::destroy_zero<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x5d1f47ea69bb0de31c313d7acf89b890dbb8991ea8e03c6c355171f84bb1ba4a::turbos::TURBOS>>(v0, 0x2::tx_context::sender(arg6));
        };
    }

    public fun redeem_lock(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::LockUpManager, arg2: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg3: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::locking::redeem_lock(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun burn_venft(arg0: &0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::GlobalConfig, arg1: &mut 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::XturbosManager, arg2: 0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::VeNFT, arg3: &mut 0x2::tx_context::TxContext) {
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::global_config::checked_package_version(arg0);
        0x3d1a7e90b9c5eab428d73de62b84b7e215b24edea7d81e03238ccbb902a9cdf1::xturbos::burn_venft(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

