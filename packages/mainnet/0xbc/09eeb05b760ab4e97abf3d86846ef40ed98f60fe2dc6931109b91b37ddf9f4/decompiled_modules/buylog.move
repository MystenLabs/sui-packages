module 0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::buylog {
    struct Entry has copy, drop, store {
        amount: u64,
        at_ms: u64,
    }

    struct Log has store {
        wallets: 0x2::table::Table<address, vector<Entry>>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Log {
        Log{wallets: 0x2::table::new<address, vector<Entry>>(arg0)}
    }

    public fun amount(arg0: &Entry) : u64 {
        arg0.amount
    }

    public fun at_ms(arg0: &Entry) : u64 {
        arg0.at_ms
    }

    public fun entries(arg0: &Log, arg1: address) : vector<Entry> {
        if (!0x2::table::contains<address, vector<Entry>>(&arg0.wallets, arg1)) {
            0x1::vector::empty<Entry>()
        } else {
            *0x2::table::borrow<address, vector<Entry>>(&arg0.wallets, arg1)
        }
    }

    public(friend) fun entry(arg0: u64, arg1: u64) : Entry {
        Entry{
            amount : arg0,
            at_ms  : arg1,
        }
    }

    public fun fee_tokens(arg0: &vector<Entry>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<Entry>(arg0)) {
            let v3 = 0x1::vector::borrow<Entry>(arg0, v2);
            let v4 = 0x1::u64::min(v3.amount, arg1 - v1);
            if (v4 > 0) {
                let v5 = if (arg2 > v3.at_ms) {
                    arg2 - v3.at_ms
                } else {
                    0
                };
                v0 = v0 + (v4 as u256) * (0xbc09eeb05b760ab4e97abf3d86846ef40ed98f60fe2dc6931109b91b37ddf9f4::math::decay(v5, arg3, arg4, arg5) as u256);
                v1 = v1 + v4;
            };
            v2 = v2 + 1;
        };
        (((v0 + ((arg1 - v1) as u256) * (arg6 as u256) + 9999) / 10000) as u64)
    }

    public fun logged(arg0: &Log, arg1: address) : u64 {
        if (!0x2::table::contains<address, vector<Entry>>(&arg0.wallets, arg1)) {
            return 0
        };
        let v0 = 0;
        let v1 = 0x2::table::borrow<address, vector<Entry>>(&arg0.wallets, arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Entry>(v1)) {
            v0 = v0 + 0x1::vector::borrow<Entry>(v1, v2).amount;
            v2 = v2 + 1;
        };
        v0
    }

    public fun preview(arg0: &Log, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = entries(arg0, arg1);
        fee_tokens(&v0, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public(friend) fun record(arg0: &mut Log, arg1: address, arg2: u64, arg3: u64) {
        if (arg2 == 0) {
            return
        };
        if (!0x2::table::contains<address, vector<Entry>>(&arg0.wallets, arg1)) {
            0x2::table::add<address, vector<Entry>>(&mut arg0.wallets, arg1, 0x1::vector::empty<Entry>());
        };
        let v0 = 0x2::table::borrow_mut<address, vector<Entry>>(&mut arg0.wallets, arg1);
        let v1 = Entry{
            amount : arg2,
            at_ms  : arg3,
        };
        0x1::vector::push_back<Entry>(v0, v1);
        if (0x1::vector::length<Entry>(v0) > 16) {
            let v2 = 0x1::vector::remove<Entry>(v0, 0);
            let v3 = 0x1::vector::borrow_mut<Entry>(v0, 0);
            v3.amount = v3.amount + v2.amount;
            if (v2.at_ms > v3.at_ms) {
                v3.at_ms = v2.at_ms;
            };
        };
    }

    public(friend) fun restore(arg0: &mut Log, arg1: address, arg2: vector<Entry>) {
        0x1::vector::reverse<Entry>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<Entry>(&arg2)) {
            let v1 = 0x1::vector::pop_back<Entry>(&mut arg2);
            record(arg0, arg1, v1.amount, v1.at_ms);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<Entry>(arg2);
    }

    public(friend) fun take(arg0: &mut Log, arg1: address, arg2: u64) : vector<Entry> {
        let v0 = 0x1::vector::empty<Entry>();
        if (arg2 == 0 || !0x2::table::contains<address, vector<Entry>>(&arg0.wallets, arg1)) {
            return v0
        };
        let v1 = arg2;
        let v2 = 0x2::table::borrow_mut<address, vector<Entry>>(&mut arg0.wallets, arg1);
        while (v1 > 0 && 0x1::vector::length<Entry>(v2) > 0) {
            let v3 = 0x1::vector::borrow_mut<Entry>(v2, 0);
            if (v3.amount <= v1) {
                v1 = v1 - v3.amount;
                0x1::vector::push_back<Entry>(&mut v0, 0x1::vector::remove<Entry>(v2, 0));
                continue
            };
            v3.amount = v3.amount - v1;
            let v4 = Entry{
                amount : v1,
                at_ms  : v3.at_ms,
            };
            0x1::vector::push_back<Entry>(&mut v0, v4);
            v1 = 0;
        };
        if (0x1::vector::length<Entry>(v2) == 0) {
            0x2::table::remove<address, vector<Entry>>(&mut arg0.wallets, arg1);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

