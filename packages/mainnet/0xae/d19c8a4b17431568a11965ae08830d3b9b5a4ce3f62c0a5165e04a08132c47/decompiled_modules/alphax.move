module 0xaed19c8a4b17431568a11965ae08830d3b9b5a4ce3f62c0a5165e04a08132c47::alphax {
    struct CheckInEvent has copy, drop, store {
        user: address,
        taskId: u32,
        userId: u64,
        timestamp: u64,
    }

    struct SignalPredictionEvent has copy, drop, store {
        user: address,
        signalId: u32,
        userId: u64,
        choice: u8,
        hasInvolved: bool,
    }

    struct CheckInInfo has store, key {
        id: 0x2::object::UID,
        taskId: u32,
        userId: u64,
        timestamp: u64,
    }

    struct UserCheckInInfo has store, key {
        id: 0x2::object::UID,
        checkInInfoMap: 0x2::table::Table<u64, CheckInInfo>,
    }

    struct PredictionInfo has store, key {
        id: 0x2::object::UID,
        signalId: u32,
        userId: u64,
        choice: u8,
        hasInvolved: bool,
    }

    struct UserPredictionInfo has store, key {
        id: 0x2::object::UID,
        predictionInfoMap: 0x2::table::Table<u32, PredictionInfo>,
    }

    struct State has key {
        id: 0x2::object::UID,
        userPredictionState: 0x2::table::Table<address, UserPredictionInfo>,
        userCheckInSate: 0x2::table::Table<address, UserCheckInInfo>,
    }

    public entry fun check_in(arg0: &mut State, arg1: u32, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, UserCheckInInfo>(&arg0.userCheckInSate, v0)) {
            let v1 = UserCheckInInfo{
                id             : 0x2::object::new(arg4),
                checkInInfoMap : 0x2::table::new<u64, CheckInInfo>(arg4),
            };
            0x2::table::add<address, UserCheckInInfo>(&mut arg0.userCheckInSate, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, UserCheckInInfo>(&mut arg0.userCheckInSate, v0);
        let v3 = now_day(arg3);
        assert!(!0x2::table::contains<u64, CheckInInfo>(&v2.checkInInfoMap, v3), 1001);
        let v4 = now_seconds(arg3);
        let v5 = CheckInInfo{
            id        : 0x2::object::new(arg4),
            taskId    : arg1,
            userId    : arg2,
            timestamp : v4,
        };
        0x2::table::add<u64, CheckInInfo>(&mut v2.checkInInfoMap, v3, v5);
        let v6 = CheckInEvent{
            user      : v0,
            taskId    : arg1,
            userId    : arg2,
            timestamp : v4,
        };
        0x2::event::emit<CheckInEvent>(v6);
    }

    public fun check_in_result(arg0: &State, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, UserCheckInInfo>(&arg0.userCheckInSate, arg1)) {
            return false
        };
        if (0x2::table::contains<u64, CheckInInfo>(&0x2::table::borrow<address, UserCheckInInfo>(&arg0.userCheckInSate, arg1).checkInInfoMap, arg2)) {
            return true
        };
        false
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id                  : 0x2::object::new(arg0),
            userPredictionState : 0x2::table::new<address, UserPredictionInfo>(arg0),
            userCheckInSate     : 0x2::table::new<address, UserCheckInInfo>(arg0),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public fun now_day(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000 / 86400
    }

    public fun now_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public entry fun signal_predict(arg0: &mut State, arg1: u32, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, UserPredictionInfo>(&arg0.userPredictionState, v0)) {
            let v1 = UserPredictionInfo{
                id                : 0x2::object::new(arg4),
                predictionInfoMap : 0x2::table::new<u32, PredictionInfo>(arg4),
            };
            0x2::table::add<address, UserPredictionInfo>(&mut arg0.userPredictionState, v0, v1);
        };
        let v2 = 0x2::table::borrow_mut<address, UserPredictionInfo>(&mut arg0.userPredictionState, v0);
        assert!(!0x2::table::contains<u32, PredictionInfo>(&v2.predictionInfoMap, arg1), 1002);
        let v3 = PredictionInfo{
            id          : 0x2::object::new(arg4),
            signalId    : arg1,
            userId      : arg2,
            choice      : arg3,
            hasInvolved : true,
        };
        0x2::table::add<u32, PredictionInfo>(&mut v2.predictionInfoMap, arg1, v3);
        let v4 = SignalPredictionEvent{
            user        : v0,
            signalId    : arg1,
            userId      : arg2,
            choice      : arg3,
            hasInvolved : true,
        };
        0x2::event::emit<SignalPredictionEvent>(v4);
    }

    public fun signal_predict_result(arg0: &State, arg1: address, arg2: u32) : (bool, u32, u8) {
        if (!0x2::table::contains<address, UserPredictionInfo>(&arg0.userPredictionState, arg1)) {
            (false, 0, 0)
        } else {
            let v3 = 0x2::table::borrow<address, UserPredictionInfo>(&arg0.userPredictionState, arg1);
            if (!0x2::table::contains<u32, PredictionInfo>(&v3.predictionInfoMap, arg2)) {
                (false, 0, 0)
            } else {
                let v4 = 0x2::table::borrow<u32, PredictionInfo>(&v3.predictionInfoMap, arg2);
                (v4.hasInvolved, v4.signalId, v4.choice)
            }
        }
    }

    // decompiled from Move bytecode v6
}

