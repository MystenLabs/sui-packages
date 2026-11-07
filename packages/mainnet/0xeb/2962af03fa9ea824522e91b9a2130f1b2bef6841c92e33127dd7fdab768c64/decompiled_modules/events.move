module 0xeb2962af03fa9ea824522e91b9a2130f1b2bef6841c92e33127dd7fdab768c64::events {
    struct CetusPoolReserved<phantom T0, phantom T1> has copy, drop {
        pool_creation_cap_id: 0x2::object::ID,
        tick_spacing: u32,
    }

    struct BluefinPoolTierRecorded<phantom T0, phantom T1> has copy, drop {
        tick_spacing: u32,
        fee_rate: u64,
    }

    public(friend) fun bluefin_pool_tier_recorded<T0, T1>(arg0: u32, arg1: u64) {
        let v0 = BluefinPoolTierRecorded<T0, T1>{
            tick_spacing : arg0,
            fee_rate     : arg1,
        };
        0x2::event::emit<BluefinPoolTierRecorded<T0, T1>>(v0);
    }

    public(friend) fun cetus_pool_reserved<T0, T1>(arg0: 0x2::object::ID, arg1: u32) {
        let v0 = CetusPoolReserved<T0, T1>{
            pool_creation_cap_id : arg0,
            tick_spacing         : arg1,
        };
        0x2::event::emit<CetusPoolReserved<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

