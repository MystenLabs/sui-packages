module 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::fee_manager {
    struct DnaFeeKey has copy, drop, store {
        dummy_field: bool,
    }

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

    struct CollectionServiceFeeRatioKey has copy, drop, store {
        collection_id: 0x2::object::ID,
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

    struct FeeCollectedByCoinType has copy, drop {
        fee_manager_id: address,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from_transaction: address,
    }

    struct FeeWithdrawn has copy, drop {
        fee_manager_id: address,
        recipient: address,
        amount: u64,
    }

    struct FeeWithdrawnByCoinType has copy, drop {
        fee_manager_id: address,
        coin_type: 0x1::ascii::String,
        recipient: address,
        amount: u64,
    }

    struct DeveloperRoyaltySet has copy, drop {
        fee_manager_id: address,
        developer: address,
        royalty_rate: u64,
    }

    struct CollectionServiceFeeRatioSet has copy, drop {
        fee_manager_id: address,
        collection_id: 0x2::object::ID,
        service_fee_rate: u64,
    }

    struct FeeManagerUpdated has copy, drop {
        fee_manager_id: address,
        purchase_fee_rate: u64,
        purchase_developer_royalty_rate: u64,
        item_swap_fee_ratio: u64,
        item_swap_developer_royalty_ratio: u64,
        item_swap_fee: u64,
        updater: address,
    }

    struct DnaCreationFeeCollected has copy, drop {
        fee_manager_id: address,
        collection_id: address,
        item_id: 0x1::option::Option<address>,
        amount: u64,
        creator: address,
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

    public(friend) fun deposit_dna_creation_fee(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: 0x1::option::Option<address>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 == get_dna_creation_fee(arg0), 5);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = DnaCreationFeeCollected{
            fee_manager_id : 0x2::object::uid_to_address(&arg0.id),
            collection_id  : arg2,
            item_id        : arg3,
            amount         : v0,
            creator        : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DnaCreationFeeCollected>(v1);
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

    public(friend) fun deposit_service_fee_by_coin_type<T0>(arg0: &mut FeeManager, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = FeeCollectedByCoinType{
            fee_manager_id   : 0x2::object::uid_to_address(&arg0.id),
            coin_type        : 0x1::type_name::into_string(v0),
            amount           : 0x2::coin::value<T0>(&arg1),
            from_transaction : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollectedByCoinType>(v1);
    }

    public fun get_balance(arg0: &FeeManager) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_collection_service_fee_ratio(arg0: &FeeManager, arg1: 0x2::object::ID) : u64 {
        let v0 = CollectionServiceFeeRatioKey{collection_id: arg1};
        if (0x2::dynamic_field::exists_<CollectionServiceFeeRatioKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<CollectionServiceFeeRatioKey, u64>(&arg0.id, v0)
        } else {
            3000
        }
    }

    public fun get_dna_creation_fee(arg0: &FeeManager) : u64 {
        let v0 = DnaFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<DnaFeeKey>(&arg0.id, v0)) {
            let v2 = DnaFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DnaFeeKey, u64>(&arg0.id, v2)
        } else {
            35000000
        }
    }

    public fun get_fee_manager(arg0: &FeeManager) : (u64, u64, u64, u64, u64) {
        (arg0.purchase_fee_rate, arg0.item_swap_fee_ratio, arg0.purchase_developer_royalty_rate, arg0.item_swap_developer_royalty_ratio, arg0.item_swap_fee)
    }

    public fun get_item_swap_fee(arg0: &FeeManager) : u64 {
        arg0.item_swap_fee
    }

    public fun get_service_fee_balance_by_coin_type<T0>(arg0: &FeeManager) : u64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.id, v0))
    }

    fun init(arg0: FEE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun set_collection_service_fee_ratio(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg4), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        assert!(arg3 <= 10000, 3);
        let v0 = CollectionServiceFeeRatioKey{collection_id: arg2};
        if (0x2::dynamic_field::exists_<CollectionServiceFeeRatioKey>(&arg1.id, v0)) {
            *0x2::dynamic_field::borrow_mut<CollectionServiceFeeRatioKey, u64>(&mut arg1.id, v0) = arg3;
        } else {
            0x2::dynamic_field::add<CollectionServiceFeeRatioKey, u64>(&mut arg1.id, v0, arg3);
        };
        let v1 = CollectionServiceFeeRatioSet{
            fee_manager_id   : 0x2::object::uid_to_address(&arg1.id),
            collection_id    : arg2,
            service_fee_rate : arg3,
        };
        0x2::event::emit<CollectionServiceFeeRatioSet>(v1);
    }

    public fun set_dna_creation_fee(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::admin_role()), 1);
        let v0 = DnaFeeKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<DnaFeeKey>(&arg1.id, v0)) {
            let v1 = DnaFeeKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<DnaFeeKey, u64>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = DnaFeeKey{dummy_field: false};
            0x2::dynamic_field::add<DnaFeeKey, u64>(&mut arg1.id, v2, arg2);
        };
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

    public fun update_fee_manager(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, v0, 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        assert!(arg2 + arg3 <= 10000, 3);
        assert!(arg4 + arg5 == 10000, 3);
        arg1.purchase_fee_rate = arg2;
        arg1.purchase_developer_royalty_rate = arg3;
        arg1.item_swap_fee_ratio = arg4;
        arg1.item_swap_developer_royalty_ratio = arg5;
        arg1.item_swap_fee = arg6;
        let v1 = FeeManagerUpdated{
            fee_manager_id                    : 0x2::object::uid_to_address(&arg1.id),
            purchase_fee_rate                 : arg2,
            purchase_developer_royalty_rate   : arg3,
            item_swap_fee_ratio               : arg4,
            item_swap_developer_royalty_ratio : arg5,
            item_swap_fee                     : arg6,
            updater                           : v0,
        };
        0x2::event::emit<FeeManagerUpdated>(v1);
    }

    public fun withdraw_all_service_fee_by_coin_type<T0>(arg0: &0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::RoleManager, arg1: &mut FeeManager, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::has_role(arg0, 0x2::tx_context::sender(arg3), 0xc8636f05706a76ecf41db6b516b64e0c38f89295732ca9370a4de27fd41b8814::role_manager::fee_role()), 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg1.id, v0), 6);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.id, v0);
        let v2 = 0x2::balance::value<T0>(v1);
        assert!(v2 > 0, 6);
        let v3 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(v1), arg3);
        let v4 = FeeWithdrawnByCoinType{
            fee_manager_id : 0x2::object::uid_to_address(&arg1.id),
            coin_type      : 0x1::type_name::into_string(v0),
            recipient      : arg2,
            amount         : v2,
        };
        0x2::event::emit<FeeWithdrawnByCoinType>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, arg2);
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

