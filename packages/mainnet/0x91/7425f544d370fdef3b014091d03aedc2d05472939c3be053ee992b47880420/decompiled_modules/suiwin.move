module 0x917425f544d370fdef3b014091d03aedc2d05472939c3be053ee992b47880420::suiwin {
    struct GameData has key {
        id: 0x2::object::UID,
        balance_data: 0x2::balance::Balance<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>,
        awardWinner: address,
        grandPrizeAndNext: u64,
        dividend: u64,
        bookmakerFee: u64,
        unitPrice: u64,
        rounds: u64,
        countdown: u64,
        total: u64,
        initprice: u64,
    }

    struct GamePlayerAndDiv has store, key {
        id: 0x2::object::UID,
        data: 0x2::table::Table<address, u64>,
        unitprice: u64,
        balance_div: 0x2::balance::Balance<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>,
    }

    struct Outcome has copy, drop {
        balance_data: u64,
        awardWinner: address,
        grandPrizeAndNext: u64,
        dividend: u64,
        bookmakerFee: u64,
        unitPrice: u64,
        rounds: u64,
        countdown: u64,
        nowtime: u64,
        total: u64,
        volcoin: u64,
        share: u8,
    }

    struct OutcomePrize has copy, drop {
        gamenumber: u8,
        addr: address,
        prize: u64,
        share: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun Claim_Div(arg0: address, arg1: &mut GameData, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, GamePlayerAndDiv>(&mut arg1.id, arg2);
        Claim_Dividend(arg0, v0, arg3);
    }

    fun Claim_Dividend(arg0: address, arg1: &mut GamePlayerAndDiv, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, u64>(&arg1.data, arg0), 2);
        assert!(arg1.unitprice > 0, 3);
        if (0x2::table::length<address, u64>(&arg1.data) > 1) {
            let v0 = 0x2::table::remove<address, u64>(&mut arg1.data, arg0);
            let v1 = arg1.unitprice * v0;
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>>(0x2::coin::take<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg1.balance_div, v1, arg2), arg0);
            let v2 = OutcomePrize{
                gamenumber : 2,
                addr       : arg0,
                prize      : v1,
                share      : v0,
            };
            0x2::event::emit<OutcomePrize>(v2);
        } else {
            let v3 = 0x2::balance::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg1.balance_div);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>>(0x2::coin::take<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg1.balance_div, v3, arg2), arg0);
            let v4 = OutcomePrize{
                gamenumber : 2,
                addr       : arg0,
                prize      : v3,
                share      : 0x2::table::remove<address, u64>(&mut arg1.data, arg0),
            };
            0x2::event::emit<OutcomePrize>(v4);
        };
    }

    entry fun Claim_GP(arg0: &mut GameData, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(arg0.countdown <= v0, 0);
        let v1 = arg0.grandPrizeAndNext / 68 * 55;
        let v2 = arg0.awardWinner;
        let v3 = GamePlayerAndDiv{
            id          : 0x2::object::new(arg2),
            data        : 0x2::table::new<address, u64>(arg2),
            unitprice   : 0,
            balance_div : 0x2::balance::zero<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(),
        };
        if (arg0.dividend > 0) {
            let v4 = 0x2::coin::take<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg0.dividend, arg2);
            arg0.dividend = 0;
            let v5 = 0x2::dynamic_object_field::borrow_mut<u64, GamePlayerAndDiv>(&mut arg0.id, arg0.rounds);
            Claim_GrandPrize(v5, 0x2::coin::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&v4) / arg0.total, v4);
        };
        arg0.awardWinner = @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44;
        arg0.bookmakerFee = 0;
        arg0.grandPrizeAndNext = arg0.grandPrizeAndNext - v1;
        arg0.rounds = arg0.rounds + 1;
        0x2::dynamic_object_field::add<u64, GamePlayerAndDiv>(&mut arg0.id, arg0.rounds, v3);
        arg0.total = 0;
        arg0.unitPrice = arg0.initprice;
        arg0.countdown = v0 + 86400000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>>(0x2::coin::take<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg0.bookmakerFee, arg2), @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>>(0x2::coin::take<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, v1, arg2), v2);
        let v6 = Outcome{
            balance_data      : 0x2::balance::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg0.balance_data),
            awardWinner       : @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44,
            grandPrizeAndNext : arg0.grandPrizeAndNext,
            dividend          : arg0.dividend,
            bookmakerFee      : arg0.bookmakerFee,
            unitPrice         : arg0.unitPrice,
            rounds            : arg0.rounds,
            countdown         : arg0.countdown,
            nowtime           : v0,
            total             : arg0.total,
            volcoin           : 0,
            share             : 0,
        };
        0x2::event::emit<Outcome>(v6);
        let v7 = OutcomePrize{
            gamenumber : 0,
            addr       : v2,
            prize      : v1,
            share      : 0,
        };
        0x2::event::emit<OutcomePrize>(v7);
    }

    fun Claim_GrandPrize(arg0: &mut GamePlayerAndDiv, arg1: u64, arg2: 0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>) {
        arg0.unitprice = arg1;
        0x2::coin::put<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_div, arg2);
    }

    entry fun Play_game_1(arg0: &mut GameData, arg1: 0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.countdown > v0, 0);
        assert!(1736955000000 < v0, 0);
        let v1 = 0x2::coin::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg1);
        assert!(v1 >= arg0.unitPrice, 1);
        let v2 = v1 * 1005 / 1000;
        let v3 = v0 + 180000;
        let (v4, v5, _, v7) = allocate_funds(v1);
        0x2::coin::put<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg1);
        arg0.unitPrice = v2;
        arg0.awardWinner = 0x2::tx_context::sender(arg3);
        arg0.grandPrizeAndNext = arg0.grandPrizeAndNext + v4;
        arg0.dividend = arg0.dividend + v5;
        arg0.bookmakerFee = arg0.bookmakerFee + v7;
        arg0.total = arg0.total + 1;
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, GamePlayerAndDiv>(&mut arg0.id, arg0.rounds);
        add_shares(v8, 1, 0x2::tx_context::sender(arg3));
        if (v3 > arg0.countdown) {
            arg0.countdown = v3;
        };
        let v9 = Outcome{
            balance_data      : 0x2::balance::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg0.balance_data),
            awardWinner       : 0x2::tx_context::sender(arg3),
            grandPrizeAndNext : arg0.grandPrizeAndNext,
            dividend          : arg0.dividend,
            bookmakerFee      : arg0.bookmakerFee,
            unitPrice         : v2,
            rounds            : arg0.rounds,
            countdown         : arg0.countdown,
            nowtime           : v0,
            total             : arg0.total,
            volcoin           : v1,
            share             : 1,
        };
        0x2::event::emit<Outcome>(v9);
    }

    entry fun Play_game_10(arg0: &mut GameData, arg1: 0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.countdown > v0, 0);
        assert!(1736955000000 < v0, 0);
        let v1 = 0x2::coin::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg1);
        let (v2, v3) = calc_Price(arg0.unitPrice, 10, arg3);
        let (v4, v5, _, v7) = allocate_funds(v1);
        assert!(v1 >= v2, 1);
        0x2::coin::put<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg1);
        arg0.unitPrice = v3;
        arg0.awardWinner = 0x2::tx_context::sender(arg3);
        arg0.grandPrizeAndNext = arg0.grandPrizeAndNext + v4;
        arg0.dividend = arg0.dividend + v5;
        arg0.bookmakerFee = arg0.bookmakerFee + v7;
        arg0.total = arg0.total + 10;
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, GamePlayerAndDiv>(&mut arg0.id, arg0.rounds);
        add_shares(v8, 10, 0x2::tx_context::sender(arg3));
        let v9 = v0 + 180000;
        if (v9 > arg0.countdown) {
            arg0.countdown = v9;
        };
        let v10 = Outcome{
            balance_data      : 0x2::balance::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg0.balance_data),
            awardWinner       : 0x2::tx_context::sender(arg3),
            grandPrizeAndNext : arg0.grandPrizeAndNext,
            dividend          : arg0.dividend,
            bookmakerFee      : arg0.bookmakerFee,
            unitPrice         : v3,
            rounds            : arg0.rounds,
            countdown         : arg0.countdown,
            nowtime           : v0,
            total             : arg0.total,
            volcoin           : v1,
            share             : 10,
        };
        0x2::event::emit<Outcome>(v10);
    }

    entry fun Play_game_5(arg0: &mut GameData, arg1: 0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.countdown > v0, 0);
        assert!(1736955000000 < v0, 0);
        let v1 = 0x2::coin::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg1);
        let (v2, v3) = calc_Price(arg0.unitPrice, 5, arg3);
        let (v4, v5, _, v7) = allocate_funds(v1);
        assert!(v1 >= v2, 1);
        0x2::coin::put<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg1);
        arg0.unitPrice = v3;
        arg0.awardWinner = 0x2::tx_context::sender(arg3);
        arg0.grandPrizeAndNext = arg0.grandPrizeAndNext + v4;
        arg0.dividend = arg0.dividend + v5;
        arg0.bookmakerFee = arg0.bookmakerFee + v7;
        arg0.total = arg0.total + 5;
        let v8 = 0x2::dynamic_object_field::borrow_mut<u64, GamePlayerAndDiv>(&mut arg0.id, arg0.rounds);
        add_shares(v8, 5, 0x2::tx_context::sender(arg3));
        let v9 = v0 + 180000;
        if (v9 > arg0.countdown) {
            arg0.countdown = v9;
        };
        let v10 = Outcome{
            balance_data      : 0x2::balance::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg0.balance_data),
            awardWinner       : 0x2::tx_context::sender(arg3),
            grandPrizeAndNext : arg0.grandPrizeAndNext,
            dividend          : arg0.dividend,
            bookmakerFee      : arg0.bookmakerFee,
            unitPrice         : v3,
            rounds            : arg0.rounds,
            countdown         : arg0.countdown,
            nowtime           : v0,
            total             : arg0.total,
            volcoin           : v1,
            share             : 5,
        };
        0x2::event::emit<Outcome>(v10);
    }

    entry fun ReviseInitprice(arg0: &mut GameData, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44, 2);
        assert!(arg0.total == 0, 3);
        arg0.initprice = arg1;
    }

    fun add_shares(arg0: &mut GamePlayerAndDiv, arg1: u64, arg2: address) {
        if (0x2::table::contains<address, u64>(&arg0.data, arg2)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.data, arg2) = *0x2::table::borrow<address, u64>(&arg0.data, arg2) + arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.data, arg2, arg1);
        };
    }

    fun allocate_funds(arg0: u64) : (u64, u64, u64, u64) {
        let v0 = arg0 / 100;
        let v1 = v0 * 30;
        let v2 = v0 * 68;
        (v2, v1, v0, arg0 - v1 - v2)
    }

    fun calc_Price(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg0;
        while (v0 < arg1) {
            v1 = v1 + v2;
            let v3 = v2 * 1005;
            v2 = v3 / 1000;
            v0 = v0 + 1;
        };
        (v1, v2)
    }

    entry fun delete_GPAD(arg0: &mut GameData, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44, 2);
        delete_GamePlayerAndDiv(0x2::dynamic_object_field::remove<u64, GamePlayerAndDiv>(&mut arg0.id, arg1));
    }

    fun delete_GamePlayerAndDiv(arg0: GamePlayerAndDiv) {
        assert!(0x2::table::length<address, u64>(&arg0.data) == 0, 2);
        let GamePlayerAndDiv {
            id          : v0,
            data        : v1,
            unitprice   : _,
            balance_div : v3,
        } = arg0;
        0x2::balance::destroy_zero<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(v3);
        0x2::table::destroy_empty<address, u64>(v1);
        0x2::object::delete(v0);
    }

    entry fun get_GPAD(arg0: address, arg1: &mut GameData, arg2: u64) : (u64, u64) {
        get_GamePlayerAndDiv(arg0, 0x2::dynamic_object_field::borrow<u64, GamePlayerAndDiv>(&arg1.id, arg2))
    }

    fun get_GamePlayerAndDiv(arg0: address, arg1: &GamePlayerAndDiv) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        if (0x2::table::contains<address, u64>(&arg1.data, arg0)) {
            let v2 = *0x2::table::borrow<address, u64>(&arg1.data, arg0);
            v0 = v2;
            v1 = arg1.unitprice * v2;
        };
        (v0, v1)
    }

    public fun get_calc_Price(arg0: u64, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < arg1) {
            v1 = v1 + arg0;
            let v2 = arg0 * 1005;
            arg0 = v2 / 1000;
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameData{
            id                : 0x2::object::new(arg0),
            balance_data      : 0x2::balance::zero<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(),
            awardWinner       : @0x82242fabebc3e6e331c3d5c6de3d34ff965671b75154ec1cb9e00aa437bbfa44,
            grandPrizeAndNext : 0,
            dividend          : 0,
            bookmakerFee      : 0,
            unitPrice         : 10000000000000,
            rounds            : 1,
            countdown         : 0,
            total             : 0,
            initprice         : 10000000000000,
        };
        let v2 = GamePlayerAndDiv{
            id          : 0x2::object::new(arg0),
            data        : 0x2::table::new<address, u64>(arg0),
            unitprice   : 0,
            balance_div : 0x2::balance::zero<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(),
        };
        0x2::dynamic_object_field::add<u64, GamePlayerAndDiv>(&mut v1.id, 1, v2);
        0x2::transfer::share_object<GameData>(v1);
    }

    entry fun start(arg0: AdminCap, arg1: &mut GameData, arg2: &0x2::clock::Clock) {
        arg1.countdown = 1736955000000 + 86400000;
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun up_sui(arg0: &mut GameData, arg1: 0x2::coin::Coin<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>) {
        0x2::coin::put<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&mut arg0.balance_data, arg1);
        arg0.grandPrizeAndNext = arg0.grandPrizeAndNext + 0x2::coin::value<0xb028311061b63b44056362db2f3ccae5a9c4e221aa7d092bc07fe83bb7f7344f::swg::SWG>(&arg1);
    }

    // decompiled from Move bytecode v6
}

