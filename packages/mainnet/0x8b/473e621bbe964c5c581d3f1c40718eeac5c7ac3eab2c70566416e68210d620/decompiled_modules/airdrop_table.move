module 0x8b473e621bbe964c5c581d3f1c40718eeac5c7ac3eab2c70566416e68210d620::airdrop_table {
    struct RecordAirdrop has copy, drop {
        from: address,
        to: address,
        ticket_amount: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropTable has key {
        id: 0x2::object::UID,
        dropper: address,
        map: 0x2::table::Table<address, u64>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropTable{
            id      : 0x2::object::new(arg0),
            dropper : @0x3746e4156bd0461d6d73129ae332d5e24f148b90303f4c8b23bb7c19b53df34f,
            map     : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<AirdropTable>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun record(arg0: &mut AirdropTable, arg1: address, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.dropper, 0);
        let v0 = &mut arg0.map;
        if (!0x2::table::contains<address, u64>(v0, arg1)) {
            0x2::table::add<address, u64>(v0, arg1, 0);
        };
        assert!(*0x2::table::borrow<address, u64>(&arg0.map, arg1) + arg2 <= arg3, 1);
        let v1 = RecordAirdrop{
            from          : arg0.dropper,
            to            : arg1,
            ticket_amount : arg2,
        };
        0x2::event::emit<RecordAirdrop>(v1);
    }

    public fun update_sender(arg0: &AdminCap, arg1: &mut AirdropTable, arg2: address) {
        arg1.dropper = arg2;
    }

    // decompiled from Move bytecode v6
}

