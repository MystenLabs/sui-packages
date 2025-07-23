module 0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_vault {
    struct DeFiVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        owner: address,
        lock_until: u64,
        created_at: u64,
        lock_duration_minutes: u64,
        defi_protocol: u8,
        defi_receipt: 0x1::option::Option<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>,
    }

    struct DeFiVaultCreated has copy, drop {
        vault_id: address,
        owner: address,
        amount: u64,
        lock_until: u64,
        lock_duration_minutes: u64,
        defi_protocol: u8,
        defi_amount: u64,
    }

    struct DeFiDeposited has copy, drop {
        vault_id: address,
        protocol: u8,
        amount: u64,
        timestamp: u64,
    }

    struct DeFiWithdrawn has copy, drop {
        vault_id: address,
        protocol: u8,
        amount: u64,
        timestamp: u64,
    }

    struct VaultWithdrawn has copy, drop {
        vault_id: address,
        owner: address,
        amount: u64,
        withdrawn_at: u64,
    }

    public fun destroy_empty<T0>(arg0: DeFiVault<T0>) {
        let DeFiVault {
            id                    : v0,
            balance               : v1,
            owner                 : _,
            lock_until            : _,
            created_at            : _,
            lock_duration_minutes : _,
            defi_protocol         : _,
            defi_receipt          : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v1;
        assert!(0x2::balance::value<T0>(&v9) == 0, 2);
        0x2::balance::destroy_zero<T0>(v9);
        if (0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&v8)) {
            let v10 = 0x1::option::destroy_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(v8);
            assert!(0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(&v10) == 0, 2);
            0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::destroy_empty_receipt(v10);
        } else {
            0x1::option::destroy_none<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(v8);
        };
        0x2::object::delete(v0);
    }

    public fun balance<T0>(arg0: &DeFiVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun create_defi_vault_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u8, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DeFiVault<0x2::sui::SUI> {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 6);
        assert!(v0 <= 1000000000000000000, 7);
        assert!(arg1 > 0 && arg1 <= 525600, 1);
        assert!(arg2 <= 3, 8);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(arg1 <= (18446744073709551615 - v1) / 60000, 5);
        let v2 = v1 + arg1 * 60000;
        let v3 = 0x2::tx_context::sender(arg5);
        let (v4, v5, v6) = if (arg3 && arg2 != 0) {
            let v7 = if (arg2 == 1) {
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::deposit_to_scallop(arg0, arg4, arg5)
            } else if (arg2 == 2) {
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::deposit_to_bucket_tank(arg0, arg4, arg5)
            } else {
                assert!(arg2 == 3, 8);
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::deposit_to_suilend(arg0, arg4, arg5)
            };
            (0x2::balance::zero<0x2::sui::SUI>(), 0x1::option::some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(v7), arg2)
        } else {
            (0x2::coin::into_balance<0x2::sui::SUI>(arg0), 0x1::option::none<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(), 0)
        };
        let v8 = DeFiVault<0x2::sui::SUI>{
            id                    : 0x2::object::new(arg5),
            balance               : v4,
            owner                 : v3,
            lock_until            : v2,
            created_at            : v1,
            lock_duration_minutes : arg1,
            defi_protocol         : v6,
            defi_receipt          : v5,
        };
        let v9 = if (0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&v8.defi_receipt)) {
            0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(0x1::option::borrow<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&v8.defi_receipt))
        } else {
            0
        };
        let v10 = DeFiVaultCreated{
            vault_id              : 0x2::object::uid_to_address(&v8.id),
            owner                 : v3,
            amount                : v0,
            lock_until            : v2,
            lock_duration_minutes : arg1,
            defi_protocol         : v6,
            defi_amount           : v9,
        };
        0x2::event::emit<DeFiVaultCreated>(v10);
        if (arg3 && arg2 != 0) {
            let v11 = DeFiDeposited{
                vault_id  : 0x2::object::uid_to_address(&v8.id),
                protocol  : arg2,
                amount    : v9,
                timestamp : v1,
            };
            0x2::event::emit<DeFiDeposited>(v11);
        };
        v8
    }

    public fun create_vault<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : DeFiVault<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 6);
        assert!(v0 <= 1000000000000000000, 7);
        assert!(arg1 > 0 && arg1 <= 525600, 1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1 <= (18446744073709551615 - v1) / 60000, 5);
        let v2 = v1 + arg1 * 60000;
        let v3 = 0x2::tx_context::sender(arg3);
        let v4 = DeFiVault<T0>{
            id                    : 0x2::object::new(arg3),
            balance               : 0x2::coin::into_balance<T0>(arg0),
            owner                 : v3,
            lock_until            : v2,
            created_at            : v1,
            lock_duration_minutes : arg1,
            defi_protocol         : 0,
            defi_receipt          : 0x1::option::none<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(),
        };
        let v5 = DeFiVaultCreated{
            vault_id              : 0x2::object::uid_to_address(&v4.id),
            owner                 : v3,
            amount                : v0,
            lock_until            : v2,
            lock_duration_minutes : arg1,
            defi_protocol         : 0,
            defi_amount           : 0,
        };
        0x2::event::emit<DeFiVaultCreated>(v5);
        v4
    }

    public fun defi_balance<T0>(arg0: &DeFiVault<T0>) : u64 {
        if (0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt)) {
            0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(0x1::option::borrow<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt))
        } else {
            0
        }
    }

    public fun defi_protocol<T0>(arg0: &DeFiVault<T0>) : u8 {
        arg0.defi_protocol
    }

    public fun is_unlocked<T0>(arg0: &DeFiVault<T0>, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.lock_until
    }

    public fun lock_until<T0>(arg0: &DeFiVault<T0>) : u64 {
        arg0.lock_until
    }

    public fun owner<T0>(arg0: &DeFiVault<T0>) : address {
        arg0.owner
    }

    public fun protocol_bucket() : u8 {
        2
    }

    public fun protocol_none() : u8 {
        0
    }

    public fun protocol_scallop() : u8 {
        1
    }

    public fun protocol_suilend() : u8 {
        3
    }

    public fun time_until_unlock<T0>(arg0: &DeFiVault<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.lock_until) {
            0
        } else {
            arg0.lock_until - v0
        }
    }

    public fun total_balance<T0>(arg0: &DeFiVault<T0>) : u64 {
        balance<T0>(arg0) + defi_balance<T0>(arg0)
    }

    public fun withdraw<T0>(arg0: &mut DeFiVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.lock_until, 0);
        let v2 = 0x2::balance::value<T0>(&arg0.balance);
        let v3 = if (0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt)) {
            0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(0x1::option::borrow<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt))
        } else {
            0
        };
        let v4 = v2 + v3;
        assert!(v4 > 0, 2);
        assert!(arg1 <= v4, 4);
        let v5 = if (arg1 <= v2) {
            arg1
        } else {
            v2
        };
        let v6 = if (v5 > 0) {
            0x2::balance::split<T0>(&mut arg0.balance, v5)
        } else {
            0x2::balance::zero<T0>()
        };
        assert!(arg1 - v5 == 0 || !0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt), 8);
        let v7 = VaultWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            owner        : v0,
            amount       : arg1,
            withdrawn_at : v1,
        };
        0x2::event::emit<VaultWithdrawn>(v7);
        0x2::coin::from_balance<T0>(v6, arg3)
    }

    public fun withdraw_sui(arg0: &mut DeFiVault<0x2::sui::SUI>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.lock_until, 0);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        let v3 = if (0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt)) {
            0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(0x1::option::borrow<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt))
        } else {
            0
        };
        let v4 = v2 + v3;
        assert!(v4 > 0, 2);
        assert!(arg1 <= v4, 4);
        let v5 = if (arg1 <= v2) {
            arg1
        } else {
            v2
        };
        let v6 = arg1 - v5;
        let v7 = if (v5 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v5)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v8 = v7;
        if (v6 > 0 && 0x1::option::is_some<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&arg0.defi_receipt)) {
            let v9 = 0x1::option::borrow_mut<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&mut arg0.defi_receipt);
            let v10 = if (arg0.defi_protocol == 1) {
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::withdraw_from_scallop(v9, v6, arg2, arg3)
            } else if (arg0.defi_protocol == 2) {
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::withdraw_from_bucket_tank(v9, v6, arg2, arg3)
            } else {
                assert!(arg0.defi_protocol == 3, 8);
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::withdraw_from_suilend(v9, v6, arg2, arg3)
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v8, 0x2::coin::into_balance<0x2::sui::SUI>(v10));
            if (0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::get_deposited_amount(v9) == 0) {
                0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::destroy_empty_receipt(0x1::option::extract<0x8953caa8d8f431cdfd49f157dc9ea79138113084fa75dc2e9469617404e90d5b::defi_integrations::DeFiDepositReceipt>(&mut arg0.defi_receipt));
                arg0.defi_protocol = 0;
            };
            let v11 = DeFiWithdrawn{
                vault_id  : 0x2::object::uid_to_address(&arg0.id),
                protocol  : arg0.defi_protocol,
                amount    : v6,
                timestamp : v1,
            };
            0x2::event::emit<DeFiWithdrawn>(v11);
        };
        let v12 = VaultWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            owner        : v0,
            amount       : arg1,
            withdrawn_at : v1,
        };
        0x2::event::emit<VaultWithdrawn>(v12);
        0x2::coin::from_balance<0x2::sui::SUI>(v8, arg3)
    }

    // decompiled from Move bytecode v6
}

