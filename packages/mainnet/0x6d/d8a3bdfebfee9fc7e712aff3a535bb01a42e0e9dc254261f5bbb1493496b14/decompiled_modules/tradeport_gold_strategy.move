module 0x6dd8a3bdfebfee9fc7e712aff3a535bb01a42e0e9dc254261f5bbb1493496b14::tradeport_gold_strategy {
    struct TRADEPORT_GOLD_STRATEGY has drop {
        dummy_field: bool,
    }

    struct GLDSTR {
        dummy_field: bool,
    }

    struct Manager has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        is_strategy_created: bool,
        treasury: 0x2::balance::Balance<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>,
    }

    public fun apply_strategy() {
    }

    public fun create_strategy() {
    }

    fun init(arg0: TRADEPORT_GOLD_STRATEGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<TRADEPORT_GOLD_STRATEGY>(arg0, arg1);
        let v0 = Manager{
            id                  : 0x2::object::new(arg1),
            version             : 1,
            admin               : 0x2::tx_context::sender(arg1),
            is_strategy_created : false,
            treasury            : 0x2::balance::zero<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(),
        };
        0x2::transfer::share_object<Manager>(v0);
    }

    public fun redeem() {
    }

    entry fun set_admin(arg0: &mut Manager, arg1: address, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    entry fun set_version(arg0: &mut Manager, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        verify_version(arg0);
        verify_admin(arg0, arg2);
        arg0.version = arg1;
    }

    fun verify_admin(arg0: &Manager, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 2);
    }

    fun verify_version(arg0: &Manager) {
        assert!(arg0.version == 1, 1);
    }

    // decompiled from Move bytecode v6
}

