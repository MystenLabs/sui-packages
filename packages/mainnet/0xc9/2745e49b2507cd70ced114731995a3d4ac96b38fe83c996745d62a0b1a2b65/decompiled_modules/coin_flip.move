module 0xc92745e49b2507cd70ced114731995a3d4ac96b38fe83c996745d62a0b1a2b65::coin_flip {
    struct FlipResult has copy, drop {
        player: address,
        bet_amount: u64,
        won: bool,
        payout: u64,
        is_heads: bool,
        fee_amount: u64,
    }

    struct HouseFunded has copy, drop {
        funder: address,
        amount: u64,
        new_balance: u64,
    }

    struct HouseWithdrawal has copy, drop {
        amount: u64,
        remaining_balance: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct House has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        total_bets: u64,
        total_won: u64,
        total_lost: u64,
        total_fees_collected: u64,
        fee_bps: u64,
    }

    struct HouseAdminCap has store, key {
        id: 0x2::object::UID,
        house_id: 0x2::object::ID,
    }

    public fun admin_cap_house_id(arg0: &HouseAdminCap) : 0x2::object::ID {
        arg0.house_id
    }

    public fun fee_bps(arg0: &House) : u64 {
        arg0.fee_bps
    }

    entry fun flip(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 >= 1000000, 1);
        assert!(v0 <= v1 * 5 / 100, 2);
        assert!(v1 >= v0 * 19600 / 10000 - v0, 0);
        let v2 = v0 * arg0.fee_bps / 10000;
        let v3 = 0x2::random::new_generator(arg3, arg4);
        let v4 = 0x2::random::generate_bool(&mut v3);
        let v5 = 0x2::tx_context::sender(arg4);
        arg0.total_bets = arg0.total_bets + 1;
        arg0.total_fees_collected = arg0.total_fees_collected + v2;
        if (v4 == arg2) {
            let v6 = (v0 - v2) * 19600 / 10000;
            0x2::coin::join<0x2::sui::SUI>(&mut arg1, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v6 - v0, arg4));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v2, arg4)));
            arg0.total_won = arg0.total_won + 1;
            let v7 = FlipResult{
                player     : v5,
                bet_amount : v0,
                won        : true,
                payout     : v6,
                is_heads   : v4,
                fee_amount : v2,
            };
            0x2::event::emit<FlipResult>(v7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v5);
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            arg0.total_lost = arg0.total_lost + 1;
            let v8 = FlipResult{
                player     : v5,
                bet_amount : v0,
                won        : false,
                payout     : 0,
                is_heads   : v4,
                fee_amount : v2,
            };
            0x2::event::emit<FlipResult>(v8);
        };
    }

    public fun fund_house(arg0: &mut House, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = HouseFunded{
            funder      : 0x2::tx_context::sender(arg2),
            amount      : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            new_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseFunded>(v0);
    }

    public fun house_balance(arg0: &House) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun house_edge_bps() : u64 {
        200
    }

    public fun house_owner(arg0: &House) : address {
        arg0.owner
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = House{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            owner                : 0x2::tx_context::sender(arg0),
            total_bets           : 0,
            total_won            : 0,
            total_lost           : 0,
            total_fees_collected : 0,
            fee_bps              : 100,
        };
        let v1 = HouseAdminCap{
            id       : 0x2::object::new(arg0),
            house_id : 0x2::object::id<House>(&v0),
        };
        0x2::transfer::share_object<House>(v0);
        0x2::transfer::transfer<HouseAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_bet(arg0: &House) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance) * 5 / 100
    }

    public fun max_bet_percent() : u64 {
        5
    }

    public fun min_bet() : u64 {
        1000000
    }

    public fun payout_bps() : u64 {
        19600
    }

    public fun set_fee(arg0: &mut House, arg1: &HouseAdminCap, arg2: u64) {
        assert!(arg2 <= 1000, 4);
        arg0.fee_bps = arg2;
        let v0 = FeeUpdated{
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg2,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun stats(arg0: &House) : (u64, u64, u64) {
        (arg0.total_bets, arg0.total_won, arg0.total_lost)
    }

    public fun total_fees_collected(arg0: &House) : u64 {
        arg0.total_fees_collected
    }

    public fun withdraw(arg0: &mut House, arg1: &HouseAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0);
        let v0 = HouseWithdrawal{
            amount            : arg2,
            remaining_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.balance),
        };
        0x2::event::emit<HouseWithdrawal>(v0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

