module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final {
    struct Deposit<phantom T0> has copy, drop {
        amount: u64,
    }

    struct FinalSplit<phantom T0> has copy, drop {
        amount_for_leaderboard: u64,
        amount_for_winners: u64,
        amount_for_fortune_bag_holders: u64,
    }

    struct FinalPool has key {
        id: 0x2::object::UID,
        is_ended: bool,
    }

    struct SinglePool<phantom T0> has store, key {
        id: 0x2::object::UID,
        is_splitted: bool,
        main_pool_final_value: u64,
        main_pool: 0x2::balance::Balance<T0>,
        winner_pool_final_value: u64,
        winner_pool: 0x2::balance::Balance<T0>,
    }

    fun borrow_single_pool<T0>(arg0: &FinalPool) : &SinglePool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0)
    }

    fun borrow_single_pool_mut<T0>(arg0: &mut FinalPool) : &mut SinglePool<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg0.id, v0), 4);
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg0.id, v0)
    }

    public fun claim_with_fortune_bag<T0>(arg0: &mut FinalPool, arg1: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::FortuneBag, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            if (0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::is_claimable(arg1)) {
                0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::set_claimed(arg1);
                let v1 = borrow_single_pool_mut<T0>(arg0);
                assert!(v1.is_splitted, 3);
                0x2::coin::take<T0>(&mut v1.main_pool, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v1.main_pool_final_value, 1, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::final_total_shares()), arg2)
            } else {
                0x2::coin::zero<T0>(arg2)
            }
        } else if (0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::is_claimable_with_type<T0>(arg1)) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::fortune_bag::set_claimed_with_type<T0>(arg1);
            let v2 = borrow_single_pool_mut<T0>(arg0);
            assert!(v2.is_splitted, 3);
            0x2::coin::take<T0>(&mut v2.main_pool, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v2.main_pool_final_value, 1, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::final_total_shares()), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public fun deposit<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg1: &mut FinalPool, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_ended, 0);
        let v0 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::assert_coin_type_is_listed<T0>(arg0);
        if (!0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, SinglePool<T0>>(&arg1.id, v0)) {
            let v1 = SinglePool<T0>{
                id                      : 0x2::object::new(arg3),
                is_splitted             : false,
                main_pool_final_value   : 0,
                main_pool               : 0x2::balance::zero<T0>(),
                winner_pool_final_value : 0,
                winner_pool             : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg1.id, v0, v1);
        };
        let v2 = Deposit<T0>{amount: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<Deposit<T0>>(v2);
        0x2::coin::put<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg1.id, v0).main_pool, arg2);
    }

    entry fun force_withdraw_pool<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::contributor::DevCap, arg1: &mut FinalPool, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = borrow_single_pool_mut<T0>(arg1);
        let v1 = 0x2::balance::withdraw_all<T0>(&mut v0.main_pool);
        0x2::balance::join<T0>(&mut v1, 0x2::balance::withdraw_all<T0>(&mut v0.winner_pool));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FinalPool{
            id       : 0x2::object::new(arg0),
            is_ended : false,
        };
        0x2::transfer::share_object<FinalPool>(v0);
    }

    public fun is_ended(arg0: &FinalPool) : bool {
        arg0.is_ended
    }

    public fun is_splitted<T0>(arg0: &FinalPool) : bool {
        borrow_single_pool<T0>(arg0).is_splitted
    }

    public fun main_pool_balance<T0>(arg0: &FinalPool) : u64 {
        0x2::balance::value<T0>(&borrow_single_pool<T0>(arg0).main_pool)
    }

    public fun main_pool_final_value<T0>(arg0: &FinalPool) : u64 {
        borrow_single_pool<T0>(arg0).main_pool_final_value
    }

    public(friend) fun set_ended(arg0: &mut FinalPool) {
        arg0.is_ended = true;
    }

    public fun split_final_pool_after_game_ended<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg1: &mut FinalPool, arg2: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::LootboxPool, arg3: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::Leaderboard, arg4: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.is_ended, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, SinglePool<T0>>(&mut arg1.id, 0x1::type_name::get<T0>());
        assert!(!v0.is_splitted, 2);
        0x2::balance::join<T0>(&mut v0.main_pool, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::lootbox::withdraw_all_after_game_ended<T0>(arg2));
        let v1 = 0x2::balance::value<T0>(&v0.main_pool);
        v0.main_pool_final_value = v1;
        let v2 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::final_total_shares();
        let v3 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v1, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::leaderboard_shares(), v2);
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard::deposit<T0>(arg0, arg3, arg4, 0x2::coin::take<T0>(&mut v0.main_pool, v3, arg5), arg5);
        let v4 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v1, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::winner_shares(), v2);
        0x2::balance::join<T0>(&mut v0.winner_pool, 0x2::balance::split<T0>(&mut v0.main_pool, v4));
        v0.winner_pool_final_value = v4;
        v0.is_splitted = true;
        let v5 = FinalSplit<T0>{
            amount_for_leaderboard         : v3,
            amount_for_winners             : v4,
            amount_for_fortune_bag_holders : v1 - v3 - v4,
        };
        0x2::event::emit<FinalSplit<T0>>(v5);
    }

    public fun winner_claim<T0>(arg0: &mut FinalPool, arg1: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::FinalWinner, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x1::type_name::get<T0>() == 0x1::type_name::get<0x2::sui::SUI>()) {
            if (0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::is_claimable(arg1)) {
                0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::set_claimed(arg1);
                let v1 = borrow_single_pool_mut<T0>(arg0);
                assert!(v1.is_splitted, 3);
                0x2::coin::take<T0>(&mut v1.winner_pool, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v1.winner_pool_final_value, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::get_shares(arg1), 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::winner_total_shares()), arg2)
            } else {
                0x2::coin::zero<T0>(arg2)
            }
        } else if (0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::is_claimable_with_type<T0>(arg1)) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::set_claimed_with_type<T0>(arg1);
            let v2 = borrow_single_pool_mut<T0>(arg0);
            assert!(v2.is_splitted, 3);
            0x2::coin::take<T0>(&mut v2.winner_pool, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v2.winner_pool_final_value, 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::final_winner::get_shares(arg1), 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::config::winner_total_shares()), arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public fun winner_pool_balance<T0>(arg0: &FinalPool) : u64 {
        0x2::balance::value<T0>(&borrow_single_pool<T0>(arg0).winner_pool)
    }

    public fun winner_pool_final_value<T0>(arg0: &FinalPool) : u64 {
        borrow_single_pool<T0>(arg0).winner_pool_final_value
    }

    // decompiled from Move bytecode v6
}

