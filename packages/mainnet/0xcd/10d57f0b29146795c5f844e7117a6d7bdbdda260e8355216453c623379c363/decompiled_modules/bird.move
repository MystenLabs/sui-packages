module 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::bird {
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

    struct Checkin has drop, store {
        amount: u64,
        last_time: u64,
    }

    struct BreakEgg has drop, store {
        amount: u64,
        last_time: u64,
    }

    struct BirdArchieve has store, key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        checkin: Checkin,
        break_egg: BreakEgg,
    }

    struct BirdStore has store, key {
        id: 0x2::object::UID,
        total_break: u128,
        total_checkin: u128,
        action_nonce: u128,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct BirdReg has store, key {
        id: 0x2::object::UID,
        egg_regs: 0x2::table::Table<address, bool>,
    }

    public fun action(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut BirdArchieve, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<vector<u8>>(&arg2.validator), 8000);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(&arg2.validator), &arg1), 8000);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u8(&mut v0);
        assert!(v1 <= 1, 8004);
        assert!(0x2::bcs::peel_u128(&mut v0) > arg2.action_nonce, 8003);
        if (v1 == 1) {
            arg2.total_checkin = arg2.total_checkin + 1;
            checkIn(arg3, 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg4, arg5);
        } else if (v1 == 0) {
            arg2.total_break = arg2.total_break + 1;
            breakEgg(arg3, 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), arg4, arg5);
        };
    }

    fun breakEgg(arg0: &mut BirdArchieve, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 == 0x2::tx_context::sender(arg4), 8001);
        assert!(arg2 > 0, 8002);
        arg0.break_egg.amount = arg0.break_egg.amount + arg2;
        arg0.break_egg.last_time = 0x2::clock::timestamp_ms(arg3);
        let v0 = EggBreakEvent{
            owner     : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EggBreakEvent>(v0);
    }

    fun checkIn(arg0: &mut BirdArchieve, arg1: address, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 == 0x2::tx_context::sender(arg4), 8001);
        assert!(arg2 > 0, 8002);
        arg0.break_egg.amount = arg0.break_egg.amount + arg2;
        let v0 = CheckinEvent{
            owner     : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<CheckinEvent>(v0);
    }

    fun init(arg0: BIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BirdAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BirdAdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = BirdStore{
            id            : 0x2::object::new(arg1),
            total_break   : 0,
            total_checkin : 0,
            action_nonce  : 0,
            validator     : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<BirdStore>(v1);
        let v2 = BirdReg{
            id       : 0x2::object::new(arg1),
            egg_regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<BirdReg>(v2);
    }

    public fun register(arg0: &mut BirdReg, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<address, bool>(&arg0.egg_regs, 0x2::tx_context::sender(arg2)), 8005);
        let v0 = Checkin{
            amount    : 0,
            last_time : 0x2::clock::timestamp_ms(arg1),
        };
        let v1 = BreakEgg{
            amount    : 0,
            last_time : 0x2::clock::timestamp_ms(arg1),
        };
        let v2 = BirdArchieve{
            id        : 0x2::object::new(arg2),
            owner     : 0x2::tx_context::sender(arg2),
            last_time : 0x2::clock::timestamp_ms(arg1),
            checkin   : v0,
            break_egg : v1,
        };
        0x2::transfer::public_transfer<BirdArchieve>(v2, 0x2::tx_context::sender(arg2));
        0x2::table::add<address, bool>(&mut arg0.egg_regs, 0x2::tx_context::sender(arg2), true);
    }

    public fun update_admin(arg0: BirdAdminCap, arg1: address, arg2: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::Version) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::checkVersion(arg2, 1);
        0x2::transfer::public_transfer<BirdAdminCap>(arg0, arg1);
    }

    public fun update_validator(arg0: &BirdAdminCap, arg1: vector<u8>, arg2: &mut BirdStore, arg3: &mut 0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::Version) {
        0xcd10d57f0b29146795c5f844e7117a6d7bdbdda260e8355216453c623379c363::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    // decompiled from Move bytecode v6
}

