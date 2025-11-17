module 0xb572868ec4951b206f36171066e75c4d26e6c5435198dcecbdb9fabfdf82ca4d::round {
    struct Round has store, key {
        id: 0x2::object::UID,
        participants: vector<Participant>,
        winners: vector<Participant>,
        winner_amount: u64,
        round_prize_value: u64,
        prize_pool: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Participant has copy, drop, store {
        wallet_address: address,
        weight: u64,
    }

    struct RoundWinner has copy, drop {
        round_id: 0x2::object::ID,
        winner: Participant,
        win_amount: u64,
    }

    public fun add_participants(arg0: &mut Round, arg1: vector<Participant>) {
        let v0 = &arg1;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Participant>(v0)) {
            if (!(0x1::vector::borrow<Participant>(v0, v1).weight > 0)) {
                v2 = false;
                /* label 6 */
                assert!(v2, 5);
                0x1::vector::reverse<Participant>(&mut arg1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<Participant>(&arg1)) {
                    0x1::vector::push_back<Participant>(&mut arg0.participants, 0x1::vector::pop_back<Participant>(&mut arg1));
                    v3 = v3 + 1;
                };
                0x1::vector::destroy_empty<Participant>(arg1);
                return
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    fun binary_search_cumulative(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<u64>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            if (*0x1::vector::borrow<u64>(arg0, v1) >= arg1) {
                continue
            };
            v0 = v1 + 1;
        };
        v0
    }

    fun compute_cumulative_weights(arg0: &vector<Participant>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Participant>(arg0)) {
            let v3 = v1 + 0x1::vector::borrow<Participant>(arg0, v2).weight;
            v1 = v3;
            0x1::vector::push_back<u64>(&mut v0, v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_participants(arg0: vector<address>, arg1: vector<u64>) : vector<Participant> {
        let v0 = 0x1::vector::empty<Participant>();
        0x1::vector::reverse<u64>(&mut arg1);
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 13906834530825666559);
        0x1::vector::reverse<address>(&mut arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = Participant{
                wallet_address : 0x1::vector::pop_back<address>(&mut arg0),
                weight         : 0x1::vector::pop_back<u64>(&mut arg1),
            };
            0x1::vector::push_back<Participant>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg0);
        0x1::vector::destroy_empty<u64>(arg1);
        v0
    }

    public fun create_round(arg0: vector<Participant>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Round {
        assert!(0x1::vector::length<Participant>(&arg0) > 0, 0);
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) % arg2 == 0, 2);
        let v0 = &arg0;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Participant>(v0)) {
            if (!(0x1::vector::borrow<Participant>(v0, v1).weight > 0)) {
                v2 = false;
                /* label 13 */
                assert!(v2, 3);
                assert!(0x1::vector::length<Participant>(&arg0) >= arg2, 4);
                return Round{
                    id                : 0x2::object::new(arg3),
                    participants      : arg0,
                    winners           : 0x1::vector::empty<Participant>(),
                    winner_amount     : arg2,
                    round_prize_value : 0x2::coin::value<0x2::sui::SUI>(&arg1),
                    prize_pool        : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
                }
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 13 */
    }

    entry fun delete_round(arg0: Round, arg1: &mut 0x2::tx_context::TxContext) {
        let Round {
            id                : v0,
            participants      : _,
            winners           : _,
            winner_amount     : _,
            round_prize_value : _,
            prize_pool        : v5,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg1), 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    entry fun finalize_round(arg0: Round, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg1, arg2);
        let v1 = arg0.winner_amount;
        let v2 = arg0.participants;
        let v3 = 0;
        let v4 = &v2;
        let v5 = 0;
        while (v5 < 0x1::vector::length<Participant>(v4)) {
            v3 = v3 + 0x1::vector::borrow<Participant>(v4, v5).weight;
            v5 = v5 + 1;
        };
        let v6 = compute_cumulative_weights(&v2);
        while (0x1::vector::length<Participant>(&arg0.winners) < v1 && 0x1::vector::length<Participant>(&v2) > 0) {
            let v7 = binary_search_cumulative(&v6, 0x2::random::generate_u64_in_range(&mut v0, 1, v3));
            let v8 = *0x1::vector::borrow<Participant>(&v2, v7);
            0x1::vector::push_back<Participant>(&mut arg0.winners, v8);
            0x1::vector::remove<Participant>(&mut v2, v7);
            v3 = v3 - v8.weight;
            v6 = compute_cumulative_weights(&v2);
        };
        let v9 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize_pool), arg2);
        let v10 = 0x2::coin::divide_into_n<0x2::sui::SUI>(&mut v9, v1, arg2);
        0x1::vector::push_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v10, v9);
        let v11 = arg0.winners;
        0x1::vector::reverse<0x2::coin::Coin<0x2::sui::SUI>>(&mut v10);
        assert!(0x1::vector::length<Participant>(&v11) == 0x1::vector::length<0x2::coin::Coin<0x2::sui::SUI>>(&v10), 13906834728394162175);
        0x1::vector::reverse<Participant>(&mut v11);
        let v12 = 0;
        while (v12 < 0x1::vector::length<Participant>(&v11)) {
            let v13 = 0x1::vector::pop_back<Participant>(&mut v11);
            let v14 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut v10);
            let v15 = RoundWinner{
                round_id   : 0x2::object::id<Round>(&arg0),
                winner     : v13,
                win_amount : 0x2::coin::value<0x2::sui::SUI>(&v14),
            };
            0x2::event::emit<RoundWinner>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v14, v13.wallet_address);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<Participant>(v11);
        0x1::vector::destroy_empty<0x2::coin::Coin<0x2::sui::SUI>>(v10);
        0x2::transfer::public_freeze_object<Round>(arg0);
    }

    public fun remove_participants(arg0: &mut Round, arg1: vector<Participant>) {
        let v0 = 0x1::vector::empty<Participant>();
        let v1 = arg0.participants;
        0x1::vector::reverse<Participant>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Participant>(&v1)) {
            let v3 = 0x1::vector::pop_back<Participant>(&mut v1);
            if (!0x1::vector::contains<Participant>(&arg1, &v3)) {
                0x1::vector::push_back<Participant>(&mut v0, v3);
            };
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Participant>(v1);
        arg0.participants = v0;
    }

    // decompiled from Move bytecode v6
}

