module 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::fee_manager {
    struct FeeValue has copy, drop, store {
        streamflow_fee: u64,
        partner_fee: u64,
    }

    struct FeeTable has key {
        id: 0x2::object::UID,
        values: 0x2::table::Table<address, FeeValue>,
        version: u64,
    }

    struct FeesWritten has copy, drop {
        wallet_address: address,
        streamflow_fee: u64,
        partner_fee: u64,
    }

    struct FeesRemoved has copy, drop {
        wallet_address: address,
    }

    public fun get_streamflow_fee(arg0: &FeeTable, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: address) : u64 {
        let v0 = get_fees(arg0, arg1, arg2);
        v0.streamflow_fee
    }

    public entry fun fees_remove(arg0: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::AdminCap, arg1: &mut FeeTable, arg2: address) {
        let v0 = FeesRemoved{wallet_address: arg2};
        0x2::event::emit<FeesRemoved>(v0);
        remove_from_fee_table(arg1, arg2);
    }

    public entry fun fees_write(arg0: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::AdminCap, arg1: &mut FeeTable, arg2: address, arg3: u64, arg4: u64) {
        assert!(arg3 <= 10000, 1);
        assert!(arg4 <= 10000, 1);
        let v0 = FeesWritten{
            wallet_address : arg2,
            streamflow_fee : arg3,
            partner_fee    : arg4,
        };
        0x2::event::emit<FeesWritten>(v0);
        remove_from_fee_table(arg1, arg2);
        let v1 = FeeValue{
            streamflow_fee : arg3,
            partner_fee    : arg4,
        };
        0x2::table::add<address, FeeValue>(&mut arg1.values, arg2, v1);
    }

    public fun get_fees(arg0: &FeeTable, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: address) : FeeValue {
        if (0x2::table::contains<address, FeeValue>(&arg0.values, arg2)) {
            *0x2::table::borrow<address, FeeValue>(&arg0.values, arg2)
        } else {
            FeeValue{streamflow_fee: 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::get_streamflow_fee(arg1), partner_fee: 0}
        }
    }

    public fun get_partner_fee(arg0: &FeeTable, arg1: &0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin::Config, arg2: address) : u64 {
        let v0 = get_fees(arg0, arg1, arg2);
        v0.partner_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeTable{
            id      : 0x2::object::new(arg0),
            values  : 0x2::table::new<address, FeeValue>(arg0),
            version : 1,
        };
        0x2::transfer::share_object<FeeTable>(v0);
    }

    fun remove_from_fee_table(arg0: &mut FeeTable, arg1: address) {
        if (0x2::table::contains<address, FeeValue>(&arg0.values, arg1)) {
            0x2::table::remove<address, FeeValue>(&mut arg0.values, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

