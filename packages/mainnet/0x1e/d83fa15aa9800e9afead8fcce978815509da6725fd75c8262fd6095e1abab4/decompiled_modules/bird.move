module 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct BirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EggBreakEvent has copy, drop {
        owner: address,
        amount: u64,
    }

    struct CheckinEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct EggBreak has store {
        owner: address,
        amount: u64,
        last_time: u64,
    }

    struct Checkin has store {
        owner: address,
        amount: u64,
        last_time: u64,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        total_break: u128,
        total_checkin: u128,
        break_egg_nonce: u128,
        checkin_nonce: u128,
        breaks: 0x2::table::Table<address, EggBreak>,
        checkins: 0x2::table::Table<address, Checkin>,
    }

    public fun breakEgg(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut BirdStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg6), 8001);
        assert!(arg1 > 0, 8002);
        assert!(arg2 > 0, 8003);
        assert!(arg2 >= arg4.break_egg_nonce, 8003);
        let v0 = composeEggMsg(arg0, arg1, arg2);
        assert!(verifySignature(&v0, arg3), 8000);
        arg4.break_egg_nonce = arg2;
        arg4.total_break = arg4.total_break + 1;
        let v1 = EggBreak{
            owner     : arg0,
            amount    : arg1,
            last_time : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<address, EggBreak>(&mut arg4.breaks, arg0, v1);
        let v2 = CheckinEvent{
            owner     : arg0,
            amount    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CheckinEvent>(v2);
    }

    public fun change_admin(arg0: BirdAdminCap, arg1: address, arg2: &mut 0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::version::Version) {
        0x1ed83fa15aa9800e9afead8fcce978815509da6725fd75c8262fd6095e1abab4::version::checkVersion(arg2, 1);
        0x2::transfer::transfer<BirdAdminCap>(arg0, arg1);
    }

    public fun checkIn(arg0: address, arg1: u64, arg2: u128, arg3: &vector<u8>, arg4: &mut BirdStore, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg6), 8001);
        assert!(arg1 > 0, 8002);
        assert!(arg2 > 0, 8003);
        assert!(arg2 >= arg4.checkin_nonce, 8003);
        let v0 = composeEggMsg(arg0, arg1, arg2);
        assert!(verifySignature(&v0, arg3), 8000);
        arg4.checkin_nonce = arg2;
        arg4.total_checkin = arg4.total_checkin + 1;
        let v1 = Checkin{
            owner     : arg0,
            amount    : arg1,
            last_time : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<address, Checkin>(&mut arg4.checkins, arg0, v1);
        let v2 = EggBreakEvent{
            owner  : arg0,
            amount : arg1,
        };
        0x2::event::emit<EggBreakEvent>(v2);
    }

    fun composeCheckinMsg(arg0: address, arg1: u64, arg2: u128) : vector<u8> {
        x"02"
    }

    fun composeEggMsg(arg0: address, arg1: u64, arg2: u128) : vector<u8> {
        x"01"
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BirdAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = BirdStore{
            id              : 0x2::object::new(arg1),
            total_break     : 0,
            total_checkin   : 0,
            break_egg_nonce : 0,
            checkin_nonce   : 0,
            breaks          : 0x2::table::new<address, EggBreak>(arg1),
            checkins        : 0x2::table::new<address, Checkin>(arg1),
        };
        0x2::transfer::share_object<BirdStore>(v1);
    }

    fun verifySignature(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        true
    }

    // decompiled from Move bytecode v6
}

