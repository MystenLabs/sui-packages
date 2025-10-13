module 0x7de6bc92a5b7e07d09faecbff30f4c0ef751b97cafbd29fef8898a822a325d27::leaderboard {
    struct Record has copy, drop, store {
        value: u64,
        account: address,
    }

    struct Leaderboard has store {
        scores: vector<Record>,
    }

    public(friend) fun empty() : Leaderboard {
        Leaderboard{scores: 0x1::vector::empty<Record>()}
    }

    public(friend) fun account(arg0: &Record) : address {
        arg0.account
    }

    public(friend) fun add_score(arg0: &mut Leaderboard, arg1: u64, arg2: address) {
        let v0 = &mut arg0.scores;
        let v1 = Record{
            value   : arg1,
            account : arg2,
        };
        insert_leaderboard(v0, v1);
    }

    fun binary_search_by_value(arg0: &vector<Record>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = 0x1::vector::length<Record>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            let v2 = *0x1::vector::borrow<Record>(arg0, v1);
            if (v2.value == arg1) {
                return 0x1::option::some<u64>(v1)
            };
            if (v2.value < arg1) {
                continue
            };
            v0 = v1 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_insertion_index(arg0: &vector<Record>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Record>(arg0);
        while (v0 < v1) {
            v1 = v0 + (v1 - v0) / 2;
            let v2 = *0x1::vector::borrow<Record>(arg0, v1);
            if (v2.value < arg1) {
                continue
            };
            v0 = v1 + 1;
        };
        v0
    }

    fun find_record_index(arg0: &vector<Record>, arg1: Record) : 0x1::option::Option<u64> {
        let v0 = binary_search_by_value(arg0, arg1.value);
        if (!0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0x1::option::extract<u64>(&mut v0);
        while (v1 > 0) {
            let v2 = *0x1::vector::borrow<Record>(arg0, v1 - 1);
            if (v2.value != arg1.value) {
                break
            };
            v1 = v1 - 1;
        };
        while (v1 < 0x1::vector::length<Record>(arg0)) {
            let v3 = *0x1::vector::borrow<Record>(arg0, v1);
            if (v3.value != arg1.value) {
                break
            };
            if (v3.account == arg1.account) {
                return 0x1::option::some<u64>(v1)
            };
            v1 = v1 + 1;
        };
        0x1::option::none<u64>()
    }

    public(friend) fun get_leaderboard(arg0: &Leaderboard) : &vector<Record> {
        &arg0.scores
    }

    fun insert_leaderboard(arg0: &mut vector<Record>, arg1: Record) {
        let v0 = 0x1::vector::length<Record>(arg0);
        if (v0 < 1000) {
            0x1::vector::insert<Record>(arg0, arg1, find_insertion_index(arg0, arg1.value));
        } else {
            let v1 = v0 - 1;
            let v2 = *0x1::vector::borrow<Record>(arg0, v1);
            if (arg1.value > v2.value) {
                0x1::vector::remove<Record>(arg0, v1);
                0x1::vector::insert<Record>(arg0, arg1, find_insertion_index(arg0, arg1.value));
            };
        };
    }

    fun remove_leaderboard(arg0: &mut vector<Record>, arg1: Record) : bool {
        let v0 = find_record_index(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x1::vector::remove<Record>(arg0, 0x1::option::extract<u64>(&mut v0));
            true
        } else {
            false
        }
    }

    public(friend) fun remove_score(arg0: &mut Leaderboard, arg1: u64, arg2: address) : bool {
        let v0 = &mut arg0.scores;
        let v1 = Record{
            value   : arg1,
            account : arg2,
        };
        remove_leaderboard(v0, v1)
    }

    // decompiled from Move bytecode v6
}

