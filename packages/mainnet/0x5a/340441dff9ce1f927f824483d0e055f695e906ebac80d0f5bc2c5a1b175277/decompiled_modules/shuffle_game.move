module 0x5a340441dff9ce1f927f824483d0e055f695e906ebac80d0f5bc2c5a1b175277::shuffle_game {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ShuffleRoom has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        capacity: u64,
        time_period_ms: u64,
        min_time_period_ms: u64,
        min_bid_amount: u64,
        max_bid_amount: u64,
        commission_percent: u64,
        is_unlimited_room: bool,
        started_at_ms: u64,
        counter_start_at_ms: u64,
        bids: vector<ShuffleBid>,
        state: u64,
        previousWinner: address,
        previousWinAmount: u256,
        previousBidValue: u256,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        shuffleNo: u64,
        valid: bool,
        history: vector<ShuffleDrawn>,
        totalCollection: u256,
        totalDistribution: u256,
        fundsWallet: address,
    }

    struct ShuffleBid has drop, store {
        bidder: address,
        amount: u256,
    }

    struct ShuffleDrawn has copy, drop, store {
        roomId: 0x2::object::ID,
        gameNo: u64,
        winner: address,
        totalBid: u256,
        winnerAmount: u256,
        time_period_ms: u64,
    }

    struct ShuffleStart has copy, drop {
        room_id: 0x2::object::ID,
        time_period_ms: u64,
    }

    public entry fun createRoom(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: u64, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 >= 0 && arg4 <= 100, 9);
        let v0 = ShuffleRoom{
            id                  : 0x2::object::new(arg9),
            name                : 0x1::string::utf8(arg1),
            capacity            : arg6,
            time_period_ms      : arg7,
            min_time_period_ms  : arg7,
            min_bid_amount      : arg2,
            max_bid_amount      : arg3,
            commission_percent  : arg4,
            is_unlimited_room   : arg5,
            started_at_ms       : 0,
            counter_start_at_ms : 0,
            bids                : 0x1::vector::empty<ShuffleBid>(),
            state               : 0,
            previousWinner      : 0x2::tx_context::sender(arg9),
            previousWinAmount   : 0,
            previousBidValue    : 0,
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            shuffleNo           : 0,
            valid               : true,
            history             : 0x1::vector::empty<ShuffleDrawn>(),
            totalCollection     : 0,
            totalDistribution   : 0,
            fundsWallet         : arg8,
        };
        0x2::transfer::share_object<ShuffleRoom>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun modifyRoom(arg0: &AdminCap, arg1: &mut ShuffleRoom, arg2: bool, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.valid = arg2;
        arg1.fundsWallet = arg4;
        arg1.commission_percent = arg3;
    }

    public entry fun placeBid(arg0: &mut ShuffleRoom, arg1: u64, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.valid, 6);
        if (arg0.state == 1) {
            assert!(0x2::clock::timestamp_ms(arg2) <= arg0.counter_start_at_ms + arg0.time_period_ms, 4);
            assert!(arg0.shuffleNo == arg1, 5);
        };
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) > 0, 7);
        let v0 = 0x1::vector::length<ShuffleBid>(&arg0.bids);
        let v1 = (0x2::coin::value<0x2::sui::SUI>(&arg3) as u256);
        let v2 = 0;
        let v3 = false;
        while (v2 < v0) {
            if (0x1::vector::borrow<ShuffleBid>(&arg0.bids, v2).bidder == 0x2::tx_context::sender(arg4)) {
                v3 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (v3) {
            let v4 = 0x1::vector::borrow_mut<ShuffleBid>(&mut arg0.bids, v2);
            assert!(v4.amount + v1 <= (arg0.max_bid_amount as u256), 10);
            v4.amount = v4.amount + v1;
        } else {
            assert!(v0 < arg0.capacity, 3);
            assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg3)) >= arg0.min_bid_amount, 2);
            assert!(0x2::balance::value<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(&arg3)) <= arg0.max_bid_amount, 10);
            let v5 = ShuffleBid{
                bidder : 0x2::tx_context::sender(arg4),
                amount : v1,
            };
            0x1::vector::push_back<ShuffleBid>(&mut arg0.bids, v5);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v6 = 0x1::vector::length<ShuffleBid>(&arg0.bids);
        if (v6 == 1) {
            arg0.started_at_ms = 0x2::clock::timestamp_ms(arg2);
            arg0.state = 8;
            let v7 = ShuffleStart{
                room_id        : 0x2::object::uid_to_inner(&arg0.id),
                time_period_ms : arg0.time_period_ms,
            };
            0x2::event::emit<ShuffleStart>(v7);
        } else if (v6 == 2) {
            arg0.state = 1;
            arg0.counter_start_at_ms = 0x2::clock::timestamp_ms(arg2);
            let v8 = ShuffleStart{
                room_id        : 0x2::object::uid_to_inner(&arg0.id),
                time_period_ms : arg0.time_period_ms,
            };
            0x2::event::emit<ShuffleStart>(v8);
        } else {
            arg0.time_period_ms = arg0.time_period_ms + 5000;
        };
    }

    public entry fun selectWinner(arg0: &AdminCap, arg1: &0x2::clock::Clock, arg2: u64, arg3: &mut ShuffleRoom, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.valid, 6);
        assert!(arg3.state == 1, 0);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 > arg3.counter_start_at_ms + arg3.time_period_ms, 1);
        let v1 = 0x1::vector::borrow<ShuffleBid>(&arg3.bids, arg2);
        let v2 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg3.balance);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&v2);
        let v4 = 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg4);
        let v5 = if (arg3.is_unlimited_room) {
            if (v3 <= 30000000000) {
                v3 * 8 / 100
            } else if (v3 <= 150000000000) {
                v3 * 5 / 100
            } else {
                v3 * 3 / 100
            }
        } else {
            v3 * arg3.commission_percent / 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, v1.bidder);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v4, v5, arg4), arg3.fundsWallet);
        arg3.previousWinner = v1.bidder;
        arg3.previousWinAmount = ((v3 - v5) as u256);
        arg3.previousBidValue = (v3 as u256);
        arg3.state = 0;
        arg3.shuffleNo = arg3.shuffleNo + 1;
        arg3.totalCollection = arg3.totalCollection + arg3.previousBidValue;
        arg3.totalDistribution = arg3.totalDistribution + arg3.previousWinAmount;
        arg3.time_period_ms = arg3.min_time_period_ms;
        while (!0x1::vector::is_empty<ShuffleBid>(&arg3.bids)) {
            0x1::vector::pop_back<ShuffleBid>(&mut arg3.bids);
        };
        let v6 = ShuffleDrawn{
            roomId         : 0x2::object::uid_to_inner(&arg3.id),
            gameNo         : arg3.shuffleNo,
            winner         : arg3.previousWinner,
            totalBid       : arg3.previousBidValue,
            winnerAmount   : arg3.previousWinAmount,
            time_period_ms : v0,
        };
        if (0x1::vector::length<ShuffleDrawn>(&arg3.history) == 20) {
            0x1::vector::remove<ShuffleDrawn>(&mut arg3.history, 0);
        };
        0x1::vector::push_back<ShuffleDrawn>(&mut arg3.history, v6);
        0x2::event::emit<ShuffleDrawn>(v6);
    }

    // decompiled from Move bytecode v6
}

