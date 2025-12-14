module 0x52387333938b88b4392bf05120b2d7beb9b65248764e9b54f58939140833458d::memory_ledger {
    struct AnniversaryRecord has drop, store {
        owner: address,
        date_yyyymmdd: u64,
        claimed: bool,
    }

    struct MemoryLedger has store, key {
        id: 0x2::object::UID,
        anniversaries: 0x2::table::Table<0x2::object::ID, AnniversaryRecord>,
        year_waiting: 0x2::table::Table<u64, address>,
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MemoryLedger{
            id            : 0x2::object::new(arg0),
            anniversaries : 0x2::table::new<0x2::object::ID, AnniversaryRecord>(arg0),
            year_waiting  : 0x2::table::new<u64, address>(arg0),
        };
        0x2::transfer::share_object<MemoryLedger>(v0);
    }

    public(friend) fun mark_anniversary_claimed(arg0: &mut MemoryLedger, arg1: 0x2::object::ID, arg2: address) : u64 {
        assert!(0x2::table::contains<0x2::object::ID, AnniversaryRecord>(&arg0.anniversaries, arg1), 102);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, AnniversaryRecord>(&mut arg0.anniversaries, arg1);
        assert!(v0.owner == arg2, 0);
        assert!(v0.claimed == false, 101);
        v0.claimed = true;
        v0.date_yyyymmdd
    }

    public(friend) fun note_today(arg0: &mut MemoryLedger, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = AnniversaryRecord{
            owner         : arg2,
            date_yyyymmdd : arg3,
            claimed       : false,
        };
        0x2::table::add<0x2::object::ID, AnniversaryRecord>(&mut arg0.anniversaries, arg1, v0);
    }

    public(friend) fun pair_or_wait_nostalgia(arg0: &mut MemoryLedger, arg1: address, arg2: u64) : 0x1::option::Option<address> {
        if (0x2::table::contains<u64, address>(&arg0.year_waiting, arg2)) {
            if (*0x2::table::borrow<u64, address>(&arg0.year_waiting, arg2) == arg1) {
                return 0x1::option::none<address>()
            };
            return 0x1::option::some<address>(0x2::table::remove<u64, address>(&mut arg0.year_waiting, arg2))
        };
        0x2::table::add<u64, address>(&mut arg0.year_waiting, arg2, arg1);
        0x1::option::none<address>()
    }

    // decompiled from Move bytecode v6
}

