module 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::vault_vester {
    struct VaultVester has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        index: u64,
        name: 0x1::string::String,
        lp_coin_type: 0x1::type_name::TypeName,
        position: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
        balance: 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>,
        total_supply: u64,
        allocated_lp_amount: u64,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
        impaired_a: u64,
        impaired_b: u64,
        cetus_amount: u64,
        redeemed_amount: u64,
        start_time: u64,
        global_vesting_periods: vector<GlobalVestingPeriod>,
        vester_infos: 0x2::table::Table<0x2::object::ID, CetusVaultVesterInfo>,
        url: 0x1::string::String,
    }

    struct GlobalVestingPeriod has copy, drop, store {
        period: u16,
        is_claimed: bool,
        release_time: u64,
        cetus_amount: u64,
        redeemed_amount: u64,
    }

    struct CetusVaultVesterInfo has copy, drop, store {
        is_pause: bool,
        msg: 0x1::string::String,
    }

    struct CetusVaultVester has store, key {
        id: 0x2::object::UID,
        index: u64,
        pool_name: 0x1::string::String,
        vester_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        lp_amount: u64,
        redeemed_amount: u64,
        impaired_a: u64,
        impaired_b: u64,
        period_infos: vector<PeriodInfo>,
        url: 0x1::string::String,
    }

    struct PeriodInfo has copy, drop, store {
        period: u16,
        cetus_amount: u64,
        is_redeemed: bool,
    }

    struct RedeemEvent has copy, drop {
        vault_vester_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        period: u16,
        amount: u64,
    }

    struct CreateEvent has copy, drop {
        clmm_vester_id: 0x2::object::ID,
        vault_vester_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lp_coin_type: 0x1::type_name::TypeName,
    }

    struct PauseEvent has copy, drop {
        vault_vester_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
    }

    struct VAULT_VESTER has drop {
        dummy_field: bool,
    }

    public fun allocate(arg0: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap, arg2: &mut VaultVester, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::check_version(arg0);
        let v0 = 0;
        let v1 = 0x1::vector::empty<PeriodInfo>();
        let v2 = arg2.global_vesting_periods;
        while (v0 < 0x1::vector::length<GlobalVestingPeriod>(&v2)) {
            let v3 = PeriodInfo{
                period       : (v0 as u16),
                cetus_amount : (((0x1::vector::borrow<GlobalVestingPeriod>(&v2, v0).cetus_amount as u128) * (arg4 as u128) / (arg2.total_supply as u128)) as u64),
                is_redeemed  : false,
            };
            0x1::vector::push_back<PeriodInfo>(&mut v1, v3);
            v0 = v0 + 1;
        };
        arg2.index = arg2.index + 1;
        arg2.allocated_lp_amount = arg2.allocated_lp_amount + arg4;
        assert!(arg2.allocated_lp_amount <= arg2.total_supply, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::allocated_lp_amount_exceed());
        let v4 = CetusVaultVesterInfo{
            is_pause : false,
            msg      : 0x1::string::utf8(b""),
        };
        let v5 = CetusVaultVester{
            id              : 0x2::object::new(arg5),
            index           : arg2.index,
            pool_name       : arg2.name,
            vester_id       : 0x2::object::id<VaultVester>(arg2),
            vault_id        : arg2.vault_id,
            lp_amount       : arg4,
            redeemed_amount : 0,
            impaired_a      : (((arg2.impaired_a as u128) * (arg4 as u128) / (arg2.total_supply as u128)) as u64),
            impaired_b      : (((arg2.impaired_b as u128) * (arg4 as u128) / (arg2.total_supply as u128)) as u64),
            period_infos    : v1,
            url             : arg2.url,
        };
        0x2::table::add<0x2::object::ID, CetusVaultVesterInfo>(&mut arg2.vester_infos, 0x2::object::id<CetusVaultVester>(&v5), v4);
        0x2::transfer::transfer<CetusVaultVester>(v5, arg3);
    }

    public fun create<T0, T1, T2>(arg0: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap, arg2: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg3: &0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::VaultsManager, arg4: &mut 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>, arg5: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::rewarder::RewarderManager, arg6: &0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::config::GlobalConfig, arg7: &mut 0x11ea791d82b5742cc8cab0bf7946035c97d9001d7c3803a93f119753da66f526::pool::Pool, arg8: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: 0x1::string::String, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::check_version(arg0);
        assert!(0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::pool_id<T2>(arg4) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::pool_not_match());
        let v0 = 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::governance_migrate_position<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg13, arg14);
        let v1 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v0);
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v0) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::position_not_match());
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_attacked_position<T0, T1>(arg9, v1), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::position_attacked());
        let v2 = 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::get_position_vesting<T0, T1>(arg2, arg9, v1);
        let v3 = 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::position_period_details(&v2);
        let (v4, v5) = 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::impaired_ab(&v2);
        let v6 = 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::global_vesting_periods(arg2);
        let v7 = 0x1::vector::empty<GlobalVestingPeriod>();
        let v8 = 0;
        while (v8 < 0x1::vector::length<0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::GlobalVestingPeriod>(&v6)) {
            let v9 = *0x1::vector::borrow<0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::GlobalVestingPeriod>(&v6, v8);
            let v10 = *0x1::vector::borrow<0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::PeriodDetail>(&v3, v8);
            let v11 = GlobalVestingPeriod{
                period          : 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::period(&v9),
                is_claimed      : false,
                release_time    : 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::release_time(&v9),
                cetus_amount    : 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::period_cetus_amount(&v10),
                redeemed_amount : 0,
            };
            0x1::vector::push_back<GlobalVestingPeriod>(&mut v7, v11);
            v8 = v8 + 1;
        };
        let v12 = VaultVester{
            id                     : 0x2::object::new(arg14),
            vault_id               : 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg4),
            index                  : 0,
            name                   : gen_vester_name<T0, T1>(arg10, arg11),
            lp_coin_type           : 0x1::type_name::get<T2>(),
            position               : v0,
            balance                : 0x2::balance::zero<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(),
            total_supply           : 0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::total_token_amount<T2>(arg4),
            allocated_lp_amount    : 0,
            coin_a                 : 0x1::type_name::get<T0>(),
            coin_b                 : 0x1::type_name::get<T1>(),
            impaired_a             : v4,
            impaired_b             : v5,
            cetus_amount           : 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::position_cetus_amount(&v2),
            redeemed_amount        : 0,
            start_time             : 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::start_time(arg2),
            global_vesting_periods : v7,
            vester_infos           : 0x2::table::new<0x2::object::ID, CetusVaultVesterInfo>(arg14),
            url                    : arg12,
        };
        let v13 = CreateEvent{
            clmm_vester_id  : 0x2::object::id<0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester>(arg2),
            vault_vester_id : 0x2::object::id<VaultVester>(&v12),
            vault_id        : 0x2::object::id<0xd3453d9be7e35efe222f78a810bb3af1859fd1600926afced8b4936d825c9a05::vaults::Vault<T2>>(arg4),
            pool_id         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg9),
            position_id     : v1,
            lp_coin_type    : 0x1::type_name::get<T2>(),
        };
        0x2::event::emit<CreateEvent>(v13);
        0x2::transfer::share_object<VaultVester>(v12);
    }

    fun gen_vester_name<T0, T1>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: &0x2::coin::CoinMetadata<T1>) : 0x1::string::String {
        let v0 = 0x1::string::from_ascii(0x2::coin::get_symbol<T0>(arg0));
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x2::coin::get_symbol<T1>(arg1)));
        v0
    }

    fun init(arg0: VAULT_VESTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Compensation Ticket of Cetus Vault #{index}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cetus.zone"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This NFT represents a compensation ticket from Cetus Vault for your affected liquidity in the {pool_name} vault."));
        let v4 = 0x2::package::claim<VAULT_VESTER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CetusVaultVester>(&v4, v0, v2, arg1);
        0x2::display::update_version<CetusVaultVester>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CetusVaultVester>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun pause(arg0: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::Versioned, arg1: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::admin_cap::AdminCap, arg2: &mut VaultVester, arg3: 0x2::object::ID, arg4: 0x1::string::String) {
        0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::check_version(arg0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, CetusVaultVesterInfo>(&mut arg2.vester_infos, arg3);
        assert!(!v0.is_pause, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::already_paused());
        v0.is_pause = true;
        v0.msg = arg4;
        let v1 = PauseEvent{
            vault_vester_id : 0x2::object::id<VaultVester>(arg2),
            nft_id          : arg3,
        };
        0x2::event::emit<PauseEvent>(v1);
    }

    public fun redeem<T0, T1>(arg0: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::Versioned, arg1: &mut VaultVester, arg2: &mut CetusVaultVester, arg3: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg4: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u16, arg7: &0x2::clock::Clock) : 0x2::balance::Balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS> {
        0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::check_version(arg0);
        assert!(0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg5) == 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg1.position), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::pool_not_match());
        assert!(arg2.vester_id == 0x2::object::id<VaultVester>(arg1), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::vester_not_match());
        assert!((arg6 as u64) < 0x1::vector::length<PeriodInfo>(&arg2.period_infos), 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::period_illegal());
        redeem_from_clmm_vester<T0, T1>(arg1, arg3, arg4, arg5, arg6, arg7);
        assert!(!0x2::table::borrow<0x2::object::ID, CetusVaultVesterInfo>(&arg1.vester_infos, 0x2::object::id<CetusVaultVester>(arg2)).is_pause, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::vesting_paused());
        let v0 = 0x1::vector::borrow_mut<PeriodInfo>(&mut arg2.period_infos, (arg6 as u64));
        assert!(!v0.is_redeemed, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::already_redeemed());
        let v1 = 0x1::vector::borrow_mut<GlobalVestingPeriod>(&mut arg1.global_vesting_periods, (arg6 as u64));
        assert!(0x2::clock::timestamp_ms(arg7) / 1000 >= v1.release_time, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::lock_time_not_end());
        v0.is_redeemed = true;
        let v2 = v0.cetus_amount;
        arg2.redeemed_amount = arg2.redeemed_amount + v2;
        v1.redeemed_amount = v1.redeemed_amount + v2;
        arg1.redeemed_amount = arg1.redeemed_amount + v2;
        assert!(0x2::balance::value<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&arg1.balance) >= v2, 0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::errors::balance_not_enough());
        let v3 = RedeemEvent{
            vault_vester_id : 0x2::object::id<VaultVester>(arg1),
            nft_id          : 0x2::object::id<CetusVaultVester>(arg2),
            period          : arg6,
            amount          : v2,
        };
        0x2::event::emit<RedeemEvent>(v3);
        0x2::balance::split<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg1.balance, v2)
    }

    public fun redeem_coin<T0, T1>(arg0: &0x27f936160f66ffaad15c775507f30d7634e4287054846f13c9c43df9cb1f9fdf::versioned::Versioned, arg1: &mut VaultVester, arg2: &mut CetusVaultVester, arg3: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg4: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u16, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>>(0x2::coin::from_balance<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(redeem<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7), arg8), 0x2::tx_context::sender(arg8));
    }

    fun redeem_from_clmm_vester<T0, T1>(arg0: &mut VaultVester, arg1: &0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::versioned::Versioned, arg2: &mut 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::ClmmVester, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u16, arg5: &0x2::clock::Clock) {
        if (0x1::vector::borrow<GlobalVestingPeriod>(&arg0.global_vesting_periods, (arg4 as u64)).is_claimed) {
            return
        };
        0x2::balance::join<0x6864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS>(&mut arg0.balance, 0x9d2f067d3b9d19ac0f8d2e5c2c393b1760232083e42005b2e5df39c06064d522::clmm_vester::redeem<T0, T1>(arg1, arg2, arg3, &mut arg0.position, arg4, arg5));
        0x1::vector::borrow_mut<GlobalVestingPeriod>(&mut arg0.global_vesting_periods, (arg4 as u64)).is_claimed = true;
    }

    // decompiled from Move bytecode v6
}

