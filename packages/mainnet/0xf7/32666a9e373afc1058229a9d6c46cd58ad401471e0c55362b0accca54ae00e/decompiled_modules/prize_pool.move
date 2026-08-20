module 0xf732666a9e373afc1058229a9d6c46cd58ad401471e0c55362b0accca54ae00e::prize_pool {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct PrizePool has key {
        id: 0x2::object::UID,
        unreserved_balances: 0x2::bag::Bag,
        draw_count: u64,
        registered_prize_count: u64,
        claimed_prize_count: u64,
    }

    struct TokenKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DrawKey has copy, drop, store {
        draw_id: vector<u8>,
    }

    struct PrizeKey has copy, drop, store {
        draw_id: vector<u8>,
    }

    struct DrawOutcome has store {
        ledger_commitment: vector<u8>,
        winning_ticket: u64,
        total_tickets: u64,
        winner_registered: bool,
    }

    struct WinnerPrize<phantom T0> has store {
        winner: address,
        balance: 0x2::balance::Balance<T0>,
    }

    struct DrawExecuted has copy, drop {
        draw_id: vector<u8>,
        ledger_commitment: vector<u8>,
        winning_ticket: u64,
        total_tickets: u64,
    }

    struct PrizeDeposited<phantom T0> has copy, drop {
        amount: u64,
    }

    struct WinnerRegistered<phantom T0> has copy, drop {
        draw_id: vector<u8>,
        winner: address,
        amount: u64,
    }

    struct PrizeClaimed<phantom T0> has copy, drop {
        draw_id: vector<u8>,
        winner: address,
        amount: u64,
    }

    struct UnreservedPrizeWithdrawn<phantom T0> has copy, drop {
        amount: u64,
    }

    fun assert_valid_draw_id(arg0: &vector<u8>) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= 96, 0);
    }

    entry fun claim<T0>(arg0: &mut PrizePool, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_draw_id(&arg1);
        let v0 = PrizeKey{draw_id: arg1};
        assert!(0x2::dynamic_field::exists_with_type<PrizeKey, WinnerPrize<T0>>(&arg0.id, v0), 7);
        let WinnerPrize {
            winner  : v1,
            balance : v2,
        } = 0x2::dynamic_field::remove<PrizeKey, WinnerPrize<T0>>(&mut arg0.id, v0);
        let v3 = v2;
        assert!(v1 == 0x2::tx_context::sender(arg2), 8);
        arg0.claimed_prize_count = arg0.claimed_prize_count + 1;
        let v4 = PrizeClaimed<T0>{
            draw_id : arg1,
            winner  : v1,
            amount  : 0x2::balance::value<T0>(&v3),
        };
        0x2::event::emit<PrizeClaimed<T0>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg2), v1);
    }

    public fun claimable_prize<T0>(arg0: &PrizePool, arg1: vector<u8>) : (address, u64) {
        let v0 = PrizeKey{draw_id: arg1};
        assert!(0x2::dynamic_field::exists_with_type<PrizeKey, WinnerPrize<T0>>(&arg0.id, v0), 7);
        let v1 = 0x2::dynamic_field::borrow<PrizeKey, WinnerPrize<T0>>(&arg0.id, v0);
        (v1.winner, 0x2::balance::value<T0>(&v1.balance))
    }

    public fun claimed_prize_count(arg0: &PrizePool) : u64 {
        arg0.claimed_prize_count
    }

    public fun deposit<T0>(arg0: &mut PrizePool, arg1: 0x2::coin::Coin<T0>) {
        let v0 = TokenKey<T0>{dummy_field: false};
        if (0x2::bag::contains<TokenKey<T0>>(&arg0.unreserved_balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.unreserved_balances, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::bag::add<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.unreserved_balances, v0, 0x2::coin::into_balance<T0>(arg1));
        };
        let v1 = PrizeDeposited<T0>{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<PrizeDeposited<T0>>(v1);
    }

    public fun draw_count(arg0: &PrizePool) : u64 {
        arg0.draw_count
    }

    public fun draw_result(arg0: &PrizePool, arg1: vector<u8>) : (vector<u8>, u64, u64, bool) {
        let v0 = DrawKey{draw_id: arg1};
        assert!(0x2::dynamic_field::exists<DrawKey>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow<DrawKey, DrawOutcome>(&arg0.id, v0);
        (v1.ledger_commitment, v1.winning_ticket, v1.total_tickets, v1.winner_registered)
    }

    entry fun execute_draw(arg0: &mut PrizePool, arg1: &OperatorCap, arg2: &0x2::random::Random, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_draw_id(&arg3);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 9);
        assert!(arg5 > 0, 1);
        let v0 = DrawKey{draw_id: arg3};
        assert!(!0x2::dynamic_field::exists<DrawKey>(&arg0.id, v0), 2);
        let v1 = 0x2::random::new_generator(arg2, arg6);
        let v2 = 0x2::random::generate_u64_in_range(&mut v1, 0, arg5 - 1);
        let v3 = DrawOutcome{
            ledger_commitment : arg4,
            winning_ticket    : v2,
            total_tickets     : arg5,
            winner_registered : false,
        };
        0x2::dynamic_field::add<DrawKey, DrawOutcome>(&mut arg0.id, v0, v3);
        arg0.draw_count = arg0.draw_count + 1;
        let v4 = DrawExecuted{
            draw_id           : arg3,
            ledger_commitment : arg4,
            winning_ticket    : v2,
            total_tickets     : arg5,
        };
        0x2::event::emit<DrawExecuted>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrizePool{
            id                     : 0x2::object::new(arg0),
            unreserved_balances    : 0x2::bag::new(arg0),
            draw_count             : 0,
            registered_prize_count : 0,
            claimed_prize_count    : 0,
        };
        0x2::transfer::share_object<PrizePool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun register_winner<T0>(arg0: &mut PrizePool, arg1: &OperatorCap, arg2: vector<u8>, arg3: address, arg4: u64) {
        assert_valid_draw_id(&arg2);
        assert!(arg4 > 0, 5);
        let v0 = DrawKey{draw_id: arg2};
        assert!(0x2::dynamic_field::exists<DrawKey>(&arg0.id, v0), 3);
        let v1 = 0x2::dynamic_field::borrow_mut<DrawKey, DrawOutcome>(&mut arg0.id, v0);
        assert!(!v1.winner_registered, 4);
        let v2 = TokenKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains_with_type<TokenKey<T0>, 0x2::balance::Balance<T0>>(&arg0.unreserved_balances, v2), 6);
        let v3 = 0x2::bag::borrow_mut<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.unreserved_balances, v2);
        assert!(0x2::balance::value<T0>(v3) >= arg4, 6);
        v1.winner_registered = true;
        let v4 = PrizeKey{draw_id: arg2};
        let v5 = WinnerPrize<T0>{
            winner  : arg3,
            balance : 0x2::balance::split<T0>(v3, arg4),
        };
        0x2::dynamic_field::add<PrizeKey, WinnerPrize<T0>>(&mut arg0.id, v4, v5);
        arg0.registered_prize_count = arg0.registered_prize_count + 1;
        let v6 = WinnerRegistered<T0>{
            draw_id : arg2,
            winner  : arg3,
            amount  : arg4,
        };
        0x2::event::emit<WinnerRegistered<T0>>(v6);
    }

    public fun registered_prize_count(arg0: &PrizePool) : u64 {
        arg0.registered_prize_count
    }

    public fun unreserved_balance<T0>(arg0: &PrizePool) : u64 {
        let v0 = TokenKey<T0>{dummy_field: false};
        if (0x2::bag::contains_with_type<TokenKey<T0>, 0x2::balance::Balance<T0>>(&arg0.unreserved_balances, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<TokenKey<T0>, 0x2::balance::Balance<T0>>(&arg0.unreserved_balances, v0))
        } else {
            0
        }
    }

    public fun withdraw_unreserved<T0>(arg0: &mut PrizePool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 5);
        let v0 = TokenKey<T0>{dummy_field: false};
        assert!(0x2::bag::contains_with_type<TokenKey<T0>, 0x2::balance::Balance<T0>>(&arg0.unreserved_balances, v0), 6);
        let v1 = 0x2::bag::borrow_mut<TokenKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.unreserved_balances, v0);
        assert!(0x2::balance::value<T0>(v1) >= arg2, 6);
        let v2 = UnreservedPrizeWithdrawn<T0>{amount: arg2};
        0x2::event::emit<UnreservedPrizeWithdrawn<T0>>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

