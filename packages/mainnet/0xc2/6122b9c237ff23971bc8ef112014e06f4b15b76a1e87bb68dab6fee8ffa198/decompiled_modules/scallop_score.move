module 0xc26122b9c237ff23971bc8ef112014e06f4b15b76a1e87bb68dab6fee8ffa198::scallop_score {
    struct ScallopScoreTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<address, u64>,
    }

    public(friend) fun decrease_score(arg0: &mut ScallopScoreTable, arg1: address, arg2: u64) {
        assert!(0x2::table::contains<address, u64>(&arg0.table, arg1), 0);
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1);
        *v0 = *v0 - arg2;
    }

    public fun get_score(arg0: &ScallopScoreTable, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.table, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.table, arg1)
        } else {
            0
        }
    }

    public(friend) fun increase_score(arg0: &mut ScallopScoreTable, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.table, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.table, arg1, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ScallopScoreTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<ScallopScoreTable>(v0);
    }

    public(friend) fun set_score(arg0: &mut ScallopScoreTable, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.table, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.table, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.table, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

