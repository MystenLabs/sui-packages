module 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::builder {
    public(friend) fun accrue<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<u32>, arg7: u16, arg8: u8) : u64 {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::carve_builder<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun builder_active<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u32) : bool {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::active(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_id_for_code<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &vector<u8>) : 0x1::option::Option<u32> {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::id_for_code(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_owner<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u32) : address {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::owner(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_payout<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u32) : address {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::payout(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_share_bps<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u32) : u16 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::share_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun kind_close_toll() : u8 {
        1
    }

    public fun kind_open() : u8 {
        0
    }

    public fun kind_win() : u8 {
        2
    }

    public fun pending_builder<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: address) : u64 {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::pending(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1)
    }

    public fun register_builder<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: vector<u8>, arg4: address, arg5: address, arg6: u16) : u32 {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_referrals());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::code_ok(&arg3), 13835621237164081157);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::code_taken(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), &arg3), 13835621241459048453);
        assert!(arg4 != @0x0, 13836465670684540939);
        assert!(arg5 != @0x0, 13836747149956349965);
        assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::payout_taken(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg4), 13835902729320792071);
        assert!((arg6 as u64) <= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::max_builder_share_bps(arg1), 13835339783662075907);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::register(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4, arg5, arg6);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_registered_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0), v1, arg3, arg4, arg5, arg6);
        v1
    }

    fun rotate_payout<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: u32, arg2: address) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0));
        assert!(arg2 != @0x0, 13836466293454798859);
        let v1 = 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::payout(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg1);
        if (v1 != arg2) {
            assert!(!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::payout_taken(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg2), 13835903356386017287);
        };
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::set_payout(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0), arg1, arg2);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_payout_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0), arg1, v1, arg2);
    }

    public fun set_builder_active<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: u32, arg4: bool) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_referrals());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::exists(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg3), 13835058480483926017);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::set_active(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_updated_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0), arg3, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::share_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg3), arg4);
    }

    public fun set_builder_payout<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: u32, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_referrals());
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::exists(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg2), 13835058549203402753);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::owner(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg2) == 0x2::tx_context::sender(arg4), 13836184453405736969);
        rotate_payout<T0>(arg0, arg2, arg3);
    }

    public fun set_builder_payout_as_admin<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: u32, arg4: address) {
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_referrals());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::exists(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg3), 13835058622217846785);
        rotate_payout<T0>(arg0, arg3, arg4);
    }

    public fun set_builder_share<T0>(arg0: &mut 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::AuthorityCap<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::PACKAGE, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::ADMIN>, arg3: u32, arg4: u16) {
        let v0 = 0x883f42ca7d9cce359b64e2f169d639a0d3b0f8f9b9e5e8923225ad2ad098acdc::auth::issue(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::uid(arg1));
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::assert_version<T0>(arg0);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_version(arg1);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::assert_unpaused(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::pause_referrals());
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::authority::assert_admin(0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config>(arg1), arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::exists(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg3), 13835058394584580097);
        assert!((arg4 as u64) <= 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::max_builder_share_bps(arg1), 13835339873856389123);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::set_share(&v0, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::events::emit_builder_updated_event(&v0, 0x2::object::id<0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>>(arg0), arg3, arg4, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::active(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), arg3));
    }

    public(friend) fun snapshot<T0>(arg0: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::Exchange<T0>, arg1: &0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::Config, arg2: 0x1::option::Option<u32>) : (0x1::option::Option<u32>, u16) {
        if (0x1::option::is_none<u32>(&arg2)) {
            return (0x1::option::none<u32>(), 0)
        };
        let v0 = *0x1::option::borrow<u32>(&arg2);
        assert!(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::exists(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), v0), 13835058794016538625);
        if (!0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::builders_enabled(arg1) || !0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::active(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), v0)) {
            return (0x1::option::none<u32>(), 0)
        };
        (0x1::option::some<u32>(v0), 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::config::effective_builder_share(arg1, 0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::builder_book::share_bps(0x47d1690840ce48acc1ffe918ea4684ea226d263d2af01fe362ee4ddb37bed960::exchange::uid<T0>(arg0), v0)))
    }

    // decompiled from Move bytecode v7
}

