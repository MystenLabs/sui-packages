module 0x488d12e10a3fb486df411a9d2f5ee9719280640065847aa6127ff2f501864ebb::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_recipient: address,
        fee_rate: u64,
    }

    struct FeeConfigUpdated has copy, drop {
        new_recipient: address,
        new_rate: u64,
    }

    public fun fee_rate(arg0: &FeeConfig) : u64 {
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
            fee_recipient : 0x2::tx_context::sender(arg0),
            fee_rate      : 1,
        };
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    entry fun update_fee_config(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address, arg3: u64) {
        arg1.fee_recipient = arg2;
        arg1.fee_rate = arg3;
        let v0 = FeeConfigUpdated{
            new_recipient : arg2,
            new_rate      : arg3,
        };
        0x2::event::emit<FeeConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

