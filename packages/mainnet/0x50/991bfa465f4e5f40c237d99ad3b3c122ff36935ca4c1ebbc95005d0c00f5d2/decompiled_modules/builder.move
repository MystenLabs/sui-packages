module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::builder {
    fun admin_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u32) : 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::exists(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3), 13835060516298424321);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1))
    }

    public fun approve_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg4: u32, arg5: u16) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_cap<T0>(arg2, arg3);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::exists(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg4), 13835059653009997825);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg4), 13839563256934039579);
        assert!(arg5 > 0, 13838155886344798225);
        assert!((arg5 as u64) <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1), 13838155890639765521);
        let v1 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::approve(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), v1, arg4, arg5);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_approval_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), v1, arg4, arg5, true);
    }

    public fun builder_active<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : bool {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::active(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_approved_max<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: 0x2::object::ID, arg2: u32) : 0x1::option::Option<u16> {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::approved_max(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1, arg2)
    }

    public fun builder_fee_bps<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : u16 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::fee_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_id_for_code<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &vector<u8>) : 0x1::option::Option<u32> {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::id_for_code(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_owner<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : address {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::owner(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_payout<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : address {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::payout(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_revoke_open<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : bool {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::revoke_open(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_self_serve<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : bool {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::self_serve(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_status<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : u8 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_tombstoned<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32) : bool {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    fun charge_bps(arg0: u16, arg1: 0x1::option::Option<u16>, arg2: u64, arg3: u16) : u16 {
        if (arg0 > 0 && (0x1::option::is_none<u16>(&arg1) || arg0 > *0x1::option::borrow<u16>(&arg1))) {
            return 0
        };
        let v0 = arg0;
        if (arg3 < arg0) {
            v0 = arg3;
        };
        if ((v0 as u64) > arg2) {
            (arg2 as u16)
        } else {
            v0
        }
    }

    public(friend) fun close_fee_bps<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: 0x1::option::Option<u32>, arg3: u16) : u16 {
        if (0x1::option::is_none<u32>(&arg2)) {
            return 0
        };
        if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::payouts_revoked(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), *0x1::option::borrow<u32>(&arg2))) {
            return 0
        };
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1);
        if ((arg3 as u64) > v0) {
            (v0 as u16)
        } else {
            arg3
        }
    }

    public fun create_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: vector<u8>, arg3: address, arg4: u16, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::tx_context::TxContext) : u32 {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        assert!(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::self_serve_enabled(arg1), 13839280656675766297);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::self_serve_code_ok(&arg2), 13837310336132841483);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::code_reserved(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), &arg2), 13837591815404650509);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::code_taken(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), &arg2), 13835621494861987843);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg3 != @0x0, 13836465928382316551);
        assert!(v1 != @0x0, 13836747407654125577);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::self_serve_count(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v1) < 3, 13837873320446263311);
        assert!(within_owner_limit(arg1, arg4), 13838154804013039633);
        let v2 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::builder_create_fee(arg1);
        assert!(0x2::coin::value<T0>(&arg5) == v2, 13838999237533499415);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::credit_fee_treasury<T0>(&v0, arg0, arg5);
        let v3 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::register(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, arg3, v1, arg4, true);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_registered_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), v3, arg2, arg3, v1, arg4, true, v2);
        emit_status<T0>(&v0, arg0, v3);
        v3
    }

    fun emit_status<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: u32) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_status_event(arg0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg1), arg2, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg1), arg2), 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::revoke_open(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg1), arg2));
    }

    fun gate_owner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: &0x2::tx_context::TxContext) : 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::exists(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13835060451873914881);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::owner(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2) == 0x2::tx_context::sender(arg3), 13836186356075986949);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1))
    }

    public fun on_top_fee(arg0: u64, arg1: u64) : u64 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::on_top_fee(arg0, arg1)
    }

    public fun pause_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        let v0 = gate_owner<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13839562440890253339);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2) != 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_admin_suspended(), 13838718020254695445);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_owner_paused());
        emit_status<T0>(&v0, arg0, arg2);
    }

    public(friend) fun pay_on_top<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: u32, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64) {
        if (arg6 == 0) {
            return
        };
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::pay_builder_on_top<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun pending_builder<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: address) : u64 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::pending(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg1)
    }

    public fun register_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: vector<u8>, arg4: address, arg5: address, arg6: u16) : u32 {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::code_ok(&arg3), 13835621331653230595);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::code_taken(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), &arg3), 13835621335948197891);
        assert!(arg4 != @0x0, 13836465765173559303);
        assert!(arg5 != @0x0, 13836747244445368329);
        assert!((arg6 as u64) <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1), 13838154623624413201);
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::register(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4, arg5, arg6, false);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_registered_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), v1, arg3, arg4, arg5, arg6, false, 0);
        emit_status<T0>(&v0, arg0, v1);
        v1
    }

    public fun release_builder_code<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: vector<u8>) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_code_reserved_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), arg3, false);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::release_code(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 92);
    }

    public(friend) fun request_fee_ceiling<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: 0x1::option::Option<u32>, arg3: 0x2::object::ID) : u16 {
        if (0x1::option::is_none<u32>(&arg2)) {
            return 0
        };
        let v0 = *0x1::option::borrow<u32>(&arg2);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::exists(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0), 13835060052441956353);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0), 13839563656365998107);
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::fee_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0);
        let v2 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::approved_max(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3, v0);
        assert!(v1 == 0 || 0x1::option::is_some<u16>(&v2), 13838437769343533075);
        charge_bps(v1, v2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1), 65535)
    }

    public fun reserve_builder_codes<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: vector<vector<u8>>) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_version(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_referrals());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::assert_admin(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config>(arg1), arg2);
        let v1 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg3)) {
            let v3 = *0x1::vector::borrow<vector<u8>>(&arg3, v2);
            assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::code_ok(&v3), 13835622413984989187);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_code_reserved_event(&v0, v1, v3, true);
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::reserve(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), v3);
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, v1, 91);
            v2 = v2 + 1;
        };
    }

    public fun resume_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: &0x2::tx_context::TxContext) {
        let v0 = gate_owner<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13839562513904697371);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2) != 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_admin_suspended(), 13838718093269139477);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_active());
        emit_status<T0>(&v0, arg0, arg2);
    }

    public fun revoke_builder_approval<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg4: u32) {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_cap<T0>(arg2, arg3);
        let v1 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::revoke_approval(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), v1, arg4), 13838437460105887763);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_approval_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), v1, arg4, 0, false);
    }

    public fun set_builder_fee<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: u16, arg4: &0x2::tx_context::TxContext) {
        let v0 = gate_owner<T0>(arg0, arg1, arg2, arg4);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13839562294861365275);
        assert!(within_owner_limit(arg1, arg3), 13838154924272123921);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_fee(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_fee_set_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), arg2, arg3);
    }

    public fun set_builder_fee_as_admin<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u32, arg4: u16) {
        let v0 = admin_builder<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3), 13839562372170776603);
        assert!((arg4 as u64) <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1), 13838155001581535249);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_fee(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_fee_set_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), arg3, arg4);
    }

    public fun set_builder_payout<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = gate_owner<T0>(arg0, arg1, arg2, arg4);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13839562960581296155);
        assert!(arg3 != @0x0, 13836466740131135495);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_payout(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_payout_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), arg2, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::payout(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), arg3);
    }

    public(friend) fun snapshot<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: 0x1::option::Option<u32>, arg3: 0x2::object::ID, arg4: u16, arg5: bool) : (0x1::option::Option<u32>, u16) {
        if (0x1::option::is_none<u32>(&arg2)) {
            return (0x1::option::none<u32>(), 0)
        };
        let v0 = *0x1::option::borrow<u32>(&arg2);
        assert!(0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::exists(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0), 13835060181290975233);
        if (0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0)) {
            assert!(!arg5, 13839563789509984283);
            return (0x1::option::none<u32>(), 0)
        };
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::fee_bps(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0);
        let v2 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::approved_max(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3, v0);
        if (v1 > 0 && 0x1::option::is_none<u16>(&v2)) {
            assert!(!arg5, 13838437915372421139);
            return (0x1::option::none<u32>(), 0)
        };
        if (!0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::builders_enabled(arg1) || !0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::active(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), v0)) {
            return (0x1::option::none<u32>(), 0)
        };
        (0x1::option::some<u32>(v0), charge_bps(v1, v2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg1), arg4))
    }

    public fun status_active() : u8 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_active()
    }

    public fun status_admin_suspended() : u8 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_admin_suspended()
    }

    public fun status_owner_paused() : u8 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_owner_paused()
    }

    public fun status_tombstoned() : u8 {
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_tombstoned()
    }

    public fun suspend_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u32, arg4: bool) {
        let v0 = admin_builder<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3), 13839562595509075995);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_admin_suspended());
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_revoke_open(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        emit_status<T0>(&v0, arg0, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 93);
        let v1 = if (arg4) {
            1
        } else {
            0
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_value(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 93, v1);
    }

    public fun tombstone_builder_code<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u32) {
        let v0 = admin_builder<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3), 13839562775897702427);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstone(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3);
        emit_status<T0>(&v0, arg0, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 96);
    }

    public fun transfer_owner<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: u32, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = gate_owner<T0>(arg0, arg1, arg2, arg4);
        assert!(arg3 != @0x0, 13836748116323729417);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2), 13839562870386982939);
        let v1 = 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::owner(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg2);
        if (v1 == arg3) {
            return
        };
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::assign_owner(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg2, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_builder_owner_transferred_event(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), arg2, v1, arg3);
    }

    public fun unsuspend_builder<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: u32) {
        let v0 = admin_builder<T0>(arg0, arg1, arg2, arg3);
        assert!(!0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::tombstoned(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg0), arg3), 13839562677113454619);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_status(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, 0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::status_active());
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::builder_book::set_revoke_open(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v0, arg0), arg3, false);
        emit_status<T0>(&v0, arg0, arg3);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_admin_action(&v0, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0), 94);
    }

    fun within_owner_limit(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg1: u16) : bool {
        let v0 = (arg1 as u64);
        v0 <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::self_serve_fee_cap_bps(arg0) && v0 <= 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::max_builder_fee_bps(arg0)
    }

    // decompiled from Move bytecode v7
}

