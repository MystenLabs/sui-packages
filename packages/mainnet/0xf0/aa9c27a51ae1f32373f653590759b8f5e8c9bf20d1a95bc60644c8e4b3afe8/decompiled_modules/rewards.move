module 0xf0aa9c27a51ae1f32373f653590759b8f5e8c9bf20d1a95bc60644c8e4b3afe8::rewards {
    struct ClaimableReward has copy, drop {
        market_id: u64,
        reward_type: 0x1::type_name::TypeName,
    }

    public fun market_id(arg0: &ClaimableReward) : u64 {
        arg0.market_id
    }

    public fun reward_type(arg0: &ClaimableReward) : 0x1::type_name::TypeName {
        arg0.reward_type
    }

    // decompiled from Move bytecode v6
}

