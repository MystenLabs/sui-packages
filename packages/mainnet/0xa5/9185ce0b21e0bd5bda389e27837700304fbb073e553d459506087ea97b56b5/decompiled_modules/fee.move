module 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::fee {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        version: u64,
        fee_rate: u32,
        fee_recipient: address,
    }

    struct SetFeeRateEvent has copy, drop {
        old_fee_rate: u32,
        new_fee_rate: u32,
    }

    struct SetFeeRecipientEvent has copy, drop {
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    public fun assert_valid_version(arg0: &FeeConfig) {
        assert!(arg0.version == 1, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::invalid_version());
    }

    public fun fee_rate(arg0: &FeeConfig) : u32 {
        arg0.fee_rate
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeConfig{
            id            : 0x2::object::new(arg0),
            version       : 1,
            fee_rate      : 0,
            fee_recipient : @0x0,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut FeeConfig) {
        assert!(arg1.version < 1, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::invalid_version());
        arg1.version = 1;
    }

    public fun set_fee_rate(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u32) {
        assert!(arg2 <= 20000, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::too_large_fee_rate());
        if (arg2 > 0) {
            assert!(arg1.fee_recipient != @0x0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::invalid_fee_recipient());
        };
        arg1.fee_rate = arg2;
        let v0 = SetFeeRateEvent{
            old_fee_rate : arg1.fee_rate,
            new_fee_rate : arg2,
        };
        0x2::event::emit<SetFeeRateEvent>(v0);
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        if (arg1.fee_rate > 0) {
            assert!(arg2 != @0x0, 0xa59185ce0b21e0bd5bda389e27837700304fbb073e553d459506087ea97b56b5::errors::invalid_fee_recipient());
        };
        arg1.fee_recipient = arg2;
        let v0 = SetFeeRecipientEvent{
            old_fee_recipient : arg1.fee_recipient,
            new_fee_recipient : arg2,
        };
        0x2::event::emit<SetFeeRecipientEvent>(v0);
    }

    public fun version(arg0: &FeeConfig) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

