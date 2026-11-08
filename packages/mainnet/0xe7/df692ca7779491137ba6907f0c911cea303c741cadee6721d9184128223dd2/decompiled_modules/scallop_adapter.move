module 0xe7df692ca7779491137ba6907f0c911cea303c741cadee6721d9184128223dd2::scallop_adapter {
    struct ScallopAdapter has drop {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        market: 0x2::object::ID,
        positions: 0x2::table::Table<0x2::object::ID, 0x2::object::ID>,
    }

    struct Position<phantom T0> has key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        market: 0x2::object::ID,
        coins: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
    }

    struct HarvestReceipt {
        position: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PositionCreated has copy, drop {
        position: 0x2::object::ID,
        vault: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
    }

    struct Supplied has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        minted: u64,
        value_added: u64,
    }

    struct Redeemed has copy, drop {
        vault: 0x2::object::ID,
        requested: u64,
        amount: u64,
        burned: u64,
        received: u64,
        forced: bool,
    }

    struct Harvested has copy, drop {
        vault: 0x2::object::ID,
        reward: 0x1::type_name::TypeName,
        reward_amount: u64,
        compounded: u64,
        minted: u64,
    }

    struct DonationAccepted has copy, drop {
        vault: 0x2::object::ID,
        coins: u64,
    }

    public fun report<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::NavSession, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &Position<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        check_bound<T0>(arg2, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1), arg3);
        let v0 = ScallopAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::report<T0, T1, ScallopAdapter>(arg0, arg1, v0, position_value<T0>(arg2, arg3));
    }

    public fun accept_market_coins<T0>(arg0: &mut Position<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>>(&mut arg0.id, arg1);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.coins, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v0));
        let v1 = DonationAccepted{
            vault : arg0.vault,
            coins : 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0),
        };
        0x2::event::emit<DonationAccepted>(v1);
    }

    fun asset_type<T0>() : 0x1::type_name::TypeName {
        0x1::type_name::with_defining_ids<T0>()
    }

    fun check_bound<T0>(arg0: &Position<T0>, arg1: 0x2::object::ID, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) {
        assert!(arg0.vault == arg1, 1);
        assert!(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg2) == arg0.market, 2);
    }

    fun coins_value(arg0: u64, arg1: u128, arg2: u64) : u64 {
        if (arg2 == 0 || arg0 == 0) {
            return 0
        };
        let v0 = (arg0 as u128) * arg1 / (arg2 as u128);
        if (v0 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v0 as u64)
        }
    }

    public fun create<T0, T1>(arg0: &mut Registry, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::CuratorCap, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::curator_cap_vault(arg2) == v0, 4);
        assert!(0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market>(arg3) == arg0.market, 2);
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::is_base_asset_active(arg3, asset_type<T0>()), 7);
        assert!(!0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.positions, v0), 3);
        let v1 = Position<T0>{
            id     : 0x2::object::new(arg4),
            vault  : v0,
            market : arg0.market,
            coins  : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(),
        };
        0x2::table::add<0x2::object::ID, 0x2::object::ID>(&mut arg0.positions, v0, 0x2::object::id<Position<T0>>(&v1));
        let v2 = PositionCreated{
            position : 0x2::object::id<Position<T0>>(&v1),
            vault    : v0,
            asset    : asset_type<T0>(),
        };
        0x2::event::emit<PositionCreated>(v2);
        0x2::transfer::share_object<Position<T0>>(v1);
    }

    public fun exchange_rate<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u128, u64) {
        pool<T0>(arg0)
    }

    public fun finish_harvest<T0, T1>(arg0: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut Position<T0>, arg2: HarvestReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let HarvestReceipt {
            position : v0,
            reward   : v1,
            amount   : v2,
        } = arg2;
        assert!(v0 == 0x2::object::id<Position<T0>>(arg1), 8);
        check_bound<T0>(arg1, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0), arg5);
        let v3 = 0x2::coin::value<T0>(&arg3);
        let v4 = if (v3 == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
            0
        } else {
            let v5 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg4, arg5, arg3, arg6, arg7);
            0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg1.coins, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v5));
            0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v5)
        };
        let v6 = Harvested{
            vault         : 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0),
            reward        : v1,
            reward_amount : v2,
            compounded    : v3,
            minted        : v4,
        };
        0x2::event::emit<Harvested>(v6);
    }

    public fun force_redeem<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut Position<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : u64 {
        check_bound<T0>(arg1, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0), arg3);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg2, arg3, arg5);
        let v0 = min(arg4, withdrawable<T0>(arg1, arg3));
        assert!(v0 > 0, 6);
        let v1 = ScallopAdapter{dummy_field: false};
        let v2 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::force_deallocate<T0, T1, ScallopAdapter>(arg0, v1, v0, arg5);
        let v3 = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocation_amount(&v2);
        let (v4, v5) = take<T0>(arg1, arg2, arg3, v3, arg5, arg6);
        let v6 = v4;
        let v7 = Redeemed{
            vault     : 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0),
            requested : arg4,
            amount    : v3,
            burned    : v5,
            received  : 0x2::balance::value<T0>(&v6),
            forced    : true,
        };
        0x2::event::emit<Redeemed>(v7);
        let v8 = ScallopAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::settle_deallocation<T0, T1, ScallopAdapter>(arg0, v2, v8, v6, b"force_redeem", arg5);
        v3
    }

    public fun harvest<T0, T1, T2>(arg0: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &mut Position<T0>, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<T2>>, arg4: &0x2::clock::Clock) : (0x2::coin::Coin<T2>, HarvestReceipt) {
        assert!(arg2.vault == 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0), 1);
        assert!(0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::is_live_allocator<T0, T1>(arg0, arg1, arg4), 5);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T2>>(&mut arg2.id, arg3);
        let v1 = HarvestReceipt{
            position : 0x2::object::id<Position<T0>>(arg2),
            reward   : 0x1::type_name::with_defining_ids<T2>(),
            amount   : 0x2::coin::value<T2>(&v0),
        };
        (v0, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg0),
            market    : 0x2::object::id_from_address(@0xa757975255146dc9686aa823b7838b507f315d704f428cbadad2f4ea061939d9),
            positions : 0x2::table::new<0x2::object::ID, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun liquidity<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let (v0, _, v2, _) = sheet<T0>(arg0);
        if (v0 > v2) {
            v0 - v2
        } else {
            0
        }
    }

    public fun market_coins<T0>(arg0: &Position<T0>) : u64 {
        0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.coins)
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun pool<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u128, u64) {
        let (v0, v1, v2, v3) = sheet<T0>(arg0);
        let v4 = (v0 as u128) + (v1 as u128);
        let v5 = if (v4 > (v2 as u128)) {
            v4 - (v2 as u128)
        } else {
            0
        };
        (v5, v3)
    }

    public fun position_of(arg0: &Registry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<0x2::object::ID, 0x2::object::ID>(&arg0.positions, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<0x2::object::ID, 0x2::object::ID>(&arg0.positions, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun position_value<T0>(arg0: &Position<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        let (v0, v1) = pool<T0>(arg1);
        coins_value(0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.coins), v0, v1)
    }

    public fun position_vault<T0>(arg0: &Position<T0>) : 0x2::object::ID {
        arg0.vault
    }

    public fun redeem<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &mut Position<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        check_bound<T0>(arg2, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0), arg4);
        assert!(arg5 > 0, 9);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg3, arg4, arg7);
        let v0 = min(min(arg5, 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::adapter_value<T0, T1, ScallopAdapter>(arg0)), withdrawable<T0>(arg2, arg4));
        assert!(v0 > 0, 6);
        let v1 = ScallopAdapter{dummy_field: false};
        let (v2, v3) = take<T0>(arg2, arg3, arg4, v0, arg7, arg8);
        let v4 = v2;
        let v5 = Redeemed{
            vault     : 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0),
            requested : arg5,
            amount    : v0,
            burned    : v3,
            received  : 0x2::balance::value<T0>(&v4),
            forced    : false,
        };
        0x2::event::emit<Redeemed>(v5);
        let v6 = ScallopAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::settle_deallocation<T0, T1, ScallopAdapter>(arg0, 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::deallocate<T0, T1, ScallopAdapter>(arg0, arg1, v1, v0, arg7), v6, v4, arg6, arg7);
        v0
    }

    public fun report_fresh<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::NavSession, arg1: &0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg2: &Position<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0x2::clock::Clock) {
        check_bound<T0>(arg2, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg1), arg4);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::accrue_interest::accrue_interest_for_market(arg3, arg4, arg5);
        let v0 = ScallopAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::report<T0, T1, ScallopAdapter>(arg0, arg1, v0, position_value<T0>(arg2, arg4));
    }

    public fun scallop_version_ok(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version) : bool {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::is_current_version(arg0)
    }

    fun sheet<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : (u64, u64, u64, u64) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheet(0x779b5c547976899f5474f3a5bc0db36ddf4697ad7e5a901db0415c2281d28162::wit_table::borrow<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheets, 0x1::type_name::TypeName, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::BalanceSheet>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::balance_sheets(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::vault(arg0)), asset_type<T0>()))
    }

    public fun supply<T0, T1>(arg0: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>, arg1: &mut 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::AllocatorCap, arg2: &mut Position<T0>, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        check_bound<T0>(arg2, 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0), arg4);
        assert!(arg5 > 0, 9);
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::is_base_asset_active(arg4, asset_type<T0>()), 7);
        let v0 = ScallopAdapter{dummy_field: false};
        let (v1, v2) = 0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::allocate<T0, T1, ScallopAdapter>(arg0, arg1, v0, arg5, arg7);
        let v3 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg3, arg4, 0x2::coin::from_balance<T0>(v1, arg8), arg7, arg8);
        let v4 = 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v3);
        0x2::balance::join<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg2.coins, 0x2::coin::into_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(v3));
        let (v5, v6) = pool<T0>(arg4);
        let v7 = coins_value(v4, v5, v6);
        let v8 = ScallopAdapter{dummy_field: false};
        0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::confirm_allocation<T0, T1, ScallopAdapter>(arg0, v2, v8, v7, arg6);
        let v9 = Supplied{
            vault       : 0x2::object::id<0x518b28157bcf6351d8b8056563c542256acd2a983251479bb4a4d39f94821178::vault::Vault<T0, T1>>(arg0),
            amount      : arg5,
            minted      : v4,
            value_added : v7,
        };
        0x2::event::emit<Supplied>(v9);
    }

    fun take<T0>(arg0: &mut Position<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        let (v0, v1) = pool<T0>(arg2);
        assert!(v0 > 0 && v1 > 0, 6);
        let v2 = 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.coins);
        let v3 = ((arg3 as u128) * (v1 as u128) + v0 - 1) / v0;
        let v4 = if (v3 > (v2 as u128)) {
            v2
        } else {
            (v3 as u64)
        };
        let v5 = v4;
        let v6 = liquidity<T0>(arg2);
        if (coins_value(v4, v0, v1) > v6) {
            v5 = (((v6 as u128) * (v1 as u128) / v0) as u64);
        };
        assert!(v5 > 0 && coins_value(v5, v0, v1) > 0, 6);
        (0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, 0x2::coin::from_balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(0x2::balance::split<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&mut arg0.coins, v5), arg5), arg4, arg5)), v5)
    }

    public fun withdrawable<T0>(arg0: &Position<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market) : u64 {
        min(position_value<T0>(arg0, arg1), liquidity<T0>(arg1))
    }

    // decompiled from Move bytecode v7
}

