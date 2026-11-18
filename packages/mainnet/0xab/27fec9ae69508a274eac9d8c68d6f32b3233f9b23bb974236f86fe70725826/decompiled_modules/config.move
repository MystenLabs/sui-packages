module 0xab27fec9ae69508a274eac9d8c68d6f32b3233f9b23bb974236f86fe70725826::config {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        pending: 0x1::option::Option<address>,
        traders: 0x2::vec_set::VecSet<address>,
        paused: bool,
    }

    public fun accept_admin(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.pending == 0x1::option::some<address>(0x2::tx_context::sender(arg1)), 3);
        arg0.admin = 0x2::tx_context::sender(arg1);
        arg0.pending = 0x1::option::none<address>();
    }

    public fun add_trader(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (!0x2::vec_set::contains<address>(&arg0.traders, &arg1)) {
            0x2::vec_set::insert<address>(&mut arg0.traders, arg1);
        };
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    fun assert_admin(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 0);
    }

    public fun assert_trader(arg0: &Config, arg1: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.traders, &v0), 1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            pending : 0x1::option::none<address>(),
            traders : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            paused  : false,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_trader(arg0: &Config, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.traders, &arg1)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun propose_admin(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.pending = 0x1::option::some<address>(arg1);
    }

    public fun remove_trader(arg0: &mut Config, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        if (0x2::vec_set::contains<address>(&arg0.traders, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.traders, &arg1);
        };
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v7
}

