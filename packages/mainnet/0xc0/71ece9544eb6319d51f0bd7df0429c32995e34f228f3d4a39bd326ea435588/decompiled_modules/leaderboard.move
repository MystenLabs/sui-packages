module 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::leaderboard {
    struct AddScore<phantom T0> has copy, drop {
        user: address,
    }

    struct Airdrop<phantom T0> has copy, drop {
        amount: u64,
    }

    struct ClaimAirdrop<phantom T0> has copy, drop {
        user: address,
        amount: u64,
    }

    struct Leaderboard has key {
        id: 0x2::object::UID,
        is_ended: bool,
        total_scores: u64,
        score_map: 0x2::table::Table<address, u64>,
        top_leaders: vector<address>,
        top_scores: vector<u64>,
    }

    struct AirdropPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        final_balance_value: u64,
        balance: 0x2::balance::Balance<T0>,
        claimed_table: 0x2::table::Table<address, bool>,
    }

    public(friend) fun add_score<T0>(arg0: &mut Leaderboard, arg1: address) {
        arg0.total_scores = arg0.total_scores + 1;
        let v0 = &mut arg0.score_map;
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            0x2::table::add<address, u64>(v0, arg1, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(v0, arg1);
        *v1 = *v1 + 1;
        let v2 = AddScore<T0>{user: arg1};
        0x2::event::emit<AddScore<T0>>(v2);
        let (v3, v4) = 0x1::vector::index_of<address>(&arg0.top_leaders, &arg1);
        if (v3) {
            *0x1::vector::borrow_mut<u64>(&mut arg0.top_scores, v4) = *v1;
            return
        };
        let (v5, v6) = get_min_score_and_index(&arg0.top_scores);
        if (*v1 > v5) {
            0x1::vector::remove<address>(&mut arg0.top_leaders, v6);
            0x1::vector::remove<u64>(&mut arg0.top_scores, v6);
            0x1::vector::push_back<address>(&mut arg0.top_leaders, arg1);
            0x1::vector::push_back<u64>(&mut arg0.top_scores, *v1);
        };
    }

    public fun airdrop<T0>(arg0: &mut Leaderboard, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_ended, 0);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_object_field::exists_with_type<0x1::type_name::TypeName, AirdropPool<T0>>(&arg0.id, v0)) {
            let v1 = AirdropPool<T0>{
                id                  : 0x2::object::new(arg2),
                final_balance_value : 0,
                balance             : 0x2::balance::zero<T0>(),
                claimed_table       : 0x2::table::new<address, bool>(arg2),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, AirdropPool<T0>>(&mut arg0.id, v0, v1);
        };
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, AirdropPool<T0>>(&mut arg0.id, v0);
        let v3 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut v2.balance, arg1);
        let v4 = Airdrop<T0>{amount: v3};
        0x2::event::emit<Airdrop<T0>>(v4);
        v2.final_balance_value = v2.final_balance_value + v3;
    }

    public fun claim_aidrop<T0>(arg0: &mut Leaderboard, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_ended, 1);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, AirdropPool<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        assert!(!0x2::table::contains<address, bool>(&v1.claimed_table, v0), 2);
        let v2 = 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::math::mul_and_div(v1.final_balance_value, get_user_score(arg0, v0), arg0.total_scores);
        0x2::table::add<address, bool>(&mut v1.claimed_table, v0, true);
        let v3 = ClaimAirdrop<T0>{
            user   : v0,
            amount : v2,
        };
        0x2::event::emit<ClaimAirdrop<T0>>(v3);
        0x2::coin::take<T0>(&mut v1.balance, v2, arg1)
    }

    public fun deposit<T0>(arg0: &0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::CoinTypeWhitelist, arg1: &Leaderboard, arg2: &mut 0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::TroveManager, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::listing::assert_coin_type_is_listed<T0>(arg0);
        let v0 = 0x2::coin::divide_into_n<T0>(&mut arg3, 10, arg4);
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v0, arg3);
        let v1 = 0;
        while (v1 < 10) {
            0xd441d82fa791d7e7fc89eb2a40b0714bd9a6a1aaf0c897d702802d30109c1f7b::trove_manager::put_coin_into_user_trove<T0>(arg2, *0x1::vector::borrow<address>(&arg1.top_leaders, v1), 0x1::vector::pop_back<0x2::coin::Coin<T0>>(&mut v0), b"leaderboard", 0x1::option::some<address>(0x2::tx_context::sender(arg4)), arg4);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<T0>>(v0);
    }

    fun get_min_score_and_index(arg0: &vector<u64>) : (u64, u64) {
        let v0 = 18446744073709551615;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = 0x1::vector::borrow<u64>(arg0, v1);
            if (*v2 < v0) {
                v0 = *v2;
            };
            v1 = v1 + 1;
        };
        (v0, 0)
    }

    public fun get_user_score(arg0: &Leaderboard, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.score_map, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.score_map, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 10) {
            0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = Leaderboard{
            id           : 0x2::object::new(arg0),
            is_ended     : false,
            total_scores : 0,
            score_map    : 0x2::table::new<address, u64>(arg0),
            top_leaders  : v0,
            top_scores   : v1,
        };
        0x2::transfer::share_object<Leaderboard>(v3);
    }

    public fun top_leaders(arg0: &Leaderboard) : vector<address> {
        arg0.top_leaders
    }

    public fun top_scores(arg0: &Leaderboard) : vector<u64> {
        arg0.top_scores
    }

    // decompiled from Move bytecode v6
}

