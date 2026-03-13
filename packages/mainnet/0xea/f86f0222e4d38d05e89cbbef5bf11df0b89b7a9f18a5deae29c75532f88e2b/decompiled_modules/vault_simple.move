module 0xeaf86f0222e4d38d05e89cbbef5bf11df0b89b7a9f18a5deae29c75532f88e2b::vault_simple {
    struct SimpleVault has store, key {
        id: 0x2::object::UID,
        pending_deposits: 0x2::balance::Balance<0x2::sui::SUI>,
        account_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct DepositReceived has copy, drop {
        user: address,
        amount: u64,
    }

    public fun create_vault(arg0: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap, arg1: &mut 0x2::tx_context::TxContext) : SimpleVault {
        SimpleVault{
            id               : 0x2::object::new(arg1),
            pending_deposits : 0x2::balance::zero<0x2::sui::SUI>(),
            account_cap      : arg0,
        }
    }

    public fun deposit_to_navi(arg0: &mut SimpleVault, arg1: &0x2::clock::Clock, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::entry_deposit_on_behalf_of_user<0x2::sui::SUI>(arg1, arg2, arg3, 0, 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pending_deposits, arg6), arg7), arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap), arg4, arg5, arg7);
    }

    public fun deposit_to_vault(arg0: &mut SimpleVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pending_deposits, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg3)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v0 = DepositReceived{
            user   : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<DepositReceived>(v0);
    }

    public fun get_pending_amount(arg0: &SimpleVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pending_deposits)
    }

    public fun get_platform_owner(arg0: &SimpleVault) : address {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.account_cap)
    }

    // decompiled from Move bytecode v6
}

