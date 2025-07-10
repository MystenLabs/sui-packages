module 0xf21b62bedc431ffe2b002ec0d37c5b54c5c937c02421d6ade2e3e1cf5059b9e1::fee_collector {
    struct FeeConfig has key {
        id: 0x2::object::UID,
        owner: address,
        fee_percentage: u64,
        total_collected: u64,
    }

    public fun calculate_fee(arg0: &FeeConfig, arg1: u64) : u64 {
        arg1 * arg0.fee_percentage / 10000
    }

    public fun get_fee_info(arg0: &FeeConfig) : (address, u64, u64) {
        (arg0.owner, arg0.fee_percentage, arg0.total_collected)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            fee_percentage  : 2000,
            total_collected : 0,
        };
        0x2::transfer::share_object<FeeConfig>(v0);
    }

    public fun record_fee(arg0: &mut FeeConfig, arg1: u64) {
        arg0.total_collected = arg0.total_collected + arg1;
    }

    public entry fun update_fee_percentage(arg0: &mut FeeConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 <= 5000, 1);
        arg0.fee_percentage = arg1;
    }

    // decompiled from Move bytecode v6
}

