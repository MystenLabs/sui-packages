module 0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log_sale {
    struct Sale has store, key {
        id: 0x2::object::UID,
        inventory: 0x2::balance::Balance<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>,
        sui_treasury_id: 0x2::object::ID,
        price_mist_per_log: u64,
        active: bool,
    }

    struct SaleAdminCap has store, key {
        id: 0x2::object::UID,
        sale_id: 0x2::object::ID,
    }

    struct SuiTreasury has store, key {
        id: 0x2::object::UID,
        proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SuiTreasuryAdminCap has store, key {
        id: 0x2::object::UID,
        treasury_id: 0x2::object::ID,
    }

    struct SaleConfigured has copy, drop {
        sale_id: 0x2::object::ID,
        price_mist_per_log: u64,
    }

    struct SaleStarted has copy, drop {
        sale_id: 0x2::object::ID,
    }

    struct SaleEnded has copy, drop {
        sale_id: 0x2::object::ID,
    }

    struct SaleInventoryWithdrawn has copy, drop {
        sale_id: 0x2::object::ID,
        amount: u64,
    }

    struct PurchaseCompleted has copy, drop {
        sale_id: 0x2::object::ID,
        sui_treasury_id: 0x2::object::ID,
        buyer: address,
        log_amount: u64,
        sui_amount: u64,
    }

    struct SuiWithdrawn has copy, drop {
        treasury_id: 0x2::object::ID,
        amount: u64,
    }

    fun assert_sale_admin(arg0: &Sale, arg1: &SaleAdminCap) {
        assert!(arg1.sale_id == 0x2::object::id<Sale>(arg0), 13906835303919910915);
    }

    public fun buy(arg0: &mut Sale, arg1: &mut SuiTreasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG> {
        assert!(arg0.active, 13906834986092593159);
        assert!(0x2::object::id<SuiTreasury>(arg1) == arg0.sui_treasury_id, 13906834998977232899);
        assert!(arg3 > 0 && arg3 % 1000000000 == 0, 13906835016157626379);
        assert!(0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory) >= arg3, 13906835024747692045);
        assert!(arg0.price_mist_per_log > 0, 13906835029042135045);
        let v0 = arg3 / 1000000000;
        assert!(v0 <= 18446744073709551615 / arg0.price_mist_per_log, 13906835050517889043);
        let v1 = v0 * arg0.price_mist_per_log;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == v1, 13906835063402659857);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.proceeds, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v2 = PurchaseCompleted{
            sale_id         : 0x2::object::id<Sale>(arg0),
            sui_treasury_id : 0x2::object::id<SuiTreasury>(arg1),
            buyer           : 0x2::tx_context::sender(arg4),
            log_amount      : arg3,
            sui_amount      : v1,
        };
        0x2::event::emit<PurchaseCompleted>(v2);
        if (0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory) == 0) {
            arg0.active = false;
            let v3 = SaleEnded{sale_id: 0x2::object::id<Sale>(arg0)};
            0x2::event::emit<SaleEnded>(v3);
        };
        0x2::coin::from_balance<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(0x2::balance::split<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&mut arg0.inventory, arg3), arg4)
    }

    public fun configure_sale(arg0: &mut Sale, arg1: &SaleAdminCap, arg2: u64) {
        assert_sale_admin(arg0, arg1);
        assert!(!arg0.active, 13906834732689653769);
        assert!(arg2 > 0 && 0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory) > 0, 13906834745574293509);
        arg0.price_mist_per_log = arg2;
        let v0 = SaleConfigured{
            sale_id            : 0x2::object::id<Sale>(arg0),
            price_mist_per_log : arg2,
        };
        0x2::event::emit<SaleConfigured>(v0);
    }

    public fun create_sale(arg0: 0x2::coin::Coin<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>, arg1: SuiTreasury, arg2: &mut 0x2::tx_context::TxContext) : (Sale, SaleAdminCap, SuiTreasury) {
        assert!(0x2::coin::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0) > 0, 13906834633905668109);
        let v0 = Sale{
            id                 : 0x2::object::new(arg2),
            inventory          : 0x2::coin::into_balance<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(arg0),
            sui_treasury_id    : 0x2::object::id<SuiTreasury>(&arg1),
            price_mist_per_log : 0,
            active             : false,
        };
        let v1 = SaleAdminCap{
            id      : 0x2::object::new(arg2),
            sale_id : 0x2::object::id<Sale>(&v0),
        };
        (v0, v1, arg1)
    }

    public fun create_sui_treasury(arg0: &mut 0x2::tx_context::TxContext) : (SuiTreasury, SuiTreasuryAdminCap) {
        let v0 = SuiTreasury{
            id       : 0x2::object::new(arg0),
            proceeds : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = SuiTreasuryAdminCap{
            id          : 0x2::object::new(arg0),
            treasury_id : 0x2::object::id<SuiTreasury>(&v0),
        };
        (v0, v1)
    }

    public fun end_sale(arg0: &mut Sale, arg1: &SaleAdminCap) {
        assert_sale_admin(arg0, arg1);
        arg0.active = false;
        let v0 = SaleEnded{sale_id: 0x2::object::id<Sale>(arg0)};
        0x2::event::emit<SaleEnded>(v0);
    }

    public fun inventory_balance(arg0: &Sale) : u64 {
        0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory)
    }

    public fun is_active(arg0: &Sale) : bool {
        arg0.active
    }

    public fun price_mist_per_log(arg0: &Sale) : u64 {
        arg0.price_mist_per_log
    }

    public fun start_sale(arg0: &mut Sale, arg1: &SaleAdminCap) {
        assert_sale_admin(arg0, arg1);
        assert!(!arg0.active, 13906834801409130505);
        assert!(arg0.price_mist_per_log > 0 && 0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory) > 0, 13906834818588737541);
        arg0.active = true;
        let v0 = SaleStarted{sale_id: 0x2::object::id<Sale>(arg0)};
        0x2::event::emit<SaleStarted>(v0);
    }

    public fun sui_balance(arg0: &SuiTreasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.proceeds)
    }

    public fun withdraw_inventory(arg0: &mut Sale, arg1: &SaleAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG> {
        assert_sale_admin(arg0, arg1);
        assert!(!arg0.active, 13906834904488738831);
        assert!(arg2 > 0 && 0x2::balance::value<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&arg0.inventory) >= arg2, 13906834908783575053);
        let v0 = SaleInventoryWithdrawn{
            sale_id : 0x2::object::id<Sale>(arg0),
            amount  : arg2,
        };
        0x2::event::emit<SaleInventoryWithdrawn>(v0);
        0x2::coin::from_balance<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(0x2::balance::split<0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log::LOG>(&mut arg0.inventory, arg2), arg3)
    }

    public fun withdraw_sui(arg0: &mut SuiTreasury, arg1: &SuiTreasuryAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.treasury_id == 0x2::object::id<SuiTreasury>(arg0), 13906835179365859331);
        assert!(arg2 > 0 && 0x2::balance::value<0x2::sui::SUI>(&arg0.proceeds) >= arg2, 13906835183662006293);
        let v0 = SuiWithdrawn{
            treasury_id : 0x2::object::id<SuiTreasury>(arg0),
            amount      : arg2,
        };
        0x2::event::emit<SuiWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.proceeds, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

