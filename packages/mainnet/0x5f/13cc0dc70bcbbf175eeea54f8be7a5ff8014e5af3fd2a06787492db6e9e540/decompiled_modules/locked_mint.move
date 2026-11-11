module 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::locked_mint {
    public fun admin_void<T0, T1>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: &0x2::clock::Clock) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::admin_void<T0, T1>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun bucket_count<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::bucket_count<T0, T1>(arg0, arg1)
    }

    public fun claim_epochs() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::claim_epochs()
    }

    public fun entries<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address) : (vector<u64>, vector<u64>) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::entries<T0, T1>(arg0, arg1)
    }

    public fun entry_vests<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address) : vector<u64> {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::entry_vests<T0, T1>(arg0, arg1)
    }

    public fun exit_early<T0, T1>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0));
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::exit_early<T0, T1>(&v0, arg0, arg1, arg2)
    }

    public fun exit_early_bounded<T0, T1>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x2::clock::Clock, arg2: vector<u64>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0));
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::exit_early_bounded<T0, T1>(&v0, arg0, arg1, arg2, arg3, arg4)
    }

    public fun fits<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address, arg2: u64, arg3: &vector<u64>) : bool {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::fits<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun forfeits<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::forfeits<T0, T1>(arg0)
    }

    public fun lock<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::lock<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun lock_loss<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::lock_loss<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun lock_ms() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::lock_ms()
    }

    public fun lock_reserved<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: vector<0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::Part>, arg6: vector<0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::EpochBasis>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::lock_reserved<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun locked_balance<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::locked_balance<T0, T1>(arg0, arg1)
    }

    public fun max_buckets() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::max_buckets()
    }

    public fun max_lock_ms() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::max_lock_ms()
    }

    public fun max_vest_ms() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::max_vest_ms()
    }

    public fun next_unlock_ms<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::next_unlock_ms<T0, T1>(arg0, arg1, arg2)
    }

    public fun parts_total(arg0: &vector<0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::Part>) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::parts_total(arg0)
    }

    public fun releasable<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address, arg2: u64) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::releasable<T0, T1>(arg0, arg1, arg2)
    }

    public fun release_unlocked<T0, T1>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0));
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::release_unlocked<T0, T1>(&v0, arg0, arg1, arg2, arg3)
    }

    public fun reserve<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::reserve<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun reserve_epochs<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::reserve_epochs<T0>(arg0, arg1)
    }

    public fun reserved<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: 0x2::object::ID) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::reserved<T0>(arg0, arg1)
    }

    public fun schedule<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : (u64, u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::schedule<T0>(arg0)
    }

    public fun set_schedule<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::set_schedule<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun take_forfeits<T0, T1>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::StakingSink) : 0x2::balance::Balance<T1> {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x2::object::id<0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::fees::StakingSink>(arg1);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0));
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::take_forfeits<T0, T1>(&v0, arg0)
    }

    public fun take_reserve<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64) : (vector<0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::Part>, vector<0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::EpochBasis>) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::take_reserve<T0>(arg0, arg1, arg2, arg3)
    }

    public fun vest_ms() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::vest_ms()
    }

    public fun vest_status<T0, T1>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: address, arg2: u64) : (u64, u64, u64, u64, u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::locked_mint::vest_status<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

