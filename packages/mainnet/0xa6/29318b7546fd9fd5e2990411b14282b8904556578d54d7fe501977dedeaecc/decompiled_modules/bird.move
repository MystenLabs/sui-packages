module 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::bird {
    struct BIRD has drop {
        dummy_field: bool,
    }

    struct BirdAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EggBreakEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct CheckinEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct EggBreak has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        last_time: u64,
    }

    struct Checkin has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        last_time: u64,
    }

    struct BirdAction has copy, drop {
        type: u8,
        owner: address,
        amount: u64,
        nonce: u128,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        total_break: u128,
        total_checkin: u128,
        action_nonce: u128,
        breaks: 0x2::object_table::ObjectTable<address, EggBreak>,
        checkins: 0x2::object_table::ObjectTable<address, Checkin>,
        validator_pubkey: vector<u8>,
    }

    public fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 <= 1, 8004);
        if (v1 == 1) {
            checkIn(0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u128(&mut v0), arg2, arg3, arg4);
        } else if (v1 == 0) {
            breakEgg(0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u128(&mut v0), arg2, arg3, arg4);
        };
    }

    fun breakEgg(arg0: address, arg1: u64, arg2: u128, arg3: &mut BirdStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg5), 8001);
        assert!(arg1 > 0, 8002);
        assert!(arg2 > arg3.action_nonce, 8003);
        arg3.action_nonce = arg2;
        arg3.total_break = arg3.total_break + 1;
        if (!0x2::object_table::contains<address, EggBreak>(&arg3.breaks, arg0)) {
            let v0 = EggBreak{
                id        : 0x2::object::new(arg5),
                owner     : arg0,
                amount    : arg1,
                last_time : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::object_table::add<address, EggBreak>(&mut arg3.breaks, arg0, v0);
        } else {
            let v1 = 0x2::object_table::borrow_mut<address, EggBreak>(&mut arg3.breaks, arg0);
            v1.amount = v1.amount + arg1;
            v1.last_time = 0x2::clock::timestamp_ms(arg4);
        };
        let v2 = EggBreakEvent{
            owner     : arg0,
            amount    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<EggBreakEvent>(v2);
    }

    public fun change_admin(arg0: BirdAdminCap, arg1: address, arg2: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::Version) {
        0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::checkVersion(arg2, 1);
        0x2::transfer::transfer<BirdAdminCap>(arg0, arg1);
    }

    fun checkIn(arg0: address, arg1: u64, arg2: u128, arg3: &mut BirdStore, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg5), 8001);
        assert!(arg1 > 0, 8002);
        assert!(arg2 > arg3.action_nonce, 8003);
        arg3.action_nonce = arg2;
        arg3.total_checkin = arg3.total_checkin + 1;
        if (!0x2::object_table::contains<address, Checkin>(&arg3.checkins, arg0)) {
            let v0 = Checkin{
                id        : 0x2::object::new(arg5),
                owner     : arg0,
                amount    : arg1,
                last_time : 0x2::clock::timestamp_ms(arg4),
            };
            0x2::object_table::add<address, Checkin>(&mut arg3.checkins, arg0, v0);
        } else {
            let v1 = 0x2::object_table::borrow_mut<address, Checkin>(&mut arg3.checkins, arg0);
            v1.amount = v1.amount + arg1;
            v1.last_time = 0x2::clock::timestamp_ms(arg4);
        };
        let v2 = CheckinEvent{
            owner     : arg0,
            amount    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<CheckinEvent>(v2);
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<BirdAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = BirdStore{
            id               : 0x2::object::new(arg1),
            total_break      : 0,
            total_checkin    : 0,
            action_nonce     : 0,
            breaks           : 0x2::object_table::new<address, EggBreak>(arg1),
            checkins         : 0x2::object_table::new<address, Checkin>(arg1),
            validator_pubkey : x"8a6a117bb3187d4477b1aa406c71f8d1edc67192f67f0769f4316f113a3e561c",
        };
        0x2::transfer::share_object<BirdStore>(v1);
    }

    public fun set_validator(arg0: &BirdAdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut 0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::Version) {
        0xa629318b7546fd9fd5e2990411b14282b8904556578d54d7fe501977dedeaecc::version::checkVersion(arg3, 1);
        arg2.validator_pubkey = arg1;
    }

    // decompiled from Move bytecode v6
}

