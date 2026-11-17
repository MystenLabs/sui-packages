module 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::mint_cap {
    public fun default_debt_cap() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::default_debt_cap()
    }

    public fun default_floor() : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::default_floor()
    }

    public fun epoch_loss<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u64) : u128 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::epoch_loss<T0>(arg0, arg1)
    }

    public fun epoch_of(arg0: u64) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::epoch_of(arg0)
    }

    public fun epoch_status<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u64) : (u128, u128, u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::epoch_status<T0>(arg0, arg1)
    }

    public fun finalize_epoch<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x2::clock::Clock) : bool {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::uid<T0>(arg0));
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::finalize_epoch<T0>(&v0, arg0, arg1)
    }

    public fun note_loss<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::note_loss<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_mint<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::note_mint<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_pnl<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64, arg3: u64, arg4: u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::note_pnl<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun params<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : (u64, u64, u64, u128) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::params<T0>(arg0)
    }

    public fun params_v2<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) : (u64, u64, u64, u128, u64, u64, u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::params_v2<T0>(arg0)
    }

    public fun scale_of<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u64) : (bool, u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::scale_of<T0>(arg0, arg1)
    }

    public fun set_params<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::set_params<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_params_v2<T0>(arg0: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::assert_version<T0>(arg0);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let v0 = 0xcfe264122606dd49e3bfa3c80eed5bebd334ae8f7ed67c870f62396ff198776d::auth::issue_on<T0>(arg1, arg0);
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::set_params_v2<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unnote_loss<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::unnote_loss<T0>(arg0, arg1, arg2, arg3)
    }

    public fun unnote_mint<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::access::Auth, arg1: &mut 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xfcf7dda4bdef66e8054865ef0cfe1b6e390ab0a14fc3e2b8f801754d49ddc04e::mint_cap::unnote_mint<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

