module 0x8efc8d86ac5a8302b075738f173c402136c72caf190a6e4639ef4da0d49d5ded::terminal_config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_bps: u64,
        quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        fee_vault: 0x2::bag::Bag,
    }

    struct FeeCollected has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ConfigUpdated has copy, drop {
        fee_bps: u64,
        paused: bool,
    }

    struct ConfigMigrated has copy, drop {
        version: u64,
    }

    public fun add_quote<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.quotes, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.quotes, v0);
        };
    }

    public fun assert_active(arg0: &Config) {
        assert!(arg0.version == 1, 2);
        assert!(!arg0.paused, 0);
    }

    public fun fee_balance<T0>(arg0: &Config) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_vault, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.fee_vault, v0))
        } else {
            0
        }
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id        : 0x2::object::new(arg0),
            version   : 1,
            paused    : false,
            fee_bps   : 50,
            quotes    : 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<0x2::sui::SUI>()),
            fee_vault : 0x2::bag::new(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_quote<T0>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quotes, &v0)
    }

    public fun is_quote_type(arg0: &Config, arg1: &0x1::type_name::TypeName) : bool {
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quotes, arg1)
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
        let v0 = ConfigMigrated{version: 1};
        0x2::event::emit<ConfigMigrated>(v0);
    }

    public fun pay_fee<T0>(arg0: &mut Config, arg1: 0x2::coin::Coin<T0>) {
        put_fee<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun put_fee<T0>(arg0: &mut Config, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_vault, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v1), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_vault, v1, arg1);
        };
        let v2 = FeeCollected{
            coin_type : v1,
            amount    : v0,
        };
        0x2::event::emit<FeeCollected>(v2);
    }

    public fun remove_quote<T0>(arg0: &AdminCap, arg1: &mut Config) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.quotes, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.quotes, &v0);
        };
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 300, 1);
        arg1.fee_bps = arg2;
        let v0 = ConfigUpdated{
            fee_bps : arg1.fee_bps,
            paused  : arg1.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = ConfigUpdated{
            fee_bps : arg1.fee_bps,
            paused  : arg1.paused,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg1.fee_vault, v0), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fee_vault, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 3);
        0x2::coin::take<T0>(v1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

