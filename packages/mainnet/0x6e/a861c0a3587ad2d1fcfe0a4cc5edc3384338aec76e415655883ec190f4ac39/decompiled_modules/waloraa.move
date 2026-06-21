module 0x6ea861c0a3587ad2d1fcfe0a4cc5edc3384338aec76e415655883ec190f4ac39::waloraa {
    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        protocol_fee_bps: u64,
        keeper_reward_bps: u64,
    }

    public fun admin(arg0: &ProtocolConfig) : address {
        arg0.admin
    }

    public fun bps_denom() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ProtocolConfig>(new_config(arg0));
    }

    public fun keeper_reward_bps(arg0: &ProtocolConfig) : u64 {
        arg0.keeper_reward_bps
    }

    fun new_config(arg0: &mut 0x2::tx_context::TxContext) : ProtocolConfig {
        let v0 = 0x2::tx_context::sender(arg0);
        ProtocolConfig{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            treasury          : v0,
            protocol_fee_bps  : 200,
            keeper_reward_bps : 10,
        }
    }

    public fun protocol_fee_bps(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee_bps
    }

    public fun set_fees(arg0: &mut ProtocolConfig, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 100);
        assert!(arg1 <= 1000, 101);
        assert!(arg2 <= 500, 101);
        arg0.protocol_fee_bps = arg1;
        arg0.keeper_reward_bps = arg2;
    }

    public fun set_treasury(arg0: &mut ProtocolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.treasury = arg1;
    }

    public fun transfer_admin(arg0: &mut ProtocolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.admin = arg1;
    }

    public fun treasury(arg0: &ProtocolConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

