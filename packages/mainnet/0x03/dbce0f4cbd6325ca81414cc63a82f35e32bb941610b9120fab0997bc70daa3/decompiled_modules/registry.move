module 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        version: u64,
        pause: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::PauseFlags,
        revenue_collector: address,
        active_caps: 0x2::table::Table<0x2::object::ID, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::CapRecord>,
    }

    public(friend) fun active_caps(arg0: &Registry) : &0x2::table::Table<0x2::object::ID, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::CapRecord> {
        &arg0.active_caps
    }

    public(friend) fun active_caps_mut(arg0: &mut Registry) : &mut 0x2::table::Table<0x2::object::ID, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::CapRecord> {
        &mut arg0.active_caps
    }

    public fun assert_global_allows(arg0: &Registry, arg1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action) {
        assert!(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::get_allows(&arg0.pause, arg1), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::errors::protocol_paused());
    }

    public fun assert_version(arg0: &Registry) {
        assert!(arg0.version == 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::constants::version(), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::errors::wrong_version());
    }

    public fun get_pause_flags(arg0: &Registry) : 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::PauseFlags {
        arg0.pause
    }

    public fun get_reserve_address<T0>(arg0: &Registry) : address {
        0x2::derived_object::derive_address<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::ReserveKey<T0>>(0x2::object::uid_to_inner(&arg0.id), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::reserve_key<T0>())
    }

    public fun get_reserve_exists<T0>(arg0: &Registry) : bool {
        0x2::derived_object::exists<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::ReserveKey<T0>>(&arg0.id, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::reserve_key<T0>())
    }

    public fun get_revenue_collector(arg0: &Registry) : address {
        arg0.revenue_collector
    }

    public(friend) fun get_uid_mut(arg0: &mut Registry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_user_cap_address<T0>(arg0: &Registry, arg1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder) : address {
        0x2::derived_object::derive_address<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::UserCapKey<T0>>(0x2::object::uid_to_inner(&arg0.id), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::user_cap_key<T0>(arg1))
    }

    public fun get_user_cap_exists<T0>(arg0: &Registry, arg1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder) : bool {
        0x2::derived_object::exists<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::UserCapKey<T0>>(&arg0.id, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::user_cap_key<T0>(arg1))
    }

    public fun get_version(arg0: &Registry) : u64 {
        arg0.version
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id                : 0x2::object::new(arg0),
            version           : 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::constants::version(),
            pause             : 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::none(),
            revenue_collector : @0x0,
            active_caps       : 0x2::table::new<0x2::object::ID, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::CapRecord>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public(friend) fun migrate(arg0: &mut Registry) {
        assert!(arg0.version < 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::constants::version(), 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::errors::already_migrated());
        arg0.version = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::constants::version();
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::events::emit_log_migrate(arg0.version, arg0.version);
    }

    public(friend) fun set_global_pause(arg0: &mut Registry, arg1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action, arg2: bool) {
        arg0.pause = 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::set(arg0.pause, arg1, arg2);
    }

    public(friend) fun set_revenue_collector(arg0: &mut Registry, arg1: address) {
        arg0.revenue_collector = arg1;
    }

    // decompiled from Move bytecode v7
}

