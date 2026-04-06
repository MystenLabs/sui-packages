module 0xb72d24477617186766f1ca4c347155bb4c2b731d14191d499da3a95f62372cfd::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        min_deposit: u64,
        max_deposit: u64,
        min_withdraw: u64,
        max_withdraw: u64,
        bridge_wallet: address,
    }

    public fun assert_active(arg0: &GlobalConfig) {
        assert!(!arg0.paused, 300);
        assert!(arg0.version <= 2, 301);
    }

    public fun assert_deposit_amount(arg0: &GlobalConfig, arg1: u64) {
        assert!(arg1 >= arg0.min_deposit, 302);
        assert!(arg1 <= arg0.max_deposit, 303);
    }

    public fun assert_withdraw_amount(arg0: &GlobalConfig, arg1: u64) {
        assert!(arg1 >= arg0.min_withdraw, 304);
        assert!(arg1 <= arg0.max_withdraw, 305);
    }

    public fun bridge_wallet(arg0: &GlobalConfig) : address {
        arg0.bridge_wallet
    }

    public fun create_operator(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : OperatorCap {
        OperatorCap{id: 0x2::object::new(arg1)}
    }

    public fun destroy_operator(arg0: OperatorCap) {
        let OperatorCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id            : 0x2::object::new(arg0),
            version       : 2,
            paused        : false,
            min_deposit   : 5000000,
            max_deposit   : 100000000000,
            min_withdraw  : 2000000,
            max_withdraw  : 10000000000,
            bridge_wallet : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun set_bridge_wallet(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        assert!(arg2 != @0x0 && arg2 != arg1.bridge_wallet, 307);
        arg1.bridge_wallet = arg2;
    }

    public fun set_deposit_limits(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 306);
        arg1.min_deposit = arg2;
        arg1.max_deposit = arg3;
    }

    public fun set_pause(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_withdraw_limits(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 306);
        arg1.min_withdraw = arg2;
        arg1.max_withdraw = arg3;
    }

    public fun upgrade(arg0: &AdminCap, arg1: &mut GlobalConfig) {
        arg1.version = arg1.version + 1;
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

