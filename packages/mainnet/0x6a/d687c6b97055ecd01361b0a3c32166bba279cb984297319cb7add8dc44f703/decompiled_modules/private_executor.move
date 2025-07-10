module 0x6ad687c6b97055ecd01361b0a3c32166bba279cb984297319cb7add8dc44f703::private_executor {
    struct PrivateConfig has key {
        id: 0x2::object::UID,
        owner: address,
        executions: u64,
        active: bool,
    }

    public entry fun execute(arg0: &mut PrivateConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        assert!(arg0.active, 1);
        arg0.executions = arg0.executions + 1;
    }

    public fun get_stats(arg0: &PrivateConfig) : (address, u64, bool) {
        (arg0.owner, arg0.executions, arg0.active)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrivateConfig{
            id         : 0x2::object::new(arg0),
            owner      : 0x2::tx_context::sender(arg0),
            executions : 0,
            active     : true,
        };
        0x2::transfer::share_object<PrivateConfig>(v0);
    }

    public entry fun toggle(arg0: &mut PrivateConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        arg0.active = !arg0.active;
    }

    // decompiled from Move bytecode v6
}

