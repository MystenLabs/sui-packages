module 0xf58bb0ff50678cc11e3344aff2424359485592fa9d0f401387b83509183596c4::bullet_game {
    struct AccountBook<phantom T0> has key {
        id: 0x2::object::UID,
        funds: 0x2::object_table::ObjectTable<address, Account<T0>>,
    }

    struct Account<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct GamePot<phantom T0> has key {
        id: 0x2::object::UID,
        players: vector<address>,
        bets: 0x2::object_table::ObjectTable<address, Account<T0>>,
    }

    struct BurnPot<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CreateGamePotCap has key {
        id: 0x2::object::UID,
    }

    struct PlaceBetCap has key {
        id: 0x2::object::UID,
    }

    struct DistributeBetsCap has key {
        id: 0x2::object::UID,
    }

    struct AccountCreatedEvent has copy, drop {
        account_id: 0x2::object::ID,
        owner: address,
    }

    struct BetDistributionEvent has copy, drop {
        loser: address,
        winners: vector<address>,
        amounts: vector<u64>,
        sender_fee: u64,
        burn_fee: u64,
    }

    public fun balance<T0>(arg0: &mut AccountBook<T0>, arg1: address) : u64 {
        0x2::balance::value<T0>(&0x2::object_table::borrow<address, Account<T0>>(&arg0.funds, arg1).balance)
    }

    public fun accept_deposit<T0>(arg0: &mut AccountBook<T0>, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg0.funds, arg1);
        0x2::balance::join<T0>(&mut v0.balance, 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut v0.id, arg2)));
    }

    public fun balance_burn_pot<T0>(arg0: &BurnPot<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun cancel_game_pot<T0>(arg0: &PlaceBetCap, arg1: &mut GamePot<T0>, arg2: &mut AccountBook<T0>) {
        while (!0x1::vector::is_empty<address>(&arg1.players)) {
            let v0 = 0x1::vector::pop_back<address>(&mut arg1.players);
            if (0x2::object_table::contains<address, Account<T0>>(&arg1.bets, v0)) {
                let Account {
                    id      : v1,
                    balance : v2,
                } = 0x2::object_table::remove<address, Account<T0>>(&mut arg1.bets, v0);
                0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg2.funds, v0).balance, v2);
                0x2::object::delete(v1);
            };
        };
        clear_game_pot<T0>(arg0, arg1);
    }

    public fun clear_game_pot<T0>(arg0: &PlaceBetCap, arg1: &mut GamePot<T0>) {
        assert!(0x2::object_table::is_empty<address, Account<T0>>(&arg1.bets), 2);
        while (!0x1::vector::is_empty<address>(&arg1.players)) {
            0x1::vector::pop_back<address>(&mut arg1.players);
        };
    }

    public fun clear_game_pot_with_distribute_cap<T0>(arg0: &DistributeBetsCap, arg1: &mut GamePot<T0>) {
        assert!(0x2::object_table::is_empty<address, Account<T0>>(&arg1.bets), 2);
        while (!0x1::vector::is_empty<address>(&arg1.players)) {
            0x1::vector::pop_back<address>(&mut arg1.players);
        };
    }

    public fun create_account<T0>(arg0: &mut AccountBook<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::object_table::contains<address, Account<T0>>(&arg0.funds, arg1), 3);
        let v0 = Account<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::object_table::add<address, Account<T0>>(&mut arg0.funds, arg1, v0);
        let v1 = AccountCreatedEvent{
            account_id : 0x2::object::id<Account<T0>>(&v0),
            owner      : arg1,
        };
        0x2::event::emit<AccountCreatedEvent>(v1);
    }

    public fun create_game_pot<T0>(arg0: &CreateGamePotCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GamePot<T0>{
            id      : 0x2::object::new(arg1),
            players : vector[],
            bets    : 0x2::object_table::new<address, Account<T0>>(arg1),
        };
        0x2::transfer::share_object<GamePot<T0>>(v0);
    }

    public fun delete_game_pot<T0>(arg0: &PlaceBetCap, arg1: GamePot<T0>) {
        assert!(0x2::object_table::is_empty<address, Account<T0>>(&arg1.bets), 2);
        let GamePot {
            id      : v0,
            players : v1,
            bets    : v2,
        } = arg1;
        0x1::vector::destroy_empty<address>(v1);
        0x2::object_table::destroy_empty<address, Account<T0>>(v2);
        0x2::object::delete(v0);
    }

    public fun delete_my_account<T0>(arg0: &mut AccountBook<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::balance::value<T0>(&0x2::object_table::borrow<address, Account<T0>>(&arg0.funds, v0).balance) == 0, 0);
        let Account {
            id      : v1,
            balance : v2,
        } = 0x2::object_table::remove<address, Account<T0>>(&mut arg0.funds, v0);
        0x2::balance::destroy_zero<T0>(v2);
        0x2::object::delete(v1);
    }

    public fun deposit<T0>(arg0: &mut AccountBook<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg0.funds, 0x2::tx_context::sender(arg2)).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun distribute_loser_bet<T0>(arg0: &DistributeBetsCap, arg1: &mut GamePot<T0>, arg2: &mut AccountBook<T0>, arg3: &mut BurnPot<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object_table::length<address, Account<T0>>(&arg1.bets);
        let v1 = 0x1::string::utf8(b"Number of all players:");
        0x1::debug::print<0x1::string::String>(&v1);
        0x1::debug::print<u64>(&v0);
        let v2 = v0 - 1;
        assert!(v2 != 0, 1);
        let v3 = 0x1::string::utf8(b"Number of winning players:");
        0x1::debug::print<0x1::string::String>(&v3);
        0x1::debug::print<u64>(&v2);
        let v4 = 0x2::object_table::remove<address, Account<T0>>(&mut arg1.bets, arg4);
        let v5 = &mut v4.balance;
        let v6 = 0x2::balance::value<T0>(v5);
        let v7 = v6 * 9 / 100;
        let v8 = v6 * 1 / 100;
        0x2::balance::join<T0>(&mut arg3.balance, 0x2::balance::split<T0>(v5, v8));
        let v9 = 0x2::balance::value<T0>(v5) / v2;
        let v10 = 0x1::string::utf8(b"Amount per winning player:");
        0x1::debug::print<0x1::string::String>(&v10);
        0x1::debug::print<u64>(&v9);
        let v11 = 0x1::vector::empty<address>();
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0;
        while (v13 < 0x1::vector::length<address>(&arg1.players)) {
            let v14 = *0x1::vector::borrow<address>(&arg1.players, v13);
            if (v14 != arg4) {
                let v15 = &mut 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg1.bets, v14).balance;
                0x2::balance::join<T0>(v15, 0x2::balance::split<T0>(v5, v9));
                0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg2.funds, v14).balance, 0x2::balance::withdraw_all<T0>(v15));
                let Account {
                    id      : v16,
                    balance : v17,
                } = 0x2::object_table::remove<address, Account<T0>>(&mut arg1.bets, v14);
                0x2::object::delete(v16);
                0x2::balance::destroy_zero<T0>(v17);
                0x1::vector::push_back<address>(&mut v11, v14);
                0x1::vector::push_back<u64>(&mut v12, v9);
            };
            v13 = v13 + 1;
        };
        0x2::balance::join<T0>(&mut 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg2.funds, arg4).balance, 0x2::balance::withdraw_all<T0>(v5));
        let Account {
            id      : v18,
            balance : v19,
        } = v4;
        0x2::object::delete(v18);
        0x2::balance::destroy_zero<T0>(v19);
        let v20 = BetDistributionEvent{
            loser      : arg4,
            winners    : v11,
            amounts    : v12,
            sender_fee : v7,
            burn_fee   : v8,
        };
        0x2::event::emit<BetDistributionEvent>(v20);
        clear_game_pot_with_distribute_cap<T0>(arg0, arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v5, v7), arg5)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlaceBetCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PlaceBetCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = CreateGamePotCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CreateGamePotCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = DistributeBetsCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DistributeBetsCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun intialize_share_objects<T0>(arg0: &DistributeBetsCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountBook<T0>{
            id    : 0x2::object::new(arg1),
            funds : 0x2::object_table::new<address, Account<T0>>(arg1),
        };
        0x2::transfer::share_object<AccountBook<T0>>(v0);
        let v1 = BurnPot<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<BurnPot<T0>>(v1);
    }

    fun place_bet_single<T0>(arg0: &PlaceBetCap, arg1: &mut GamePot<T0>, arg2: &mut AccountBook<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg2.funds, arg3);
        assert!(0x2::balance::value<T0>(&v0.balance) >= arg4, 0);
        let v1 = Account<T0>{
            id      : 0x2::object::new(arg5),
            balance : 0x2::balance::split<T0>(&mut v0.balance, arg4),
        };
        0x2::object_table::add<address, Account<T0>>(&mut arg1.bets, arg3, v1);
    }

    public fun place_bets<T0>(arg0: &PlaceBetCap, arg1: &mut GamePot<T0>, arg2: &mut AccountBook<T0>, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            place_bet_single<T0>(arg0, arg1, arg2, *0x1::vector::borrow<address>(&arg3, v0), *0x1::vector::borrow<u64>(&arg4, v0), arg5);
            v0 = v0 + 1;
        };
        arg1.players = arg3;
    }

    public fun read_bet_amount<T0>(arg0: &GamePot<T0>, arg1: address) : u64 {
        if (0x2::object_table::contains<address, Account<T0>>(&arg0.bets, arg1)) {
            0x2::balance::value<T0>(&0x2::object_table::borrow<address, Account<T0>>(&arg0.bets, arg1).balance)
        } else {
            0
        }
    }

    public fun withdraw<T0>(arg0: &mut AccountBook<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::object_table::borrow_mut<address, Account<T0>>(&mut arg0.funds, 0x2::tx_context::sender(arg2));
        assert!(0x2::balance::value<T0>(&v0.balance) >= arg1, 0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

