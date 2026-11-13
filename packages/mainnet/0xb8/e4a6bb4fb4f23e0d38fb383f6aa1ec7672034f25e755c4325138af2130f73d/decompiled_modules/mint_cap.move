module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::mint_cap {
    public fun default_debt_cap() : u64 {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::default_debt_cap()
    }

    public fun default_floor() : u64 {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::default_floor()
    }

    public fun epoch_loss<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u64) : u128 {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::epoch_loss<T0>(arg0, arg1)
    }

    public fun epoch_of(arg0: u64) : u64 {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::epoch_of(arg0)
    }

    public fun epoch_status<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u64) : (u128, u128, u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::epoch_status<T0>(arg0, arg1)
    }

    public fun finalize_epoch<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0x2::clock::Clock) : bool {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0));
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::finalize_epoch<T0>(&v0, arg0, arg1)
    }

    public fun note_loss<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::note_loss<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_mint<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::note_mint<T0>(arg0, arg1, arg2, arg3);
    }

    public fun note_pnl<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64, arg4: u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::note_pnl<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun params<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>) : (u64, u64, u64, u128) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::params<T0>(arg0)
    }

    public fun params_v2<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>) : (u64, u64, u64, u128, u64, u64, u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::params_v2<T0>(arg0)
    }

    public fun scale_of<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u64) : (bool, u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::scale_of<T0>(arg0, arg1)
    }

    public fun set_params<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::set_params<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_params_v2<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::set_params_v2<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun unnote_loss<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64) : u64 {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::unnote_loss<T0>(arg0, arg1, arg2, arg3)
    }

    public fun unnote_mint<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u64, arg3: u64) {
        0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::mint_cap::unnote_mint<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

