module 0x117f8bfdde26b5ece4fd88b0afa862468e2bf7106563b1033edcc1037734901::multisig {
    struct MultisigVault<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        creator: address,
        participants: 0x2::vec_set::VecSet<address>,
        signatures: 0x2::table::Table<address, bool>,
        is_list_closed: bool,
        is_vault_open: bool,
        created_at: u64,
    }

    struct MultisigVaultCreated has copy, drop {
        vault_id: address,
        creator: address,
        created_at: u64,
    }

    struct ParticipantAdded has copy, drop {
        vault_id: address,
        participant: address,
        added_at: u64,
    }

    struct ListClosed has copy, drop {
        vault_id: address,
        total_participants: u64,
        closed_at: u64,
    }

    struct FundsDeposited has copy, drop {
        vault_id: address,
        depositor: address,
        amount: u64,
        deposited_at: u64,
    }

    struct TransactionSigned has copy, drop {
        vault_id: address,
        signer: address,
        signed_at: u64,
    }

    struct VaultOpened has copy, drop {
        vault_id: address,
        opened_at: u64,
    }

    struct FundsWithdrawn has copy, drop {
        vault_id: address,
        withdrawer: address,
        amount: u64,
        withdrawn_at: u64,
    }

    public fun balance<T0>(arg0: &MultisigVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun withdraw_all<T0>(arg0: &mut MultisigVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_vault_open, 5);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 7);
        let v1 = FundsWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            withdrawer   : 0x2::tx_context::sender(arg2),
            amount       : v0,
            withdrawn_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<FundsWithdrawn>(v1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.balance), arg2)
    }

    public fun close_list<T0>(arg0: &mut MultisigVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        assert!(!arg0.is_list_closed, 1);
        arg0.is_list_closed = true;
        let v0 = ListClosed{
            vault_id           : 0x2::object::uid_to_address(&arg0.id),
            total_participants : 0x2::vec_set::size<address>(&arg0.participants),
            closed_at          : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ListClosed>(v0);
    }

    public entry fun create_multisig_vault<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        create_multisig_vault_and_return_id<T0>(arg0, arg1);
    }

    public fun create_multisig_vault_and_return_id<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = MultisigVault<T0>{
            id             : 0x2::object::new(arg1),
            balance        : 0x2::balance::zero<T0>(),
            creator        : v0,
            participants   : 0x2::vec_set::empty<address>(),
            signatures     : 0x2::table::new<address, bool>(arg1),
            is_list_closed : false,
            is_vault_open  : false,
            created_at     : v1,
        };
        0x2::vec_set::insert<address>(&mut v2.participants, v0);
        let v3 = 0x2::object::uid_to_address(&v2.id);
        let v4 = MultisigVaultCreated{
            vault_id   : v3,
            creator    : v0,
            created_at : v1,
        };
        0x2::event::emit<MultisigVaultCreated>(v4);
        0x2::transfer::public_share_object<MultisigVault<T0>>(v2);
        v3
    }

    public fun creator<T0>(arg0: &MultisigVault<T0>) : address {
        arg0.creator
    }

    public fun deposit<T0>(arg0: &mut MultisigVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 8);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        let v1 = FundsDeposited{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            depositor    : 0x2::tx_context::sender(arg3),
            amount       : v0,
            deposited_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FundsDeposited>(v1);
    }

    public fun has_signed<T0>(arg0: &MultisigVault<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.signatures, arg1)
    }

    public fun is_list_closed<T0>(arg0: &MultisigVault<T0>) : bool {
        arg0.is_list_closed
    }

    public fun is_participant<T0>(arg0: &MultisigVault<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.participants, &arg1)
    }

    public fun is_vault_open<T0>(arg0: &MultisigVault<T0>) : bool {
        arg0.is_vault_open
    }

    public fun join_vault<T0>(arg0: &mut MultisigVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_list_closed, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::vec_set::contains<address>(&arg0.participants, &v0), 9);
        0x2::vec_set::insert<address>(&mut arg0.participants, v0);
        let v1 = ParticipantAdded{
            vault_id    : 0x2::object::uid_to_address(&arg0.id),
            participant : v0,
            added_at    : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ParticipantAdded>(v1);
    }

    public fun participant_count<T0>(arg0: &MultisigVault<T0>) : u64 {
        0x2::vec_set::size<address>(&arg0.participants)
    }

    public fun participants<T0>(arg0: &MultisigVault<T0>) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.participants)
    }

    public fun sign_to_open<T0>(arg0: &mut MultisigVault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_list_closed, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.participants, &v0), 4);
        assert!(!0x2::table::contains<address, bool>(&arg0.signatures, v0), 3);
        assert!(!arg0.is_vault_open, 6);
        0x2::table::add<address, bool>(&mut arg0.signatures, v0, true);
        let v1 = TransactionSigned{
            vault_id  : 0x2::object::uid_to_address(&arg0.id),
            signer    : v0,
            signed_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<TransactionSigned>(v1);
        if (0x2::table::length<address, bool>(&arg0.signatures) == 0x2::vec_set::size<address>(&arg0.participants)) {
            arg0.is_vault_open = true;
            let v2 = VaultOpened{
                vault_id  : 0x2::object::uid_to_address(&arg0.id),
                opened_at : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<VaultOpened>(v2);
        };
    }

    public fun signature_count<T0>(arg0: &MultisigVault<T0>) : u64 {
        0x2::table::length<address, bool>(&arg0.signatures)
    }

    public fun withdraw<T0>(arg0: &mut MultisigVault<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_vault_open, 5);
        assert!(0x2::tx_context::sender(arg3) == arg0.creator, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 7);
        let v0 = FundsWithdrawn{
            vault_id     : 0x2::object::uid_to_address(&arg0.id),
            withdrawer   : 0x2::tx_context::sender(arg3),
            amount       : arg1,
            withdrawn_at : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg3)
    }

    // decompiled from Move bytecode v6
}

