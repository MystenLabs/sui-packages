module 0x17ac3a36f09e0a4d214efeec8c37e9d88d9720eb274a93b3907b1d1cd2fed8d0::escrow {
    struct Escrow has key {
        id: 0x2::object::UID,
        creator: address,
        party_a: 0x1::option::Option<address>,
        party_b: 0x1::option::Option<address>,
        escrow_type: u8,
        reference_amount: u64,
        required_deposit_a: u64,
        required_deposit_b: u64,
        deposited_a: u64,
        deposited_b: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        proposed_payout_a: u64,
        proposed_payout_b: u64,
        proposed_donation: u64,
        finalization_proposer: 0x1::option::Option<address>,
        finalization_note: vector<u8>,
        status: u8,
        created_at: u64,
        deposit_at: u64,
        finalized_at: u64,
        note: vector<u8>,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        creator: address,
        escrow_type: u8,
        reference_amount: u64,
        required_deposit_a: u64,
        required_deposit_b: u64,
    }

    struct Deposited has copy, drop {
        escrow_id: 0x2::object::ID,
        depositor: address,
        party: u8,
        amount: u64,
    }

    struct DepositsComplete has copy, drop {
        escrow_id: 0x2::object::ID,
        timestamp_ms: u64,
    }

    struct FinalizationSuggested has copy, drop {
        escrow_id: 0x2::object::ID,
        proposer: address,
        payout_a: u64,
        payout_b: u64,
        donation: u64,
    }

    struct FinalizationRejected has copy, drop {
        escrow_id: 0x2::object::ID,
        rejected_by: address,
    }

    struct EscrowCompleted has copy, drop {
        escrow_id: 0x2::object::ID,
        accepted_by: address,
        payout_a: u64,
        payout_b: u64,
        donation: u64,
        timestamp_ms: u64,
    }

    struct EscrowCancelled has copy, drop {
        escrow_id: 0x2::object::ID,
        withdrawn_by: address,
        amount: u64,
    }

    public fun accept_finalization(arg0: &mut Escrow, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 4);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_party(arg0, v0), 3);
        assert!(0x1::option::is_some<address>(&arg0.finalization_proposer), 8);
        assert!(v0 != *0x1::option::borrow<address>(&arg0.finalization_proposer), 9);
        assert!(0x1::option::is_some<address>(&arg0.party_a) && 0x1::option::is_some<address>(&arg0.party_b), 2);
        let v1 = arg0.proposed_payout_a;
        let v2 = arg0.proposed_payout_b;
        let v3 = arg0.proposed_donation;
        let v4 = checked_add(arg0.deposited_a, arg0.deposited_b);
        assert!(checked_add(checked_add(v1, v2), v3) == v4, 8);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) == v4, 8);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg2), *0x1::option::borrow<address>(&arg0.party_a));
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v2), arg2), *0x1::option::borrow<address>(&arg0.party_b));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v3), arg2), @0x516ec0b66f3174da736236c22d6d8db79d006c51518302316fa38876ed3afcb0);
        };
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.vault) == 0, 8);
        arg0.status = 3;
        arg0.finalized_at = 0x2::clock::timestamp_ms(arg1);
        let v5 = EscrowCompleted{
            escrow_id    : 0x2::object::uid_to_inner(&arg0.id),
            accepted_by  : v0,
            payout_a     : v1,
            payout_b     : v2,
            donation     : v3,
            timestamp_ms : arg0.finalized_at,
        };
        0x2::event::emit<EscrowCompleted>(v5);
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 12);
        arg0 + arg1
    }

    public fun create_escrow(arg0: u8, arg1: 0x1::option::Option<address>, arg2: 0x1::option::Option<address>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        assert!(arg4 > 0, 0);
        assert!(arg5 > 0, 0);
        assert!(0x1::vector::length<u8>(&arg6) <= 200, 1);
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::option::is_some<address>(&arg1) || 0x1::option::is_some<address>(&arg2), 2);
        let v1 = 0x1::option::is_some<address>(&arg1) && *0x1::option::borrow<address>(&arg1) == v0;
        let v2 = 0x1::option::is_some<address>(&arg2) && *0x1::option::borrow<address>(&arg2) == v0;
        assert!(v1 || v2, 3);
        if (0x1::option::is_some<address>(&arg1) && 0x1::option::is_some<address>(&arg2)) {
            assert!(*0x1::option::borrow<address>(&arg1) != *0x1::option::borrow<address>(&arg2), 2);
        };
        let v3 = Escrow{
            id                    : 0x2::object::new(arg8),
            creator               : v0,
            party_a               : arg1,
            party_b               : arg2,
            escrow_type           : arg0,
            reference_amount      : arg3,
            required_deposit_a    : arg4,
            required_deposit_b    : arg5,
            deposited_a           : 0,
            deposited_b           : 0,
            vault                 : 0x2::balance::zero<0x2::sui::SUI>(),
            proposed_payout_a     : 0,
            proposed_payout_b     : 0,
            proposed_donation     : 0,
            finalization_proposer : 0x1::option::none<address>(),
            finalization_note     : b"",
            status                : 0,
            created_at            : 0x2::clock::timestamp_ms(arg7),
            deposit_at            : 0,
            finalized_at          : 0,
            note                  : arg6,
        };
        let v4 = EscrowCreated{
            escrow_id          : 0x2::object::uid_to_inner(&v3.id),
            creator            : v0,
            escrow_type        : arg0,
            reference_amount   : arg3,
            required_deposit_a : arg4,
            required_deposit_b : arg5,
        };
        0x2::event::emit<EscrowCreated>(v4);
        0x2::transfer::share_object<Escrow>(v3);
    }

    public fun created_at(arg0: &Escrow) : u64 {
        arg0.created_at
    }

    public fun creator(arg0: &Escrow) : address {
        arg0.creator
    }

    public fun deposit(arg0: &mut Escrow, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v2 = if (0x1::option::is_some<address>(&arg0.party_a) && *0x1::option::borrow<address>(&arg0.party_a) == v0) {
            true
        } else if (0x1::option::is_some<address>(&arg0.party_b) && *0x1::option::borrow<address>(&arg0.party_b) == v0) {
            false
        } else if (0x1::option::is_none<address>(&arg0.party_a)) {
            if (0x1::option::is_some<address>(&arg0.party_b)) {
                assert!(*0x1::option::borrow<address>(&arg0.party_b) != v0, 2);
            };
            0x1::option::fill<address>(&mut arg0.party_a, v0);
            true
        } else {
            assert!(0x1::option::is_none<address>(&arg0.party_b), 3);
            if (0x1::option::is_some<address>(&arg0.party_a)) {
                assert!(*0x1::option::borrow<address>(&arg0.party_a) != v0, 2);
            };
            0x1::option::fill<address>(&mut arg0.party_b, v0);
            false
        };
        if (v2) {
            assert!(arg0.deposited_a == 0, 5);
            assert!(v1 == arg0.required_deposit_a, 6);
            arg0.deposited_a = v1;
        } else {
            assert!(arg0.deposited_b == 0, 5);
            assert!(v1 == arg0.required_deposit_b, 6);
            arg0.deposited_b = v1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v3 = if (v2) {
            0
        } else {
            1
        };
        let v4 = Deposited{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            depositor : v0,
            party     : v3,
            amount    : v1,
        };
        0x2::event::emit<Deposited>(v4);
        if (arg0.deposited_a == arg0.required_deposit_a && arg0.deposited_b == arg0.required_deposit_b) {
            arg0.status = 1;
            arg0.deposit_at = 0x2::clock::timestamp_ms(arg2);
            let v5 = DepositsComplete{
                escrow_id    : 0x2::object::uid_to_inner(&arg0.id),
                timestamp_ms : arg0.deposit_at,
            };
            0x2::event::emit<DepositsComplete>(v5);
        };
    }

    public fun deposit_at(arg0: &Escrow) : u64 {
        arg0.deposit_at
    }

    public fun deposited_a(arg0: &Escrow) : u64 {
        arg0.deposited_a
    }

    public fun deposited_b(arg0: &Escrow) : u64 {
        arg0.deposited_b
    }

    public fun escrow_type(arg0: &Escrow) : u8 {
        arg0.escrow_type
    }

    public fun finalized_at(arg0: &Escrow) : u64 {
        arg0.finalized_at
    }

    fun is_party(arg0: &Escrow, arg1: address) : bool {
        let v0 = 0x1::option::is_some<address>(&arg0.party_a) && *0x1::option::borrow<address>(&arg0.party_a) == arg1;
        let v1 = 0x1::option::is_some<address>(&arg0.party_b) && *0x1::option::borrow<address>(&arg0.party_b) == arg1;
        v0 || v1
    }

    public fun note(arg0: &Escrow) : &vector<u8> {
        &arg0.note
    }

    public fun party_a(arg0: &Escrow) : &0x1::option::Option<address> {
        &arg0.party_a
    }

    public fun party_a_address(arg0: &Escrow) : address {
        assert!(0x1::option::is_some<address>(&arg0.party_a), 2);
        *0x1::option::borrow<address>(&arg0.party_a)
    }

    public fun party_b(arg0: &Escrow) : &0x1::option::Option<address> {
        &arg0.party_b
    }

    public fun party_b_address(arg0: &Escrow) : address {
        assert!(0x1::option::is_some<address>(&arg0.party_b), 2);
        *0x1::option::borrow<address>(&arg0.party_b)
    }

    public fun proposed_donation(arg0: &Escrow) : u64 {
        arg0.proposed_donation
    }

    public fun proposed_payout_a(arg0: &Escrow) : u64 {
        arg0.proposed_payout_a
    }

    public fun proposed_payout_b(arg0: &Escrow) : u64 {
        arg0.proposed_payout_b
    }

    public fun reference_amount(arg0: &Escrow) : u64 {
        arg0.reference_amount
    }

    public fun reject_finalization(arg0: &mut Escrow, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 4);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(is_party(arg0, v0), 3);
        assert!(0x1::option::is_some<address>(&arg0.finalization_proposer), 8);
        assert!(v0 != *0x1::option::borrow<address>(&arg0.finalization_proposer), 10);
        arg0.proposed_payout_a = 0;
        arg0.proposed_payout_b = 0;
        arg0.proposed_donation = 0;
        0x1::option::extract<address>(&mut arg0.finalization_proposer);
        arg0.finalization_note = b"";
        arg0.status = 1;
        let v1 = FinalizationRejected{
            escrow_id   : 0x2::object::uid_to_inner(&arg0.id),
            rejected_by : v0,
        };
        0x2::event::emit<FinalizationRejected>(v1);
    }

    public fun required_deposit_a(arg0: &Escrow) : u64 {
        arg0.required_deposit_a
    }

    public fun required_deposit_b(arg0: &Escrow) : u64 {
        arg0.required_deposit_b
    }

    public fun status(arg0: &Escrow) : u8 {
        arg0.status
    }

    public fun suggest_finalization(arg0: &mut Escrow, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 4);
        assert!(0x1::vector::length<u8>(&arg4) <= 200, 1);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(is_party(arg0, v0), 3);
        assert!(checked_add(checked_add(arg1, arg2), arg3) == checked_add(arg0.deposited_a, arg0.deposited_b), 8);
        assert!(arg3 <= arg0.reference_amount, 11);
        arg0.proposed_payout_a = arg1;
        arg0.proposed_payout_b = arg2;
        arg0.proposed_donation = arg3;
        arg0.finalization_proposer = 0x1::option::some<address>(v0);
        arg0.finalization_note = arg4;
        arg0.status = 2;
        let v1 = FinalizationSuggested{
            escrow_id : 0x2::object::uid_to_inner(&arg0.id),
            proposer  : v0,
            payout_a  : arg1,
            payout_b  : arg2,
            donation  : arg3,
        };
        0x2::event::emit<FinalizationSuggested>(v1);
    }

    public fun vault_balance(arg0: &Escrow) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun withdraw_before_complete(arg0: &mut Escrow, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 4);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x1::option::is_some<address>(&arg0.party_a) && *0x1::option::borrow<address>(&arg0.party_a) == v0) {
            assert!(arg0.deposited_a > 0, 7);
            arg0.deposited_a = 0;
            arg0.deposited_a
        } else {
            assert!(0x1::option::is_some<address>(&arg0.party_b) && *0x1::option::borrow<address>(&arg0.party_b) == v0, 3);
            assert!(arg0.deposited_b > 0, 7);
            arg0.deposited_b = 0;
            arg0.deposited_b
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v1), arg1), v0);
        arg0.status = 4;
        let v2 = EscrowCancelled{
            escrow_id    : 0x2::object::uid_to_inner(&arg0.id),
            withdrawn_by : v0,
            amount       : v1,
        };
        0x2::event::emit<EscrowCancelled>(v2);
    }

    // decompiled from Move bytecode v7
}

