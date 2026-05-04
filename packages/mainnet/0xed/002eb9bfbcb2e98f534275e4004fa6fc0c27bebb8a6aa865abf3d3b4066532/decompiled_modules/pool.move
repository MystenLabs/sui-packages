module 0x529e9c233a7f2f6cc5bcd8371735cba8e44d80a1d30c8bd0a29ea4b4be4d4b54::pool {
    struct EscrowKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        entry_fee: u64,
        balance: u64,
        dev_fee_percentage: u8,
        dev_wallet: address,
        players: vector<address>,
        is_active: bool,
    }

    public entry fun close_pool(arg0: &mut Pool) {
        arg0.is_active = false;
    }

    public entry fun create_pool(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 100, 2);
        let v0 = Pool{
            id                 : 0x2::object::new(arg4),
            name               : arg0,
            entry_fee          : arg1,
            balance            : 0,
            dev_fee_percentage : arg2,
            dev_wallet         : arg3,
            players            : 0x1::vector::empty<address>(),
            is_active          : true,
        };
        let v1 = EscrowKey{dummy_field: false};
        0x2::dynamic_field::add<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.id, v1, 0x2::balance::zero<0x2::sui::SUI>());
        0x2::transfer::share_object<Pool>(v0);
    }

    public entry fun deposit(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 0);
        let v0 = EscrowKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v0)) {
            let v1 = EscrowKey{dummy_field: false};
            0x2::dynamic_field::add<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v2 = EscrowKey{dummy_field: false};
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(0x2::dynamic_field::borrow_mut<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v2), v3);
        arg0.balance = arg0.balance + 0x2::balance::value<0x2::sui::SUI>(&v3);
    }

    public entry fun deposit_and_join(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        deposit(arg0, arg1, arg3);
        join_pool(arg0, arg2);
    }

    public entry fun distribute_rewards(arg0: &mut Pool, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg1) > 0, 1);
        let v0 = EscrowKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_with_type<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v0)) {
            let v1 = EscrowKey{dummy_field: false};
            0x2::dynamic_field::add<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1, 0x2::balance::zero<0x2::sui::SUI>());
        };
        let v2 = EscrowKey{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v2);
        let v4 = 0x2::balance::value<0x2::sui::SUI>(v3);
        assert!(v4 > 0, 1);
        let v5 = 0x1::vector::length<address>(&arg1);
        assert!(v5 == 0x1::vector::length<u64>(&arg2), 2);
        let v6 = 0;
        while (v6 < v5) {
            let v7 = *0x1::vector::borrow<u64>(&arg2, v6);
            if (v7 > 0 && v7 <= v4) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v3, v7, arg3), *0x1::vector::borrow<address>(&arg1, v6));
            };
            v6 = v6 + 1;
        };
    }

    public fun get_balance(arg0: &Pool) : u64 {
        arg0.balance
    }

    public fun get_escrow_balance(arg0: &Pool) : u64 {
        let v0 = EscrowKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v0)) {
            let v2 = EscrowKey{dummy_field: false};
            0x2::balance::value<0x2::sui::SUI>(0x2::dynamic_field::borrow<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v2))
        } else {
            0
        }
    }

    public fun get_players(arg0: &Pool) : vector<address> {
        arg0.players
    }

    public fun get_pool_info(arg0: &Pool) : (vector<u8>, u64, u64, u8, address, bool, u64) {
        (arg0.name, arg0.entry_fee, arg0.balance, arg0.dev_fee_percentage, arg0.dev_wallet, arg0.is_active, 0x1::vector::length<address>(&arg0.players))
    }

    public entry fun join_pool(arg0: &mut Pool, arg1: address) {
        assert!(arg0.is_active, 0);
        if (!0x1::vector::contains<address>(&arg0.players, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.players, arg1);
        };
    }

    public entry fun refund_all(arg0: &mut Pool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = EscrowKey{dummy_field: false};
        if (0x2::dynamic_field::exists_with_type<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.id, v0)) {
            let v1 = EscrowKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<EscrowKey, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, v1);
            let v3 = 0x2::balance::value<0x2::sui::SUI>(v2);
            if (v3 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, v3, arg1), arg0.dev_wallet);
            };
        };
        arg0.is_active = false;
    }

    public entry fun reopen_pool(arg0: &mut Pool) {
        arg0.is_active = true;
    }

    // decompiled from Move bytecode v7
}

