module 0xdaa3f8b4f88d04695ec91161b4a2c1dfe1fbea6c9268eeb1801b0e12e642441d::referral {
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
        max_wagered_usd_to_set_referrer: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        level_up_usd_rewards_per_referee: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
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
        usd_rewards_balance: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
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
        total_wagered_usd: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
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
        usd_amount: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        dollar_coin_type: 0x1::type_name::TypeName,
        dollar_amount: u64,
        dollar_coin_decimals: u8,
        stablecoin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        stablecoin_confidence: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        payout_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
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
        max_wagered_usd_to_set_referrer: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        level_up_usd_rewards_per_referee: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>,
    }

    struct ReferralRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        is_enabled: bool,
        default_referrer_rate: u64,
        default_partner_rate: u64,
        commission_multiplier: u64,
        max_wagered_usd_to_set_referrer: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct ReferralRegistryVersionChangedEvent has copy, drop {
        version_number: u64,
        is_added: bool,
    }

    struct ReferrerLevelUpUsdRewardEvent has copy, drop {
        referrer: address,
        referee: address,
        usd_amount: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        level: u64,
    }

    struct ReferrerCommissionEvent<phantom T0> has copy, drop {
        referrer: address,
        referee: address,
        amount: u64,
        unsafe_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        adjusted_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    struct PartnerCommissionEvent<phantom T0> has copy, drop {
        partner: address,
        player: address,
        amount: u64,
        unsafe_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
        adjusted_oracle_usd_coin_price: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float,
    }

    fun accrue_total_wagered_usd(arg0: &mut ReferralRegistry, arg1: address, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerWagerKey{player: arg1};
        if (0x2::dynamic_object_field::exists_<PlayerWagerKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_object_field::borrow_mut<PlayerWagerKey, PlayerWagerData>(&mut arg0.id, v0);
            v1.total_wagered_usd = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v1.total_wagered_usd, arg2);
        } else {
            let v2 = PlayerWagerData{
                id                : 0x2::object::new(arg3),
                total_wagered_usd : arg2,
            };
            0x2::dynamic_object_field::add<PlayerWagerKey, PlayerWagerData>(&mut arg0.id, v0, v2);
        };
    }

    public fun admin_add_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
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

    public fun admin_create_empty_referrer_data(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        create_empty_referrer_data_internal(arg0, arg2, arg3);
    }

    public fun admin_create_referral_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        create_referral_registry_internal(arg0, arg2);
    }

    public fun admin_edit_referral_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg7: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>) {
        edit_referral_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun admin_edit_referrer_data(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>) {
        edit_referrer_data_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::AdminCap, arg2: u64) {
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    fun apply_commission_multiplier(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (1000000000 as u128)) as u64)
    }

    fun assert_valid_commission_multiplier(arg0: u64) {
        assert!(arg0 >= 200000000 && arg0 <= 1000000000, 13841814992324198442);
    }

    fun assert_valid_version(arg0: &ReferralRegistry) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 13841251655823458342);
    }

    public fun borrow_referral_registry(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &ReferralRegistry {
        let v0 = borrow_referral_registry_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_referral_registry_mut(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut ReferralRegistry {
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        assert_valid_version(v0);
        v0
    }

    fun borrow_referral_registry_mut_unchecked(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &mut ReferralRegistry {
        let v0 = Referral{dummy_field: false};
        let v1 = ReferralRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_borrow_operator_dof_mut<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v0, v1)
    }

    fun borrow_referral_registry_unchecked(arg0: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse) : &ReferralRegistry {
        let v0 = ReferralRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::borrow_operator_dof<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v0)
    }

    fun can_set_referrer(arg0: &ReferralRegistry, arg1: address) : bool {
        let v0 = get_total_wagered_usd(arg0, arg1);
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::le(&v0, &arg0.max_wagered_usd_to_set_referrer)
    }

    public fun claim_commission_balance<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_referral_registry_mut(arg0);
        let v3 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v2.id, v3), 13835342871743889416);
        let v4 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v3);
        let v5 = ReferrerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v4.id, v5), 13835342914693562376);
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
            0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v10, v8), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun claim_partner_balance<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = borrow_referral_registry_mut(arg0);
        let v3 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v2.id, v3), 13835343120851992584);
        let v4 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v3);
        assert!(v4.is_partner, 13840128225522286622);
        let v5 = PartnerBalanceKey{pos0: v1};
        assert!(0x2::dynamic_object_field::exists_<PartnerBalanceKey>(&v4.id, v5), 13835343168096632840);
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
            0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v10, v8), arg1)
        } else {
            0x2::coin::zero<T0>(arg1)
        }
    }

    public fun claim_referrer_level_up_usd_rewards<T0>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_dollar_coin_type(arg0) == v1, 13835624827757068298);
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::get_coin_decimals<T0>(arg0);
        let v3 = borrow_referral_registry_mut(arg0);
        let v4 = ReferrerKey{referrer: v0};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v3.id, v4), 13835343408614801416);
        let v5 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v3.id, v4).usd_rewards_balance;
        let (v6, v7, _) = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::get_checked_usd_price(arg0, v1, arg1, arg2);
        let v9 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::oracle::price_upper_bound(v6, v7);
        let v10 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::floor_to_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(v5, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(10, (v2 as u64)))), v9));
        let v11 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::div(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::mul(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(v10), v9), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(10, (v2 as u64))));
        let v12 = borrow_referral_registry_mut(arg0);
        let v13 = ReferrerKey{referrer: v0};
        0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v12.id, v13).usd_rewards_balance = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::positive_part(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::sub(v5, v11));
        let v14 = Referral{dummy_field: false};
        let v15 = ReferrerClaimLevelUpUsdRewardsEvent{
            referrer              : v0,
            usd_amount            : v11,
            dollar_coin_type      : 0x1::type_name::with_defining_ids<T0>(),
            dollar_amount         : v10,
            dollar_coin_decimals  : v2,
            stablecoin_price      : v6,
            stablecoin_confidence : v7,
            payout_price          : v9,
        };
        0x2::event::emit<ReferrerClaimLevelUpUsdRewardsEvent>(v15);
        0x2::coin::from_balance<T0>(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_take_from_rakeback_pool<T0, Referral>(arg0, v14, v10), arg3)
    }

    fun create_empty_referrer_data_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferrerKey{referrer: arg1};
        let v1 = ReferrerData{
            id                              : 0x2::object::new(arg2),
            number_of_referee               : 0,
            is_partner                      : false,
            partner_share_rate              : 500000000,
            special_commission_rate         : 0x1::option::none<u64>(),
            special_partner_commission_rate : 0x1::option::none<u64>(),
            usd_rewards_balance             : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero(),
        };
        0x2::dynamic_object_field::add<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v0, v1);
    }

    fun create_referral_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ReferralRegistry{
            id                               : 0x2::object::new(arg1),
            version_set                      : 0x2::vec_set::singleton<u64>(0),
            is_enabled                       : true,
            default_referrer_rate            : 3000000,
            default_partner_rate             : 3000000,
            commission_multiplier            : 250000000,
            max_wagered_usd_to_set_referrer  : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(18446744073709551615),
            level_up_usd_rewards_per_referee : 0x2::vec_map::empty<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(),
        };
        let v1 = Referral{dummy_field: false};
        let v2 = ReferralRegistryKey{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_add_operator_dof<Referral, ReferralRegistryKey, ReferralRegistry>(arg0, v1, v2, v0);
        let v3 = ReferralRegistryCreatedEvent{
            registry_id                     : 0x2::object::id<ReferralRegistry>(&v0),
            is_enabled                      : true,
            default_referrer_rate           : 3000000,
            default_partner_rate            : 3000000,
            commission_multiplier           : 250000000,
            max_wagered_usd_to_set_referrer : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(18446744073709551615),
        };
        0x2::event::emit<ReferralRegistryCreatedEvent>(v3);
    }

    fun edit_referral_registry_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: bool, arg2: u64, arg3: u64, arg4: u64, arg5: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg6: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>) {
        let v0 = borrow_referral_registry_mut(arg0);
        assert!(arg2 <= 10000000, 13837594134687580182);
        assert!(arg3 <= 10000000, 13838438576797712408);
        assert_valid_commission_multiplier(arg4);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_negative(&arg5), 13840971873063731236);
        let (_, v2) = 0x2::vec_map::into_keys_values<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(arg6);
        let v3 = v2;
        let v4 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::from_u64(18446744073709551615);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v3)) {
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::is_positive_or_zero(0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v3, v5)), 13839283053267583002);
            assert!(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::le(0x1::vector::borrow<0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v3, v5), &v4), 13839564532539392028);
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

    fun edit_referrer_data_internal(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<bool>) {
        let v0 = borrow_referral_registry_mut(arg0);
        let v1 = ReferrerKey{referrer: arg1};
        assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v0.id, v1), 13835341948325920776);
        let v2 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v0.id, v1);
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(*0x1::option::borrow<u64>(&arg2) <= 10000000, 13836749344684965906);
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) <= 10000000, 13837312311818387476);
        };
        v2.special_commission_rate = arg2;
        v2.special_partner_commission_rate = arg3;
        if (0x1::option::is_some<u64>(&arg4)) {
            let v3 = *0x1::option::borrow<u64>(&arg4);
            assert!(v3 <= 1000000000, 13840408566627762208);
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

    fun get_total_wagered_usd(arg0: &ReferralRegistry, arg1: address) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float {
        let v0 = PlayerWagerKey{player: arg1};
        if (0x2::dynamic_object_field::exists_<PlayerWagerKey>(&arg0.id, v0)) {
            0x2::dynamic_object_field::borrow<PlayerWagerKey, PlayerWagerData>(&arg0.id, v0).total_wagered_usd
        } else {
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero()
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
        assert!(arg0.is_enabled, 13835904378588561420);
        assert!(arg1 != arg2, 13836467332837212176);
        assert!(!is_reciprocal_referral(arg0, arg1, arg2), 13842096845258162220);
        let v0 = RefereeKey{referee: arg1};
        assert!(!0x2::dynamic_object_field::exists_<RefereeKey>(&arg0.id, v0), 13836185883630174222);
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
                usd_rewards_balance             : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::zero(),
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

    public fun manager_create_empty_referrer_data(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg3));
        create_empty_referrer_data_internal(arg0, arg2, arg3);
    }

    public fun manager_create_referral_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg2));
        create_referral_registry_internal(arg0, arg2);
    }

    public fun manager_edit_referral_registry(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float, arg7: 0x2::vec_map::VecMap<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>, arg8: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg8));
        edit_referral_registry_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun manager_edit_referrer_data(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: address, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg7));
        edit_referrer_data_internal(arg0, arg2, arg3, arg4, arg5, arg6);
    }

    public fun manager_remove_version(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::ManagerRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::assert_is_manager<Referral>(arg1, 0x2::tx_context::sender(arg3));
        let v0 = borrow_referral_registry_mut_unchecked(arg0);
        remove_version_internal(v0, arg2);
    }

    fun package_version() : u64 {
        0
    }

    fun remove_version_internal(arg0: &mut ReferralRegistry, arg1: u64) {
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &arg1), 13841533349843632168);
        0x2::vec_set::remove<u64>(&mut arg0.version_set, &arg1);
        let v0 = ReferralRegistryVersionChangedEvent{
            version_number : arg1,
            is_added       : false,
        };
        0x2::event::emit<ReferralRegistryVersionChangedEvent>(v0);
    }

    entry fun set_my_referrer(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = borrow_referral_registry_mut(arg0);
        assert!(v1.is_enabled, 13835906646331293708);
        assert!(can_set_referrer(v1, v0), 13840691733821718562);
        let v2 = RefereeKey{referee: v0};
        if (0x2::dynamic_object_field::exists_<RefereeKey>(&v1.id, v2)) {
            return
        };
        assert!(!is_reciprocal_referral(v1, v0, arg1), 13842099138770698284);
        link_referrer_referee(v1, v0, arg1, 0x1::option::none<address>(), arg2, arg3);
    }

    public fun settle_referral_rewards<T0, T1: drop>(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: &0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::StakeTicket<T0, T1>, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_player<T0, T1>(arg1);
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_stake_amount<T0, T1>(arg1);
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_unsafe_oracle_usd_coin_price<T0, T1>(arg1);
        let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_adjusted_oracle_usd_coin_price<T0, T1>(arg1);
        let v4 = borrow_referral_registry(arg0).is_enabled;
        if (v4) {
            let v5 = borrow_referral_registry_mut(arg0);
            try_link_referrer_from_option(v5, v0, &arg2, &arg3, arg5, arg6);
        };
        let v6 = borrow_referral_registry_mut(arg0);
        accrue_total_wagered_usd(v6, v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::core::get_total_stake_usd_value_if_exists<T0, T1>(arg1), arg6);
        if (!v4) {
            return
        };
        settle_vip_level_up_usd_rewards(arg0, v0, arg6);
        let v7 = false;
        let v8 = @0x0;
        let v9 = borrow_referral_registry_mut(arg0);
        let v10 = RefereeKey{referee: v0};
        if (0x2::dynamic_object_field::exists_<RefereeKey>(&v9.id, v10)) {
            v8 = 0x2::dynamic_object_field::borrow<RefereeKey, RefereeData>(&v9.id, v10).referrer;
            v7 = true;
        };
        let v11 = false;
        let v12 = @0x0;
        let v13 = 0;
        let v14 = 500000000;
        if (0x1::option::is_some<address>(&arg3)) {
            let v15 = *0x1::option::borrow<address>(&arg3);
            v12 = v15;
            let v16 = borrow_referral_registry(arg0);
            let v17 = ReferrerKey{referrer: v15};
            assert!(0x2::dynamic_object_field::exists_<ReferrerKey>(&v16.id, v17), 13840129582731952158);
            let v18 = 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v16.id, v17);
            assert!(v18.is_partner, 13840129599911821342);
            v14 = v18.partner_share_rate;
            v13 = effective_partner_commission_rate(v16, v18);
            v11 = true;
        };
        if (!v11) {
            if (!v7) {
                return
            };
            let v19 = borrow_referral_registry(arg0);
            let v20 = ReferrerKey{referrer: v8};
            let v21 = (((v1 as u128) * (effective_referrer_commission_rate(v19, 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v19.id, v20)) as u128) / (1000000000 as u128)) as u64);
            let v22 = Referral{dummy_field: false};
            0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Referral, T1>(arg0, v22, arg1, v21);
            let v23 = 0x1::type_name::with_defining_ids<T0>();
            let v24 = ReferrerKey{referrer: v8};
            let v25 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v24);
            let v26 = ReferrerBalanceKey{pos0: v23};
            if (0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v25.id, v26)) {
                let v27 = ReferrerBalanceKey{pos0: v23};
                let v28 = 0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v25.id, v27);
                v28.commission_balance = v28.commission_balance + v21;
            } else {
                let v29 = ReferrerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v21,
                };
                let v30 = ReferrerBalanceKey{pos0: v23};
                0x2::dynamic_object_field::add<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v25.id, v30, v29);
            };
            if (v21 > 0) {
                let v31 = ReferrerCommissionEvent<T0>{
                    referrer                       : v8,
                    referee                        : v0,
                    amount                         : v21,
                    unsafe_oracle_usd_coin_price   : v2,
                    adjusted_oracle_usd_coin_price : v3,
                };
                0x2::event::emit<ReferrerCommissionEvent<T0>>(v31);
            };
            return
        };
        let v32 = (((v1 as u128) * (v13 as u128) / (1000000000 as u128)) as u64);
        if (v32 == 0) {
            return
        };
        let v33 = v32;
        let v34 = 0;
        let v35 = 0;
        if (v7) {
            let v36 = (((v32 as u128) * (v14 as u128) / (1000000000 as u128)) as u64);
            v33 = v36;
            let v37 = v32 - v36;
            v34 = v37;
            if (v37 > 0) {
                let v38 = borrow_referral_registry(arg0);
                let v39 = ReferrerKey{referrer: v8};
                if ((((v1 as u128) * (effective_referrer_commission_rate(v38, 0x2::dynamic_object_field::borrow<ReferrerKey, ReferrerData>(&v38.id, v39)) as u128) / (1000000000 as u128)) as u64) > 0) {
                    v35 = v37;
                } else {
                    v33 = v32;
                    v34 = 0;
                };
            };
        };
        let v40 = Referral{dummy_field: false};
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::operator_fund_rakeback_pool_using_stake_ticket_sources<T0, Referral, T1>(arg0, v40, arg1, v32);
        let v41 = 0x1::type_name::with_defining_ids<T0>();
        if (v33 > 0) {
            let v42 = borrow_referral_registry_mut(arg0);
            let v43 = ReferrerKey{referrer: v12};
            let v44 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v42.id, v43);
            let v45 = PartnerBalanceKey{pos0: v41};
            if (0x2::dynamic_object_field::exists_<PartnerBalanceKey>(&v44.id, v45)) {
                let v46 = PartnerBalanceKey{pos0: v41};
                let v47 = 0x2::dynamic_object_field::borrow_mut<PartnerBalanceKey, PartnerBalance<T0>>(&mut v44.id, v46);
                v47.commission_balance = v47.commission_balance + v33;
            } else {
                let v48 = PartnerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v33,
                };
                let v49 = PartnerBalanceKey{pos0: v41};
                0x2::dynamic_object_field::add<PartnerBalanceKey, PartnerBalance<T0>>(&mut v44.id, v49, v48);
            };
            let v50 = PartnerCommissionEvent<T0>{
                partner                        : v12,
                player                         : v0,
                amount                         : v33,
                unsafe_oracle_usd_coin_price   : v2,
                adjusted_oracle_usd_coin_price : v3,
            };
            0x2::event::emit<PartnerCommissionEvent<T0>>(v50);
        };
        if (v7 && v34 > 0) {
            let v51 = ReferrerKey{referrer: v8};
            let v52 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut borrow_referral_registry_mut(arg0).id, v51);
            let v53 = ReferrerBalanceKey{pos0: v41};
            if (0x2::dynamic_object_field::exists_<ReferrerBalanceKey>(&v52.id, v53)) {
                let v54 = ReferrerBalanceKey{pos0: v41};
                let v55 = 0x2::dynamic_object_field::borrow_mut<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v52.id, v54);
                v55.commission_balance = v55.commission_balance + v35;
            } else {
                let v56 = ReferrerBalance<T0>{
                    id                 : 0x2::object::new(arg6),
                    commission_balance : v35,
                };
                let v57 = ReferrerBalanceKey{pos0: v41};
                0x2::dynamic_object_field::add<ReferrerBalanceKey, ReferrerBalance<T0>>(&mut v52.id, v57, v56);
            };
            if (v35 > 0) {
                let v58 = ReferrerCommissionEvent<T0>{
                    referrer                       : v8,
                    referee                        : v0,
                    amount                         : v35,
                    unsafe_oracle_usd_coin_price   : v2,
                    adjusted_oracle_usd_coin_price : v3,
                };
                0x2::event::emit<ReferrerCommissionEvent<T0>>(v58);
            };
        };
    }

    public fun settle_vip_level_up_usd_rewards(arg0: &mut 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::sweethouse::SweetHouse, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x12936bef50c5ce93fd6e0ec805ac760660d7c5c58a860e920a6fd8ff47c26af8::vip::vip_registry_enabled(arg0)) {
            return
        };
        let (v0, _) = 0x12936bef50c5ce93fd6e0ec805ac760660d7c5c58a860e920a6fd8ff47c26af8::vip::read_player_vip_data(arg0, arg1, arg2);
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
            if (0x2::vec_map::contains<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v2.level_up_usd_rewards_per_referee, &v6)) {
                let v7 = *0x2::vec_map::get<u64, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::Float>(&v2.level_up_usd_rewards_per_referee, &v6);
                let v8 = ReferrerKey{referrer: v5};
                let v9 = 0x2::dynamic_object_field::borrow_mut<ReferrerKey, ReferrerData>(&mut v2.id, v8);
                v9.usd_rewards_balance = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float::add(v9.usd_rewards_balance, v7);
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

