module 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::builder {
    public(friend) fun accrue<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u64, arg2: u64, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: 0x1::option::Option<u32>, arg7: u16, arg8: u8) : u64 {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::carve_builder<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun builder_active<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32) : bool {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::active(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_id_for_code<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &vector<u8>) : 0x1::option::Option<u32> {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::id_for_code(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_owner<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32) : address {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::owner(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_payout<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32) : address {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::payout(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
    }

    public fun builder_share_bps<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32) : u16 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::share_bps(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
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

    public fun pending_builder<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: address) : u64 {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::pending(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1)
    }

    public fun register_builder<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: vector<u8>, arg4: address, arg5: address, arg6: u16) : u32 {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::code_ok(&arg3), 13835621215689244677);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::code_taken(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), &arg3), 13835621219984211973);
        assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::payout_taken(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg4), 13835902699256020999);
        assert!((arg6 as u64) <= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::max_builder_share_bps(arg1), 13835339753597304835);
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::register(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4, arg5, arg6);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_registered_event(&v0, v1, arg3, arg4, arg5, arg6);
        v1
    }

    fun rotate_payout<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32, arg2: address) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0));
        let v1 = 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::payout(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1);
        if (v1 != arg2) {
            assert!(!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::payout_taken(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg2), 13835903300551442439);
        };
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::set_payout(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid_mut<T0>(&v0, arg0), arg1, arg2);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_payout_event(&v0, arg1, v1, arg2);
    }

    public fun set_builder_active<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: u32, arg4: bool) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::exists(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg3), 13835058441829220353);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::set_active(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_updated_event(&v0, arg3, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::share_bps(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg3), arg4);
    }

    public fun set_builder_payout<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: u32, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::exists(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1), 13835058501958762497);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::owner(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg1) == 0x2::tx_context::sender(arg3), 13836184406161096713);
        rotate_payout<T0>(arg0, arg1, arg2);
    }

    public fun set_builder_payout_as_admin<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: u32, arg4: address) {
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::exists(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg3), 13835058570678239233);
        rotate_payout<T0>(arg0, arg3, arg4);
    }

    public fun set_builder_share<T0>(arg0: &mut 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::AuthorityCap<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::PACKAGE, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::ADMIN>, arg3: u32, arg4: u16) {
        let v0 = 0xdfc5f638343b58340f7d17312ba7b2e43f053808f964cd06085c4787b022358b::auth::issue(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::uid(arg1));
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::assert_version<T0>(arg0);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::assert_version(arg1);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::authority::assert_admin(0x2::object::id<0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config>(arg1), arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::exists(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg3), 13835058360224841729);
        assert!((arg4 as u64) <= 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::max_builder_share_bps(arg1), 13835339839496650755);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::set_share(&v0, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid_mut<T0>(&v0, arg0), arg3, arg4);
        0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::events::emit_builder_updated_event(&v0, arg3, arg4, 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::active(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), arg3));
    }

    public(friend) fun snapshot<T0>(arg0: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::Exchange<T0>, arg1: &0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::Config, arg2: 0x1::option::Option<u32>) : (0x1::option::Option<u32>, u16) {
        if (0x1::option::is_none<u32>(&arg2)) {
            return (0x1::option::none<u32>(), 0)
        };
        let v0 = *0x1::option::borrow<u32>(&arg2);
        assert!(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::exists(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), v0), 13835058742476931073);
        if (!0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::config::builders_enabled(arg1) || !0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::active(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), v0)) {
            return (0x1::option::none<u32>(), 0)
        };
        (0x1::option::some<u32>(v0), 0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::builder_book::share_bps(0x273f8b652335504609c59c85106526e8dfb772ca6b7a4c774fa999f6e6901fc4::exchange::uid<T0>(arg0), v0))
    }

    // decompiled from Move bytecode v7
}

