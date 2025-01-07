module 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::minter {
    struct MinterRole has drop {
        dummy_field: bool,
    }

    struct Transaction has copy, drop, store {
        amount: u64,
        timestamp_ms: u64,
    }

    struct MintConfig has drop, store {
        duration_ms: u64,
        mint_limit: u64,
        history: vector<Transaction>,
    }

    struct MintEvent<phantom T0> has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun mint<T0>(arg0: &mut 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::ManagedTreasury<T0>, arg1: &0x2::deny_list::DenyList, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_authorized<MinterRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0), 0x2::tx_context::sender(arg5));
        0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::assert_is_not_paused<MinterRole>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles<T0>(arg0));
        assert!(!0x2::coin::deny_list_contains<T0>(arg1, arg3), 2);
        let v0 = 0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::roles::config_mut<MinterRole, MintConfig>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::roles_mut<T0>(arg0), 0x2::tx_context::sender(arg5));
        add_mint_transaction(v0, arg2, 0x2::clock::timestamp_ms(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::mint<T0>(0x1723b5afd0951ac969c273116e0dd82a9ed684d17895fab1efc3530262175949::treasury::treasury_cap_mut<T0>(arg0), arg2, arg5), arg3);
        let v1 = MintEvent<T0>{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<MintEvent<T0>>(v1);
    }

    public(friend) fun add_mint_transaction(arg0: &mut MintConfig, arg1: u64, arg2: u64) {
        let v0 = Transaction{
            amount       : arg1,
            timestamp_ms : arg2,
        };
        let v1 = 0x1::vector::empty<Transaction>();
        0x1::vector::push_back<Transaction>(&mut v1, v0);
        adjust_history(arg0, v1, arg2);
    }

    fun adjust_history(arg0: &mut MintConfig, arg1: vector<Transaction>, arg2: u64) {
        let v0 = 0;
        0x1::vector::reverse<Transaction>(&mut arg1);
        while (!0x1::vector::is_empty<Transaction>(&arg1)) {
            let v1 = 0x1::vector::pop_back<Transaction>(&mut arg1);
            v0 = v0 + v1.amount;
        };
        0x1::vector::destroy_empty<Transaction>(arg1);
        let v2 = v0;
        0x1::vector::reverse<Transaction>(&mut arg0.history);
        while (0x1::vector::length<Transaction>(&arg0.history) > 0) {
            let v3 = 0x1::vector::pop_back<Transaction>(&mut arg0.history);
            if (floor_timestamp(arg0, arg2) > v3.timestamp_ms) {
                break
            };
            v2 = v2 + v3.amount;
            0x1::vector::push_back<Transaction>(&mut arg1, v3);
        };
        assert!(v2 <= arg0.mint_limit, 1);
        assert!(0x1::vector::length<Transaction>(&arg1) <= 7500, 3);
        arg0.history = arg1;
    }

    fun floor_timestamp(arg0: &MintConfig, arg1: u64) : u64 {
        if (arg0.duration_ms > arg1) {
            0
        } else {
            arg1 - arg0.duration_ms
        }
    }

    public(friend) fun new_config(arg0: u64, arg1: u64) : MintConfig {
        MintConfig{
            duration_ms : arg1,
            mint_limit  : arg0,
            history     : 0x1::vector::empty<Transaction>(),
        }
    }

    // decompiled from Move bytecode v6
}

