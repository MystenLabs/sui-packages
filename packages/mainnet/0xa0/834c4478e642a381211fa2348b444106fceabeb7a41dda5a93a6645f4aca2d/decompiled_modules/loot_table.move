module 0xa0834c4478e642a381211fa2348b444106fceabeb7a41dda5a93a6645f4aca2d::loot_table {
    struct LootEntry has copy, drop, store {
        template: 0x2::object::ID,
        weight: u64,
        amount: u32,
    }

    public fun amount(arg0: &LootEntry) : u32 {
        arg0.amount
    }

    public fun new_entry(arg0: 0x2::object::ID, arg1: u64, arg2: u32) : LootEntry {
        LootEntry{
            template : arg0,
            weight   : arg1,
            amount   : arg2,
        }
    }

    public fun pick(arg0: &vector<LootEntry>, arg1: u64) : LootEntry {
        let v0 = 0;
        let v1 = *0x1::vector::borrow<LootEntry>(arg0, 0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<LootEntry>(arg0)) {
            let v3 = arg1 >= v0;
            let v4 = v0 + 0x1::vector::borrow<LootEntry>(arg0, v2).weight;
            v0 = v4;
            if (v3 == arg1 < v4) {
                v1 = *0x1::vector::borrow<LootEntry>(arg0, v2);
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun template(arg0: &LootEntry) : 0x2::object::ID {
        arg0.template
    }

    public fun total_weight(arg0: &vector<LootEntry>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<LootEntry>(arg0)) {
            v0 = v0 + 0x1::vector::borrow<LootEntry>(arg0, v1).weight;
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

