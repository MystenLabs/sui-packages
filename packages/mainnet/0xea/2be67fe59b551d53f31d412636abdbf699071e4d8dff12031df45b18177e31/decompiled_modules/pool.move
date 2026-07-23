module 0xea2be67fe59b551d53f31d412636abdbf699071e4d8dff12031df45b18177e31::pool {
    struct SaintsPool has key {
        id: 0x2::object::UID,
        kiosk_id: 0x2::object::ID,
        kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        inventory: vector<0x2::object::ID>,
        bid_mist: u64,
        ask_mist: u64,
        pick_fee_mist: u64,
        max_inventory: u64,
        paused: bool,
    }

    struct PoolAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PoolSold has copy, drop {
        saint_id: 0x2::object::ID,
        number: u64,
        seller: address,
        bid_atoms: u64,
        royalty_atoms: u64,
    }

    struct PoolBought has copy, drop {
        saint_id: 0x2::object::ID,
        number: u64,
        buyer: address,
        paid_atoms: u64,
        picked: bool,
    }

    struct PoolBackstopRedeemed has copy, drop {
        saint_id: 0x2::object::ID,
        number: u64,
        recovered_atoms: u64,
    }

    struct PoolDialsUpdated has copy, drop {
        bid_mist: u64,
        ask_mist: u64,
        pick_fee_mist: u64,
        max_inventory: u64,
        paused: bool,
    }

    struct PoolLiquidityChanged has copy, drop {
        amount_atoms: u64,
        is_deposit: bool,
        liquidity_atoms: u64,
    }

    public fun ask(arg0: &SaintsPool) : u64 {
        arg0.ask_mist
    }

    public fun backstop_redeem(arg0: &PoolAdminCap, arg1: &mut SaintsPool, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::SaintsConfig, arg4: &0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        remove_from_inventory(arg1, arg5);
        let (v0, v1) = take_from_pool_kiosk(arg1, arg2, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::redeem(arg3, v3, &mut v2, arg6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg4, v2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.sui, 0x2::coin::into_balance<0x2::sui::SUI>(v4));
        let v8 = PoolBackstopRedeemed{
            saint_id        : arg5,
            number          : 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::number(&v3),
            recovered_atoms : 0x2::coin::value<0x2::sui::SUI>(&v4),
        };
        0x2::event::emit<PoolBackstopRedeemed>(v8);
    }

    public fun bid(arg0: &SaintsPool) : u64 {
        arg0.bid_mist
    }

    fun buy_internal(arg0: &mut SaintsPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: bool, arg7: &mut 0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        let v0 = if (arg6) {
            arg0.ask_mist + arg0.pick_fee_mist
        } else {
            arg0.ask_mist
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) == v0, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg5));
        remove_from_inventory(arg0, arg4);
        let (v1, v2) = take_from_pool_kiosk(arg0, arg1, arg4, arg8);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::lock<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg2, arg3, arg7, v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(&mut v3, arg2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg7, &mut v3, 0x2::coin::zero<0x2::sui::SUI>(arg8));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg7, v3);
        let v8 = PoolBought{
            saint_id   : arg4,
            number     : 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::number(&v4),
            buyer      : 0x2::tx_context::sender(arg8),
            paid_atoms : v0,
            picked     : arg6,
        };
        0x2::event::emit<PoolBought>(v8);
    }

    public fun buy_next(arg0: &mut SaintsPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.inventory) > 0, 6);
        let v0 = *0x1::vector::borrow<0x2::object::ID>(&arg0.inventory, 0);
        buy_internal(arg0, arg1, arg2, arg3, v0, arg4, false, arg5, arg6);
    }

    public fun buy_pick(arg0: &mut SaintsPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg7: &mut 0x2::tx_context::TxContext) {
        buy_internal(arg0, arg1, arg2, arg3, arg4, arg5, true, arg6, arg7);
    }

    public fun deposit(arg0: &mut SaintsPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = PoolLiquidityChanged{
            amount_atoms    : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            is_deposit      : true,
            liquidity_atoms : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
        };
        0x2::event::emit<PoolLiquidityChanged>(v0);
    }

    fun emit_dials(arg0: &SaintsPool) {
        let v0 = PoolDialsUpdated{
            bid_mist      : arg0.bid_mist,
            ask_mist      : arg0.ask_mist,
            pick_fee_mist : arg0.pick_fee_mist,
            max_inventory : arg0.max_inventory,
            paused        : arg0.paused,
        };
        0x2::event::emit<PoolDialsUpdated>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        let v3 = SaintsPool{
            id            : 0x2::object::new(arg0),
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(&v2),
            kiosk_cap     : v1,
            sui           : 0x2::balance::zero<0x2::sui::SUI>(),
            inventory     : 0x1::vector::empty<0x2::object::ID>(),
            bid_mist      : 18000000000,
            ask_mist      : 22000000000,
            pick_fee_mist : 2000000000,
            max_inventory : 50,
            paused        : true,
        };
        0x2::transfer::share_object<SaintsPool>(v3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        let v4 = PoolAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PoolAdminCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun inventory(arg0: &SaintsPool) : vector<0x2::object::ID> {
        arg0.inventory
    }

    public fun inventory_size(arg0: &SaintsPool) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.inventory)
    }

    public fun is_paused(arg0: &SaintsPool) : bool {
        arg0.paused
    }

    public fun kiosk_id(arg0: &SaintsPool) : 0x2::object::ID {
        arg0.kiosk_id
    }

    public fun liquidity(arg0: &SaintsPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun max_inventory(arg0: &SaintsPool) : u64 {
        arg0.max_inventory
    }

    public fun pick_fee(arg0: &SaintsPool) : u64 {
        arg0.pick_fee_mist
    }

    fun remove_from_inventory(arg0: &mut SaintsPool, arg1: 0x2::object::ID) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.inventory, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.inventory, v1);
    }

    public fun sell_to_pool(arg0: &mut SaintsPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::transfer_policy::TransferPolicy<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.inventory) < arg0.max_inventory, 1);
        let v0 = arg0.bid_mist;
        let v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg5, v0);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= v0 + v1, 2);
        0x2::kiosk::list<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg2, arg3, arg4, v0);
        let (v2, v3) = 0x2::kiosk::purchase<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg2, arg4, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v0), arg6));
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::lock<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, &arg0.kiosk_cap, arg5, v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(&mut v4, arg1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg5, &mut v4, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, v1), arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg5, v4);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.inventory, arg4);
        let v9 = PoolSold{
            saint_id      : arg4,
            number        : 0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::number(&v5),
            seller        : 0x2::tx_context::sender(arg6),
            bid_atoms     : v0,
            royalty_atoms : v1,
        };
        0x2::event::emit<PoolSold>(v9);
    }

    public fun set_dials(arg0: &PoolAdminCap, arg1: &mut SaintsPool, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2 >= 17500000000, 5);
        assert!(arg3 >= arg2 + 1000000000, 5);
        assert!(arg5 <= 200, 5);
        arg1.bid_mist = arg2;
        arg1.ask_mist = arg3;
        arg1.pick_fee_mist = arg4;
        arg1.max_inventory = arg5;
        emit_dials(arg1);
    }

    public fun set_paused(arg0: &PoolAdminCap, arg1: &mut SaintsPool, arg2: bool) {
        arg1.paused = arg2;
        emit_dials(arg1);
    }

    fun take_from_pool_kiosk(arg0: &SaintsPool, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint, 0x2::transfer_policy::TransferRequest<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>) {
        0x2::kiosk::list<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, &arg0.kiosk_cap, arg2, 0);
        0x2::kiosk::purchase<0xbd8d4a6622d6e62e6bc7037cd98a232e0a27b8730fe799db8e02f58615e5c360::saint::Saint>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public fun withdraw(arg0: &PoolAdminCap, arg1: &mut SaintsPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = PoolLiquidityChanged{
            amount_atoms    : arg2,
            is_deposit      : false,
            liquidity_atoms : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
        };
        0x2::event::emit<PoolLiquidityChanged>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

