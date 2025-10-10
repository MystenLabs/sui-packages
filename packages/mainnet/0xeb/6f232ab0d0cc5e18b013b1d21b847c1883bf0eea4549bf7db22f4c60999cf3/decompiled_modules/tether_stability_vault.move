module 0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_stability_vault {
    struct StabilityVault has key {
        id: 0x2::object::UID,
        sui_reserves: 0x2::balance::Balance<0x2::sui::SUI>,
        usdt_treasury: 0x2::coin::TreasuryCap<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>,
        collateral_ratio: u64,
        min_collateral_ratio: u64,
        redemption_fee: u64,
        total_collateral_usd: u64,
        total_debt_usd: u64,
        admin: address,
        emergency_paused: bool,
    }

    struct CollateralPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        sui_collateral: 0x2::balance::Balance<0x2::sui::SUI>,
        usdt_debt: u64,
        collateral_usd_value: u64,
        health_factor: u64,
    }

    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintWithCollateralEvent has copy, drop {
        user: address,
        collateral_amount: u64,
        usdt_minted: u64,
        collateral_ratio: u64,
    }

    struct RedeemCollateralEvent has copy, drop {
        user: address,
        usdt_burned: u64,
        collateral_returned: u64,
        redemption_fee: u64,
    }

    struct LiquidationEvent has copy, drop {
        liquidated_user: address,
        liquidator: address,
        collateral_seized: u64,
        debt_repaid: u64,
    }

    struct PegMaintenanceEvent has copy, drop {
        action: vector<u8>,
        amount: u64,
        current_price: u64,
        target_price: u64,
    }

    public entry fun emergency_burn_for_peg(arg0: &VaultAdminCap, arg1: &mut StabilityVault, arg2: 0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg3 < 10000, 2005);
        0x2::coin::burn<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg1.usdt_treasury, arg2);
        let v0 = PegMaintenanceEvent{
            action        : b"burn",
            amount        : 0x2::coin::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg2),
            current_price : arg3,
            target_price  : 10000,
        };
        0x2::event::emit<PegMaintenanceEvent>(v0);
    }

    public entry fun emergency_mint_for_peg(arg0: &VaultAdminCap, arg1: &mut StabilityVault, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 10000, 2005);
        let v0 = PegMaintenanceEvent{
            action        : b"mint",
            amount        : arg2,
            current_price : arg4,
            target_price  : 10000,
        };
        0x2::event::emit<PegMaintenanceEvent>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>>(0x2::coin::mint<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg1.usdt_treasury, arg2, arg5), arg3);
    }

    public fun get_position_health(arg0: &CollateralPosition) : (u64, u64, u64) {
        (arg0.collateral_usd_value, arg0.usdt_debt, arg0.health_factor)
    }

    public fun get_system_health(arg0: &StabilityVault) : u64 {
        if (arg0.total_debt_usd == 0) {
            return 10000
        };
        arg0.total_collateral_usd * 1000 / arg0.total_debt_usd
    }

    public fun get_vault_stats(arg0: &StabilityVault) : (u64, u64, u64, u64) {
        (arg0.total_collateral_usd, arg0.total_debt_usd, arg0.collateral_ratio, arg0.redemption_fee)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<VaultAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun liquidate_position(arg0: &mut StabilityVault, arg1: &mut CollateralPosition, arg2: 0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.health_factor < arg0.min_collateral_ratio, 2002);
        let v0 = 0x2::coin::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg2);
        assert!(v0 <= arg1.usdt_debt / 2, 2005);
        let v1 = v0 * 110 / 100;
        0x2::coin::burn<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_treasury, arg2);
        arg1.usdt_debt = arg1.usdt_debt - v0;
        arg1.collateral_usd_value = arg1.collateral_usd_value - v1;
        if (arg1.usdt_debt > 0) {
            arg1.health_factor = arg1.collateral_usd_value * 1000 / arg1.usdt_debt;
        } else {
            arg1.health_factor = 10000;
        };
        arg0.total_collateral_usd = arg0.total_collateral_usd - v1;
        arg0.total_debt_usd = arg0.total_debt_usd - v0;
        let v2 = LiquidationEvent{
            liquidated_user   : arg1.owner,
            liquidator        : 0x2::tx_context::sender(arg3),
            collateral_seized : v1,
            debt_repaid       : v0,
        };
        0x2::event::emit<LiquidationEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_collateral, v1), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun mint_with_collateral(arg0: &mut StabilityVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_paused, 2003);
        assert!(arg2 > 0, 2005);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg2 * arg0.collateral_ratio / 1000, 2001);
        let v1 = CollateralPosition{
            id                   : 0x2::object::new(arg3),
            owner                : 0x2::tx_context::sender(arg3),
            sui_collateral       : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            usdt_debt            : arg2,
            collateral_usd_value : v0,
            health_factor        : v0 * 1000 / arg2,
        };
        arg0.total_collateral_usd = arg0.total_collateral_usd + v0;
        arg0.total_debt_usd = arg0.total_debt_usd + arg2;
        let v2 = MintWithCollateralEvent{
            user              : 0x2::tx_context::sender(arg3),
            collateral_amount : v0,
            usdt_minted       : arg2,
            collateral_ratio  : v0 * 1000 / arg2,
        };
        0x2::event::emit<MintWithCollateralEvent>(v2);
        0x2::transfer::transfer<CollateralPosition>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>>(0x2::coin::mint<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_treasury, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun redeem_for_collateral(arg0: &mut StabilityVault, arg1: &mut CollateralPosition, arg2: 0x2::coin::Coin<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.emergency_paused, 2003);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2004);
        let v0 = 0x2::coin::value<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&arg2);
        assert!(v0 <= arg1.usdt_debt, 2005);
        let v1 = v0 * arg0.redemption_fee / 10000;
        let v2 = v0 - v1;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.sui_collateral) >= v0, 2007);
        0x2::coin::burn<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>(&mut arg0.usdt_treasury, arg2);
        arg1.usdt_debt = arg1.usdt_debt - v0;
        arg1.collateral_usd_value = arg1.collateral_usd_value - v0;
        if (arg1.usdt_debt > 0) {
            arg1.health_factor = arg1.collateral_usd_value * 1000 / arg1.usdt_debt;
        } else {
            arg1.health_factor = 10000;
        };
        arg0.total_collateral_usd = arg0.total_collateral_usd - v0;
        arg0.total_debt_usd = arg0.total_debt_usd - v0;
        let v3 = RedeemCollateralEvent{
            user                : 0x2::tx_context::sender(arg3),
            usdt_burned         : v0,
            collateral_returned : v2,
            redemption_fee      : v1,
        };
        0x2::event::emit<RedeemCollateralEvent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui_collateral, v2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun setup_stability_vault(arg0: &VaultAdminCap, arg1: 0x2::coin::TreasuryCap<0xeb6f232ab0d0cc5e18b013b1d21b847c1883bf0eea4549bf7db22f4c60999cf3::tether_usdt_core::TETHER_USDT_CORE>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StabilityVault{
            id                   : 0x2::object::new(arg2),
            sui_reserves         : 0x2::balance::zero<0x2::sui::SUI>(),
            usdt_treasury        : arg1,
            collateral_ratio     : 1500,
            min_collateral_ratio : 1200,
            redemption_fee       : 50,
            total_collateral_usd : 0,
            total_debt_usd       : 0,
            admin                : 0x2::tx_context::sender(arg2),
            emergency_paused     : false,
        };
        0x2::transfer::share_object<StabilityVault>(v0);
    }

    // decompiled from Move bytecode v6
}

