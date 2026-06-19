module 0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        limit: u64,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct VaultDeposited has copy, drop {
        vault_id: address,
        old_balance: u64,
        new_balance: u64,
        depositor: address,
    }

    struct VaultLimitChanged has copy, drop {
        vault_id: address,
        old_limit: u64,
        new_limit: u64,
    }

    public fun balance_of<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    entry fun change_limit<T0>(arg0: &mut Vault<T0>, arg1: &0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::owner_cap::OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::owner_cap::is_owned(&arg0.id, arg1);
        arg0.limit = arg2;
        let v0 = VaultLimitChanged{
            vault_id  : 0x2::object::uid_to_address(&arg0.id),
            old_limit : arg0.limit,
            new_limit : arg2,
        };
        0x2::event::emit<VaultLimitChanged>(v0);
    }

    entry fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::coin::into_balance<T0>(arg0),
            limit   : arg1,
            claimed : 0x2::table::new<address, bool>(arg2),
        };
        0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::owner_cap::create_owner_cap(&v0.id, 0x2::tx_context::sender(arg2), arg2);
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = VaultDeposited{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            old_balance : 0x2::balance::value<T0>(&arg0.balance),
            new_balance : 0x2::balance::value<T0>(&arg0.balance),
            depositor   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultDeposited>(v0);
    }

    public fun has_claimed<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.claimed, arg1)
    }

    entry fun liquidate_vault<T0>(arg0: &mut Vault<T0>, arg1: &0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::owner_cap::OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x6db4c7a0d3e068825442558bb184a772ba537c809ddb34c95ec28c2023e20d6::owner_cap::is_owned(&arg0.id, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun request_airdrop<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, arg2), 1);
        if (arg1 > arg0.limit || arg1 > 0x2::balance::value<T0>(&arg0.balance)) {
        } else {
            0x2::table::add<address, bool>(&mut arg0.claimed, arg2, true);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3), arg2);
        };
    }

    // decompiled from Move bytecode v7
}

