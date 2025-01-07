module 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun add_referral_tier(arg0: &AdminCap, arg1: &mut 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::ReferralTiers, arg2: u64, arg3: u64, arg4: u64) {
        0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::add_tier(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_referral_tier(arg0: &AdminCap, arg1: &mut 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::ReferralTiers, arg2: u64) {
        let (_, _) = 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::referral_tiers::remove_tier(arg1, arg2);
    }

    public entry fun set_contract_version(arg0: &AdminCap, arg1: &mut 0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::Version, arg2: u64) {
        0x1bf5a8ce77050d8052549d743e16b469f15aa6b81b752b78b6ebb65179665f5a::version::set_version(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

