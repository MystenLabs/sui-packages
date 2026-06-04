module 0x72f4c62e6266a5847fb4d679bdbb5cccd463252c33b9c884959e1318d6653bf7::trading_journal {
    struct TradingJournalBatchEntry has store, key {
        id: 0x2::object::UID,
        timestamp_ms: u64,
        batch_seq: u64,
        hashes: vector<0x1::ascii::String>,
    }

    struct TradingJournal has store, key {
        id: 0x2::object::UID,
        owner: address,
        seq: u64,
    }

    struct TradingJournalEvent has copy, drop {
        trading_journal_id: 0x2::object::ID,
        trading_journal_entry_id: 0x2::object::ID,
        trading_journal_entry_seq: u64,
        timestamp_ms: u64,
    }

    public entry fun add_journal_entry(arg0: &mut TradingJournal, arg1: vector<vector<u8>>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(*0x1::vector::borrow<vector<u8>>(&arg1, v1)));
            v1 = v1 + 1;
        };
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = arg0.seq;
        let v4 = 0x2::object::new(arg3);
        let v5 = TradingJournalBatchEntry{
            id           : v4,
            timestamp_ms : v2,
            batch_seq    : v3,
            hashes       : v0,
        };
        let v6 = TradingJournalEvent{
            trading_journal_id        : 0x2::object::id<TradingJournal>(arg0),
            trading_journal_entry_id  : 0x2::object::uid_to_inner(&v4),
            trading_journal_entry_seq : v3,
            timestamp_ms              : v2,
        };
        0x2::event::emit<TradingJournalEvent>(v6);
        0x2::dynamic_object_field::add<u64, TradingJournalBatchEntry>(&mut arg0.id, v3, v5);
        arg0.seq = v3 + 1;
    }

    public fun borrow_batch(arg0: &TradingJournal, arg1: u64) : &TradingJournalBatchEntry {
        0x2::dynamic_object_field::borrow<u64, TradingJournalBatchEntry>(&arg0.id, arg1)
    }

    public entry fun create_journal(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradingJournal{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            seq   : 0,
        };
        0x2::transfer::share_object<TradingJournal>(v0);
    }

    public entry fun delete_journal(arg0: TradingJournal, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let TradingJournal {
            id    : v0,
            owner : _,
            seq   : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v0;
        while (v3 > 0) {
            v3 = v3 - 1;
            let TradingJournalBatchEntry {
                id           : v5,
                timestamp_ms : _,
                batch_seq    : _,
                hashes       : _,
            } = 0x2::dynamic_object_field::remove<u64, TradingJournalBatchEntry>(&mut v4, v3);
            0x2::object::delete(v5);
        };
        0x2::object::delete(v4);
    }

    public fun get_batch_count(arg0: &TradingJournal) : u64 {
        arg0.seq
    }

    public fun get_hashes(arg0: &TradingJournalBatchEntry) : &vector<0x1::ascii::String> {
        &arg0.hashes
    }

    public fun get_timestamp(arg0: &TradingJournalBatchEntry) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v6
}

