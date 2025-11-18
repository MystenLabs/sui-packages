module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager {
    struct FeeManager has store, key {
        id: 0x2::object::UID,
        purchase_fee_rate: u64,
        purchase_developer_royalty_rate: u64,
        item_swap_fee_ratio: u64,
        item_swap_developer_royalty_ratio: u64,
        item_swap_fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        developer_royalties: 0x2::table::Table<address, u64>,
    }

    struct FeeManagerCreated has copy, drop {
        fee_manager_id: address,
        purchase_fee_rate: u64,
        purchase_developer_royalty_rate: u64,
        item_swap_fee_ratio: u64,
        item_swap_developer_royalty_ratio: u64,
        item_swap_fee: u64,
        creator: address,
    }

    struct FeeCollected has copy, drop {
        fee_manager_id: address,
        amount: u64,
        from_transaction: address,
    }

    struct FeeWithdrawn has copy, drop {
        fee_manager_id: address,
        recipient: address,
        amount: u64,
    }

    struct DeveloperRoyaltySet has copy, drop {
        fee_manager_id: address,
        developer: address,
        royalty_rate: u64,
    }

    struct FEE_MANAGER has drop {
        dummy_field: bool,
    }

    public fun calculate_item_swap_developer_royalty(arg0: &FeeManager, arg1: address, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.developer_royalties, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.developer_royalties, arg1) + arg0.item_swap_developer_royalty_ratio
        } else {
            arg0.item_swap_developer_royalty_ratio
        };
        arg2 * v0 / 10000
    }

    public fun calculate_item_swap_fee(arg0: &FeeManager, arg1: u64) : u64 {
        arg1 * arg0.item_swap_fee_ratio / 10000
    }

    public fun calculate_purchase_developer_royalty(arg0: &FeeManager, arg1: address, arg2: u64) : u64 {
        let v0 = if (0x2::table::contains<address, u64>(&arg0.developer_royalties, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.developer_royalties, arg1) + arg0.purchase_developer_royalty_rate
        } else {
            arg0.purchase_developer_royalty_rate
        };
        arg2 * v0 / 10000
    }

    public fun calculate_purchase_fee(arg0: &FeeManager, arg1: u64) : u64 {
        arg1 * arg0.purchase_fee_rate / 10000
    }

    public fun create_fee_manager(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        assert!(arg1 + arg2 <= 10000, 3);
        assert!(arg3 + arg4 == 10000, 3);
        let v1 = 0x2::object::new(arg6);
        let v2 = FeeManager{
            id                                : v1,
            purchase_fee_rate                 : arg1,
            purchase_developer_royalty_rate   : arg2,
            item_swap_fee_ratio               : arg3,
            item_swap_developer_royalty_ratio : arg4,
            item_swap_fee                     : arg5,
            balance                           : 0x2::balance::zero<0x2::sui::SUI>(),
            developer_royalties               : 0x2::table::new<address, u64>(arg6),
        };
        let v3 = FeeManagerCreated{
            fee_manager_id                    : 0x2::object::uid_to_address(&v1),
            purchase_fee_rate                 : arg1,
            purchase_developer_royalty_rate   : arg2,
            item_swap_fee_ratio               : arg3,
            item_swap_developer_royalty_ratio : arg4,
            item_swap_fee                     : arg5,
            creator                           : v0,
        };
        0x2::event::emit<FeeManagerCreated>(v3);
        0x2::transfer::share_object<FeeManager>(v2);
    }

    public(friend) fun deposit_service_fee(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = FeeCollected{
            fee_manager_id   : 0x2::object::uid_to_address(&arg0.id),
            amount           : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            from_transaction : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public fun get_balance(arg0: &FeeManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_fee_manager(arg0: &FeeManager) : (u64, u64, u64, u64, u64) {
        (arg0.purchase_fee_rate, arg0.item_swap_fee_ratio, arg0.purchase_developer_royalty_rate, arg0.item_swap_developer_royalty_ratio, arg0.item_swap_fee)
    }

    public fun get_item_swap_fee(arg0: &FeeManager) : u64 {
        arg0.item_swap_fee
    }

    fun init(arg0: FEE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun set_specific_developer_royalty(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        assert!(arg3 <= 10000, 3);
        assert!(arg3 + arg1.purchase_developer_royalty_rate <= 10000, 4);
        if (0x2::table::contains<address, u64>(&arg1.developer_royalties, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg1.developer_royalties, arg2) = arg3;
        } else {
            0x2::table::add<address, u64>(&mut arg1.developer_royalties, arg2, arg3);
        };
        let v0 = DeveloperRoyaltySet{
            fee_manager_id : 0x2::object::uid_to_address(&arg1.id),
            developer      : arg2,
            royalty_rate   : arg3,
        };
        0x2::event::emit<DeveloperRoyaltySet>(v0);
    }

    public fun withdraw_service_fee(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.balance) >= arg3, 2);
        let v0 = FeeWithdrawn{
            fee_manager_id : 0x2::object::uid_to_address(&arg1.id),
            recipient      : arg2,
            amount         : arg3,
        };
        0x2::event::emit<FeeWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg3), arg4), arg2);
    }

    // decompiled from Move bytecode v6
}

