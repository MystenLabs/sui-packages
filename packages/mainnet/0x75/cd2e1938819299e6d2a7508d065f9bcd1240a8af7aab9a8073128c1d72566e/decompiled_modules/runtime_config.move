module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::runtime_config {
    struct RuntimeConfig has key {
        id: 0x2::object::UID,
        protocol_fee_share: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        treasury: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RuntimeConfig{
            id                 : 0x2::object::new(arg0),
            protocol_fee_share : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::new(0),
            treasury           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<RuntimeConfig>(v0);
    }

    public fun set_protocol_fee_share(arg0: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::AdminCap, arg1: &mut RuntimeConfig, arg2: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps) {
        arg1.protocol_fee_share = arg2;
    }

    public fun set_treasury(arg0: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::AdminCap, arg1: &mut RuntimeConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun treasury(arg0: &RuntimeConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v7
}

