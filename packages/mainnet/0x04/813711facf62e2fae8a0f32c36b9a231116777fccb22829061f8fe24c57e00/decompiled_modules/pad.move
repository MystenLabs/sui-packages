module 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::pad {
    struct CurveParams has copy, drop, store {
        supply: u64,
        virtual_reserve: u64,
        virtual_tokens: u64,
        target_reserve: u64,
        graduation_fee: u64,
        launch_fee: u64,
        fee_bps: u16,
        creator_share_bps: u16,
    }

    struct Pad has key {
        id: 0x2::object::UID,
        hub: 0x2::object::ID,
        slug: 0x1::string::String,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
        platform_bps: u16,
        graduation_bounty: u64,
        metadata_uri: 0x1::string::String,
        params: CurveParams,
        tokens_count: u64,
        owner_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct PadCreated has copy, drop {
        hub: 0x2::object::ID,
        pad: 0x2::object::ID,
        owner: address,
        reserve: 0x1::string::String,
        slug: 0x1::string::String,
        metadata_uri: 0x1::string::String,
        platform_bps: u16,
        graduation_bounty: u64,
        index: u64,
    }

    struct ParamsUpdated has copy, drop {
        pad: 0x2::object::ID,
        params: CurveParams,
    }

    struct MetadataUpdated has copy, drop {
        pad: 0x2::object::ID,
        metadata_uri: 0x1::string::String,
    }

    struct OwnershipOffered has copy, drop {
        pad: 0x2::object::ID,
        new_owner: address,
    }

    struct OwnerUpdated has copy, drop {
        pad: 0x2::object::ID,
        new_owner: address,
    }

    struct LaunchFeePaid has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        amount: u64,
    }

    struct FeesSwept has copy, drop {
        pad: 0x2::object::ID,
        curve: 0x2::object::ID,
        owner_amount: u64,
        platform_amount: u64,
    }

    struct OwnerFeesClaimed has copy, drop {
        pad: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct PlatformFeesClaimed has copy, drop {
        pad: 0x2::object::ID,
        treasury: address,
        amount: u64,
    }

    public fun hub(arg0: &Pad) : 0x2::object::ID {
        arg0.hub
    }

    public fun graduation_bounty(arg0: &Pad) : u64 {
        arg0.graduation_bounty
    }

    public fun platform_bps(arg0: &Pad) : u16 {
        arg0.platform_bps
    }

    public fun accept_ownership(arg0: &mut Pad, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.pending_owner == 0x1::option::some<address>(0x2::tx_context::sender(arg1)), 13906835815021150213);
        arg0.owner = 0x2::tx_context::sender(arg1);
        arg0.pending_owner = 0x1::option::none<address>();
        let v0 = OwnerUpdated{
            pad       : 0x2::object::id<Pad>(arg0),
            new_owner : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<OwnerUpdated>(v0);
    }

    fun assert_owner(arg0: &Pad, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 13906835845085790211);
    }

    fun check_params(arg0: &CurveParams, arg1: u64) {
        let v0 = if (arg0.supply > 0) {
            if (arg0.virtual_reserve > 0) {
                if (arg0.virtual_tokens > 0) {
                    arg0.target_reserve > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13906835870855856135);
        let v1 = (arg0.virtual_reserve as u128);
        let v2 = (arg0.virtual_tokens as u128);
        assert!(v2 - v1 * v2 / (v1 + (arg0.target_reserve as u128)) < (arg0.supply as u128), 13906835892330692615);
        assert!(arg0.fee_bps <= 500 && arg0.creator_share_bps <= 10000, 13906835896625659911);
        assert!(arg0.graduation_fee < arg0.target_reserve, 13906835900920627207);
        assert!(arg0.launch_fee <= arg0.target_reserve / 10, 13906835913805529095);
        assert!(arg0.graduation_fee >= arg1 && arg0.graduation_fee <= arg1 + arg0.target_reserve / 10, 13906835926690430983);
    }

    public fun claim_owner_fees(arg0: &mut Pad, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.owner_fees);
        if (v0 == 0) {
            return 0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.owner_fees), arg1), arg0.owner);
        let v1 = OwnerFeesClaimed{
            pad    : 0x2::object::id<Pad>(arg0),
            owner  : arg0.owner,
            amount : v0,
        };
        0x2::event::emit<OwnerFeesClaimed>(v1);
        v0
    }

    public fun claim_platform_fees(arg0: &mut Pad, arg1: &0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg0.hub == 0x2::object::id<0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub>(arg1), 13906835673287622667);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::treasury(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.platform_fees), arg2), v1);
        let v2 = PlatformFeesClaimed{
            pad      : 0x2::object::id<Pad>(arg0),
            treasury : v1,
            amount   : v0,
        };
        0x2::event::emit<PlatformFeesClaimed>(v2);
        v0
    }

    public fun create_pad(arg0: &mut 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: CurveParams, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::graduation_bounty(arg0);
        check_params(&arg3, v0);
        let v1 = Pad{
            id                : 0x2::object::new(arg5),
            hub               : 0x2::object::id<0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub>(arg0),
            slug              : arg1,
            owner             : 0x2::tx_context::sender(arg5),
            pending_owner     : 0x1::option::none<address>(),
            platform_bps      : 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::platform_bps(arg0),
            graduation_bounty : v0,
            metadata_uri      : arg2,
            params            : arg3,
            tokens_count      : 0,
            owner_fees        : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fees     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v2 = 0x2::object::id<Pad>(&v1);
        let v3 = 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::creation_fee(arg0);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v3, arg5), 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::treasury(arg0));
        };
        let v4 = PadCreated{
            hub               : 0x2::object::id<0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub>(arg0),
            pad               : v2,
            owner             : v1.owner,
            reserve           : 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::coin_type<0x2::sui::SUI>(),
            slug              : arg1,
            metadata_uri      : arg2,
            platform_bps      : v1.platform_bps,
            graduation_bounty : v0,
            index             : 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::register_pad(arg0, arg1, v2),
        };
        0x2::event::emit<PadCreated>(v4);
        let v5 = ParamsUpdated{
            pad    : v2,
            params : arg3,
        };
        0x2::event::emit<ParamsUpdated>(v5);
        0x2::transfer::share_object<Pad>(v1);
        v2
    }

    public fun graduation_fee(arg0: &CurveParams) : u64 {
        arg0.graduation_fee
    }

    fun hash_params(arg0: &CurveParams) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<CurveParams>(arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun launch<T0>(arg0: &mut Pad, arg1: &0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub, arg2: 0x2::coin_registry::CurrencyInitializer<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::package::UpgradeCap, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::is_right_order<T0, 0x2::sui::SUI>(), 13906835183661613071);
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::mint_pool_creation_cap<T0>(arg5, arg6, &mut arg3, arg10);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::register_permission_pair<T0, 0x2::sui::SUI>(arg5, arg6, 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::tick_spacing(arg1), &v0, arg10);
        launch_internal<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>(v0), arg7, arg8, arg9, arg10)
    }

    public fun launch_fee(arg0: &CurveParams) : u64 {
        arg0.launch_fee
    }

    fun launch_internal<T0>(arg0: &mut Pad, arg1: &0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub, arg2: 0x2::coin_registry::CurrencyInitializer<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::package::UpgradeCap, arg5: 0x1::option::Option<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::PoolCreationCap>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.hub == 0x2::object::id<0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::Hub>(arg1), 13906835316805337099);
        let v0 = arg0.params;
        if (!0x1::vector::is_empty<u8>(&arg7)) {
            assert!(arg7 == hash_params(&v0), 13906835329690107913);
        };
        let v1 = 0x2::package::upgrade_package(&arg4);
        assert!(0x2::object::id_to_address(&v1) == 0x1::type_name::original_id<T0>(), 13906835346870370319);
        0x2::package::make_immutable(arg4);
        assert!(0x2::coin::total_supply<T0>(&arg3) == 0, 13906835364050239503);
        0x2::coin_registry::make_supply_burn_only_init<T0>(&mut arg2, arg3);
        0x2::coin_registry::finalize_and_delete_metadata_cap<T0>(arg2, arg9);
        let v2 = arg0.tokens_count;
        arg0.tokens_count = v2 + 1;
        let v3 = 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::new<T0>(0x2::object::id<Pad>(arg0), v2, 0x2::tx_context::sender(arg9), 0x2::coin::mint_balance<T0>(&mut arg3, v0.supply), v0.virtual_reserve, v0.virtual_tokens, v0.target_reserve, v0.graduation_fee, v0.fee_bps, v0.creator_share_bps, arg0.platform_bps, arg0.graduation_bounty, 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::hub::tick_spacing(arg1), arg5, arg8, arg9);
        if (v0.launch_fee > 0) {
            split_pad_fee(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg6, v0.launch_fee, arg9)));
            let v4 = LaunchFeePaid{
                pad    : 0x2::object::id<Pad>(arg0),
                curve  : v3,
                amount : v0.launch_fee,
            };
            0x2::event::emit<LaunchFeePaid>(v4);
        };
        v3
    }

    public fun metadata_uri(arg0: &Pad) : 0x1::string::String {
        arg0.metadata_uri
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u16, arg7: u16) : CurveParams {
        CurveParams{
            supply            : arg0,
            virtual_reserve   : arg1,
            virtual_tokens    : arg2,
            target_reserve    : arg3,
            graduation_fee    : arg4,
            launch_fee        : arg5,
            fee_bps           : arg6,
            creator_share_bps : arg7,
        }
    }

    public fun owner(arg0: &Pad) : address {
        arg0.owner
    }

    public fun owner_fees(arg0: &Pad) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.owner_fees)
    }

    public fun params(arg0: &Pad) : CurveParams {
        arg0.params
    }

    public fun params_hash(arg0: &Pad) : vector<u8> {
        hash_params(&arg0.params)
    }

    public fun pending_owner(arg0: &Pad) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    public fun platform_fees(arg0: &Pad) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.platform_fees)
    }

    public fun set_metadata_uri(arg0: &mut Pad, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.metadata_uri = arg1;
        let v0 = MetadataUpdated{
            pad          : 0x2::object::id<Pad>(arg0),
            metadata_uri : arg1,
        };
        0x2::event::emit<MetadataUpdated>(v0);
    }

    public fun set_params(arg0: &mut Pad, arg1: CurveParams, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        check_params(&arg1, arg0.graduation_bounty);
        arg0.params = arg1;
        let v0 = ParamsUpdated{
            pad    : 0x2::object::id<Pad>(arg0),
            params : arg1,
        };
        0x2::event::emit<ParamsUpdated>(v0);
    }

    public fun slug(arg0: &Pad) : 0x1::string::String {
        arg0.slug
    }

    fun split_pad_fee(arg0: &mut Pad, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, 0x2::balance::split<0x2::sui::SUI>(&mut arg1, (((0x2::balance::value<0x2::sui::SUI>(&arg1) as u128) * (arg0.platform_bps as u128) / 10000) as u64)));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, arg1);
    }

    public fun supply(arg0: &CurveParams) : u64 {
        arg0.supply
    }

    public fun sweep_fees<T0>(arg0: &mut Pad, arg1: &mut 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::Curve<T0>) {
        assert!(0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::pad<T0>(arg1) == 0x2::object::id<Pad>(arg0), 13906835557323636749);
        let (v0, v1) = 0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::take_pad_fees<T0>(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::balance::value<0x2::sui::SUI>(&v3);
        let v5 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.owner_fees, v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.platform_fees, v2);
        if (v4 + v5 > 0) {
            let v6 = FeesSwept{
                pad             : 0x2::object::id<Pad>(arg0),
                curve           : 0x2::object::id<0x4813711facf62e2fae8a0f32c36b9a231116777fccb22829061f8fe24c57e00::curve::Curve<T0>>(arg1),
                owner_amount    : v4,
                platform_amount : v5,
            };
            0x2::event::emit<FeesSwept>(v6);
        };
    }

    public fun target_reserve(arg0: &CurveParams) : u64 {
        arg0.target_reserve
    }

    public fun tokens_count(arg0: &Pad) : u64 {
        arg0.tokens_count
    }

    public fun transfer_ownership(arg0: &mut Pad, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert!(arg1 != @0x0, 13906835789251477511);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v0 = OwnershipOffered{
            pad       : 0x2::object::id<Pad>(arg0),
            new_owner : arg1,
        };
        0x2::event::emit<OwnershipOffered>(v0);
    }

    public fun version() : u64 {
        2
    }

    // decompiled from Move bytecode v7
}

