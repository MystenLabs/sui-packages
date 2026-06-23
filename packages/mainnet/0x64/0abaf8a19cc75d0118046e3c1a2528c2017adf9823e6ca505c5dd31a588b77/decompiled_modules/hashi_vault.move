module 0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::hashi_vault {
    struct HashiVault<phantom T0> has key {
        id: 0x2::object::UID,
        hbtc: 0x2::balance::Balance<T0>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_received_hbtc: u64,
        total_withdrawn_hbtc: u64,
        total_received_sui: u64,
        total_withdrawn_sui: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: address,
        derivation_path: address,
    }

    struct VaultReceivedHbtc has copy, drop {
        vault_id: address,
        amount: u64,
        new_balance: u64,
    }

    struct VaultReceivedSui has copy, drop {
        vault_id: address,
        amount: u64,
        new_balance: u64,
    }

    struct VaultWithdrewHbtc has copy, drop {
        vault_id: address,
        amount: u64,
        new_balance: u64,
    }

    public fun claim_accumulated_hbtc<T0>(arg0: &mut HashiVault<T0>, arg1: u64) {
        0x2::balance::join<T0>(&mut arg0.hbtc, 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg1)));
        arg0.total_received_hbtc = arg0.total_received_hbtc + arg1;
        let v0 = VaultReceivedHbtc{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.hbtc),
        };
        0x2::event::emit<VaultReceivedHbtc>(v0);
    }

    public fun claim_accumulated_sui<T0>(arg0: &mut HashiVault<T0>, arg1: u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::balance::redeem_funds<0x2::sui::SUI>(0x2::balance::withdraw_funds_from_object<0x2::sui::SUI>(&mut arg0.id, arg1)));
        arg0.total_received_sui = arg0.total_received_sui + arg1;
        let v0 = VaultReceivedSui{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : arg1,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
        };
        0x2::event::emit<VaultReceivedSui>(v0);
    }

    public fun create_shared<T0>(arg0: &0x640abaf8a19cc75d0118046e3c1a2528c2017adf9823e6ca505c5dd31a588b77::pool::PoolAdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = HashiVault<T0>{
            id                   : 0x2::object::new(arg1),
            hbtc                 : 0x2::balance::zero<T0>(),
            sui                  : 0x2::balance::zero<0x2::sui::SUI>(),
            total_received_hbtc  : 0,
            total_withdrawn_hbtc : 0,
            total_received_sui   : 0,
            total_withdrawn_sui  : 0,
        };
        let v1 = 0x2::object::uid_to_address(&v0.id);
        let v2 = VaultCreated{
            vault_id        : v1,
            derivation_path : v1,
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<HashiVault<T0>>(v0);
    }

    public(friend) fun deposit_hbtc<T0>(arg0: &mut HashiVault<T0>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.hbtc, arg1);
        arg0.total_received_hbtc = arg0.total_received_hbtc + v0;
        let v1 = VaultReceivedHbtc{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : v0,
            new_balance : 0x2::balance::value<T0>(&arg0.hbtc),
        };
        0x2::event::emit<VaultReceivedHbtc>(v1);
    }

    public fun derivation_path<T0>(arg0: &HashiVault<T0>) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun hbtc_balance<T0>(arg0: &HashiVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.hbtc)
    }

    public fun lifetime_received_hbtc<T0>(arg0: &HashiVault<T0>) : u64 {
        arg0.total_received_hbtc
    }

    public fun lifetime_withdrawn_hbtc<T0>(arg0: &HashiVault<T0>) : u64 {
        arg0.total_withdrawn_hbtc
    }

    public fun receive_hbtc<T0>(arg0: &mut HashiVault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        0x2::balance::join<T0>(&mut arg0.hbtc, 0x2::coin::into_balance<T0>(v0));
        arg0.total_received_hbtc = arg0.total_received_hbtc + v1;
        let v2 = VaultReceivedHbtc{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : v1,
            new_balance : 0x2::balance::value<T0>(&arg0.hbtc),
        };
        0x2::event::emit<VaultReceivedHbtc>(v2);
    }

    public fun receive_sui<T0>(arg0: &mut HashiVault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.id, arg1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(v0));
        arg0.total_received_sui = arg0.total_received_sui + v1;
        let v2 = VaultReceivedSui{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : v1,
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
        };
        0x2::event::emit<VaultReceivedSui>(v2);
    }

    public fun sui_balance<T0>(arg0: &HashiVault<T0>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public(friend) fun take_exact_hbtc<T0>(arg0: &mut HashiVault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg1 > 0, 13906835097761349633);
        assert!(0x2::balance::value<T0>(&arg0.hbtc) >= arg1, 13906835102056448003);
        arg0.total_withdrawn_hbtc = arg0.total_withdrawn_hbtc + arg1;
        let v0 = VaultWithdrewHbtc{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            amount      : arg1,
            new_balance : 0x2::balance::value<T0>(&arg0.hbtc),
        };
        0x2::event::emit<VaultWithdrewHbtc>(v0);
        0x2::balance::split<T0>(&mut arg0.hbtc, arg1)
    }

    // decompiled from Move bytecode v6
}

