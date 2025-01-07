module 0xaada81624f2be6abd31f2433dac2642a03414cdb20d494314a4d3d889281fb5e::game_wallet {
    struct Ledger has key {
        id: 0x2::object::UID,
        values: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    public fun new_ledger(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Ledger{
            id     : 0x2::object::new(arg0),
            values : 0x2::vec_map::empty<0x1::string::String, u64>(),
        };
        0x2::transfer::transfer<Ledger>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun remove_ledger(arg0: Ledger) {
        let Ledger {
            id     : v0,
            values : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        while (0x2::vec_map::size<0x1::string::String, u64>(&v2) > 0) {
            let (_, _) = 0x2::vec_map::pop<0x1::string::String, u64>(&mut v2);
        };
    }

    public fun update_ledger(arg0: &mut Ledger, arg1: 0x1::string::String, arg2: u64) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.values, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, u64>(&mut arg0.values, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.values, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

