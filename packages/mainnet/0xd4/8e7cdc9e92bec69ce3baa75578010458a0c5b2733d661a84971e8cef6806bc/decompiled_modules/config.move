module 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        protocol_fee_account: address,
    }

    struct UpdatedConfig has copy, drop {
        sender: address,
        max_commission_bps: u64,
        protocol_fee_bps: u64,
        protocol_fee_account: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                   : 0x2::object::new(arg0),
            max_commission_bps   : 500,
            protocol_fee_bps     : 2000,
            protocol_fee_account : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun max_commission_bps(arg0: &Config) : u64 {
        arg0.max_commission_bps
    }

    public fun protocol_fee_account(arg0: &Config) : address {
        arg0.protocol_fee_account
    }

    public fun protocol_fee_bps(arg0: &Config) : u64 {
        arg0.protocol_fee_bps
    }

    public fun update(arg0: &0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000 && arg2 > 0, 0);
        assert!(arg3 <= 5000 && arg3 >= 0, 0);
        arg1.max_commission_bps = arg2;
        arg1.protocol_fee_bps = arg3;
        arg1.protocol_fee_account = arg4;
        let v0 = UpdatedConfig{
            sender               : 0x2::tx_context::sender(arg5),
            max_commission_bps   : arg2,
            protocol_fee_bps     : arg3,
            protocol_fee_account : arg4,
        };
        0x2::event::emit<UpdatedConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

