module 0x8b55ca913af06a354f0171baf768c76d45a2c2f337b888da1345a746f5cd6d5::spend_vault {
    struct Vault has key {
        id: 0x2::object::UID,
        allowances: 0x2::linked_table::LinkedTable<BudgetKey, Allowance>,
        granted_coin_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct BudgetKey has copy, drop, store {
        cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SpenderCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct Allowance has drop, store {
        remaining: u64,
        expires_at_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        owner_cap_id: 0x2::object::ID,
        creator: address,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        depositor: address,
    }

    struct Squashed has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        by: address,
    }

    struct SpenderCapMinted has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        by: address,
    }

    struct AllowanceSet has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        new_amount: u64,
        new_expires_at_ms: u64,
        cas_was_provided: bool,
        was_created: bool,
        by: address,
    }

    struct Spent has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        remaining: u64,
        caller: address,
    }

    struct Revoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        was_present: bool,
        by: address,
    }

    struct Renounced has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        by: address,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        by: address,
    }

    struct VaultDestroyed has copy, drop {
        vault_id: 0x2::object::ID,
        by: address,
    }

    struct CapDeleted has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public fun contains<T0>(arg0: &Vault, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, budget_key<T0>(arg1))
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (Vault, OwnerCap) {
        let v0 = Vault{
            id                 : 0x2::object::new(arg0),
            allowances         : 0x2::linked_table::new<BudgetKey, Allowance>(arg0),
            granted_coin_types : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = 0x2::object::id<Vault>(&v0);
        let v2 = OwnerCap{
            id       : 0x2::object::new(arg0),
            vault_id : v1,
        };
        let v3 = VaultCreated{
            vault_id     : v1,
            owner_cap_id : 0x2::object::id<OwnerCap>(&v2),
            creator      : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<VaultCreated>(v3);
        (v0, v2)
    }

    public fun allowance<T0>(arg0: &Vault, arg1: 0x2::object::ID) : u64 {
        let v0 = budget_key<T0>(arg1);
        if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v0)) {
            0x2::linked_table::borrow<BudgetKey, Allowance>(&arg0.allowances, v0).remaining
        } else {
            0
        }
    }

    public fun balance_value<T0>(arg0: &Vault, arg1: &0x2::accumulator::AccumulatorRoot) : u64 {
        0x2::balance::settled_funds_value<T0>(arg1, 0x2::object::id_address<Vault>(arg0))
    }

    fun budget_key<T0>(arg0: 0x2::object::ID) : BudgetKey {
        BudgetKey{
            cap_id    : arg0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
        }
    }

    public fun delete_orphaned_cap(arg0: SpenderCap) {
        let SpenderCap {
            id       : v0,
            vault_id : v1,
        } = arg0;
        let v2 = v0;
        0x2::object::delete(v2);
        let v3 = CapDeleted{
            vault_id : v1,
            cap_id   : 0x2::object::uid_to_inner(&v2),
        };
        0x2::event::emit<CapDeleted>(v3);
    }

    public fun deposit<T0>(arg0: &Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        deposit_balance<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2);
    }

    public fun deposit_balance<T0>(arg0: &Vault, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 13836467908362502155);
        0x2::balance::send_funds<T0>(arg1, 0x2::object::id_address<Vault>(arg0));
        let v1 = Deposited{
            vault_id  : 0x2::object::id<Vault>(arg0),
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            depositor : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Deposited>(v1);
    }

    public fun destroy(arg0: Vault, arg1: OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(&arg0), 13835060224240648193);
        let Vault {
            id                 : v0,
            allowances         : v1,
            granted_coin_types : _,
        } = arg0;
        let v3 = v1;
        let v4 = v0;
        while (!0x2::linked_table::is_empty<BudgetKey, Allowance>(&v3)) {
            let (_, _) = 0x2::linked_table::pop_front<BudgetKey, Allowance>(&mut v3);
        };
        0x2::linked_table::destroy_empty<BudgetKey, Allowance>(v3);
        let OwnerCap {
            id       : v7,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v4);
        0x2::object::delete(v7);
        let v9 = VaultDestroyed{
            vault_id : 0x2::object::uid_to_inner(&v4),
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VaultDestroyed>(v9);
    }

    public fun expiry<T0>(arg0: &Vault, arg1: 0x2::object::ID) : u64 {
        let v0 = budget_key<T0>(arg1);
        if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v0)) {
            0x2::linked_table::borrow<BudgetKey, Allowance>(&arg0.allowances, v0).expires_at_ms
        } else {
            0
        }
    }

    public fun granted_coin_types(arg0: &Vault) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.granted_coin_types)
    }

    public fun mint_cap(arg0: &Vault, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) : SpenderCap {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13835060679507181569);
        let v0 = SpenderCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault>(arg0),
        };
        let v1 = SpenderCapMinted{
            vault_id : 0x2::object::id<Vault>(arg0),
            cap_id   : 0x2::object::id<SpenderCap>(&v0),
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<SpenderCapMinted>(v1);
        v0
    }

    public fun owner_cap_vault_id(arg0: &OwnerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun renounce(arg0: &mut Vault, arg1: SpenderCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg0);
        assert!(arg1.vault_id == v0, 13835344005614927875);
        let SpenderCap {
            id       : v1,
            vault_id : _,
        } = arg1;
        let v3 = v1;
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.granted_coin_types);
        let v6 = &v5;
        let v7 = 0;
        while (v7 < 0x1::vector::length<0x1::type_name::TypeName>(v6)) {
            let v8 = BudgetKey{
                cap_id    : v4,
                coin_type : *0x1::vector::borrow<0x1::type_name::TypeName>(v6, v7),
            };
            if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v8)) {
                0x2::linked_table::remove<BudgetKey, Allowance>(&mut arg0.allowances, v8);
            };
            v7 = v7 + 1;
        };
        0x2::object::delete(v3);
        let v9 = Renounced{
            vault_id : v0,
            cap_id   : v4,
            by       : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Renounced>(v9);
    }

    public fun revoke<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13835062092551421953);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = BudgetKey{
            cap_id    : arg2,
            coin_type : v0,
        };
        let v2 = if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v1)) {
            0x2::linked_table::remove<BudgetKey, Allowance>(&mut arg0.allowances, v1);
            true
        } else {
            false
        };
        let v3 = Revoked{
            vault_id    : 0x2::object::id<Vault>(arg0),
            cap_id      : arg2,
            coin_type   : v0,
            was_present : v2,
            by          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Revoked>(v3);
        v2
    }

    public fun revoke_all(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.vault_id == 0x2::object::id<Vault>(arg0), 13835062345954492417);
        let v0 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.granted_coin_types);
        let v1 = &v0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2);
            let v4 = BudgetKey{
                cap_id    : arg2,
                coin_type : v3,
            };
            if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v4)) {
                0x2::linked_table::remove<BudgetKey, Allowance>(&mut arg0.allowances, v4);
                let v5 = Revoked{
                    vault_id    : 0x2::object::id<Vault>(arg0),
                    cap_id      : arg2,
                    coin_type   : v3,
                    was_present : true,
                    by          : 0x2::tx_context::sender(arg3),
                };
                0x2::event::emit<Revoked>(v5);
            };
            v2 = v2 + 1;
        };
    }

    public fun set_allowance<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg0);
        assert!(arg1.vault_id == v0, 13835061083234107393);
        assert!(arg4 == 18446744073709551615 || arg4 > 0x2::clock::timestamp_ms(arg6), 13836749950275026957);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = BudgetKey{
            cap_id    : arg2,
            coin_type : v1,
        };
        let v3 = 0x1::option::is_some<u64>(&arg5);
        if (v3) {
            assert!(0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v2) && 0x2::linked_table::borrow<BudgetKey, Allowance>(&arg0.allowances, v2).remaining == 0x1::option::destroy_some<u64>(arg5), 13837031485381410831);
        };
        let v4 = if (0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v2)) {
            let v5 = 0x2::linked_table::borrow_mut<BudgetKey, Allowance>(&mut arg0.allowances, v2);
            v5.remaining = arg3;
            v5.expires_at_ms = arg4;
            false
        } else {
            let v6 = Allowance{
                remaining     : arg3,
                expires_at_ms : arg4,
            };
            0x2::linked_table::push_back<BudgetKey, Allowance>(&mut arg0.allowances, v2, v6);
            if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.granted_coin_types, &v1)) {
                0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.granted_coin_types, v1);
            };
            true
        };
        let v7 = AllowanceSet{
            vault_id          : v0,
            cap_id            : arg2,
            coin_type         : v1,
            new_amount        : arg3,
            new_expires_at_ms : arg4,
            cas_was_provided  : v3,
            was_created       : v4,
            by                : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<AllowanceSet>(v7);
    }

    public fun share(arg0: Vault) {
        0x2::transfer::share_object<Vault>(arg0);
    }

    public fun spend<T0>(arg0: &mut Vault, arg1: &SpenderCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<Vault>(arg0);
        let v1 = 0x2::object::id<SpenderCap>(arg1);
        assert!(arg1.vault_id == v0, 13835343125146632195);
        let v2 = 0x1::type_name::with_defining_ids<T0>();
        let v3 = BudgetKey{
            cap_id    : v1,
            coin_type : v2,
        };
        assert!(0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v3), 13835624634483212293);
        let v4 = 0x2::linked_table::borrow<BudgetKey, Allowance>(&arg0.allowances, v3);
        let v5 = v4.remaining;
        let v6 = v4.expires_at_ms;
        assert!(v6 == 18446744073709551615 || 0x2::clock::timestamp_ms(arg3) < v6, 13835906160999661575);
        assert!(arg2 > 0, 13836469128133214219);
        assert!(v5 == 18446744073709551615 || arg2 <= v5, 13836187670336241673);
        let v7 = if (v5 == 18446744073709551615) {
            v5
        } else {
            v5 - arg2
        };
        0x2::linked_table::borrow_mut<BudgetKey, Allowance>(&mut arg0.allowances, v3).remaining = v7;
        let v8 = Spent{
            vault_id  : v0,
            cap_id    : v1,
            coin_type : v2,
            amount    : arg2,
            remaining : v7,
            caller    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Spent>(v8);
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2))
    }

    public fun spendable_now<T0>(arg0: &Vault, arg1: &0x2::accumulator::AccumulatorRoot, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : u64 {
        let v0 = budget_key<T0>(arg2);
        if (!0x2::linked_table::contains<BudgetKey, Allowance>(&arg0.allowances, v0)) {
            return 0
        };
        let v1 = 0x2::linked_table::borrow<BudgetKey, Allowance>(&arg0.allowances, v0);
        if (v1.expires_at_ms != 18446744073709551615 && 0x2::clock::timestamp_ms(arg3) >= v1.expires_at_ms) {
            return 0
        };
        0x1::u64::min(v1.remaining, 0x2::balance::settled_funds_value<T0>(arg1, 0x2::object::id_address<Vault>(arg0)))
    }

    public fun spender_cap_vault_id(arg0: &SpenderCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun squash<T0>(arg0: &mut Vault, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Vault>(arg0);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        0x2::balance::send_funds<T0>(0x2::coin::into_balance<T0>(v1), 0x2::object::id_to_address(&v0));
        let v2 = Squashed{
            vault_id  : v0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : 0x2::coin::value<T0>(&v1),
            by        : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Squashed>(v2);
    }

    public fun withdraw<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<Vault>(arg0);
        assert!(arg1.vault_id == v0, 13835063084688867329);
        assert!(arg2 > 0, 13836470463868043275);
        let v1 = Withdrawn{
            vault_id  : v0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : arg2,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdrawn>(v1);
        0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, arg2))
    }

    public fun withdraw_all<T0>(arg0: &mut Vault, arg1: &OwnerCap, arg2: &0x2::accumulator::AccumulatorRoot, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::object::id<Vault>(arg0);
        assert!(arg1.vault_id == v0, 13835063423991283713);
        let v1 = 0x2::balance::settled_funds_value<T0>(arg2, 0x2::object::id_to_address(&v0));
        let v2 = if (v1 == 0) {
            0x2::balance::zero<T0>()
        } else {
            0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg0.id, v1))
        };
        let v3 = Withdrawn{
            vault_id  : v0,
            coin_type : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
            by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Withdrawn>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

