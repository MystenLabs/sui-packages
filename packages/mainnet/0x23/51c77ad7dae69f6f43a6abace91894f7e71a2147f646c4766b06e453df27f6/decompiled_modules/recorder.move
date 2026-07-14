module 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::recorder {
    struct Recorder has key {
        id: 0x2::object::UID,
        version: u64,
        record_cap: 0x2::object::ID,
        earned: 0x2::table::Table<address, u64>,
        spent: 0x2::table::Table<address, u64>,
    }

    struct RecordCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EarnedRecorded has copy, drop {
        user: address,
        earned_total: u64,
    }

    struct Spent has copy, drop {
        user: address,
        amount: u64,
        spent_total: u64,
    }

    public(friend) fun add_spent(arg0: &mut Recorder, arg1: address, arg2: u64) {
        assert!(arg0.version == 1, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::wrong_version());
        assert!(points_of(arg0, arg1) >= arg2, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::insufficient_points());
        let v0 = spent_of(arg0, arg1) + arg2;
        if (0x2::table::contains<address, u64>(&arg0.spent, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.spent, arg1) = v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.spent, arg1, v0);
        };
        let v1 = Spent{
            user        : arg1,
            amount      : arg2,
            spent_total : v0,
        };
        0x2::event::emit<Spent>(v1);
    }

    public fun earned_of(arg0: &Recorder, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.earned, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.earned, arg1)
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecordCap{id: 0x2::object::new(arg0)};
        let v1 = Recorder{
            id         : 0x2::object::new(arg0),
            version    : 1,
            record_cap : 0x2::object::id<RecordCap>(&v0),
            earned     : 0x2::table::new<address, u64>(arg0),
            spent      : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Recorder>(v1);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v3, v2);
        0x2::transfer::transfer<RecordCap>(v0, v2);
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Recorder) {
        assert!(arg1.version < 1, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::wrong_version());
        arg1.version = 1;
    }

    public fun new_record_cap(arg0: &mut Recorder, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : RecordCap {
        assert!(arg0.version == 1, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::wrong_version());
        let v0 = RecordCap{id: 0x2::object::new(arg2)};
        arg0.record_cap = 0x2::object::id<RecordCap>(&v0);
        v0
    }

    public fun points_of(arg0: &Recorder, arg1: address) : u64 {
        earned_of(arg0, arg1) - spent_of(arg0, arg1)
    }

    public fun record(arg0: &mut Recorder, arg1: &RecordCap, arg2: address, arg3: u64) {
        assert!(arg0.version == 1, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::wrong_version());
        assert!(0x2::object::id<RecordCap>(arg1) == arg0.record_cap, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::invalid_record_cap());
        record_inner(arg0, arg2, arg3);
    }

    public fun record_batch(arg0: &mut Recorder, arg1: &RecordCap, arg2: vector<address>, arg3: vector<u64>) {
        assert!(arg0.version == 1, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::wrong_version());
        assert!(0x2::object::id<RecordCap>(arg1) == arg0.record_cap, 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::invalid_record_cap());
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::length_mismatch());
        let v1 = 0;
        while (v1 < v0) {
            record_inner(arg0, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    fun record_inner(arg0: &mut Recorder, arg1: address, arg2: u64) {
        write_earned(arg0, arg1, arg2);
        let v0 = EarnedRecorded{
            user         : arg1,
            earned_total : arg2,
        };
        0x2::event::emit<EarnedRecorded>(v0);
    }

    public fun spent_of(arg0: &Recorder, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.spent, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.spent, arg1)
        } else {
            0
        }
    }

    fun write_earned(arg0: &mut Recorder, arg1: address, arg2: u64) {
        assert!(arg2 >= earned_of(arg0, arg1), 0x2351c77ad7dae69f6f43a6abace91894f7e71a2147f646c4766b06e453df27f6::errors::invalid_earned());
        if (0x2::table::contains<address, u64>(&arg0.earned, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.earned, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.earned, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v7
}

