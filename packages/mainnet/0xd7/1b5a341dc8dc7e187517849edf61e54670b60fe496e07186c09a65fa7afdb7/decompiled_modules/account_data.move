module 0xd71b5a341dc8dc7e187517849edf61e54670b60fe496e07186c09a65fa7afdb7::account_data {
    struct DeepbookCoreAccountApp has drop {
        dummy_field: bool,
    }

    struct DeepbookCoreAccountData has store {
        balance_manager: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager,
        deposit_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::DepositCap,
        withdraw_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::WithdrawCap,
        trade_cap: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeCap,
    }

    struct DeepbookCoreAccountInitialized has copy, drop {
        account_id: 0x2::object::ID,
        account_owner: address,
        wrapper_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
    }

    public(friend) fun borrow(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account) : &DeepbookCoreAccountData {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data<DeepbookCoreAccountApp, DeepbookCoreAccountData>(arg0)
    }

    public(friend) fun borrow_mut(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account) : &mut DeepbookCoreAccountData {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::borrow_data_mut<DeepbookCoreAccountApp, DeepbookCoreAccountData>(arg0, 0x1::internal::permit<DeepbookCoreAccountApp>())
    }

    public(friend) fun balance_manager(arg0: &DeepbookCoreAccountData) : &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &arg0.balance_manager
    }

    public(friend) fun generate_auth_as_app(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::AccountRegistry) : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account_registry::generate_auth_as_app<DeepbookCoreAccountApp>(arg0, 0x1::internal::permit<DeepbookCoreAccountApp>())
    }

    public fun balance_manager_balance<T0>(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account) : u64 {
        if (!is_initialized(arg0)) {
            0
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&borrow(arg0).balance_manager)
        }
    }

    public fun balance_manager_id(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account) : 0x1::option::Option<0x2::object::ID> {
        if (!is_initialized(arg0)) {
            0x1::option::none<0x2::object::ID>()
        } else {
            0x1::option::some<0x2::object::ID>(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(&borrow(arg0).balance_manager))
        }
    }

    public(friend) fun balance_manager_mut(arg0: &mut DeepbookCoreAccountData) : &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager {
        &mut arg0.balance_manager
    }

    public(friend) fun deposit_all<T0, T1>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        deposit_to_account_if_nonzero<T0>(arg0, arg1);
        deposit_to_account_if_nonzero<T1>(arg0, arg2);
        deposit_to_account_if_nonzero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg3);
    }

    fun deposit_to_account_if_nonzero<T0>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<T0>(arg0, arg1);
        };
    }

    public(friend) fun deposit_to_manager_if_nonzero<T0>(arg0: &mut DeepbookCoreAccountData, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg1) == 0) {
            0x2::coin::destroy_zero<T0>(arg1);
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit_with_cap<T0>(&mut arg0.balance_manager, &arg0.deposit_cap, arg1, arg2);
        };
    }

    public(friend) fun ensure(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::registry::Registry, arg2: &mut 0x2::tx_context::TxContext) {
        if (!is_initialized(arg0)) {
            let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(arg0);
            let v1 = DeepbookCoreAccountApp{dummy_field: false};
            let (v2, v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::new_with_custom_owner_caps_v2<DeepbookCoreAccountApp>(v1, arg1, 0x2::object::id_to_address(&v0), arg2);
            let v6 = v2;
            let v7 = DeepbookCoreAccountData{
                balance_manager : v6,
                deposit_cap     : v3,
                withdraw_cap    : v4,
                trade_cap       : v5,
            };
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::attach<DeepbookCoreAccountApp, DeepbookCoreAccountData>(arg0, 0x1::internal::permit<DeepbookCoreAccountApp>(), v7);
            let v8 = DeepbookCoreAccountInitialized{
                account_id         : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(arg0),
                account_owner      : 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::owner(arg0),
                wrapper_id         : 0x2::object::id_from_address(0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(arg0)),
                balance_manager_id : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::id(&v6),
            };
            0x2::event::emit<DeepbookCoreAccountInitialized>(v8);
        };
    }

    public(friend) fun generate_trader_proof(arg0: &mut DeepbookCoreAccountData, arg1: &0x2::tx_context::TxContext) : 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::TradeProof {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::generate_proof_as_trader(&mut arg0.balance_manager, &arg0.trade_cap, arg1)
    }

    public fun is_initialized(arg0: &0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account) : bool {
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::has_data<DeepbookCoreAccountApp>(arg0)
    }

    public(friend) fun sweep_all<T0, T1>(arg0: &mut DeepbookCoreAccountData, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = sweep_from_manager<T0>(arg0, arg1);
        let v1 = sweep_from_manager<T1>(arg0, arg1);
        (v0, v1, sweep_from_manager<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1))
    }

    fun sweep_from_manager<T0>(arg0: &mut DeepbookCoreAccountData, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<T0>(&arg0.balance_manager);
        if (v0 == 0) {
            0x2::coin::zero<T0>(arg1)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw_with_cap<T0>(&mut arg0.balance_manager, &arg0.withdraw_cap, v0, arg1)
        }
    }

    public(friend) fun withdraw_all<T0, T1>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        let v0 = withdraw_all_of_type<T0>(arg0, arg1, arg2, arg3);
        let v1 = withdraw_all_of_type<T1>(arg0, arg1, arg2, arg3);
        (v0, v1, withdraw_all_of_type<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg0, arg1, arg2, arg3))
    }

    fun withdraw_all_of_type<T0>(arg0: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Account, arg1: &0x2::accumulator::AccumulatorRoot, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::balance<T0>(arg0, arg1, arg2);
        if (v0 == 0) {
            0x2::coin::zero<T0>(arg3)
        } else {
            0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<T0>(arg0, v0, arg3)
        }
    }

    // decompiled from Move bytecode v7
}

