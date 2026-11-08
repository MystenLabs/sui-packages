module 0xbaa40216cb4d10704b9b5be64a69e4ba4ece0c251e847a23dcfa6e5687f0c817::adapter_suilend {
    struct ADAPTER_SUILEND has drop {
        dummy_field: bool,
    }

    struct SuilendAdapter has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        positions: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Position<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        reserve_index: u64,
        ctokens: 0x2::balance::Balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>,
        cap: 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::ObligationOwnerCap<T0>,
        stake_new: bool,
    }

    struct HarvestReceipt {
        position: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        claimed: u64,
    }

    struct PositionCreated has copy, drop {
        position: 0x2::object::ID,
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        reserve_index: u64,
        obligation: 0x2::object::ID,
    }

    struct Supplied has copy, drop {
        position: 0x2::object::ID,
        amount: u64,
        ctokens: u64,
        value_added: u64,
        to_obligation: bool,
    }

    struct Redeemed has copy, drop {
        position: 0x2::object::ID,
        requested: u64,
        amount: u64,
        ctokens: u64,
        received: u64,
        forced: bool,
    }

    struct Harvested has copy, drop {
        position: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        claimed: u64,
        compounded: u64,
        dust_returned: u64,
    }

    struct BucketMoved has copy, drop {
        position: 0x2::object::ID,
        ctokens: u64,
        to_obligation: bool,
    }

    public fun report<T0, T1, T2>(arg0: &Position<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::NavSession, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock) {
        assert_bound<T0, T1, T2>(arg0, arg2, arg3);
        let v0 = SuilendAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::report<T1, T2, SuilendAdapter>(arg1, arg2, v0, live_value<T0, T1>(arg0, arg3, arg4));
    }

    fun assert_bound<T0, T1, T2>(arg0: &Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>>(arg1), 1);
        assert!(arg0.market == 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg2), 2);
    }

    fun assert_version<T0, T1>(arg0: &Position<T0, T1>) {
        assert!(arg0.version == 1, 11);
    }

    fun clamp<T0, T1, T2>(arg0: &Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = arg3;
        let v1 = redeemable<T0, T1>(arg0, arg2, arg4);
        if (v1 < arg3) {
            v0 = v1;
        };
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::adapter_value<T1, T2, SuilendAdapter>(arg1);
        if (v2 < v0) {
            v0 = v2;
        };
        assert!(v0 > 0, 7);
        v0
    }

    public fun create<T0, T1, T2>(arg0: &mut Registry, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_address<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3) == @0x84030d26d85eaa7035084a057f2f11f701b7e2e4eda87551becbc7c97505ece1, 2);
        create_impl<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun create_impl<T0, T1, T2>(arg0: &mut Registry, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>>(arg1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == v0, 5);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.positions, v0), 4);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserve_array_index<T0, T1>(arg3);
        assert!(v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg3)), 3);
        let v2 = Position<T0, T1>{
            id            : 0x2::object::new(arg5),
            version       : 1,
            vault         : v0,
            market        : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3),
            reserve_index : v1,
            ctokens       : 0x2::balance::zero<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(),
            cap           : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::create_obligation<T0>(arg3, arg5),
            stake_new     : arg4,
        };
        let v3 = 0x2::object::id<Position<T0, T1>>(&v2);
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.positions, v0, v3);
        let v4 = PositionCreated{
            position      : v3,
            vault         : v0,
            market        : 0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3),
            reserve_index : v1,
            obligation    : 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&v2.cap),
        };
        0x2::event::emit<PositionCreated>(v4);
        0x2::transfer::share_object<Position<T0, T1>>(v2);
    }

    fun ctokens_to_value(arg0: u64, arg1: u256) : u64 {
        let v0 = (arg0 as u256) * arg1 / 1000000000000000000;
        if (v0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        }
    }

    fun deposit_amount<T0>(arg0: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg1: 0x2::object::ID, arg2: u64) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg0, arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v1)) == arg2) {
                return 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v1))
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun finish_harvest<T0, T1>(arg0: &mut Position<T0, T1>, arg1: HarvestReceipt, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert_version<T0, T1>(arg0);
        assert!(0x2::object::id<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>>(arg3) == arg0.market, 2);
        let HarvestReceipt {
            position : v0,
            reward   : v1,
            claimed  : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Position<T0, T1>>(arg0), 9);
        let v3 = 0x2::coin::value<T1>(&arg2);
        let v4 = ratio<T0, T1>(arg0, arg3, arg4);
        let v5 = if (v4 == 0) {
            0
        } else {
            (v3 as u256) * 1000000000000000000 / v4
        };
        if (v5 == 0) {
            let v6 = Harvested{
                position      : v0,
                reward        : v1,
                claimed       : v2,
                compounded    : 0,
                dust_returned : v3,
            };
            0x2::event::emit<Harvested>(v6);
            return arg2
        };
        let v7 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg0.reserve_index, arg4, arg2, arg5);
        put_ctokens<T0, T1>(arg0, arg3, v7, arg4, arg5);
        let v8 = Harvested{
            position      : v0,
            reward        : v1,
            claimed       : v2,
            compounded    : v3,
            dust_returned : 0,
        };
        0x2::event::emit<Harvested>(v8);
        0x2::coin::zero<T1>(arg5)
    }

    fun finish_redeem<T0, T1, T2>(arg0: &Position<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Deallocation, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: bool, arg9: &0x2::clock::Clock) : u64 {
        let v0 = SuilendAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::settle_deallocation<T1, T2, SuilendAdapter>(arg1, arg2, v0, 0x2::coin::into_balance<T1>(arg3), arg7, arg9);
        let v1 = Redeemed{
            position  : 0x2::object::id<Position<T0, T1>>(arg0),
            requested : arg4,
            amount    : arg5,
            ctokens   : arg6,
            received  : 0x2::coin::value<T1>(&arg3),
            forced    : arg8,
        };
        0x2::event::emit<Redeemed>(v1);
        arg5
    }

    public fun force_redeem<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : u64 {
        assert_bound<T0, T1, T2>(arg0, arg1, arg2);
        let v0 = SuilendAdapter{dummy_field: false};
        let v1 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::force_deallocate<T1, T2, SuilendAdapter>(arg1, v0, clamp<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4), arg4);
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocation_amount(&v1);
        let (v3, v4) = redeem_request<T0, T1>(arg0, arg2, v2, arg4, arg5);
        finish_redeem<T0, T1, T2>(arg0, arg1, v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg2, arg0.reserve_index, v3, arg5), arg3, v2, v4, b"forced", true, arg4)
    }

    public fun force_redeem_sui<T0, T1>(arg0: &mut Position<T0, 0x2::sui::SUI>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<0x2::sui::SUI, T1>, arg2: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        assert_bound<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2);
        let v0 = SuilendAdapter{dummy_field: false};
        let v1 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::force_deallocate<0x2::sui::SUI, T1, SuilendAdapter>(arg1, v0, clamp<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg2, arg4, arg5), arg5);
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocation_amount(&v1);
        let (v3, v4) = redeem_request<T0, 0x2::sui::SUI>(arg0, arg2, v2, arg5, arg6);
        let v5 = v3;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg2, arg0.reserve_index, &v5, arg3, arg6);
        finish_redeem<T0, 0x2::sui::SUI, T1>(arg0, arg1, v1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg2, arg0.reserve_index, v5, arg6), arg4, v2, v4, b"forced", true, arg5)
    }

    public fun harvest<T0, T1, T2, T3>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, HarvestReceipt) {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T1, T2>(arg1, arg2, arg6), 6);
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::claim_rewards<T0, T3>(arg3, &arg0.cap, arg6, arg4, arg5, true, arg7);
        assert!(total_ctokens<T0, T1>(arg0, arg3) == total_ctokens<T0, T1>(arg0, arg3), 8);
        let v1 = HarvestReceipt{
            position : 0x2::object::id<Position<T0, T1>>(arg0),
            reward   : 0x1::type_name::with_defining_ids<T3>(),
            claimed  : 0x2::coin::value<T3>(&v0),
        };
        (v0, v1)
    }

    public fun harvest_foreign<T0, T1, T2, T3>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T3>, HarvestReceipt) {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T1, T2>(arg1, arg2, arg5), 6);
        assert!(arg4 != arg0.reserve_index, 10);
        let v0 = deposit_amount<T0>(arg3, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.cap), arg4);
        assert!(v0 > 0, 12);
        let v1 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity<T0, T3>(arg3, arg4, arg5, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T3>(arg3, arg4, &arg0.cap, arg5, v0, arg6), 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T3>>(), arg6);
        assert!(total_ctokens<T0, T1>(arg0, arg3) == total_ctokens<T0, T1>(arg0, arg3), 8);
        let v2 = HarvestReceipt{
            position : 0x2::object::id<Position<T0, T1>>(arg0),
            reward   : 0x1::type_name::with_defining_ids<T3>(),
            claimed  : 0x2::coin::value<T3>(&v1),
        };
        (v1, v2)
    }

    fun init(arg0: ADAPTER_SUILEND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            positions : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun live_value<T0, T1>(arg0: &Position<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        ctokens_to_value(total_ctokens<T0, T1>(arg0, arg1), ratio<T0, T1>(arg0, arg1, arg2))
    }

    public fun migrate<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap) {
        assert!(arg0.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>>(arg1), 1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == arg0.vault, 5);
        assert!(arg0.version < 1, 11);
        arg0.version = 1;
    }

    public fun obligation_ctokens<T0, T1>(arg0: &Position<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        let v0 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposits<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.cap)));
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0)) {
            if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_reserve_array_index(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v2)) == arg0.reserve_index) {
                v1 = v1 + 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::deposit_deposited_ctoken_amount(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::Deposit>(v0, v2));
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun obligation_id<T0, T1>(arg0: &Position<T0, T1>) : 0x2::object::ID {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation_id<T0>(&arg0.cap)
    }

    public fun position_vault<T0, T1>(arg0: &Position<T0, T1>) : 0x2::object::ID {
        arg0.vault
    }

    fun put_ctokens<T0, T1>(arg0: &mut Position<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::coin::Coin<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg0.stake_new) {
            0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg1, arg0.reserve_index, &arg0.cap, arg3, arg2, arg4);
        } else {
            0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(arg2));
        };
    }

    fun ratio<T0, T1>(arg0: &Position<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u256 {
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::to_scaled_val(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::simulated_ctoken_ratio<T0>(0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), arg0.reserve_index), arg2))
    }

    public fun raw_ctokens<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens)
    }

    public fun receipt_claimed(arg0: &HarvestReceipt) : u64 {
        arg0.claimed
    }

    public fun redeem<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : u64 {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = clamp<T0, T1, T2>(arg0, arg1, arg3, arg4, arg6);
        let v1 = SuilendAdapter{dummy_field: false};
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocate<T1, T2, SuilendAdapter>(arg1, arg2, v1, v0, arg6);
        let (v3, v4) = redeem_request<T0, T1>(arg0, arg3, v0, arg6, arg7);
        finish_redeem<T0, T1, T2>(arg0, arg1, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, T1>(arg3, arg0.reserve_index, v3, arg7), arg4, v0, v4, arg5, false, arg6)
    }

    fun redeem_request<T0, T1>(arg0: &mut Position<T0, T1>, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::LiquidityRequest<T0, T1>, u64) {
        let v0 = ratio<T0, T1>(arg0, arg1, arg3);
        let v1 = total_ctokens<T0, T1>(arg0, arg1);
        let v2 = ((arg2 as u256) * 1000000000000000000 + v0 - 1) / v0;
        let v3 = v2;
        if (v2 > (v1 as u256)) {
            v3 = (v1 as u256);
        };
        let v4 = (v3 as u64);
        let v5 = 0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens);
        let v6 = if (v4 < v5) {
            v4
        } else {
            v5
        };
        let v7 = 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(0x2::balance::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, v6), arg4);
        if (v4 > v6) {
            0x2::coin::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut v7, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg1, arg0.reserve_index, &arg0.cap, arg3, v4 - v6, arg4));
        };
        (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::redeem_ctokens_and_withdraw_liquidity_request<T0, T1>(arg1, arg0.reserve_index, arg3, v7, 0x1::option::none<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::RateLimiterExemption<T0, T1>>(), arg4), v4)
    }

    public fun redeem_sui<T0, T1>(arg0: &mut Position<T0, 0x2::sui::SUI>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<0x2::sui::SUI, T1>, arg2: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_bound<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg3);
        let v0 = clamp<T0, 0x2::sui::SUI, T1>(arg0, arg1, arg3, arg5, arg7);
        let v1 = SuilendAdapter{dummy_field: false};
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocate<0x2::sui::SUI, T1, SuilendAdapter>(arg1, arg2, v1, v0, arg7);
        let (v3, v4) = redeem_request<T0, 0x2::sui::SUI>(arg0, arg3, v0, arg7, arg8);
        let v5 = v3;
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::unstake_sui_from_staker<T0>(arg3, arg0.reserve_index, &v5, arg4, arg8);
        finish_redeem<T0, 0x2::sui::SUI, T1>(arg0, arg1, v2, 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::fulfill_liquidity_request<T0, 0x2::sui::SUI>(arg3, arg0.reserve_index, v5, arg8), arg5, v0, v4, arg6, false, arg7)
    }

    public fun redeemable<T0, T1>(arg0: &Position<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::vector::borrow<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::Reserve<T0>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::reserves<T0>(arg1), arg0.reserve_index);
        if (0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::is_market_paused<T0>(arg1) || 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::is_paused<T0>(v0)) {
            return 0
        };
        let v1 = ctokens_to_value(total_ctokens<T0, T1>(arg0, arg1), ratio<T0, T1>(arg0, arg1, arg2));
        let v2 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::available_amount<T0>(v0);
        let v3 = if (v2 > 100 + 1) {
            v2 - 100 - 1
        } else {
            0
        };
        if (v1 < v3) {
            v1
        } else {
            v3
        }
    }

    public fun reserve_index<T0, T1>(arg0: &Position<T0, T1>) : u64 {
        arg0.reserve_index
    }

    public fun set_stake_new<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap, arg3: bool) {
        assert_version<T0, T1>(arg0);
        assert!(arg0.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>>(arg1), 1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == arg0.vault, 5);
        arg0.stake_new = arg3;
    }

    public fun stake_ctokens<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T1, T2>(arg1, arg2, arg5), 6);
        assert!(arg4 > 0, 12);
        0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_ctokens_into_obligation<T0, T1>(arg3, arg0.reserve_index, &arg0.cap, arg5, 0x2::coin::from_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(0x2::balance::split<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, arg4), arg6), arg6);
        assert!(total_ctokens<T0, T1>(arg0, arg3) == total_ctokens<T0, T1>(arg0, arg3), 8);
        let v0 = BucketMoved{
            position      : 0x2::object::id<Position<T0, T1>>(arg0),
            ctokens       : arg4,
            to_obligation : true,
        };
        0x2::event::emit<BucketMoved>(v0);
    }

    public fun stake_new<T0, T1>(arg0: &Position<T0, T1>) : bool {
        arg0.stake_new
    }

    public fun supply<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        let v0 = live_value<T0, T1>(arg0, arg3, arg6);
        let v1 = SuilendAdapter{dummy_field: false};
        let (v2, v3) = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::allocate<T1, T2, SuilendAdapter>(arg1, arg2, v1, arg4, arg6);
        let v4 = 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::deposit_liquidity_and_mint_ctokens<T0, T1>(arg3, arg0.reserve_index, arg6, 0x2::coin::from_balance<T1>(v2, arg7), arg7);
        let v5 = arg0.stake_new;
        put_ctokens<T0, T1>(arg0, arg3, v4, arg6, arg7);
        let v6 = live_value<T0, T1>(arg0, arg3, arg6);
        let v7 = if (v6 > v0) {
            v6 - v0
        } else {
            0
        };
        let v8 = SuilendAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::confirm_allocation<T1, T2, SuilendAdapter>(arg1, v3, v8, v7, arg5);
        let v9 = Supplied{
            position      : 0x2::object::id<Position<T0, T1>>(arg0),
            amount        : arg4,
            ctokens       : 0x2::coin::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&v4),
            value_added   : v7,
            to_obligation : v5,
        };
        0x2::event::emit<Supplied>(v9);
    }

    public fun total_ctokens<T0, T1>(arg0: &Position<T0, T1>, arg1: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>) : u64 {
        0x2::balance::value<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&arg0.ctokens) + obligation_ctokens<T0, T1>(arg0, arg1)
    }

    public fun unstake_ctokens<T0, T1, T2>(arg0: &mut Position<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T1, T2>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_bound<T0, T1, T2>(arg0, arg1, arg3);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T1, T2>(arg1, arg2, arg5), 6);
        0x2::balance::join<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(&mut arg0.ctokens, 0x2::coin::into_balance<0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::reserve::CToken<T0, T1>>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::withdraw_ctokens<T0, T1>(arg3, arg0.reserve_index, &arg0.cap, arg5, arg4, arg6)));
        assert!(total_ctokens<T0, T1>(arg0, arg3) == total_ctokens<T0, T1>(arg0, arg3), 8);
        let v0 = BucketMoved{
            position      : 0x2::object::id<Position<T0, T1>>(arg0),
            ctokens       : arg4,
            to_obligation : false,
        };
        0x2::event::emit<BucketMoved>(v0);
    }

    // decompiled from Move bytecode v7
}

