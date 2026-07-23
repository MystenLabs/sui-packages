module 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint {
    struct SAINT has drop {
        dummy_field: bool,
    }

    struct Saint has store, key {
        id: 0x2::object::UID,
        number: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        activated_in: 0x1::option::Option<0x2::object::ID>,
        tier: u8,
    }

    struct SaintsConfig has key {
        id: 0x2::object::UID,
        minted: u64,
        paused: bool,
        staker_start_ms: u64,
        public_start_ms: u64,
        activation_price_atoms: u64,
        redeem_fee_bps: u64,
        tier_prices_atoms: vector<u64>,
        tier_multipliers_bps: vector<u64>,
        pool_reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        redeem_fees: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SaintsAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RedeemRule has drop {
        dummy_field: bool,
    }

    struct RuleFlag has drop, store {
        dummy_field: bool,
    }

    struct SaintMinted has copy, drop {
        saint_id: 0x2::object::ID,
        number: u64,
        minter: address,
        lane: u8,
    }

    struct SaintActivated has copy, drop {
        saint_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        faith_burned_atoms: u64,
    }

    struct SaintAscended has copy, drop {
        saint_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        owner: address,
        tier: u8,
        faith_burned_atoms: u64,
    }

    struct SaintRedeemed has copy, drop {
        saint_id: 0x2::object::ID,
        number: u64,
        vault_atoms: u64,
        fee_atoms: u64,
    }

    struct MintScheduled has copy, drop {
        staker_start_ms: u64,
        public_start_ms: u64,
    }

    struct SaintsConfigUpdated has copy, drop {
        activation_price_atoms: u64,
        redeem_fee_bps: u64,
        paused: bool,
    }

    struct PoolReserveWithdrawn has copy, drop {
        amount_atoms: u64,
        remaining_atoms: u64,
    }

    public fun activate(arg0: &SaintsConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg5: &mut 0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::FaithStakingPool, arg6: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg4);
        assert!(v0 == arg0.activation_price_atoms, 6);
        0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::burn90_and_deposit10(arg5, arg6, arg4, arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = 0x2::kiosk::borrow_mut<Saint>(arg1, arg2, arg3);
        v2.activated_in = 0x1::option::some<0x2::object::ID>(v1);
        v2.tier = 0;
        let v3 = SaintActivated{
            saint_id           : arg3,
            kiosk_id           : v1,
            owner              : 0x2::tx_context::sender(arg7),
            faith_burned_atoms : v0,
        };
        0x2::event::emit<SaintActivated>(v3);
    }

    public fun activated_in(arg0: &Saint) : 0x1::option::Option<0x2::object::ID> {
        arg0.activated_in
    }

    public fun activation_price(arg0: &SaintsConfig) : u64 {
        arg0.activation_price_atoms
    }

    public fun ascend(arg0: &SaintsConfig, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::coin::Coin<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>, arg5: &mut 0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::FaithStakingPool, arg6: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v1 = 0x2::kiosk::borrow_mut<Saint>(arg1, arg2, arg3);
        assert!(0x1::option::contains<0x2::object::ID>(&v1.activated_in, &v0), 11);
        assert!((v1.tier as u64) + 1 < 5, 12);
        let v2 = v1.tier + 1;
        let v3 = 0x2::coin::value<0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::faith::FAITH>(&arg4);
        assert!(v3 == *0x1::vector::borrow<u64>(&arg0.tier_prices_atoms, (v2 as u64) - 1), 6);
        0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::burn90_and_deposit10(arg5, arg6, arg4, arg7);
        v1.tier = v2;
        let v4 = SaintAscended{
            saint_id           : arg3,
            kiosk_id           : v0,
            owner              : 0x2::tx_context::sender(arg7),
            tier               : v2,
            faith_burned_atoms : v3,
        };
        0x2::event::emit<SaintAscended>(v4);
    }

    fun emit_config(arg0: &SaintsConfig) {
        let v0 = SaintsConfigUpdated{
            activation_price_atoms : arg0.activation_price_atoms,
            redeem_fee_bps         : arg0.redeem_fee_bps,
            paused                 : arg0.paused,
        };
        0x2::event::emit<SaintsConfigUpdated>(v0);
    }

    fun init(arg0: SAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SAINT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Saint>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Saint>(&mut v4, &v3, 1000, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Saint>(&mut v4, &v3);
        let (v5, v6) = 0x2::transfer_policy::new<Saint>(&v0, arg1);
        let v7 = v6;
        let v8 = v5;
        let v9 = RedeemRule{dummy_field: false};
        let v10 = RuleFlag{dummy_field: false};
        0x2::transfer_policy::add_rule<Saint, RedeemRule, RuleFlag>(v9, &mut v8, &v7, v10);
        let v11 = SaintsConfig{
            id                     : 0x2::object::new(arg1),
            minted                 : 0,
            paused                 : false,
            staker_start_ms        : 0,
            public_start_ms        : 0,
            activation_price_atoms : 1000000000000,
            redeem_fee_bps         : 0,
            tier_prices_atoms      : vector[1500000000000, 3500000000000, 6000000000000, 13000000000000],
            tier_multipliers_bps   : vector[10000, 12500, 16000, 20000, 33300],
            pool_reserve           : 0x2::balance::zero<0x2::sui::SUI>(),
            redeem_fees            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SaintsConfig>(v11);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Saint>>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Saint>>(v8);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Saint>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Saint>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v12 = SaintsAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SaintsAdminCap>(v12, 0x2::tx_context::sender(arg1));
    }

    public fun is_active_in(arg0: &Saint, arg1: &0x2::kiosk::Kiosk) : bool {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        0x1::option::contains<0x2::object::ID>(&arg0.activated_in, &v0)
    }

    public fun mint(arg0: &mut SaintsConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Saint>, arg5: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.public_start_ms > 0, 9);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg0.public_start_ms, 2);
        mint_internal(arg0, arg1, arg2, arg3, arg4, arg5, 1, arg7)
    }

    fun mint_internal(arg0: &mut SaintsConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Saint>, arg5: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg6: u8, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 4);
        assert!(arg0.minted < 1000, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 20000000000, 0);
        arg0.minted = arg0.minted + 1;
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool_reserve, 0x2::balance::split<0x2::sui::SUI>(&mut v0, 1000000000));
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::deposit_and_route_entry_v2(arg5, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg7), arg7);
        let v1 = Saint{
            id           : 0x2::object::new(arg7),
            number       : arg0.minted,
            vault        : 0x2::balance::split<0x2::sui::SUI>(&mut v0, 17500000000),
            activated_in : 0x1::option::none<0x2::object::ID>(),
            tier         : 0,
        };
        let v2 = 0x2::object::id<Saint>(&v1);
        0x2::kiosk::lock<Saint>(arg2, arg3, arg4, v1);
        let v3 = SaintMinted{
            saint_id : v2,
            number   : arg0.minted,
            minter   : 0x2::tx_context::sender(arg7),
            lane     : arg6,
        };
        0x2::event::emit<SaintMinted>(v3);
        v2
    }

    public fun mint_manifest<T0>(arg0: &mut SaintsConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::coin::Coin<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<Saint>, arg6: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.staker_start_ms > 0, 9);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg0.staker_start_ms, 2);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"c466c28d87b3d5cd34f3d5c088751532d71a38d93a8aae4551dd56272cfb4355::manifest::MANIFEST", 14);
        assert!(0x2::coin::value<T0>(arg2) >= 100000000000000, 15);
        mint_internal(arg0, arg1, arg3, arg4, arg5, arg6, 2, arg8)
    }

    public fun mint_schedule(arg0: &SaintsConfig) : (u64, u64) {
        (arg0.staker_start_ms, arg0.public_start_ms)
    }

    public fun mint_staker(arg0: &mut SaintsConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::FaithStakingAccount, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<Saint>, arg6: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.staker_start_ms > 0, 9);
        assert!(0x2::clock::timestamp_ms(arg7) >= arg0.staker_start_ms, 2);
        assert!(0x4cec3750c2aec58aab872d0d1ca0abe6daf361dab9e7537b8115ceccac860722::faithgg_staking_v2::account_balance(arg2) >= 100000000000000, 5);
        mint_internal(arg0, arg1, arg3, arg4, arg5, arg6, 0, arg8)
    }

    public fun minted(arg0: &SaintsConfig) : u64 {
        arg0.minted
    }

    public fun number(arg0: &Saint) : u64 {
        arg0.number
    }

    public fun pool_reserve_value(arg0: &SaintsConfig) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool_reserve)
    }

    public fun redeem(arg0: &mut SaintsConfig, arg1: Saint, arg2: &mut 0x2::transfer_policy::TransferRequest<Saint>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let Saint {
            id           : v0,
            number       : v1,
            vault        : v2,
            activated_in : _,
            tier         : _,
        } = arg1;
        let v5 = v2;
        let v6 = v0;
        assert!(0x2::object::uid_to_inner(&v6) == 0x2::transfer_policy::item<Saint>(arg2), 1);
        let v7 = 0x2::balance::value<0x2::sui::SUI>(&v5);
        let v8 = v7 * arg0.redeem_fee_bps / 10000;
        if (v8 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.redeem_fees, 0x2::balance::split<0x2::sui::SUI>(&mut v5, v8));
        };
        let v9 = SaintRedeemed{
            saint_id    : 0x2::object::uid_to_inner(&v6),
            number      : v1,
            vault_atoms : v7,
            fee_atoms   : v8,
        };
        0x2::event::emit<SaintRedeemed>(v9);
        0x2::object::delete(v6);
        let v10 = RedeemRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<Saint, RedeemRule>(v10, arg2);
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    public fun redeem_fee_bps(arg0: &SaintsConfig) : u64 {
        arg0.redeem_fee_bps
    }

    public fun schedule_mint(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: u64) {
        assert!(arg2 > 0, 9);
        arg1.staker_start_ms = arg2;
        arg1.public_start_ms = arg2 + 172800000;
        let v0 = MintScheduled{
            staker_start_ms : arg1.staker_start_ms,
            public_start_ms : arg1.public_start_ms,
        };
        0x2::event::emit<MintScheduled>(v0);
    }

    public fun set_activation_price(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: u64) {
        assert!(arg2 <= 10000000000000, 7);
        arg1.activation_price_atoms = arg2;
        emit_config(arg1);
    }

    public fun set_paused(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: bool) {
        arg1.paused = arg2;
        emit_config(arg1);
    }

    public fun set_redeem_fee_bps(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: u64) {
        assert!(arg2 <= 200, 8);
        arg1.redeem_fee_bps = arg2;
        emit_config(arg1);
    }

    public fun set_tier_ladder(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: vector<u64>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u64>(&arg2) == 5 - 1, 13);
        assert!(0x1::vector::length<u64>(&arg3) == 5, 13);
        let v0 = &arg2;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v2 = 0x1::vector::borrow<u64>(v0, v1);
            assert!(*v2 > 0 && *v2 <= 50000000000000, 13);
            v1 = v1 + 1;
        };
        let v3 = 0;
        let v4 = &arg3;
        let v5 = 0;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            let v6 = 0x1::vector::borrow<u64>(v4, v5);
            assert!(*v6 >= v3 && *v6 <= 100000, 13);
            v3 = *v6;
            v5 = v5 + 1;
        };
        arg1.tier_prices_atoms = arg2;
        arg1.tier_multipliers_bps = arg3;
        emit_config(arg1);
    }

    public fun sweep_redeem_fees(arg0: &mut SaintsConfig, arg1: &mut 0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::GlobalV2, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.redeem_fees) > 0, 10);
        0x965c6cb391f2e240cea5f43a10de3495004c78c057d4c233159205c40c7e03e3::round_manager::deposit_and_route_entry_v2(arg1, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.redeem_fees), arg2), arg2);
    }

    public fun tier(arg0: &Saint) : u8 {
        arg0.tier
    }

    public fun tier_multipliers(arg0: &SaintsConfig) : vector<u64> {
        arg0.tier_multipliers_bps
    }

    public fun tier_prices(arg0: &SaintsConfig) : vector<u64> {
        arg0.tier_prices_atoms
    }

    public fun vault_value(arg0: &Saint) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun withdraw_pool_reserve(arg0: &SaintsAdminCap, arg1: &mut SaintsConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = PoolReserveWithdrawn{
            amount_atoms    : arg2,
            remaining_atoms : 0x2::balance::value<0x2::sui::SUI>(&arg1.pool_reserve),
        };
        0x2::event::emit<PoolReserveWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.pool_reserve, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

