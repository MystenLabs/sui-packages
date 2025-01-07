module 0x61484c9f7e2d8a2feedba08f3c91094d09c4f95b2cab73bf6a5510084c2e7bbd::prediction {
    struct Rounds has key {
        id: 0x2::object::UID,
        rounds: vector<Round>,
    }

    struct Round has store {
        epoch: u64,
        lockTimestamp: u64,
        closeTimestamp: u64,
        lockPrice: u128,
        closePrice: u128,
        totalAmount: 0x2::balance::Balance<0x2::sui::SUI>,
        upAmount: u64,
        downAmount: u64,
        upaddress: 0x2::table::Table<address, u64>,
        downaddress: 0x2::table::Table<address, u64>,
        upamount: u64,
        downamount: u64,
        oracleCalled: bool,
        upordown: bool,
    }

    struct BetInfo has store {
        amount: u128,
        claimed: bool,
    }

    struct Epoch has store, key {
        id: 0x2::object::UID,
        currentEpoch: u64,
    }

    public entry fun betDown(arg0: &mut Rounds, arg1: &mut Epoch, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg3);
        assert!(arg3 == arg1.currentEpoch + 1, 0);
        assert!(v0.epoch == arg1.currentEpoch + 1, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.totalAmount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v2.downAmount = v2.downAmount + v1;
        v2.downamount = v2.downamount + 1;
        0x2::table::add<address, u64>(&mut v2.downaddress, 0x2::tx_context::sender(arg4), v1);
    }

    public entry fun betUp(arg0: &mut Rounds, arg1: &mut Epoch, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg3);
        assert!(arg3 == arg1.currentEpoch + 1, 0);
        assert!(v0.epoch == arg1.currentEpoch + 1, 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v2.totalAmount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v2.upAmount = v2.upAmount + v1;
        v2.upamount = v2.upamount + 1;
        0x2::table::add<address, u64>(&mut v2.upaddress, 0x2::tx_context::sender(arg4), v1);
    }

    public entry fun claim(arg0: &mut Rounds, arg1: u64, arg2: &mut Epoch, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        assert!(v0.oracleCalled, 0);
        if (v0.upordown) {
            let v1 = &mut v0.totalAmount;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v1, *0x2::table::borrow<address, u64>(&v0.upaddress, 0x2::tx_context::sender(arg3)) / v0.upamount * 0x2::balance::value<0x2::sui::SUI>(v1), arg3), 0x2::tx_context::sender(arg3));
            if (0x2::table::contains<address, u64>(&v0.upaddress, 0x2::tx_context::sender(arg3))) {
                0x2::table::remove<address, u64>(&mut v0.upaddress, 0x2::tx_context::sender(arg3));
            };
        } else {
            let v2 = &mut v0.totalAmount;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, *0x2::table::borrow<address, u64>(&v0.downaddress, 0x2::tx_context::sender(arg3)) / v0.downamount * 0x2::balance::value<0x2::sui::SUI>(v2), arg3), 0x2::tx_context::sender(arg3));
            if (0x2::table::contains<address, u64>(&v0.downaddress, 0x2::tx_context::sender(arg3))) {
                0x2::table::remove<address, u64>(&mut v0.downaddress, 0x2::tx_context::sender(arg3));
            };
        };
    }

    public entry fun executeRound(arg0: &mut Rounds, arg1: u64, arg2: &mut Epoch, arg3: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == arg2.currentEpoch, 0);
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        let (v1, _, _, _) = 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::get_price(arg3, 90);
        assert!(v1 > 0, 0);
        v0.closePrice = v1;
        v0.closeTimestamp = 0x2::clock::timestamp_ms(arg4);
        if (v0.closePrice > v0.lockPrice) {
            v0.oracleCalled = true;
            v0.upordown = true;
        };
        if (v0.closePrice < v0.lockPrice) {
            v0.oracleCalled = true;
            v0.upordown = false;
        };
        let v5 = Round{
            epoch          : arg2.currentEpoch + 2,
            lockTimestamp  : 0,
            closeTimestamp : 0,
            lockPrice      : 0,
            closePrice     : 0,
            totalAmount    : 0x2::balance::zero<0x2::sui::SUI>(),
            upAmount       : 0,
            downAmount     : 0,
            upaddress      : 0x2::table::new<address, u64>(arg5),
            downaddress    : 0x2::table::new<address, u64>(arg5),
            upamount       : 0,
            downamount     : 0,
            oracleCalled   : false,
            upordown       : false,
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v5);
        let v6 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1 + 1);
        v6.lockPrice = v1;
        v6.lockTimestamp = 0x2::clock::timestamp_ms(arg4);
        arg2.currentEpoch = arg2.currentEpoch + 1;
    }

    public entry fun getdownAmount(arg0: &mut Rounds, arg1: u64) : u64 {
        0x1::vector::borrow<Round>(&mut arg0.rounds, arg1).downAmount
    }

    public entry fun gettotalAmount(arg0: &mut Rounds, arg1: u64) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&0x1::vector::borrow<Round>(&mut arg0.rounds, arg1).totalAmount)
    }

    public entry fun getupAmount(arg0: &mut Rounds, arg1: u64) : u64 {
        0x1::vector::borrow<Round>(&mut arg0.rounds, arg1).upAmount
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Rounds{
            id     : 0x2::object::new(arg0),
            rounds : 0x1::vector::empty<Round>(),
        };
        0x2::transfer::share_object<Rounds>(v0);
        let v1 = Epoch{
            id           : 0x2::object::new(arg0),
            currentEpoch : 0,
        };
        0x2::transfer::share_object<Epoch>(v1);
    }

    public entry fun startplay(arg0: &mut Rounds, arg1: &mut Epoch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Round{
            epoch          : 0,
            lockTimestamp  : 0x2::clock::timestamp_ms(arg2),
            closeTimestamp : 0x2::clock::timestamp_ms(arg2),
            lockPrice      : 0,
            closePrice     : 0,
            totalAmount    : 0x2::balance::zero<0x2::sui::SUI>(),
            upAmount       : 0,
            downAmount     : 0,
            upaddress      : 0x2::table::new<address, u64>(arg3),
            downaddress    : 0x2::table::new<address, u64>(arg3),
            upamount       : 0,
            downamount     : 0,
            oracleCalled   : false,
            upordown       : false,
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v0);
        let v1 = Round{
            epoch          : 1,
            lockTimestamp  : 0x2::clock::timestamp_ms(arg2),
            closeTimestamp : 0,
            lockPrice      : 0,
            closePrice     : 1,
            totalAmount    : 0x2::balance::zero<0x2::sui::SUI>(),
            upAmount       : 0,
            downAmount     : 0,
            upaddress      : 0x2::table::new<address, u64>(arg3),
            downaddress    : 0x2::table::new<address, u64>(arg3),
            upamount       : 0,
            downamount     : 0,
            oracleCalled   : false,
            upordown       : false,
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v1);
    }

    // decompiled from Move bytecode v6
}

