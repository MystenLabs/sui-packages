module 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::liq_book {
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
        hedged: bool,
    }

    struct LiqBook has store {
        long: Heap,
        short: Heap,
        records: 0x2::table::Table<u64, LiqRecord>,
        pending: 0x2::table::Table<0x2::object::ID, PendingList>,
        sides: 0x2::table::Table<0x2::object::ID, SideNotional>,
        liq_since: 0x2::table::Table<u64, LiqFlag>,
        obs_hi: ObsStack,
        obs_lo: ObsStack,
    }

    struct PendingList has store {
        ids: 0x2::table::Table<u64, u64>,
        slots: 0x2::table::Table<u64, u64>,
    }

    struct LiqFlag has copy, drop, store {
        since_ms: u64,
        oracle_ts_ms: u64,
    }

    struct Obs has copy, drop, store {
        bucket: u64,
        ts_ms: u64,
        mid_wad: u128,
    }

    struct ObsStack has store {
        keep_max: bool,
        head: u64,
        tail: u64,
        items: 0x2::table::Table<u64, Obs>,
        pruned_ts_ms: 0x1::option::Option<u64>,
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

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : LiqBook {
        let v0 = new_heap(true, arg0);
        let v1 = new_heap(false, arg0);
        let v2 = 0x2::table::new<u64, LiqRecord>(arg0);
        let v3 = 0x2::table::new<0x2::object::ID, PendingList>(arg0);
        let v4 = 0x2::table::new<0x2::object::ID, SideNotional>(arg0);
        let v5 = 0x2::table::new<u64, LiqFlag>(arg0);
        let v6 = new_obs(true, arg0);
        LiqBook{
            long      : v0,
            short     : v1,
            records   : v2,
            pending   : v3,
            sides     : v4,
            liq_since : v5,
            obs_hi    : v6,
            obs_lo    : new_obs(false, arg0),
        }
    }

    public fun remove(arg0: &mut LiqBook, arg1: u64) : LiqRecord {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1), 13835058905685688321);
        let v0 = 0x2::table::remove<u64, LiqRecord>(&mut arg0.records, arg1);
        let v1 = if (v0.is_long) {
            &mut arg0.long
        } else {
            &mut arg0.short
        };
        heap_remove(v1, arg1);
        sub_side(arg0, v0.account_id, v0.is_long, v0.notional);
        if (0x2::table::contains<u64, LiqFlag>(&arg0.liq_since, arg1)) {
            0x2::table::remove<u64, LiqFlag>(&mut arg0.liq_since, arg1);
        };
        v0
    }

    fun above(arg0: &Heap, arg1: u128, arg2: u128) : bool {
        arg0.max_heap && arg1 > arg2 || arg1 < arg2
    }

    fun add_side(arg0: &mut LiqBook, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        if (!0x2::table::contains<0x2::object::ID, SideNotional>(&arg0.sides, arg1)) {
            let v0 = SideNotional{
                long   : 0,
                short  : 0,
                hedged : false,
            };
            0x2::table::add<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, SideNotional>(&mut arg0.sides, arg1);
        if (arg2) {
            v1.long = v1.long + arg3;
        } else {
            v1.short = v1.short + arg3;
        };
        if (v1.long > 0 && v1.short > 0) {
            v1.hedged = true;
        };
    }

    public fun borrow_record(arg0: &LiqBook, arg1: u64) : &LiqRecord {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1), 13835059661599932417);
        0x2::table::borrow<u64, LiqRecord>(&arg0.records, arg1)
    }

    public fun clear_since(arg0: &mut LiqBook, arg1: u64) : bool {
        if (!0x2::table::contains<u64, LiqFlag>(&arg0.liq_since, arg1)) {
            return false
        };
        0x2::table::remove<u64, LiqFlag>(&mut arg0.liq_since, arg1);
        true
    }

    public fun entry_bust(arg0: &HeapEntry) : u128 {
        arg0.bust_wad
    }

    public fun entry_position_id(arg0: &HeapEntry) : u64 {
        arg0.position_id
    }

    public fun flag_live(arg0: &LiqBook, arg1: u64) : bool {
        if (!0x2::table::contains<u64, LiqFlag>(&arg0.liq_since, arg1)) {
            return false
        };
        let v0 = *0x2::table::borrow<u64, LiqFlag>(&arg0.liq_since, arg1);
        let v1 = 0x2::table::borrow<u64, LiqRecord>(&arg0.records, arg1);
        let v2 = if (v1.is_long) {
            &arg0.obs_hi
        } else {
            &arg0.obs_lo
        };
        if (0x1::option::is_some<u64>(&v2.pruned_ts_ms) && v0.oracle_ts_ms <= *0x1::option::borrow<u64>(&v2.pruned_ts_ms)) {
            return false
        };
        let v3 = obs_since(v2, v0.oracle_ts_ms);
        if (0x1::option::is_none<u128>(&v3)) {
            return true
        };
        v1.is_long && 0x1::option::destroy_some<u128>(v3) <= v1.bust_wad || 0x1::option::destroy_some<u128>(v3) >= v1.bust_wad
    }

    public fun flag_since(arg0: &mut LiqBook, arg1: u64, arg2: u64, arg3: u64) : u64 {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1), 13835059051714576385);
        if (!flag_live(arg0, arg1)) {
            if (0x2::table::contains<u64, LiqFlag>(&arg0.liq_since, arg1)) {
                0x2::table::remove<u64, LiqFlag>(&mut arg0.liq_since, arg1);
            };
            let v0 = LiqFlag{
                since_ms     : arg2,
                oracle_ts_ms : arg3,
            };
            0x2::table::add<u64, LiqFlag>(&mut arg0.liq_since, arg1, v0);
        };
        0x2::table::borrow<u64, LiqFlag>(&arg0.liq_since, arg1).since_ms
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

    public fun insert(arg0: &mut LiqBook, arg1: u64, arg2: LiqRecord) {
        assert!(!0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1), 13835340342007824387);
        let v0 = if (arg2.is_long) {
            &mut arg0.long
        } else {
            &mut arg0.short
        };
        let v1 = HeapEntry{
            position_id : arg1,
            bust_wad    : arg2.bust_wad,
        };
        heap_push(v0, v1);
        add_side(arg0, arg2.account_id, arg2.is_long, arg2.notional);
        0x2::table::add<u64, LiqRecord>(&mut arg0.records, arg1, arg2);
    }

    public fun is_hedged(arg0: &LiqBook, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, SideNotional>(&arg0.sides, arg1) && 0x2::table::borrow<0x2::object::ID, SideNotional>(&arg0.sides, arg1).hedged
    }

    public fun is_pending(arg0: &LiqBook, arg1: 0x2::object::ID, arg2: u64) : bool {
        0x2::table::contains<0x2::object::ID, PendingList>(&arg0.pending, arg1) && 0x2::table::contains<u64, u64>(&0x2::table::borrow<0x2::object::ID, PendingList>(&arg0.pending, arg1).slots, arg2)
    }

    public fun liq_since(arg0: &LiqBook, arg1: u64) : 0x1::option::Option<u64> {
        if (flag_live(arg0, arg1)) {
            0x1::option::some<u64>(0x2::table::borrow<u64, LiqFlag>(&arg0.liq_since, arg1).since_ms)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun new_heap(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : Heap {
        Heap{
            max_heap : arg0,
            size     : 0,
            slots    : 0x2::table::new<u64, HeapEntry>(arg1),
            index    : 0x2::table::new<u64, u64>(arg1),
        }
    }

    fun new_obs(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : ObsStack {
        ObsStack{
            keep_max     : arg0,
            head         : 0,
            tail         : 0,
            items        : 0x2::table::new<u64, Obs>(arg1),
            pruned_ts_ms : 0x1::option::none<u64>(),
        }
    }

    fun obs_cap(arg0: &mut ObsStack) {
        if (arg0.tail - arg0.head <= 320) {
            return
        };
        let v0 = 0x2::table::remove<u64, Obs>(&mut arg0.items, arg0.head);
        arg0.head = arg0.head + 1;
        obs_mark_pruned(arg0, v0.ts_ms);
    }

    fun obs_dominates(arg0: &ObsStack, arg1: u128, arg2: u128) : bool {
        arg0.keep_max && arg1 >= arg2 || arg1 <= arg2
    }

    fun obs_insert(arg0: &mut ObsStack, arg1: u128, arg2: u64) {
        let v0 = obs_lower_bound(arg0, arg2);
        if (obs_dominates(arg0, 0x2::table::borrow<u64, Obs>(&arg0.items, v0).mid_wad, arg1)) {
            return
        };
        if (0x1::option::is_some<u64>(&arg0.pruned_ts_ms) && arg2 <= *0x1::option::borrow<u64>(&arg0.pruned_ts_ms)) {
            return
        };
        if (0x2::table::borrow<u64, Obs>(&arg0.items, v0).ts_ms == arg2) {
            0x2::table::borrow_mut<u64, Obs>(&mut arg0.items, v0).mid_wad = arg1;
        } else {
            if (arg0.tail - v0 > 16) {
                obs_mark_pruned(arg0, arg2);
                return
            };
            let v1 = arg0.tail;
            while (v1 > v0) {
                0x2::table::add<u64, Obs>(&mut arg0.items, v1, 0x2::table::remove<u64, Obs>(&mut arg0.items, v1 - 1));
                v1 = v1 - 1;
            };
            let v2 = Obs{
                bucket  : arg2 / 2000,
                ts_ms   : arg2,
                mid_wad : arg1,
            };
            0x2::table::add<u64, Obs>(&mut arg0.items, v0, v2);
            arg0.tail = arg0.tail + 1;
            obs_cap(arg0);
        };
        let v3 = 0;
        while (v0 > arg0.head && !obs_dominates(arg0, 0x2::table::borrow<u64, Obs>(&arg0.items, v0 - 1).mid_wad, arg1)) {
            if (v3 == 16) {
                let v4 = 0x2::table::borrow<u64, Obs>(&arg0.items, v0 - 1).ts_ms;
                obs_mark_pruned(arg0, v4);
                return
            };
            0x2::table::borrow_mut<u64, Obs>(&mut arg0.items, v0 - 1).mid_wad = arg1;
            v0 = v0 - 1;
            v3 = v3 + 1;
        };
    }

    fun obs_lower_bound(arg0: &ObsStack, arg1: u64) : u64 {
        let v0 = arg0.tail;
        let v1 = arg0.head;
        while (v1 < v0) {
            v0 = v1 + (v0 - v1) / 2;
            if (0x2::table::borrow<u64, Obs>(&arg0.items, v0).ts_ms >= arg1) {
                continue
            };
            v1 = v0 + 1;
        };
        v1
    }

    fun obs_mark_pruned(arg0: &mut ObsStack, arg1: u64) {
        if (0x1::option::is_none<u64>(&arg0.pruned_ts_ms) || arg1 > *0x1::option::borrow<u64>(&arg0.pruned_ts_ms)) {
            arg0.pruned_ts_ms = 0x1::option::some<u64>(arg1);
        };
    }

    fun obs_push(arg0: &mut ObsStack, arg1: u128, arg2: u64) {
        if (arg0.tail > arg0.head && arg2 < 0x2::table::borrow<u64, Obs>(&arg0.items, arg0.tail - 1).ts_ms) {
            obs_insert(arg0, arg1, arg2);
            return
        };
        while (arg0.tail > arg0.head && obs_dominates(arg0, arg1, 0x2::table::borrow<u64, Obs>(&arg0.items, arg0.tail - 1).mid_wad)) {
            arg0.tail = arg0.tail - 1;
            0x2::table::remove<u64, Obs>(&mut arg0.items, arg0.tail);
        };
        let v0 = arg2 / 2000;
        if (arg0.tail > arg0.head && 0x2::table::borrow<u64, Obs>(&arg0.items, arg0.tail - 1).bucket == v0) {
            0x2::table::borrow_mut<u64, Obs>(&mut arg0.items, arg0.tail - 1).ts_ms = arg2;
        } else {
            let v1 = Obs{
                bucket  : v0,
                ts_ms   : arg2,
                mid_wad : arg1,
            };
            0x2::table::add<u64, Obs>(&mut arg0.items, arg0.tail, v1);
            arg0.tail = arg0.tail + 1;
            obs_cap(arg0);
        };
        let v2 = 0;
        while (v2 < 4 && arg0.tail - arg0.head > 1) {
            let v3 = 0x2::table::borrow<u64, Obs>(&arg0.items, arg0.head).ts_ms;
            if (v3 + 600000 >= arg2) {
                break
            };
            0x2::table::remove<u64, Obs>(&mut arg0.items, arg0.head);
            arg0.head = arg0.head + 1;
            obs_mark_pruned(arg0, v3);
            v2 = v2 + 1;
        };
    }

    fun obs_since(arg0: &ObsStack, arg1: u64) : 0x1::option::Option<u128> {
        let v0 = obs_lower_bound(arg0, arg1);
        if (v0 == arg0.tail) {
            0x1::option::none<u128>()
        } else {
            0x1::option::some<u128>(0x2::table::borrow<u64, Obs>(&arg0.items, v0).mid_wad)
        }
    }

    public fun observe(arg0: &mut LiqBook, arg1: u128, arg2: u64) {
        let v0 = &mut arg0.obs_hi;
        obs_push(v0, arg1, arg2);
        let v1 = &mut arg0.obs_lo;
        obs_push(v1, arg1, arg2);
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
        if (!0x2::table::contains<0x2::object::ID, PendingList>(&arg0.pending, arg1)) {
            0
        } else {
            0x2::table::length<u64, u64>(&0x2::table::borrow<0x2::object::ID, PendingList>(&arg0.pending, arg1).ids)
        }
    }

    public fun pop_top(arg0: &mut LiqBook, arg1: bool) : HeapEntry {
        let v0 = if (arg1) {
            &mut arg0.long
        } else {
            &mut arg0.short
        };
        assert!(v0.size > 0, 13835059747499278337);
        let v1 = *0x2::table::borrow<u64, HeapEntry>(&v0.slots, 1);
        heap_remove(v0, v1.position_id);
        v1
    }

    public fun push_pending(arg0: &mut LiqBook, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, PendingList>(&arg0.pending, arg1)) {
            let v0 = PendingList{
                ids   : 0x2::table::new<u64, u64>(arg3),
                slots : 0x2::table::new<u64, u64>(arg3),
            };
            0x2::table::add<0x2::object::ID, PendingList>(&mut arg0.pending, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PendingList>(&mut arg0.pending, arg1);
        let v2 = 0x2::table::length<u64, u64>(&v1.ids);
        0x2::table::add<u64, u64>(&mut v1.ids, v2, arg2);
        0x2::table::add<u64, u64>(&mut v1.slots, arg2, v2);
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

    public fun record(arg0: 0x2::object::ID, arg1: address, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: bool) : LiqRecord {
        LiqRecord{
            account_id           : arg0,
            owner                : arg1,
            is_long              : arg2,
            margin               : arg3,
            notional             : arg4,
            exposure             : arg5,
            entry_wad            : arg6,
            bust_wad             : arg7,
            open_oracle_ts_ms    : arg8,
            open_oracle_sequence : arg9,
            wash                 : arg10,
        }
    }

    public fun reinsert(arg0: &mut LiqBook, arg1: HeapEntry) {
        assert!(0x2::table::contains<u64, LiqRecord>(&arg0.records, arg1.position_id), 13835059781859016705);
        let v0 = 0x2::table::borrow<u64, LiqRecord>(&arg0.records, arg1.position_id);
        assert!(v0.bust_wad == arg1.bust_wad, 13835059790448951297);
        let v1 = if (v0.is_long) {
            &mut arg0.long
        } else {
            &mut arg0.short
        };
        assert!(!0x2::table::contains<u64, u64>(&v1.index, arg1.position_id), 13835341274015727619);
        heap_push(v1, arg1);
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

    public fun take_pending(arg0: &mut LiqBook, arg1: 0x2::object::ID, arg2: u64) : vector<u64> {
        let v0 = vector[];
        if (!0x2::table::contains<0x2::object::ID, PendingList>(&arg0.pending, arg1)) {
            return v0
        };
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, PendingList>(&mut arg0.pending, arg1);
        while (0x1::vector::length<u64>(&v0) < arg2 && 0x2::table::length<u64, u64>(&v1.ids) > 0) {
            let v2 = 0x2::table::remove<u64, u64>(&mut v1.ids, 0x2::table::length<u64, u64>(&v1.ids) - 1);
            0x2::table::remove<u64, u64>(&mut v1.slots, v2);
            0x1::vector::push_back<u64>(&mut v0, v2);
        };
        if (0x2::table::length<u64, u64>(&v1.ids) == 0) {
            let PendingList {
                ids   : v3,
                slots : v4,
            } = 0x2::table::remove<0x2::object::ID, PendingList>(&mut arg0.pending, arg1);
            0x2::table::destroy_empty<u64, u64>(v3);
            0x2::table::destroy_empty<u64, u64>(v4);
        };
        v0
    }

    // decompiled from Move bytecode v7
}

