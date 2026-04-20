module 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::fee {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_rate: u32,
        fee_recipient: address,
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
            fee_rate      : 0,
            fee_recipient : @0x0,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public fun set_fee_rate(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u32) {
        assert!(arg2 <= 100000, 0x116e7522cc0685e2cfd00f8fe37bcf153e2aa6bbd9978307f3c50a60a873315e::errors::too_large_fee_rate());
        arg1.fee_rate = arg2;
    }

    public fun set_fee_recipient(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    // decompiled from Move bytecode v7
}

