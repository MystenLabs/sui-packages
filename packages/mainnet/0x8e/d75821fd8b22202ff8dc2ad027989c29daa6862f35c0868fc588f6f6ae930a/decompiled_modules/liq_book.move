module 0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::liq_book {
    struct LiqRecord has copy, drop, store {
        account_id: 0x2::object::ID,
        owner: address,
        is_long: bool,
        margin: u64,
        notional: u64,
        exposure: u64,
        entry_wad: u128,
        bust_wad: u128,
        open_oracle_ts_ms: u64,
        open_oracle_sequence: u64,
        wash: bool,
    }

    struct HeapEntry has copy, drop, store {
        position_id: u64,
        bust_wad: u128,
    }

    struct Heap has store {
        max_heap: bool,
        size: u64,
        slots: 0x2::table::Table<u64, HeapEntry>,
        index: 0x2::table::Table<u64, u64>,
    }

    struct SideNotional has copy, drop, store {
        long: u64,
        short: u64,
    }

    struct LiqBook has store {
        long: Heap,
        short: Heap,
        records: 0x2::table::Table<u64, LiqRecord>,
        pending: 0x2::table::Table<0x2::object::ID, vector<u64>>,
        sides: 0x2::table::Table<0x2::object::ID, SideNotional>,
    }

    fun swap(arg0: &mut Heap, arg1: u64, arg2: u64) {
        let v0 = *0x2::table::borrow<u64, HeapEntry>(&arg0.slots, arg1);
        let v1 = *0x2::table::borrow<u64, HeapEntry>(&arg0.slots, arg2);
        *0x2::table::borrow_mut<u64, HeapEntry>(&mut arg0.slots, arg1) = v1;
        *0x2::table::borrow_mut<u64, HeapEntry>(&mut arg0.slots, arg2) = v0;
        *0x2::table::borrow_mut<u64, u64>(&mut arg0.index, v1.position_id) = arg1;
        *0x2::table::borrow_mut<u64, u64>(&mut arg0.index, v0.position_id) = arg2;
    }

    public fun contains(arg0: &LiqBook, arg1: u64) : bool {
        0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : LiqBook {
        let v0 = new_heap(true, arg0);
        let v1 = new_heap(false, arg0);
        LiqBook{
            long    : v0,
            short   : v1,
            records : 0x2::table::new<u64, LiqRecord>(arg0),
            pending : 0x2::table::new<0x2::object::ID, vector<u64>>(arg0),
            sides   : 0x2::table::new<0x2::object::ID, SideNotional>(arg0),
        }
    }

    public fun remove(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: u64) : LiqRecord {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg1.records, arg2), 13835058583563141121);
        let v0 = 0x2::table::remove<u64, LiqRecord>(&mut arg1.records, arg2);
        let v1 = if (v0.is_long) {
            &mut arg1.long
        } else {
            &mut arg1.short
        };
        heap_remove(v1, arg2);
        sub_side(arg1, v0.account_id, v0.is_long, v0.notional);
        v0
    }

    fun above(arg0: &Heap, arg1: u128, arg2: u128) : bool {
        arg0.max_heap && arg1 > arg2 || arg1 < arg2
    }

    fun add_side(arg0: &mut LiqBook, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        if (!0x2::table::contains<0x2::object::ID, SideNotional>(&arg0.sides, arg1)) {
            let v0 = SideNotional{
                long  : 0,
                short : 0,
            };
            0x2::table::add<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1);
        if (arg2) {
            v1.long = v1.long + arg3;
        } else {
            v1.short = v1.short + arg3;
        };
    }

    public fun borrow_record(arg0: &LiqBook, arg1: u64) : &LiqRecord {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1), 13835058630807781377);
        0x2::table::borrow<u64, LiqRecord>(&arg0.records, arg1)
    }

    public fun entry_bust(arg0: &HeapEntry) : u128 {
        arg0.bust_wad
    }

    public fun entry_position_id(arg0: &HeapEntry) : u64 {
        arg0.position_id
    }

    fun heap_push(arg0: &mut Heap, arg1: HeapEntry) {
        arg0.size = arg0.size + 1;
        let v0 = arg0.size;
        0x2::table::add<u64, HeapEntry>(&mut arg0.slots, v0, arg1);
        0x2::table::add<u64, u64>(&mut arg0.index, arg1.position_id, v0);
        sift_up(arg0, v0);
    }

    fun heap_remove(arg0: &mut Heap, arg1: u64) {
        let v0 = 0x2::table::remove<u64, u64>(&mut arg0.index, arg1);
        let v1 = arg0.size;
        arg0.size = v1 - 1;
        if (v0 == v1) {
            0x2::table::remove<u64, HeapEntry>(&mut arg0.slots, v1);
            return
        };
        let v2 = 0x2::table::remove<u64, HeapEntry>(&mut arg0.slots, v1);
        *0x2::table::borrow_mut<u64, HeapEntry>(&mut arg0.slots, v0) = v2;
        *0x2::table::borrow_mut<u64, u64>(&mut arg0.index, v2.position_id) = v0;
        let v3 = sift_up(arg0, v0);
        if (v3 == v0) {
            sift_down(arg0, v0);
        };
    }

    public fun insert(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: u64, arg3: LiqRecord) {
        assert!(!0x2::table::contains<u64, LiqRecord>(&arg1.records, arg2), 13835340019885277187);
        let v0 = if (arg3.is_long) {
            &mut arg1.long
        } else {
            &mut arg1.short
        };
        let v1 = HeapEntry{
            position_id : arg2,
            bust_wad    : arg3.bust_wad,
        };
        heap_push(v0, v1);
        add_side(arg1, arg3.account_id, arg3.is_long, arg3.notional);
        0x2::table::add<u64, LiqRecord>(&mut arg1.records, arg2, arg3);
    }

    public fun is_pending(arg0: &LiqBook, arg1: 0x2::object::ID, arg2: u64) : bool {
        0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.pending, arg1) && 0x1::vector::contains<u64>(0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg0.pending, arg1), &arg2)
    }

    fun new_heap(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : Heap {
        Heap{
            max_heap : arg0,
            size     : 0,
            slots    : 0x2::table::new<u64, HeapEntry>(arg1),
            index    : 0x2::table::new<u64, u64>(arg1),
        }
    }

    public fun opposite_notional(arg0: &LiqBook, arg1: 0x2::object::ID, arg2: bool) : u64 {
        if (!0x2::table::contains<0x2::object::ID, SideNotional>(&arg0.sides, arg1)) {
            return 0
        };
        if (arg2) {
            0x2::table::borrow<0x2::object::ID, SideNotional>(&arg0.sides, arg1).short
        } else {
            0x2::table::borrow<0x2::object::ID, SideNotional>(&arg0.sides, arg1).long
        }
    }

    public fun peek(arg0: &LiqBook, arg1: bool) : 0x1::option::Option<HeapEntry> {
        let v0 = if (arg1) {
            &arg0.long
        } else {
            &arg0.short
        };
        if (v0.size == 0) {
            0x1::option::none<HeapEntry>()
        } else {
            0x1::option::some<HeapEntry>(*0x2::table::borrow<u64, HeapEntry>(&v0.slots, 1))
        }
    }

    public fun pending_count(arg0: &LiqBook, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.pending, arg1)) {
            0
        } else {
            0x1::vector::length<u64>(0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg0.pending, arg1))
        }
    }

    public fun pop_top(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: bool) : HeapEntry {
        let v0 = if (arg2) {
            &mut arg1.long
        } else {
            &mut arg1.short
        };
        assert!(v0.size > 0, 13835058716707127297);
        let v1 = *0x2::table::borrow<u64, HeapEntry>(&v0.slots, 1);
        heap_remove(v0, v1.position_id);
        v1
    }

    public fun push_pending(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: 0x2::object::ID, arg3: u64) {
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg1.pending, arg2)) {
            let v0 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v0, arg3);
            0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg1.pending, arg2, v0);
        } else {
            0x1::vector::push_back<u64>(0x2::table::borrow_mut<0x2::object::ID, vector<u64>>(&mut arg1.pending, arg2), arg3);
        };
    }

    public fun r_account_id(arg0: &LiqRecord) : 0x2::object::ID {
        arg0.account_id
    }

    public fun r_bust(arg0: &LiqRecord) : u128 {
        arg0.bust_wad
    }

    public fun r_entry(arg0: &LiqRecord) : u128 {
        arg0.entry_wad
    }

    public fun r_exposure(arg0: &LiqRecord) : u64 {
        arg0.exposure
    }

    public fun r_is_long(arg0: &LiqRecord) : bool {
        arg0.is_long
    }

    public fun r_margin(arg0: &LiqRecord) : u64 {
        arg0.margin
    }

    public fun r_notional(arg0: &LiqRecord) : u64 {
        arg0.notional
    }

    public fun r_oracle_sequence(arg0: &LiqRecord) : u64 {
        arg0.open_oracle_sequence
    }

    public fun r_oracle_ts(arg0: &LiqRecord) : u64 {
        arg0.open_oracle_ts_ms
    }

    public fun r_owner(arg0: &LiqRecord) : address {
        arg0.owner
    }

    public fun r_wash(arg0: &LiqRecord) : bool {
        arg0.wash
    }

    public fun record(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u128, arg8: u128, arg9: u64, arg10: u64, arg11: bool) : LiqRecord {
        LiqRecord{
            account_id           : arg1,
            owner                : arg2,
            is_long              : arg3,
            margin               : arg4,
            notional             : arg5,
            exposure             : arg6,
            entry_wad            : arg7,
            bust_wad             : arg8,
            open_oracle_ts_ms    : arg9,
            open_oracle_sequence : arg10,
            wash                 : arg11,
        }
    }

    public fun reinsert(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: HeapEntry) {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg1.records, arg2.position_id), 13835058751066865665);
        let v0 = 0x2::table::borrow<u64, LiqRecord>(&arg1.records, arg2.position_id);
        assert!(v0.bust_wad == arg2.bust_wad, 13835058759656800257);
        let v1 = if (v0.is_long) {
            &mut arg1.long
        } else {
            &mut arg1.short
        };
        assert!(!0x2::table::contains<u64, u64>(&v1.index, arg2.position_id), 13835340243223576579);
        heap_push(v1, arg2);
    }

    public fun side_size(arg0: &LiqBook, arg1: bool) : u64 {
        if (arg1) {
            arg0.long.size
        } else {
            arg0.short.size
        }
    }

    fun sift_down(arg0: &mut Heap, arg1: u64) {
        loop {
            let v0 = 2 * arg1;
            if (v0 > arg0.size) {
                break
            };
            let v1 = v0 + 1;
            let v2 = v0;
            if (v1 <= arg0.size && above(arg0, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, v1).bust_wad, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, v0).bust_wad)) {
                v2 = v1;
            };
            if (!above(arg0, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, v2).bust_wad, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, arg1).bust_wad)) {
                break
            };
            swap(arg0, arg1, v2);
            arg1 = v2;
        };
    }

    fun sift_up(arg0: &mut Heap, arg1: u64) : u64 {
        while (arg1 > 1) {
            let v0 = arg1 / 2;
            if (!above(arg0, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, arg1).bust_wad, 0x2::table::borrow<u64, HeapEntry>(&arg0.slots, v0).bust_wad)) {
                break
            };
            swap(arg0, arg1, v0);
            arg1 = v0;
        };
        arg1
    }

    fun sub_side(arg0: &mut LiqBook, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1);
        if (arg2) {
            v0.long = v0.long - arg3;
        } else {
            v0.short = v0.short - arg3;
        };
        if (v0.long == 0 && v0.short == 0) {
            0x2::table::remove<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1);
        };
    }

    public fun take_pending(arg0: &0x8ed75821fd8b22202ff8dc2ad027989c29daa6862f35c0868fc588f6f6ae930a::access::Auth, arg1: &mut LiqBook, arg2: 0x2::object::ID, arg3: u64) : vector<u64> {
        let v0 = vector[];
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg1.pending, arg2)) {
            return v0
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, vector<u64>>(&mut arg1.pending, arg2);
        while (0x1::vector::length<u64>(&v0) < arg3 && !0x1::vector::is_empty<u64>(v1)) {
            0x1::vector::push_back<u64>(&mut v0, 0x1::vector::pop_back<u64>(v1));
        };
        if (0x1::vector::is_empty<u64>(v1)) {
            0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg1.pending, arg2);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

