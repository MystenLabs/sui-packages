module 0xcecac1d9cafdc922a8974675c32a53473e43f227d34c8695a94413c723832633::vault_fee_record {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RecordCap has store, key {
        id: 0x2::object::UID,
    }

    struct PerformanceFeeRecord has store {
        total_claimed: u64,
        total_active_cumulated: u64,
    }

    struct VaultPerformanceFeeRecord has store, key {
        id: 0x2::object::UID,
        fees: 0x2::table::Table<address, PerformanceFeeRecord>,
    }

    public fun claim_performance_fee(arg0: &mut VaultPerformanceFeeRecord, arg1: &RecordCap, arg2: address, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<address, PerformanceFeeRecord>(&mut arg0.fees, arg2);
        assert!(v0.total_active_cumulated >= arg3, 1001);
        v0.total_claimed = v0.total_claimed + arg3;
        v0.total_active_cumulated = v0.total_active_cumulated - arg3;
    }

    public fun create_fee_record(arg0: &mut VaultPerformanceFeeRecord, arg1: &AdminCap, arg2: address) {
        let v0 = PerformanceFeeRecord{
            total_claimed          : 0,
            total_active_cumulated : 0,
        };
        0x2::table::add<address, PerformanceFeeRecord>(&mut arg0.fees, arg2, v0);
    }

    public fun create_record_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = RecordCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<RecordCap>(v0, arg1);
    }

    public fun cumulate_performance_fee(arg0: &mut VaultPerformanceFeeRecord, arg1: &RecordCap, arg2: address, arg3: u64) {
        assert!(0x2::table::contains<address, PerformanceFeeRecord>(&arg0.fees, arg2), 1002);
        let v0 = 0x2::table::borrow_mut<address, PerformanceFeeRecord>(&mut arg0.fees, arg2);
        v0.total_active_cumulated = v0.total_active_cumulated + arg3;
    }

    public fun get_cumulated_performance_fee(arg0: &VaultPerformanceFeeRecord, arg1: address) : u64 {
        0x2::table::borrow<address, PerformanceFeeRecord>(&arg0.fees, arg1).total_active_cumulated
    }

    public fun get_total_claimed_performance_fee(arg0: &VaultPerformanceFeeRecord, arg1: address) : u64 {
        0x2::table::borrow<address, PerformanceFeeRecord>(&arg0.fees, arg1).total_claimed
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = VaultPerformanceFeeRecord{
            id   : 0x2::object::new(arg0),
            fees : 0x2::table::new<address, PerformanceFeeRecord>(arg0),
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<VaultPerformanceFeeRecord>(v1);
    }

    // decompiled from Move bytecode v6
}

