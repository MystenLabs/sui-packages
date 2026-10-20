module 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::royalty {
    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        amount_bps: u64,
        min_amount_mist: u64,
    }

    struct KioskLockRule has drop {
        dummy_field: bool,
    }

    struct KioskLockConfig has drop, store {
        dummy_field: bool,
    }

    struct RoyaltyProceeds has drop {
        dummy_field: bool,
    }

    struct PolicyVault<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        version: u64,
        policy_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        cap: 0x2::transfer_policy::TransferPolicyCap<T0>,
    }

    struct PolicyCreated has copy, drop {
        policy_id: 0x2::object::ID,
        policy_vault_id: 0x2::object::ID,
        amount_bps: u64,
        min_amount_mist: u64,
        coin_type: 0x1::type_name::TypeName,
    }

    struct RoyaltyUpdated has copy, drop {
        policy_id: 0x2::object::ID,
        amount_bps: u64,
        min_amount_mist: u64,
    }

    struct RoyaltyPaid has copy, drop {
        policy_id: 0x2::object::ID,
        item_id: 0x2::object::ID,
        paid: u64,
        royalty: u64,
    }

    struct RoyaltiesSwept has copy, drop {
        policy_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_royalty_bounds(arg0: u64, arg1: u64) {
        assert!(arg0 <= 1000, 13906835570208145415);
        assert!(arg1 <= 10000000000, 13906835574503243785);
    }

    public fun create_policy<T0, T1: store + key>(arg0: &mut 0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::ShopRegistry, arg1: &0x2::package::Publisher, arg2: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert_royalty_bounds(arg3, arg4);
        assert!(!0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::has_canonical_policy<T1>(arg0), 13906834865834426389);
        let (v0, v1) = new_policy<T0, T1>(arg1, arg3, arg4, arg5);
        0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::register_canonical_policy<T1>(arg0, v0, v1);
        v0
    }

    public fun migrate<T0: store + key>(arg0: &mut PolicyVault<T0>, arg1: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap) {
        assert!(arg0.version < 1, 13906835037632069637);
        arg0.version = 1;
    }

    fun new_policy<T0, T1: store + key>(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x1::type_name::TypeName) {
        let (v0, v1) = 0x2::transfer_policy::new<T1>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = RoyaltyRule{dummy_field: false};
        let v5 = RoyaltyConfig{
            amount_bps      : arg1,
            min_amount_mist : arg2,
        };
        0x2::transfer_policy::add_rule<T1, RoyaltyRule, RoyaltyConfig>(v4, &mut v3, &v2, v5);
        let v6 = KioskLockRule{dummy_field: false};
        let v7 = KioskLockConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T1, KioskLockRule, KioskLockConfig>(v6, &mut v3, &v2, v7);
        let v8 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<T1>>(&v3);
        let v9 = 0x1::type_name::with_original_ids<T0>();
        let v10 = PolicyVault<T1>{
            id        : 0x2::object::new(arg3),
            version   : 1,
            policy_id : v8,
            coin_type : v9,
            cap       : v2,
        };
        let v11 = PolicyCreated{
            policy_id       : v8,
            policy_vault_id : 0x2::object::id<PolicyVault<T1>>(&v10),
            amount_bps      : arg1,
            min_amount_mist : arg2,
            coin_type       : v9,
        };
        0x2::event::emit<PolicyCreated>(v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T1>>(v3);
        0x2::transfer::share_object<PolicyVault<T1>>(v10);
        (v8, v9)
    }

    public fun pay_royalty<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer_policy::paid<T0>(arg1);
        let v1 = royalty_amount<T0>(arg0, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v1, 13906835110646906891);
        let v2 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<T0, RoyaltyRule>(v2, arg0, 0x2::coin::split<0x2::sui::SUI>(arg2, v1, arg3));
        let v3 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v3, arg1);
        let v4 = RoyaltyPaid{
            policy_id : 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg0),
            item_id   : 0x2::transfer_policy::item<T0>(arg1),
            paid      : v0,
            royalty   : v1,
        };
        0x2::event::emit<RoyaltyPaid>(v4);
    }

    public fun policy_coin_type<T0: store + key>(arg0: &PolicyVault<T0>) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun policy_id<T0: store + key>(arg0: &PolicyVault<T0>) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun prove_locked<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::kiosk::Kiosk) {
        let v0 = 0x2::transfer_policy::item<T0>(arg1);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, v0) && 0x2::kiosk::is_locked(arg2, v0), 13906835200841351181);
        let v1 = KioskLockRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, KioskLockRule>(v1, arg1);
    }

    public fun royalty_amount<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        0x1::u64::max(0x1::u64::mul_div(arg1, v1.amount_bps, 10000), v1.min_amount_mist)
    }

    public fun set_royalty<T0: store + key>(arg0: &PolicyVault<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg2: &0x3eb28ecd40707945465a5031c4aa01e68e0e9ae20035b98073d099ea9f2815d5::shop::CommerceAdminCap, arg3: u64, arg4: u64) {
        assert!(arg0.version == 1, 13906834938847821829);
        assert!(arg0.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<T0>>(arg1), 13906834943143444495);
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg1);
        assert!(arg3 != v1.amount_bps || arg4 != v1.min_amount_mist, 13906834960323444753);
        assert_royalty_bounds(arg3, arg4);
        0x2::transfer_policy::remove_rule<T0, RoyaltyRule, RoyaltyConfig>(arg1, &arg0.cap);
        let v2 = RoyaltyRule{dummy_field: false};
        let v3 = RoyaltyConfig{
            amount_bps      : arg3,
            min_amount_mist : arg4,
        };
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v2, arg1, &arg0.cap, v3);
        let v4 = RoyaltyUpdated{
            policy_id       : arg0.policy_id,
            amount_bps      : arg3,
            min_amount_mist : arg4,
        };
        0x2::event::emit<RoyaltyUpdated>(v4);
    }

    public fun sweep_royalties<T0, T1: store + key>(arg0: &PolicyVault<T1>, arg1: &mut 0x2::transfer_policy::TransferPolicy<T1>, arg2: &mut 0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::FeeVault<T0>, arg3: &0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::config::EconomyConfig<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 13906835273855270917);
        assert!(arg0.policy_id == 0x2::object::id<0x2::transfer_policy::TransferPolicy<T1>>(arg1), 13906835278150893583);
        assert!(0x1::type_name::with_original_ids<T0>() == arg0.coin_type, 13906835282446123027);
        let v0 = 0x2::transfer_policy::withdraw<T1>(arg1, &arg0.cap, 0x1::option::none<u64>(), arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            return
        };
        let v2 = RoyaltyProceeds{dummy_field: false};
        0x94bb2ec96ef3570244a7e505fc48fc642523997297993fb6d47f8948b58a4bc5::treasury::deposit<T0, RoyaltyProceeds>(arg2, arg3, v2, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        let v3 = RoyaltiesSwept{
            policy_id : arg0.policy_id,
            amount    : v1,
        };
        0x2::event::emit<RoyaltiesSwept>(v3);
    }

    // decompiled from Move bytecode v7
}

