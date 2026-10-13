module 0xd72e5db9141b2dcb229863050f37e3719f91522f747001ae5cbb2ab63d6f0a26::router {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        operators: 0x2::vec_set::VecSet<address>,
    }

    struct ArbSession<phantom T0> {
        owed: u64,
    }

    struct ArbExecuted has copy, drop {
        token: 0x1::type_name::TypeName,
        owed: u64,
        profit: u64,
        operator: address,
    }

    public fun add_operator(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.operators, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.operators, arg2);
        };
    }

    fun assert_live(arg0: &Config) {
        assert!(arg0.version == 1, 3);
        assert!(!arg0.paused, 2);
    }

    public(friend) fun begin<T0>(arg0: &Config, arg1: u64, arg2: &0x2::tx_context::TxContext) : ArbSession<T0> {
        assert_live(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 1);
        ArbSession<T0>{owed: arg1}
    }

    public fun finish<T0>(arg0: ArbSession<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let ArbSession { owed: v0 } = arg0;
        let v1 = 0x2::balance::value<T0>(&arg1);
        assert!(v1 >= v0, 4);
        let v2 = v1 - v0;
        assert!(v2 >= arg2, 5);
        sweep<T0>(arg1, arg3);
        let v3 = ArbExecuted{
            token    : 0x1::type_name::with_defining_ids<T0>(),
            owed     : v0,
            profit   : v2,
            operator : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ArbExecuted>(v3);
        0x2::balance::split<T0>(&mut arg1, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, v0);
        let v2 = Config{
            id        : 0x2::object::new(arg0),
            version   : 1,
            paused    : false,
            operators : 0x2::vec_set::singleton<address>(v0),
        };
        0x2::transfer::share_object<Config>(v2);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 6);
        arg1.version = 1;
    }

    public fun owed<T0>(arg0: &ArbSession<T0>) : u64 {
        arg0.owed
    }

    public fun remove_operator(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.operators, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.operators, &arg2);
        };
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
    }

    public(friend) fun sweep<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v7
}

