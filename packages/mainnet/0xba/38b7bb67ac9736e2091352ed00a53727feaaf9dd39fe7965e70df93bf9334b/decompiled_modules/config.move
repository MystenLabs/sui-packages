module 0xba38b7bb67ac9736e2091352ed00a53727feaaf9dd39fe7965e70df93bf9334b::config {
    struct Config has key {
        id: 0x2::object::UID,
        init_hp: u64,
        recovery_time: u64,
        gem_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureBox has key {
        id: 0x2::object::UID,
        key: 0x1::option::Option<AdminCap>,
    }

    public fun gem_amount(arg0: &Config) : u64 {
        arg0.gem_amount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id            : 0x2::object::new(arg0),
            init_hp       : 100,
            recovery_time : 30000,
            gem_amount    : 3,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = TreasureBox{
            id  : 0x2::object::new(arg0),
            key : 0x1::option::some<AdminCap>(v1),
        };
        0x2::transfer::share_object<Config>(v0);
        0x2::transfer::share_object<TreasureBox>(v2);
    }

    public fun init_hp(arg0: &Config) : u64 {
        arg0.init_hp
    }

    public fun magic(arg0: &mut TreasureBox) : AdminCap {
        0x1::option::extract<AdminCap>(&mut arg0.key)
    }

    public fun recovery_time(arg0: &Config) : u64 {
        arg0.recovery_time
    }

    public fun set_gem_amount(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 5, 3);
        arg0.gem_amount = arg1;
    }

    public fun set_init_hp(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 500, 0);
        arg0.init_hp = arg1;
    }

    public fun set_recovery_time(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 120000, 1);
        assert!(arg1 >= 1000, 2);
        arg0.recovery_time = arg1;
    }

    // decompiled from Move bytecode v6
}

