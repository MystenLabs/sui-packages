module 0xa7ce899e09d4b717cfa30aa187e1b7106e49589b9b603625fcc4a8ca40092234::slots {
    struct Slot<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        balance: 0x2::balance::Balance<T0>,
        name: 0x1::string::String,
        games_played: u64,
        money_made: u64,
        max_payout: u64,
        accepted_stakes: vector<u64>,
    }

    struct SlotResult has copy, drop {
        combination: vector<u8>,
        payout: u64,
    }

    fun calculate_payout(arg0: vector<u8>) : u64 {
        let v0 = 0;
        if (*0x1::vector::borrow<u8>(&arg0, 0) == *0x1::vector::borrow<u8>(&arg0, 1) && *0x1::vector::borrow<u8>(&arg0, 1) == *0x1::vector::borrow<u8>(&arg0, 2)) {
            if (*0x1::vector::borrow<u8>(&arg0, 0) == 0) {
                v0 = 30;
            } else if (*0x1::vector::borrow<u8>(&arg0, 0) == 1) {
                v0 = 15;
            } else {
                v0 = 10;
            };
        } else if ((*0x1::vector::borrow<u8>(&arg0, 0) == *0x1::vector::borrow<u8>(&arg0, 1) || *0x1::vector::borrow<u8>(&arg0, 0) == *0x1::vector::borrow<u8>(&arg0, 2)) && *0x1::vector::borrow<u8>(&arg0, 0) == 0 || *0x1::vector::borrow<u8>(&arg0, 1) == *0x1::vector::borrow<u8>(&arg0, 2) && *0x1::vector::borrow<u8>(&arg0, 1) == 0) {
            v0 = 3;
        } else {
            let v1 = if (*0x1::vector::borrow<u8>(&arg0, 0) == 0) {
                true
            } else if (*0x1::vector::borrow<u8>(&arg0, 1) == 0) {
                true
            } else {
                *0x1::vector::borrow<u8>(&arg0, 2) == 0
            };
            if (v1) {
                v0 = 1;
            };
        };
        v0
    }

    public fun new_slot<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Slot<T0>{
            id              : 0x2::object::new(arg1),
            owner           : 0x2::tx_context::sender(arg1),
            balance         : 0x2::balance::zero<T0>(),
            name            : arg0,
            games_played    : 0,
            money_made      : 0,
            max_payout      : 30,
            accepted_stakes : vector[200000000, 500000000, 1000000000],
        };
        0x2::transfer::public_share_object<Slot<T0>>(v0);
    }

    entry fun pull_lever<T0>(arg0: &mut Slot<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(0x1::vector::contains<u64>(&arg0.accepted_stakes, &v0), 1);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg0.max_payout * v1, 2);
        let v2 = b"";
        let v3 = 0x2::random::new_generator(arg2, arg3);
        0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v3, 0, 5));
        0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v3, 0, 5));
        0x1::vector::push_back<u8>(&mut v2, 0x2::random::generate_u8_in_range(&mut v3, 0, 5));
        let v4 = calculate_payout(v2);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
        if (v4 >= 1) {
            arg0.money_made = arg0.money_made + v4 * v1;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v4 * v1), arg3), 0x2::tx_context::sender(arg3));
        };
        arg0.games_played = arg0.games_played + 1;
        let v5 = SlotResult{
            combination : v2,
            payout      : v4,
        };
        0x2::event::emit<SlotResult>(v5);
    }

    public fun top_up<T0>(arg0: &mut Slot<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg1) > 0, 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &mut Slot<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

