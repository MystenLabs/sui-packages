module 0x850965f7b085874d5ae1ecb25036dba7d1fe42de51f268fb03b4cac8e6ba890b::simple_admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        value: u64,
        paused: bool,
    }

    struct ValueUpdated has copy, drop {
        old_value: u64,
        new_value: u64,
    }

    struct PauseStatusChanged has copy, drop {
        paused: bool,
    }

    public fun get_value(arg0: &Config) : u64 {
        arg0.value
    }

    public fun get_version(arg0: &Config) : u64 {
        arg0.version
    }

    public entry fun increment(arg0: &mut Config) {
        assert!(!arg0.paused, 1);
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, @0x7ef2da06e687ec88854899307928c0f3508f1e914fa2e4127fb34379a80398cc);
        let v1 = Config{
            id      : 0x2::object::new(arg0),
            version : 1,
            value   : 0,
            paused  : false,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseStatusChanged{paused: arg2};
        0x2::event::emit<PauseStatusChanged>(v0);
    }

    public entry fun set_value(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.value = arg2;
        let v0 = ValueUpdated{
            old_value : arg1.value,
            new_value : arg2,
        };
        0x2::event::emit<ValueUpdated>(v0);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun upgrade_version(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.version = arg2;
    }

    // decompiled from Move bytecode v6
}

