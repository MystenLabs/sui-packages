module 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::cetus_balance_manager {
    struct CetusBalanceManager has store, key {
        id: 0x2::object::UID,
        deepbook_balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        owner: address,
    }

    struct CetusBalanceManagerIndexer has store, key {
        id: 0x2::object::UID,
        cetus_managers: 0x2::table::Table<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>,
        cetus_manager_size: u64,
        deepbook_managers: 0x2::table::Table<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>,
        deepbook_manager_size: u64,
    }

    struct InitEvent has copy, drop, store {
        cetus_balance_manager_indexer_id: 0x2::object::ID,
    }

    struct CreateCetusBalanceManagerEvent has copy, drop, store {
        cetus_balance_manager_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        owner: address,
    }

    struct GetCetusBalanceManagerList has copy, drop, store {
        owner: address,
        cetus_balance_managers: vector<0x2::object::ID>,
        deepbook_balance_managers: vector<0x2::object::ID>,
    }

    struct CETUS_BALANCE_MANAGER has drop {
        dummy_field: bool,
    }

    public(friend) fun delete(arg0: CetusBalanceManager) {
        let CetusBalanceManager {
            id                       : v0,
            deepbook_balance_manager : v1,
            owner                    : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_share_object<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(v1);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : CetusBalanceManager {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new(arg0);
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = CetusBalanceManager{
            id                       : 0x2::object::new(arg0),
            deepbook_balance_manager : v0,
            owner                    : v1,
        };
        let v3 = CreateCetusBalanceManagerEvent{
            cetus_balance_manager_id : 0x2::object::id<CetusBalanceManager>(&v2),
            balance_manager_id       : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&v0),
            owner                    : v1,
        };
        0x2::event::emit<CreateCetusBalanceManagerEvent>(v3);
        v2
    }

    public(friend) fun balance<T0>(arg0: &CetusBalanceManager) : u64 {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.deepbook_balance_manager)
    }

    public fun deposit<T0>(arg0: &mut CetusBalanceManager, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(&mut arg0.deepbook_balance_manager, arg1, arg2);
    }

    public fun withdraw<T0>(arg0: &mut CetusBalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.deepbook_balance_manager, arg1, arg2)
    }

    public fun withdraw_all<T0>(arg0: &mut CetusBalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut arg0.deepbook_balance_manager, arg1)
    }

    public(friend) fun place_market_order<T0, T1>(arg0: &mut CetusBalanceManager, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u8, arg4: u64, arg5: bool, arg6: bool, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::order_info::OrderInfo {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_owner(&mut arg0.deepbook_balance_manager, arg8);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::place_market_order<T0, T1>(arg1, &mut arg0.deepbook_balance_manager, &v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public(friend) fun balance_manager_id(arg0: &CetusBalanceManager) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(&arg0.deepbook_balance_manager)
    }

    public fun check_and_add_cetus_balance_manager_indexer(arg0: &mut CetusBalanceManagerIndexer, arg1: &CetusBalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<CetusBalanceManager>(arg1);
        if (0x2::table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.cetus_managers, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.cetus_managers, v0);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(v2, v1)) {
                return
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(v2, v1, true);
        } else {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg2);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut v3, v1, true);
            0x2::table::add<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.cetus_managers, v0, v3);
            arg0.cetus_manager_size = arg0.cetus_manager_size + 1;
        };
    }

    public fun check_and_add_deepbook_balance_manager_indexer(arg0: &mut CetusBalanceManagerIndexer, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager>(arg1);
        if (0x2::table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.deepbook_managers, v0)) {
            let v2 = 0x2::table::borrow_mut<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.deepbook_managers, v0);
            if (0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::contains<0x2::object::ID, bool>(v2, v1)) {
                return
            };
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(v2, v1, true);
        } else {
            let v3 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::new<0x2::object::ID, bool>(arg2);
            0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::push_back<0x2::object::ID, bool>(&mut v3, v1, true);
            0x2::table::add<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&mut arg0.deepbook_managers, v0, v3);
            arg0.deepbook_manager_size = arg0.deepbook_manager_size + 1;
        };
    }

    public(friend) fun create_cetus_balance_manager(arg0: &mut CetusBalanceManagerIndexer, arg1: &mut 0x2::tx_context::TxContext) : CetusBalanceManager {
        let v0 = new(arg1);
        check_and_add_cetus_balance_manager_indexer(arg0, &v0, arg1);
        check_and_add_deepbook_balance_manager_indexer(arg0, &v0.deepbook_balance_manager, arg1);
        let v1 = CreateCetusBalanceManagerEvent{
            cetus_balance_manager_id : 0x2::object::id<CetusBalanceManager>(&v0),
            balance_manager_id       : balance_manager_id(&v0),
            owner                    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CreateCetusBalanceManagerEvent>(v1);
        v0
    }

    public(friend) fun deposit_proxy_deep(arg0: &mut CetusBalanceManager, arg1: &mut 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x624a80998bfca8118a794c71cccca771c351158eecd425661e07056f4ed94683::global_config::withdraw_advance_deep(arg1, arg2);
        deposit<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, v0, arg2);
    }

    public fun get_balance_managers_by_owner(arg0: &CetusBalanceManagerIndexer, arg1: address) {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.cetus_managers, arg1)) {
            let v1 = 0x2::table::borrow<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.cetus_managers, arg1);
            let v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, bool>(v1);
            while (0x1::option::is_some<0x2::object::ID>(&v2)) {
                let v3 = *0x1::option::borrow<0x2::object::ID>(&v2);
                0x1::vector::push_back<0x2::object::ID>(&mut v0, v3);
                v2 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v1, v3));
            };
        };
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        if (0x2::table::contains<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.deepbook_managers, arg1)) {
            let v5 = 0x2::table::borrow<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(&arg0.deepbook_managers, arg1);
            let v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::head<0x2::object::ID, bool>(v5);
            while (0x1::option::is_some<0x2::object::ID>(&v6)) {
                let v7 = *0x1::option::borrow<0x2::object::ID>(&v6);
                0x1::vector::push_back<0x2::object::ID>(&mut v4, v7);
                v6 = 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::next<0x2::object::ID, bool>(0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::borrow_node<0x2::object::ID, bool>(v5, v7));
            };
        };
        let v8 = GetCetusBalanceManagerList{
            owner                     : arg1,
            cetus_balance_managers    : v0,
            deepbook_balance_managers : v4,
        };
        0x2::event::emit<GetCetusBalanceManagerList>(v8);
    }

    fun init(arg0: CETUS_BALANCE_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusBalanceManagerIndexer{
            id                    : 0x2::object::new(arg1),
            cetus_managers        : 0x2::table::new<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
            cetus_manager_size    : 0,
            deepbook_managers     : 0x2::table::new<address, 0xbe21a06129308e0495431d12286127897aff07a8ade3970495a4404d97f9eaaa::linked_table::LinkedTable<0x2::object::ID, bool>>(arg1),
            deepbook_manager_size : 0,
        };
        let v1 = InitEvent{cetus_balance_manager_indexer_id: 0x2::object::id<CetusBalanceManagerIndexer>(&v0)};
        0x2::event::emit<InitEvent>(v1);
        0x2::transfer::share_object<CetusBalanceManagerIndexer>(v0);
    }

    public fun share(arg0: CetusBalanceManager) {
        0x2::transfer::share_object<CetusBalanceManager>(arg0);
    }

    public(friend) fun withdraw_all_refund_deep<T0>(arg0: &mut CetusBalanceManager, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_all<T0>(&mut arg0.deepbook_balance_manager, arg1)
    }

    public(friend) fun withdraw_refund_deep<T0>(arg0: &mut CetusBalanceManager, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(&mut arg0.deepbook_balance_manager, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

