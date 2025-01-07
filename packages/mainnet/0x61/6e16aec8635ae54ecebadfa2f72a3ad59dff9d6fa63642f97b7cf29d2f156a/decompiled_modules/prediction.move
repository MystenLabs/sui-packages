module 0x616e16aec8635ae54ecebadfa2f72a3ad59dff9d6fa63642f97b7cf29d2f156a::prediction {
    struct Rounds has key {
        id: 0x2::object::UID,
        rounds: vector<Round>,
    }

    struct Round has store {
        epoch: u32,
        startTimestamp: u32,
        lockTimestamp: u32,
        closeTimestamp: u32,
        lockPrice: u128,
        closePrice: u128,
        lockOracleId: u128,
        closeOracleId: u128,
        totalAmount: 0x2::balance::Balance<0x2::sui::SUI>,
        upAmount: u64,
        downAmount: u64,
        upaddress: vector<address>,
        downaddress: vector<address>,
        upamount: u64,
        downamount: u64,
        rewardBaseCalAmount: 0x2::balance::Balance<0x2::sui::SUI>,
        rewardAmount: 0x2::balance::Balance<0x2::sui::SUI>,
        oracleCalled: bool,
        uprodown: bool,
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
        0x2::balance::join<0x2::sui::SUI>(&mut v0.totalAmount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v0.downAmount = v0.downAmount + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        v0.downamount = v0.downamount + 1;
        0x1::vector::push_back<address>(&mut v0.downaddress, 0x2::tx_context::sender(arg4));
    }

    public entry fun betUp(arg0: &mut Rounds, arg1: &mut Epoch, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut v0.totalAmount, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        v0.upAmount = v0.upAmount + 0x2::coin::value<0x2::sui::SUI>(&arg2);
        v0.upamount = v0.upamount + 1;
        0x1::vector::push_back<address>(&mut v0.upaddress, 0x2::tx_context::sender(arg4));
    }

    public entry fun claim(arg0: &mut Rounds, arg1: u64, arg2: &mut Epoch, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        assert!(v0.oracleCalled, 0);
        if (v0.uprodown) {
            let v1 = &mut v0.totalAmount;
            let v2 = 0x2::balance::value<0x2::sui::SUI>(v1) / v0.upamount;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v1, v2, arg3), 0x2::tx_context::sender(arg3));
            0x1::debug::print<u64>(&v2);
            let v3 = 0x2::tx_context::sender(arg3);
            let (v4, v5) = 0x1::vector::index_of<address>(&v0.upaddress, &v3);
            if (v4) {
                0x1::vector::remove<address>(&mut v0.upaddress, v5);
            };
        };
    }

    public entry fun executeRound(arg0: &mut Rounds, arg1: u64, arg2: &mut Epoch) {
        let v0 = 0x1::vector::borrow_mut<Round>(&mut arg0.rounds, arg1);
        if (v0.closePrice > v0.lockPrice) {
            v0.oracleCalled = true;
            v0.uprodown = true;
        };
        if (v0.closePrice < v0.lockPrice) {
            v0.oracleCalled = true;
            v0.uprodown = false;
        };
        let v1 = Round{
            epoch               : ((arg2.currentEpoch + 1) as u32),
            startTimestamp      : 1111,
            lockTimestamp       : 2222,
            closeTimestamp      : 3333,
            lockPrice           : 0,
            closePrice          : 1,
            lockOracleId        : 1,
            closeOracleId       : 1,
            totalAmount         : 0x2::balance::zero<0x2::sui::SUI>(),
            upAmount            : 0,
            downAmount          : 0,
            upaddress           : 0x1::vector::empty<address>(),
            downaddress         : 0x1::vector::empty<address>(),
            upamount            : 0,
            downamount          : 0,
            rewardBaseCalAmount : 0x2::balance::zero<0x2::sui::SUI>(),
            rewardAmount        : 0x2::balance::zero<0x2::sui::SUI>(),
            oracleCalled        : false,
            uprodown            : false,
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v1);
        arg2.currentEpoch = arg2.currentEpoch + 1;
    }

    public entry fun getdownAmount(arg0: &mut Rounds, arg1: u64) : u64 {
        0x1::vector::borrow<Round>(&mut arg0.rounds, arg1).downAmount
    }

    public entry fun getinfo(arg0: &mut Rounds, arg1: u64) : (u32, u64, u64) {
        let v0 = 0x1::vector::borrow<Round>(&mut arg0.rounds, arg1);
        (v0.epoch, v0.upAmount, v0.downAmount)
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

    public fun startplay(arg0: &mut Rounds, arg1: &mut Epoch) {
        let v0 = Round{
            epoch               : 1,
            startTimestamp      : 1111,
            lockTimestamp       : 2222,
            closeTimestamp      : 3333,
            lockPrice           : 0,
            closePrice          : 1,
            lockOracleId        : 1,
            closeOracleId       : 1,
            totalAmount         : 0x2::balance::zero<0x2::sui::SUI>(),
            upAmount            : 0,
            downAmount          : 0,
            upaddress           : 0x1::vector::empty<address>(),
            downaddress         : 0x1::vector::empty<address>(),
            upamount            : 0,
            downamount          : 0,
            rewardBaseCalAmount : 0x2::balance::zero<0x2::sui::SUI>(),
            rewardAmount        : 0x2::balance::zero<0x2::sui::SUI>(),
            oracleCalled        : false,
            uprodown            : false,
        };
        0x1::vector::push_back<Round>(&mut arg0.rounds, v0);
        arg1.currentEpoch = arg1.currentEpoch + 1;
    }

    // decompiled from Move bytecode v6
}

