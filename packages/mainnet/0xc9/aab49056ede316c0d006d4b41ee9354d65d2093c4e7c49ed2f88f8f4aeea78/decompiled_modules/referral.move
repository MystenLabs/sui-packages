module 0xc9aab49056ede316c0d006d4b41ee9354d65d2093c4e7c49ed2f88f8f4aeea78::referral {
    struct Referral has copy, drop, store {
        dummy_field: bool,
    }

    struct ReferralRegistryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReferralRegistry has store, key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        is_enabled: bool,
        default_referrer_rate: u64,
        default_partner_rate: u64,
        commission_multiplier: u64,
        max_wagered_usd_to_set_referrer: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        level_up_usd_rewards_per_referee: 0x2::vec_map::VecMap<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>,
    }

    struct ReferrerKey has copy, drop, store {
        referrer: address,
    }

    struct ReferrerData has store, key {
        id: 0x2::object::UID,
        number_of_referee: u64,
        is_partner: bool,
        partner_share_rate: u64,
        special_commission_rate: 0x1::option::Option<u64>,
        special_partner_commission_rate: 0x1::option::Option<u64>,
        usd_rewards_balance: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct ReferrerBalanceKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct ReferrerBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        commission_balance: u64,
    }

    struct PartnerBalanceKey has copy, drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct PartnerBalance<phantom T0> has store, key {
        id: 0x2::object::UID,
        commission_balance: u64,
    }

    struct RefereeKey has copy, drop, store {
        referee: address,
    }

    struct PlayerWagerKey has copy, drop, store {
        player: address,
    }

    struct PlayerWagerData has store, key {
        id: 0x2::object::UID,
        total_wagered_usd: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct RefereeData has store, key {
        id: 0x2::object::UID,
        referrer: address,
        max_rewarded_vip_level: u64,
        date_referred_timestamp_ms: u64,
    }

    struct ReferralCreatedEvent has copy, drop {
        referrer: address,
        referee: address,
        partner: 0x1::option::Option<address>,
    }

    struct ReferrerClaimCommissionBalanceEvent<phantom T0> has copy, drop {
        referrer: address,
        amount: u64,
    }

    struct PartnerClaimBalanceEvent<phantom T0> has copy, drop {
        partner: address,
        amount: u64,
    }

    struct ReferrerClaimLevelUpUsdRewardsEvent has copy, drop {
        referrer: address,
        usd_amount: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        dollar_coin_type: 0x1::type_name::TypeName,
        dollar_amount: u64,
    }

    struct ReferrerDataEditedEvent has copy, drop {
        referrer: address,
        special_commission_rate: 0x1::option::Option<u64>,
        special_partner_commission_rate: 0x1::option::Option<u64>,
        partner_share_rate: 0x1::option::Option<u64>,
    }

    struct PartnerStatusEditedEvent has copy, drop {
        referrer: address,
        is_partner: bool,
    }

    struct ReferralRegistryEditedEvent has copy, drop {
        is_enabled: bool,
        default_referrer_rate: u64,
        default_partner_rate: u64,
        commission_multiplier: u64,
        max_wagered_usd_to_set_referrer: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        level_up_usd_rewards_per_referee: 0x2::vec_map::VecMap<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>,
    }

    struct ReferralRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        default_referrer_rate: u64,
        default_partner_rate: u64,
        commission_multiplier: u64,
        max_wagered_usd_to_set_referrer: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
    }

    struct ReferralRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct ReferrerLevelUpUsdRewardEvent has copy, drop {
        referrer: address,
        referee: address,
        usd_amount: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float,
        level: u64,
    }

    struct ReferrerCommissionEvent<phantom T0> has copy, drop {
        referrer: address,
        referee: address,
        amount: u64,
    }

    struct PartnerCommissionEvent<phantom T0> has copy, drop {
        partner: address,
        player: address,
        amount: u64,
    }

    fun accrue_total_wagered_usd(arg0: &mut ReferralRegistry, arg1: address, arg2: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerWagerKey{player: arg1};
        if (0x2::dynamic_object_field::exists_<PlayerWagerKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<PlayerWagerKey, PlayerWagerData>(&mut arg0.id, v0);
            v1.total_wagered_usd = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v1.total_wagered_usd, arg2);
        } else {
            let v2 = PlayerWagerData{
                id                : 0x2::object::new(arg3),
                total_wagered_usd : arg2,
            };
            0x2::dynamic_object_field::add<PlayerWagerKey, PlayerWagerData>(&mut arg0.id, v0, v2);
        };
    }

    public fun admin_add_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        if (!0x2::vec_set::contains<u64>(&v0.version_set, &arg2)) {
            0x2::vec_set::insert<u64>(&mut v0.version_set, arg2);
            let v1 = ReferralRegistryVersionChangedEvent{
                version_number : arg2,
                is_added       : true,
            };
            0x2::event::emit<ReferralRegistryVersionChangedEvent>(v1);
        };
    }

    public fun admin_create_empty_referrer_data(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        create_empty_referrer_data_internal(arg0, arg2, arg3);
    }

    public fun admin_create_referral_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_referral_registry_internal(arg0, arg2);
    }

    public fun admin_edit_referral_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: 0x2::vec_map::VecMap<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>) {
        edit_referral_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_edit_referrer_data(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>) {
        edit_referrer_data_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::AdminCap, arg2: u64) {
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    fun apply_commission_multiplier(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    fun assert_valid_commission_multiplier(arg0: u64) {
        assert!(arg0 >= 200000000 && arg0 <= 1000000000, 13841814957964460074);
    }

    fun assert_valid_version(arg0: &ReferralRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13841251621463719974);
    }

    public fun borrow_referral_registry(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &ReferralRegistry {
        let v0 = borrow_referral_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_referral_registry_mut(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut ReferralRegistry {
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_referral_registry_mut_unchecked(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &mut ReferralRegistry {
        let v0 = Referral{dummy_field: false};
        let v1 = ReferralRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_borrow_operator_dof_mut<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v0, v1)
    }

    fun borrow_referral_registry_unchecked(arg0: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse) : &ReferralRegistry {
        let v0 = ReferralRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::borrow_operator_dof<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v0)
    }

    fun can_set_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        let v0 = get_total_wagered_usd(arg0, arg1);
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::le(&v0, &arg0.max_wagered_usd_to_set_referrer)
    }

    public fun claim_commission_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_referral_registry_mut(arg0);
        let v3 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v2.id, v3), 13835342837384151048);
        let v4 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v3);
        let v5 = ReferrerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v4.id, v5), 13835342880333824008);
        let v6 = ReferrerBalanceKey{pos0: v1};
        let v7 = 0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v4.id, v6);
        let v8 = v7.commission_balance;
        if (v8 > 0) {
            v7.commission_balance = 0;
        };
        if (v8 > 0) {
            let v10 = Referral{dummy_field: false};
            let v11 = ReferrerClaimCommissionBalanceEvent<T0>{
                referrer : v0,
                amount   : v8,
            };
            0x2::event::emit<ReferrerClaimCommissionBalanceEvent<T0>>(v11);
            0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v10, v8), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun claim_partner_balance<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_referral_registry_mut(arg0);
        let v3 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v2.id, v3), 13835343086492254216);
        let v4 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v3);
        assert!(v4.is_partner, 13840128191162548254);
        let v5 = PartnerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<PartnerBalanceKey>(&v4.id, v5), 13835343133736894472);
        let v6 = PartnerBalanceKey{pos0: v1};
        let v7 = 0x2::dynamic_object_field::borrow_mut<PartnerBalanceKey, PartnerBalance<T0>>(&mut v4.id, v6);
        let v8 = v7.commission_balance;
        if (v8 > 0) {
            v7.commission_balance = 0;
        };
        if (v8 > 0) {
            let v10 = Referral{dummy_field: false};
            let v11 = PartnerClaimBalanceEvent<T0>{
                partner : v0,
                amount  : v8,
            };
            0x2::event::emit<PartnerClaimBalanceEvent<T0>>(v11);
            0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v10, v8), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun claim_referrer_level_up_usd_rewards<T0>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_dollar_coin_type(arg0) == v1, 13835624793397329930);
        let v2 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::get_coin_decimals<T0>(arg0);
        let v3 = borrow_referral_registry_mut(arg0);
        let v4 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v3.id, v4), 13835343374255063048);
        let v5 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v3.id, v4).usd_rewards_balance;
        let (v6, v7, _) = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::get_checked_usd_price(arg0, v1, arg1, arg2);
        let v9 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::oracle::price_upper_bound(v6, v7);
        let v10 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::floor_to_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(v5, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::math::pow_u64(10, (v2 as u64)))), v9));
        let v11 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::div(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::mul(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(v10), v9), 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::math::pow_u64(10, (v2 as u64))));
        let v12 = borrow_referral_registry_mut(arg0);
        let v13 = ReferrerKey{referrer: v0};
        0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v12.id, v13).usd_rewards_balance = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::positive_part(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::sub(v5, v11));
        let v14 = Referral{dummy_field: false};
        let v15 = ReferrerClaimLevelUpUsdRewardsEvent{
            referrer         : v0,
            usd_amount       : v11,
            dollar_coin_type : 0x1::type_name::with_defining_ids<T0>(),
            dollar_amount    : v10,
        };
        0x2::event::emit<ReferrerClaimLevelUpUsdRewardsEvent>(v15);
        0x2::coin::from_balance<T0>(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v14, v10), arg3)
    }

    fun create_empty_referrer_data_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferrerKey{referrer: arg1};
        let v1 = ReferrerData{
            id                              : 0x2::object::new(arg2),
            number_of_referee               : 0,
            is_partner                      : false,
            partner_share_rate              : 500000000,
            special_commission_rate         : 0x1::option::none<u64>(),
            special_partner_commission_rate : 0x1::option::none<u64>(),
            usd_rewards_balance             : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
        };
        0x2::dynamic_object_field::add<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v0, v1);
    }

    fun create_referral_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRegistry{
            id                               : 0x2::object::new(arg1),
            version_set                      : 0x2::vec_set::singleton<u64>(0),
            is_enabled                       : true,
            default_referrer_rate            : 3000000,
            default_partner_rate             : 3000000,
            commission_multiplier            : 250000000,
            max_wagered_usd_to_set_referrer  : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(18446744073709551615),
            level_up_usd_rewards_per_referee : 0x2::vec_map::empty<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(),
        };
        let v1 = Referral{dummy_field: false};
        let v2 = ReferralRegistryKey{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_add_operator_dof<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v1, v2, v0);
        let v3 = ReferralRegistryCreatedEvent{
            registry_id                     : 0x2::object::id<ReferralRegistry>(&v0),
            is_enabled                      : true,
            default_referrer_rate           : 3000000,
            default_partner_rate            : 3000000,
            commission_multiplier           : 250000000,
            max_wagered_usd_to_set_referrer : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(18446744073709551615),
        };
        0x2::event::emit<ReferralRegistryCreatedEvent>(v3);
    }

    fun edit_referral_registry_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg6: 0x2::vec_map::VecMap<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>) {
        let v0 = borrow_referral_registry_mut(arg0);
        assert!(arg2 <= 10000000, 13837594100327841814);
        assert!(arg3 <= 10000000, 13838438542437974040);
        assert_valid_commission_multiplier(arg4);
        assert!(!0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_negative(&arg5), 13840971838703992868);
        let (_, v2) = 0x2::vec_map::into_keys_values<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(arg6);
        let v3 = v2;
        let v4 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::from_u64(18446744073709551615);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v3)) {
            assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::is_positive_or_zero(0x1::vector::borrow<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v3, v5)), 13839283018907844634);
            assert!(0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::le(0x1::vector::borrow<0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v3, v5), &v4), 13839564498179653660);
            v5 = v5 + 1;
        };
        v0.is_enabled = arg1;
        v0.default_referrer_rate = arg2;
        v0.default_partner_rate = arg3;
        v0.commission_multiplier = arg4;
        v0.max_wagered_usd_to_set_referrer = arg5;
        v0.level_up_usd_rewards_per_referee = arg6;
        emit_referral_registry_edited_event(v0);
    }

    fun edit_referrer_data_internal(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<bool>) {
        let v0 = borrow_referral_registry_mut(arg0);
        let v1 = ReferrerKey{referrer: arg1};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v0.id, v1), 13835341913966182408);
        let v2 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v0.id, v1);
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(*0x1::option::borrow<u64>(&arg2) <= 10000000, 13836749310325227538);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) <= 10000000, 13837312277458649108);
        };
        v2.special_commission_rate = arg2;
        v2.special_partner_commission_rate = arg3;
        if (0x1::option::is_some<u64>(&arg4)) {
            let v3 = *0x1::option::borrow<u64>(&arg4);
            assert!(v3 <= 1000000000, 13840408532268023840);
            v2.partner_share_rate = v3;
        };
        if (0x1::option::is_some<bool>(&arg5)) {
            let v4 = *0x1::option::borrow<bool>(&arg5);
            if (v2.is_partner != v4) {
                v2.is_partner = v4;
                let v5 = PartnerStatusEditedEvent{
                    referrer   : arg1,
                    is_partner : v4,
                };
                0x2::event::emit<PartnerStatusEditedEvent>(v5);
            };
        };
        let v6 = ReferrerDataEditedEvent{
            referrer                        : arg1,
            special_commission_rate         : arg2,
            special_partner_commission_rate : arg3,
            partner_share_rate              : arg4,
        };
        0x2::event::emit<ReferrerDataEditedEvent>(v6);
    }

    fun effective_partner_commission_rate(arg0: &ReferralRegistry, arg1: &ReferrerData) : u64 {
        let v0 = arg0.default_partner_rate;
        if (0x1::option::is_some<u64>(&arg1.special_partner_commission_rate)) {
            v0 = *0x1::option::borrow<u64>(&arg1.special_partner_commission_rate);
        };
        apply_commission_multiplier(v0, arg0.commission_multiplier)
    }

    fun effective_referrer_commission_rate(arg0: &ReferralRegistry, arg1: &ReferrerData) : u64 {
        let v0 = arg0.default_referrer_rate;
        if (0x1::option::is_some<u64>(&arg1.special_commission_rate)) {
            v0 = *0x1::option::borrow<u64>(&arg1.special_commission_rate);
        };
        apply_commission_multiplier(v0, arg0.commission_multiplier)
    }

    fun emit_referral_registry_edited_event(arg0: &ReferralRegistry) {
        let v0 = ReferralRegistryEditedEvent{
            is_enabled                       : arg0.is_enabled,
            default_referrer_rate            : arg0.default_referrer_rate,
            default_partner_rate             : arg0.default_partner_rate,
            commission_multiplier            : arg0.commission_multiplier,
            max_wagered_usd_to_set_referrer  : arg0.max_wagered_usd_to_set_referrer,
            level_up_usd_rewards_per_referee : arg0.level_up_usd_rewards_per_referee,
        };
        0x2::event::emit<ReferralRegistryEditedEvent>(v0);
    }

    fun get_total_wagered_usd(arg0: &ReferralRegistry, arg1: address) : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float {
        let v0 = PlayerWagerKey{player: arg1};
        if (0x2::dynamic_object_field::exists_<PlayerWagerKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<PlayerWagerKey, PlayerWagerData>(&arg0.id, v0).total_wagered_usd
        } else {
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero()
        }
    }

    fun is_reciprocal_referral(arg0: &ReferralRegistry, arg1: address, arg2: address) : bool {
        let v0 = RefereeKey{referee: arg2};
        if (!0x2::dynamic_object_field::exists_<RefereeKey>(&arg0.id, v0)) {
            return false
        };
        0x2::dynamic_object_field::borrow<RefereeKey, RefereeData>(&arg0.id, v0).referrer == arg1
    }

    fun link_referrer_referee(arg0: &mut ReferralRegistry, arg1: address, arg2: address, arg3: 0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_enabled, 13835904344228823052);
        assert!(arg1 != arg2, 13836467298477473808);
        assert!(!is_reciprocal_referral(arg0, arg1, arg2), 13842096810898423852);
        let v0 = RefereeKey{referee: arg1};
        assert!(!0x2::dynamic_object_field::exists_<RefereeKey>(&arg0.id, v0), 13836185849270435854);
        let v1 = RefereeData{
            id                         : 0x2::object::new(arg5),
            referrer                   : arg2,
            max_rewarded_vip_level     : 0,
            date_referred_timestamp_ms : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_object_field::add<RefereeKey, RefereeData>(&mut arg0.id, v0, v1);
        let v2 = ReferrerKey{referrer: arg2};
        if (!0x2::dynamic_object_field::exists_<ReferrerKey>(&arg0.id, v2)) {
            let v3 = ReferrerData{
                id                              : 0x2::object::new(arg5),
                number_of_referee               : 1,
                is_partner                      : false,
                partner_share_rate              : 500000000,
                special_commission_rate         : 0x1::option::none<u64>(),
                special_partner_commission_rate : 0x1::option::none<u64>(),
                usd_rewards_balance             : 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::zero(),
            };
            0x2::dynamic_object_field::add<ReferrerKey, ReferrerData>(&mut arg0.id, v2, v3);
        } else {
            let v4 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut arg0.id, v2);
            v4.number_of_referee = v4.number_of_referee + 1;
        };
        let v5 = ReferralCreatedEvent{
            referrer : arg2,
            referee  : arg1,
            partner  : arg3,
        };
        0x2::event::emit<ReferralCreatedEvent>(v5);
    }

    public fun manager_create_empty_referrer_data(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg3));
        create_empty_referrer_data_internal(arg0, arg2, arg3);
    }

    public fun manager_create_referral_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg2));
        create_referral_registry_internal(arg0, arg2);
    }

    public fun manager_edit_referral_registry(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float, arg7: 0x2::vec_map::VecMap<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>, arg8: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg8));
        edit_referral_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun manager_edit_referrer_data(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg7));
        edit_referrer_data_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun manager_remove_version(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    fun package_version() : u64 {
        0
    }

    fun remove_version_internal(arg0: &mut ReferralRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13841533315483893800);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = ReferralRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<ReferralRegistryVersionChangedEvent>(v0);
    }

    entry fun set_my_referrer(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_referral_registry_mut(arg0);
        assert!(v1.is_enabled, 13835906594791686156);
        assert!(can_set_referrer(v1, v0), 13840691682282111010);
        let v2 = RefereeKey{referee: v0};
        if (0x2::dynamic_object_field::exists_<RefereeKey>(&v1.id, v2)) {
            return
        };
        assert!(!is_reciprocal_referral(v1, v0, arg1), 13842099087231090732);
        link_referrer_referee(v1, v0, arg1, 0x1::option::none<address>(), arg2, arg3);
    }

    public fun settle_referral_rewards<T0, T1: drop>(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: &0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::StakeTicket<T0, T1>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_player<T0, T1>(arg1);
        let v1 = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_stake_amount<T0, T1>(arg1);
        let v2 = borrow_referral_registry(arg0).is_enabled;
        if (v2) {
            let v3 = borrow_referral_registry_mut(arg0);
            try_link_referrer_from_option(v3, v0, &arg2, &arg3, arg5, arg6);
        };
        let v4 = borrow_referral_registry_mut(arg0);
        accrue_total_wagered_usd(v4, v0, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1), arg6);
        if (!v2) {
            return
        };
        settle_vip_level_up_usd_rewards(arg0, v0, arg6);
        let v5 = false;
        let v6 = @0x0;
        let v7 = borrow_referral_registry_mut(arg0);
        let v8 = RefereeKey{referee: v0};
        if (0x2::dynamic_object_field::exists_<RefereeKey>(&v7.id, v8)) {
            v6 = 0x2::dynamic_object_field::borrow<RefereeKey, RefereeData>(&v7.id, v8).referrer;
            v5 = true;
        };
        let v9 = false;
        let v10 = @0x0;
        let v11 = 0;
        let v12 = 500000000;
        if (0x1::option::is_some<address>(&arg3)) {
            let v13 = *0x1::option::borrow<address>(&arg3);
            v10 = v13;
            let v14 = borrow_referral_registry(arg0);
            let v15 = ReferrerKey{referrer: v13};
            assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v14.id, v15), 13840129522602410014);
            let v16 = 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v14.id, v15);
            assert!(v16.is_partner, 13840129539782279198);
            v12 = v16.partner_share_rate;
            v11 = effective_partner_commission_rate(v14, v16);
            v9 = true;
        };
        if (!v9) {
            if (!v5) {
                return
            };
            let v17 = borrow_referral_registry(arg0);
            let v18 = ReferrerKey{referrer: v6};
            let v19 = (((v1 as u128) * (effective_referrer_commission_rate(v17, 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v17.id, v18)) as u128) / (1000000000 as u128)) as u64);
            let v20 = Referral{dummy_field: false};
            0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Referral, T1>(arg0, v20, arg1, v19);
            let v21 = 0x1::type_name::with_defining_ids<T0>();
            let v22 = ReferrerKey{referrer: v6};
            let v23 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v22);
            let v24 = ReferrerBalanceKey{pos0: v21};
            if (0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v23.id, v24)) {
                let v25 = ReferrerBalanceKey{pos0: v21};
                let v26 = 0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v23.id, v25);
                v26.commission_balance = v26.commission_balance + v19;
            } else {
                let v27 = ReferrerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v19,
                };
                let v28 = ReferrerBalanceKey{pos0: v21};
                0x2::dynamic_object_field::add<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v23.id, v28, v27);
            };
            if (v19 > 0) {
                let v29 = ReferrerCommissionEvent<T0>{
                    referrer : v6,
                    referee  : v0,
                    amount   : v19,
                };
                0x2::event::emit<ReferrerCommissionEvent<T0>>(v29);
            };
            return
        };
        let v30 = (((v1 as u128) * (v11 as u128) / (1000000000 as u128)) as u64);
        if (v30 == 0) {
            return
        };
        let v31 = v30;
        let v32 = 0;
        let v33 = 0;
        if (v5) {
            let v34 = (((v30 as u128) * (v12 as u128) / (1000000000 as u128)) as u64);
            v31 = v34;
            let v35 = v30 - v34;
            v32 = v35;
            if (v35 > 0) {
                let v36 = borrow_referral_registry(arg0);
                let v37 = ReferrerKey{referrer: v6};
                if ((((v1 as u128) * (effective_referrer_commission_rate(v36, 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v36.id, v37)) as u128) / (1000000000 as u128)) as u64) > 0) {
                    v33 = v35;
                } else {
                    v31 = v30;
                    v32 = 0;
                };
            };
        };
        let v38 = Referral{dummy_field: false};
        0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Referral, T1>(arg0, v38, arg1, v30);
        let v39 = 0x1::type_name::with_defining_ids<T0>();
        if (v31 > 0) {
            let v40 = borrow_referral_registry_mut(arg0);
            let v41 = ReferrerKey{referrer: v10};
            let v42 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v40.id, v41);
            let v43 = PartnerBalanceKey{pos0: v39};
            if (0x2::dynamic_object_field::exists_<PartnerBalanceKey>(&v42.id, v43)) {
                let v44 = PartnerBalanceKey{pos0: v39};
                let v45 = 0x2::dynamic_object_field::borrow_mut<PartnerBalanceKey, PartnerBalance<T0>>(&mut v42.id, v44);
                v45.commission_balance = v45.commission_balance + v31;
            } else {
                let v46 = PartnerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v31,
                };
                let v47 = PartnerBalanceKey{pos0: v39};
                0x2::dynamic_object_field::add<PartnerBalanceKey, PartnerBalance<T0>>(&mut v42.id, v47, v46);
            };
            let v48 = PartnerCommissionEvent<T0>{
                partner : v10,
                player  : v0,
                amount  : v31,
            };
            0x2::event::emit<PartnerCommissionEvent<T0>>(v48);
        };
        if (v5 && v32 > 0) {
            let v49 = ReferrerKey{referrer: v6};
            let v50 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v49);
            let v51 = ReferrerBalanceKey{pos0: v39};
            if (0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v50.id, v51)) {
                let v52 = ReferrerBalanceKey{pos0: v39};
                let v53 = 0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v50.id, v52);
                v53.commission_balance = v53.commission_balance + v33;
            } else {
                let v54 = ReferrerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v33,
                };
                let v55 = ReferrerBalanceKey{pos0: v39};
                0x2::dynamic_object_field::add<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v50.id, v55, v54);
            };
            if (v33 > 0) {
                let v56 = ReferrerCommissionEvent<T0>{
                    referrer : v6,
                    referee  : v0,
                    amount   : v33,
                };
                0x2::event::emit<ReferrerCommissionEvent<T0>>(v56);
            };
        };
    }

    public fun settle_vip_level_up_usd_rewards(arg0: &mut 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::sweethouse::SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x25980ae9e9d1a5c204a1a9f7dcccad313305567e9bce7ec99b64009b1680e24f::vip::vip_registry_enabled(arg0)) {
            return
        };
        let (v0, _) = 0x25980ae9e9d1a5c204a1a9f7dcccad313305567e9bce7ec99b64009b1680e24f::vip::read_player_vip_data(arg0, arg1, arg2);
        if (v0 == 0) {
            return
        };
        let v2 = borrow_referral_registry_mut(arg0);
        if (!v2.is_enabled) {
            return
        };
        let v3 = RefereeKey{referee: arg1};
        if (!0x2::dynamic_object_field::exists_<RefereeKey>(&v2.id, v3)) {
            return
        };
        let v4 = 0x2::dynamic_object_field::borrow_mut<RefereeKey, RefereeData>(&mut v2.id, v3);
        if (v0 <= v4.max_rewarded_vip_level) {
            return
        };
        let v5 = v4.referrer;
        let v6 = v4.max_rewarded_vip_level + 1;
        v4.max_rewarded_vip_level = v0;
        let v6 = v6;
        while (v6 <= v0) {
            if (0x2::vec_map::contains<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v2.level_up_usd_rewards_per_referee, &v6)) {
                let v7 = *0x2::vec_map::get<u64, 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::Float>(&v2.level_up_usd_rewards_per_referee, &v6);
                let v8 = ReferrerKey{referrer: v5};
                let v9 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v8);
                v9.usd_rewards_balance = 0xbde37abf904292a57b279a9299ff508b7b55620db1f193771498c6c3d0ea2a6::float::add(v9.usd_rewards_balance, v7);
                let v10 = ReferrerLevelUpUsdRewardEvent{
                    referrer   : v5,
                    referee    : arg1,
                    usd_amount : v7,
                    level      : v6,
                };
                0x2::event::emit<ReferrerLevelUpUsdRewardEvent>(v10);
            };
            v6 = v6 + 1;
        };
    }

    fun try_link_referrer_from_option(arg0: &mut ReferralRegistry, arg1: address, arg2: &0x1::option::Option<address>, arg3: &0x1::option::Option<address>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = RefereeKey{referee: arg1};
        if (0x2::dynamic_object_field::exists_<RefereeKey>(&arg0.id, v0)) {
            true
        } else if (0x1::option::is_some<address>(arg2)) {
            if (!can_set_referrer(arg0, arg1)) {
                return false
            };
            let v2 = *0x1::option::borrow<address>(arg2);
            if (is_reciprocal_referral(arg0, arg1, v2)) {
                return false
            };
            link_referrer_referee(arg0, arg1, v2, *arg3, arg4, arg5);
            true
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

