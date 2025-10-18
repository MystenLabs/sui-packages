module 0xee9aec5a38da5613a0412791974eff83148f7f966cb5112c338d721ff64ce0ba::rank {
    struct RankTable has store, key {
        id: 0x2::object::UID,
        rankTable: 0x1::string::String,
        level: 0x1::string::String,
    }

    struct RankRecords has store, key {
        id: 0x2::object::UID,
    }

    struct RankAutherizeCap has store, key {
        id: 0x2::object::UID,
    }

    entry fun addToTable(arg0: &RankAutherizeCap, arg1: &mut RankRecords, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RankTable>(&mut arg1.id, arg3);
        v0.rankTable = concat_strings(v0.rankTable, concat_strings(0x2::address::to_string(arg2), arg4));
    }

    fun concat_strings(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append(&mut v0, arg0);
        0x1::string::append(&mut v0, arg1);
        v0
    }

    entry fun createTodayTables(arg0: &RankAutherizeCap, arg1: &mut RankRecords, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RankTable{
            id        : 0x2::object::new(arg3),
            rankTable : 0x1::string::utf8(b""),
            level     : 0x1::string::utf8(b"Gold"),
        };
        let v1 = RankTable{
            id        : 0x2::object::new(arg3),
            rankTable : 0x1::string::utf8(b""),
            level     : 0x1::string::utf8(b"Sliver"),
        };
        let v2 = RankTable{
            id        : 0x2::object::new(arg3),
            rankTable : 0x1::string::utf8(b""),
            level     : 0x1::string::utf8(b"Bronze"),
        };
        0x2::dynamic_object_field::add<0x1::string::String, RankTable>(&mut arg1.id, concat_strings(arg2, 0x1::string::utf8(b"-gold")), v0);
        0x2::dynamic_object_field::add<0x1::string::String, RankTable>(&mut arg1.id, concat_strings(arg2, 0x1::string::utf8(b"-sliver")), v1);
        0x2::dynamic_object_field::add<0x1::string::String, RankTable>(&mut arg1.id, concat_strings(arg2, 0x1::string::utf8(b"-bronze")), v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RankTable{
            id        : 0x2::object::new(arg0),
            rankTable : 0x1::string::utf8(b""),
            level     : 0x1::string::utf8(b""),
        };
        let v1 = RankRecords{id: 0x2::object::new(arg0)};
        let v2 = RankAutherizeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RankAutherizeCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::dynamic_object_field::add<0x1::string::String, RankTable>(&mut v1.id, 0x1::string::utf8(b"2025-10-18"), v0);
        0x2::transfer::public_share_object<RankRecords>(v1);
    }

    // decompiled from Move bytecode v6
}

