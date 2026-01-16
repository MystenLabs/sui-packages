module 0x92ad7e9eb483ba31772e76baf02e8634b5ebffbf58a93367ebf838d8c51fe780::pawtato_powerup_state {
    struct Powerup has copy, drop, store {
        is_active: bool,
        expires_at: u64,
    }

    struct PowerupRegistry has key {
        id: 0x2::object::UID,
        user_states: 0x2::table::Table<address, 0x2::table::Table<u16, Powerup>>,
        version: u64,
        paused: bool,
    }

    struct PowerupBackendCap has store, key {
        id: 0x2::object::UID,
    }

    struct PowerupAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PowerupSet has copy, drop {
        user: address,
        powerup_id: u16,
        is_active: bool,
        expires_at: u64,
    }

    struct PowerupRemoved has copy, drop {
        user: address,
        powerup_id: u16,
    }

    fun check_not_paused(arg0: &PowerupRegistry) {
        assert!(!arg0.paused, 321);
    }

    fun check_version(arg0: &PowerupRegistry) {
        assert!(arg0.version == 1, 320);
    }

    public(friend) fun initialize_powerup_system(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PowerupRegistry{
            id          : 0x2::object::new(arg0),
            user_states : 0x2::table::new<address, 0x2::table::Table<u16, Powerup>>(arg0),
            version     : 1,
            paused      : false,
        };
        let v1 = PowerupBackendCap{id: 0x2::object::new(arg0)};
        let v2 = PowerupAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PowerupRegistry>(v0);
        0x2::transfer::public_transfer<PowerupBackendCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<PowerupAdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_powerup_active(arg0: &PowerupRegistry, arg1: address, arg2: u16, arg3: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<address, 0x2::table::Table<u16, Powerup>>(&arg0.user_states, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<address, 0x2::table::Table<u16, Powerup>>(&arg0.user_states, arg1);
        if (!0x2::table::contains<u16, Powerup>(v0, arg2)) {
            return false
        };
        let v1 = 0x2::table::borrow<u16, Powerup>(v0, arg2);
        v1.is_active && 0x2::clock::timestamp_ms(arg3) < v1.expires_at
    }

    public entry fun remove_powerup_state(arg0: &PowerupBackendCap, arg1: &mut PowerupRegistry, arg2: address, arg3: u16) {
        check_version(arg1);
        check_not_paused(arg1);
        if (!0x2::table::contains<address, 0x2::table::Table<u16, Powerup>>(&arg1.user_states, arg2)) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u16, Powerup>>(&mut arg1.user_states, arg2);
        if (0x2::table::contains<u16, Powerup>(v0, arg3)) {
            0x2::table::remove<u16, Powerup>(v0, arg3);
            let v1 = PowerupRemoved{
                user       : arg2,
                powerup_id : arg3,
            };
            0x2::event::emit<PowerupRemoved>(v1);
        };
    }

    public entry fun set_paused(arg0: &PowerupAdminCap, arg1: &mut PowerupRegistry, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_powerup_state(arg0: &PowerupBackendCap, arg1: &mut PowerupRegistry, arg2: address, arg3: u16, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        check_not_paused(arg1);
        if (!0x2::table::contains<address, 0x2::table::Table<u16, Powerup>>(&arg1.user_states, arg2)) {
            0x2::table::add<address, 0x2::table::Table<u16, Powerup>>(&mut arg1.user_states, arg2, 0x2::table::new<u16, Powerup>(arg6));
        };
        let v0 = 0x2::table::borrow_mut<address, 0x2::table::Table<u16, Powerup>>(&mut arg1.user_states, arg2);
        let v1 = Powerup{
            is_active  : arg4,
            expires_at : arg5,
        };
        if (0x2::table::contains<u16, Powerup>(v0, arg3)) {
            *0x2::table::borrow_mut<u16, Powerup>(v0, arg3) = v1;
        } else {
            0x2::table::add<u16, Powerup>(v0, arg3, v1);
        };
        let v2 = PowerupSet{
            user       : arg2,
            powerup_id : arg3,
            is_active  : arg4,
            expires_at : arg5,
        };
        0x2::event::emit<PowerupSet>(v2);
    }

    public entry fun upgrade_version(arg0: &PowerupAdminCap, arg1: &mut PowerupRegistry) {
        assert!(arg1.version < 1, 13906835256675139583);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

