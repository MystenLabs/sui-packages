module 0x1579dd8a6677290d2effda38842fdddd0905a59b2285c6b8b88dfccaf1d02319::dust_converter {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Fees has key {
        id: 0x2::object::UID,
        platform_fee_percentage: u64,
        tier1_volume: u64,
        tier1_percentage: u64,
        tier2_volume: u64,
        tier2_percentage: u64,
        tier3_volume: u64,
        tier3_percentage: u64,
        tier4_volume: u64,
        tier4_percentage: u64,
    }

    struct ReferralState has store, key {
        id: 0x2::object::UID,
        referral_tag: vector<u8>,
        volume: u64,
        acumulated_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ReferralRegistry has key {
        id: 0x2::object::UID,
        referrals: 0x2::table::Table<address, ReferralState>,
        referral_tags: 0x2::table::Table<vector<u8>, address>,
    }

    public entry fun claim_accumulated_fees(arg0: &mut ReferralRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = get_acumulated_fees(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun collect_fee(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut Treasury, arg2: &mut ReferralRegistry, arg3: &Fees, arg4: 0x1::option::Option<vector<u8>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&v0);
        let v2 = v1 * arg3.platform_fee_percentage / 10000;
        let v3 = v2;
        if (0x1::option::is_some<vector<u8>>(&arg4)) {
            let v4 = 0x1::option::borrow<vector<u8>>(&arg4);
            let v5 = evaluate_tier(v4, arg2, v1, arg3);
            let v6 = v2 * v5 / 10000;
            v3 = v2 - v6;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v0, v6), arg5), *0x2::table::borrow<vector<u8>, address>(&arg2.referral_tags, *v4));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.treasury_balance, 0x2::balance::split<0x2::sui::SUI>(&mut v0, v3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg5), 0x2::tx_context::sender(arg5));
    }

    fun evaluate_tier(arg0: &vector<u8>, arg1: &mut ReferralRegistry, arg2: u64, arg3: &Fees) : u64 {
        let v0 = 0x2::table::borrow_mut<address, ReferralState>(&mut arg1.referrals, *0x2::table::borrow<vector<u8>, address>(&arg1.referral_tags, *arg0));
        v0.volume = v0.volume + arg2;
        let v1 = v0.volume;
        let v2 = &v1;
        if (*v2 < arg3.tier1_volume) {
            arg3.tier1_percentage
        } else if (*v2 < arg3.tier2_volume) {
            arg3.tier2_percentage
        } else if (*v2 < arg3.tier3_volume) {
            arg3.tier3_percentage
        } else {
            arg3.tier4_percentage
        }
    }

    fun get_acumulated_fees(arg0: &mut ReferralRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, ReferralState>(&arg0.referrals, v0), 201);
        let v1 = 0x2::table::borrow_mut<address, ReferralState>(&mut arg0.referrals, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.acumulated_fees) > 0, 202);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.acumulated_fees), arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id               : 0x2::object::new(arg0),
            treasury_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = ReferralRegistry{
            id            : 0x2::object::new(arg0),
            referrals     : 0x2::table::new<address, ReferralState>(arg0),
            referral_tags : 0x2::table::new<vector<u8>, address>(arg0),
        };
        0x2::transfer::share_object<ReferralRegistry>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_referral(arg0: vector<u8>, arg1: &mut ReferralRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, ReferralState>(&arg1.referrals, v0), 200);
        let v1 = ReferralState{
            id              : 0x2::object::new(arg2),
            referral_tag    : arg0,
            volume          : 0,
            acumulated_fees : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::table::add<address, ReferralState>(&mut arg1.referrals, v0, v1);
        0x2::table::add<vector<u8>, address>(&mut arg1.referral_tags, arg0, v0);
    }

    public entry fun set_fees(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = Fees{
            id                      : 0x2::object::new(arg10),
            platform_fee_percentage : arg1,
            tier1_volume            : arg2,
            tier1_percentage        : arg3,
            tier2_volume            : arg4,
            tier2_percentage        : arg5,
            tier3_volume            : arg6,
            tier3_percentage        : arg7,
            tier4_volume            : arg8,
            tier4_percentage        : arg9,
        };
        0x2::transfer::transfer<Fees>(v0, 0x2::tx_context::sender(arg10));
    }

    public entry fun withdraw_royalties(arg0: &AdminCap, arg1: &mut ReferralRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, ReferralState>(&arg1.referrals, v0), 201);
        let v1 = 0x2::table::borrow_mut<address, ReferralState>(&mut arg1.referrals, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v1.acumulated_fees) > 0, 202);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut v1.acumulated_fees), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

