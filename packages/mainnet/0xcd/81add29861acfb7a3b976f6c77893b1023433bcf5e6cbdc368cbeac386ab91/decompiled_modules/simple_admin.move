module 0xcd81add29861acfb7a3b976f6c77893b1023433bcf5e6cbdc368cbeac386ab91::simple_admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
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

    public entry fun increment(arg0: &mut Config) {
        assert!(!arg0.paused, 1);
        arg0.value = arg0.value + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id     : 0x2::object::new(arg0),
            value  : 0,
            paused : false,
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

    // decompiled from Move bytecode v6
}

