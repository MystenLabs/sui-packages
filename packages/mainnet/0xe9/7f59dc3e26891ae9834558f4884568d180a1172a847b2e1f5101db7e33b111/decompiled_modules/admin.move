module 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::admin {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AdminCapV2 has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_referral_tier(arg0: &AdminCap, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::ReferralTiers, arg2: u64, arg3: u64, arg4: u64) {
        abort 0
    }

    public entry fun add_referral_tier_v2(arg0: &AdminCapV2, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::ReferralTiers, arg2: u64, arg3: u64, arg4: u64) {
        0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::add_tier(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_referral_tier(arg0: &AdminCap, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::ReferralTiers, arg2: u64) {
        abort 0
    }

    public entry fun remove_referral_tier_v2(arg0: &AdminCapV2, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::ReferralTiers, arg2: u64) {
        let (_, _) = 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::referral_tiers::remove_tier(arg1, arg2);
    }

    public entry fun set_contract_version(arg0: &AdminCap, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::version::Version, arg2: u64) {
        abort 0
    }

    public entry fun set_contract_version_v2(arg0: &AdminCapV2, arg1: &mut 0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::version::Version, arg2: u64) {
        0x5658d4bf5ddcba27e4337b4262108b3ad1716643cac8c2054ac341538adc72ec::version::set_version(arg1, arg2);
    }

    public fun upgrade_admin_cap(arg0: AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCapV2 {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        AdminCapV2{id: 0x2::object::new(arg1)}
    }

    // decompiled from Move bytecode v6
}

