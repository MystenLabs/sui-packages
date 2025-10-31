module 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminConfig has key {
        id: 0x2::object::UID,
        default_platform_fee_bps: u64,
        total_merchants: u64,
        total_payments: u64,
        total_volume: u64,
    }

    public entry fun force_activate_merchant(arg0: &AdminCap, arg1: &mut 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant) {
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::admin_set_active_status(arg1, true);
    }

    public entry fun force_deactivate_merchant(arg0: &AdminCap, arg1: &mut 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant) {
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::admin_set_active_status(arg1, false);
    }

    public fun get_default_platform_fee_bps(arg0: &AdminConfig) : u64 {
        arg0.default_platform_fee_bps
    }

    public fun get_total_merchants(arg0: &AdminConfig) : u64 {
        arg0.total_merchants
    }

    public fun get_total_payments(arg0: &AdminConfig) : u64 {
        arg0.total_payments
    }

    public fun get_total_volume(arg0: &AdminConfig) : u64 {
        arg0.total_volume
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AdminConfig{
            id                       : 0x2::object::new(arg0),
            default_platform_fee_bps : 30,
            total_merchants          : 0,
            total_payments           : 0,
            total_volume             : 0,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<AdminConfig>(v1);
    }

    public entry fun set_default_platform_fee(arg0: &AdminCap, arg1: &mut AdminConfig, arg2: u64) {
        assert!(arg2 <= 1000, 101);
        arg1.default_platform_fee_bps = arg2;
    }

    public entry fun set_merchant_platform_fee(arg0: &AdminCap, arg1: &mut 0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::Merchant, arg2: u64) {
        assert!(arg2 <= 1000, 101);
        0x7836014a540787d57dc08e5a99cfd34cd3f3f3f10920da17cfb476a378344507::merchant::admin_set_platform_fee(arg1, arg2);
    }

    public entry fun update_platform_stats(arg0: &AdminCap, arg1: &mut AdminConfig, arg2: u64, arg3: u64, arg4: u64) {
        arg1.total_merchants = arg1.total_merchants + arg2;
        arg1.total_payments = arg1.total_payments + arg3;
        arg1.total_volume = arg1.total_volume + arg4;
    }

    // decompiled from Move bytecode v6
}

