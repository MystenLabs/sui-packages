module 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::p2p_lifecycle {
    struct EscrowReceipt has store, key {
        id: 0x2::object::UID,
        registration_id: 0x2::object::ID,
        game_type_id: u64,
        balance: u64,
    }

    public fun escrow_more_p2p<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &mut EscrowReceipt, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        assert!(v0 > 0, 700);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 702);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::absorb_p2p_escrow<T0>(arg0, arg3);
        arg2.balance = arg2.balance + v0;
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_escrowed(0x2::object::id<EscrowReceipt>(arg2), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), 0x2::tx_context::sender(arg4), v0, arg2.balance);
    }

    public fun escrow_p2p<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : EscrowReceipt {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 700);
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::absorb_p2p_escrow<T0>(arg0, arg2);
        let v1 = EscrowReceipt{
            id              : 0x2::object::new(arg3),
            registration_id : 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1),
            game_type_id    : 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1),
            balance         : v0,
        };
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_escrowed(0x2::object::id<EscrowReceipt>(&v1), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), 0x2::tx_context::sender(arg3), v0, v0);
        v1
    }

    public fun receipt_balance(arg0: &EscrowReceipt) : u64 {
        arg0.balance
    }

    public fun receipt_game_type_id(arg0: &EscrowReceipt) : u64 {
        arg0.game_type_id
    }

    public fun receipt_id(arg0: &EscrowReceipt) : 0x2::object::ID {
        0x2::object::id<EscrowReceipt>(arg0)
    }

    public fun receipt_registration_id(arg0: &EscrowReceipt) : 0x2::object::ID {
        arg0.registration_id
    }

    public fun refund_p2p_all<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: EscrowReceipt, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 702);
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 703);
        assert!(v0 > 0, 704);
        let v1 = 0;
        let v2 = 0;
        while (v2 < v0) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg4, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == arg2.balance, 705);
        let v3 = arg2.balance;
        let EscrowReceipt {
            id              : v4,
            registration_id : _,
            game_type_id    : _,
            balance         : _,
        } = arg2;
        0x2::object::delete(v4);
        let v8 = 0;
        while (v8 < v0) {
            let v9 = *0x1::vector::borrow<u64>(&arg4, v8);
            let v10 = *0x1::vector::borrow<address>(&arg3, v8);
            if (v9 > 0) {
                v3 = v3 - v9;
                0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_released(0x2::object::id<EscrowReceipt>(&arg2), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), v10, v9, v3, b"refund");
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_p2p_escrow<T0>(arg0, v9, arg5), v10);
            };
            v8 = v8 + 1;
        };
    }

    public fun refund_p2p_remainder<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: EscrowReceipt, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        release_p2p_final_kinded<T0>(arg0, arg1, arg2, arg3, b"refund", arg4);
    }

    public fun release_p2p<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &mut EscrowReceipt, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 700);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 702);
        assert!(arg2.balance >= arg3, 701);
        arg2.balance = arg2.balance - arg3;
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_released(0x2::object::id<EscrowReceipt>(arg2), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), arg4, arg3, arg2.balance, b"release");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_p2p_escrow<T0>(arg0, arg3, arg5), arg4);
    }

    public fun release_p2p_final<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: EscrowReceipt, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        release_p2p_final_kinded<T0>(arg0, arg1, arg2, arg3, b"release", arg4);
    }

    fun release_p2p_final_kinded<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: EscrowReceipt, arg3: address, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 702);
        let EscrowReceipt {
            id              : v0,
            registration_id : _,
            game_type_id    : _,
            balance         : v3,
        } = arg2;
        0x2::object::delete(v0);
        if (v3 > 0) {
            0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_released(0x2::object::id<EscrowReceipt>(&arg2), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), arg3, v3, 0, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_p2p_escrow<T0>(arg0, v3, arg5), arg3);
        };
    }

    public fun release_p2p_for_rake<T0>(arg0: &mut 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>, arg1: &0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::GameRegistration, arg2: &mut EscrowReceipt, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg3 > 0, 700);
        assert!(arg2.registration_id == 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 702);
        assert!(arg2.balance >= arg3, 701);
        arg2.balance = arg2.balance - arg3;
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::events::emit_p2p_released(0x2::object::id<EscrowReceipt>(arg2), 0x2::object::id<0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::Vault<T0>>(arg0), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::id_of(arg1), 0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::registry::game_type_id(arg1), 0x2::tx_context::sender(arg4), arg3, arg2.balance, b"rake");
        0x6b49997f47a46d2cf8bc1b501daa9b93bcfc1b715ee1e8649074f61ebb4ab22f::vault::release_p2p_escrow<T0>(arg0, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

