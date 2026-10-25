module 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::launch_config {
    struct ProtocolAllocation has copy, drop, store {
        meme_bps: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        quote_bps: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
    }

    struct LaunchConfig has key {
        id: 0x2::object::UID,
        quote_fee_bps: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        meme_fee_bps: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps,
        creation_fee: u64,
        protocol_allocation: ProtocolAllocation,
        meme_decimals: vector<u8>,
    }

    public fun creation_fee(arg0: &LaunchConfig) : u64 {
        arg0.creation_fee
    }

    fun fresh(arg0: &mut 0x2::tx_context::TxContext) : LaunchConfig {
        let v0 = ProtocolAllocation{
            meme_bps  : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::new(0),
            quote_bps : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::new(0),
        };
        LaunchConfig{
            id                  : 0x2::object::new(arg0),
            quote_fee_bps       : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::new(100),
            meme_fee_bps        : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::new(0),
            creation_fee        : 0,
            protocol_allocation : v0,
            meme_decimals       : x"0609",
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<LaunchConfig>(fresh(arg0));
    }

    public fun meme_fee(arg0: &LaunchConfig) : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps {
        arg0.meme_fee_bps
    }

    public fun quote_fee(arg0: &LaunchConfig) : 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps {
        arg0.quote_fee_bps
    }

    public fun set_creation_fee(arg0: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::AdminCap, arg1: &mut LaunchConfig, arg2: u64) {
        arg1.creation_fee = arg2;
    }

    public fun set_trade_fees(arg0: &0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::blast_fun::AdminCap, arg1: &mut LaunchConfig, arg2: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps, arg3: 0x75cd2e1938819299e6d2a7508d065f9bcd1240a8af7aab9a8073128c1d72566e::bps::Bps) {
        arg1.quote_fee_bps = arg2;
        arg1.meme_fee_bps = arg3;
    }

    // decompiled from Move bytecode v7
}

