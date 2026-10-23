module 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::bounty {
    struct Entry has copy, drop, store {
        hunter: address,
        link: 0x1::string::String,
        note: 0x1::string::String,
        at_ms: u64,
    }

    struct Bounty<phantom T0> has key {
        id: 0x2::object::UID,
        poster: address,
        title: 0x1::string::String,
        brief: 0x1::string::String,
        amount: u64,
        escrow: 0x2::balance::Balance<T0>,
        entries: vector<Entry>,
        deadline_ms: u64,
        judge_ms: u64,
        arbiter_ms: u64,
        status: u8,
        winner: address,
        reason: 0x1::string::String,
        created_ms: u64,
        review_ms: u64,
        version: u64,
    }

    struct BountyPosted has copy, drop {
        bounty: 0x2::object::ID,
        poster: address,
        amount: u64,
        deadline_ms: u64,
        coin: 0x1::ascii::String,
    }

    struct EntrySubmitted has copy, drop {
        bounty: 0x2::object::ID,
        hunter: address,
        index: u64,
    }

    struct BountyPaid has copy, drop {
        bounty: 0x2::object::ID,
        winner: address,
        paid: u64,
        fee: u64,
        how: u8,
    }

    struct BountyRefunded has copy, drop {
        bounty: 0x2::object::ID,
        poster: address,
        amount: u64,
        how: u8,
    }

    struct BountyInReview has copy, drop {
        bounty: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct BountySplit has copy, drop {
        bounty: 0x2::object::ID,
        each: u64,
        entrants: u64,
    }

    struct BountyPicked has copy, drop {
        bounty: 0x2::object::ID,
        winner: address,
        index: u64,
        until_ms: u64,
    }

    struct BountyFlagged has copy, drop {
        bounty: 0x2::object::ID,
        by: address,
        reason: 0x1::string::String,
    }

    struct PickKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pick has drop, store {
        index: u64,
        picked_ms: u64,
        until_ms: u64,
        flagged_by: address,
    }

    struct HiddenKey has copy, drop, store {
        dummy_field: bool,
    }

    struct EntryHidden has copy, drop {
        bounty: 0x2::object::ID,
        index: u64,
        by: address,
        hidden: bool,
    }

    public fun cancel<T0>(arg0: &mut Bounty<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.poster, 3);
        assert!(arg0.status == 0, 2);
        assert!(0x1::vector::is_empty<Entry>(&arg0.entries), 8);
        refund<T0>(arg0, 2, 0, arg1);
    }

    public fun deadline_ms<T0>(arg0: &Bounty<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun entries_count<T0>(arg0: &Bounty<T0>) : u64 {
        0x1::vector::length<Entry>(&arg0.entries)
    }

    public fun escrow_value<T0>(arg0: &Bounty<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.escrow)
    }

    public fun extend<T0>(arg0: &mut Bounty<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.poster, 3);
        assert!(arg0.status == 0, 2);
        assert!(arg1 > arg0.deadline_ms && arg1 <= 0x2::clock::timestamp_ms(arg2) + 5184000000, 13);
        arg0.deadline_ms = arg1;
    }

    public fun finalize_pick<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 6, 2);
        let v0 = PickKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow<PickKey, Pick>(&arg1.id, v0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.until_ms, 6);
        pay_winner<T0>(arg0, arg1, v1.index, 0, arg3);
    }

    fun find<T0>(arg0: &Bounty<T0>, arg1: address) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Entry>(&arg0.entries)) {
            if (0x1::vector::borrow<Entry>(&arg0.entries, v0).hunter == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun flag<T0>(arg0: &mut Bounty<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.status == 6, 2);
        let (v1, _) = find<T0>(arg0, v0);
        assert!(v1 && v0 != arg0.winner, 14);
        len_ok(&arg1, 500, false);
        let v3 = 0x2::clock::timestamp_ms(arg2);
        let v4 = PickKey{dummy_field: false};
        let v5 = 0x2::dynamic_field::borrow_mut<PickKey, Pick>(&mut arg0.id, v4);
        assert!(v3 < v5.until_ms, 5);
        v5.flagged_by = v0;
        let v6 = BountyFlagged{
            bounty : 0x2::object::id<Bounty<T0>>(arg0),
            by     : v0,
            reason : arg1,
        };
        0x2::event::emit<BountyFlagged>(v6);
        to_review<T0>(arg0, arg1, v3);
    }

    public fun flagged_by<T0>(arg0: &Bounty<T0>) : address {
        let v0 = PickKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PickKey>(&arg0.id, v0)) {
            let v2 = PickKey{dummy_field: false};
            0x2::dynamic_field::borrow<PickKey, Pick>(&arg0.id, v2).flagged_by
        } else {
            @0x0
        }
    }

    public fun hidden_entries<T0>(arg0: &Bounty<T0>) : vector<u64> {
        let v0 = HiddenKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<HiddenKey>(&arg0.id, v0)) {
            let v2 = HiddenKey{dummy_field: false};
            *0x2::dynamic_field::borrow<HiddenKey, vector<u64>>(&arg0.id, v2)
        } else {
            vector[]
        }
    }

    fun len_ok(arg0: &0x1::string::String, arg1: u64, arg2: bool) {
        let v0 = 0x1::vector::length<u8>(0x1::string::as_bytes(arg0));
        assert!(v0 <= arg1 && (arg2 || v0 > 0), 1);
    }

    public fun no_winner<T0>(arg0: &mut Bounty<T0>, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.poster, 3);
        assert!(arg0.status == 0, 2);
        assert!(!0x1::vector::is_empty<Entry>(&arg0.entries), 9);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.deadline_ms, 6);
        assert!(v0 < arg0.deadline_ms + arg0.judge_ms, 5);
        len_ok(&arg1, 500, false);
        to_review<T0>(arg0, arg1, v0);
    }

    fun pay_winner<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: u64, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x1::vector::length<Entry>(&arg1.entries), 10);
        let v0 = 0x1::vector::borrow<Entry>(&arg1.entries, arg2).hunter;
        let (v1, v2) = 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::pay<T0>(arg0, &mut arg1.escrow, 0x2::balance::value<T0>(&arg1.escrow), v0, arg1.poster, arg4);
        arg1.winner = v0;
        arg1.status = 1;
        let v3 = BountyPaid{
            bounty : 0x2::object::id<Bounty<T0>>(arg1),
            winner : v0,
            paid   : v1,
            fee    : v2,
            how    : arg3,
        };
        0x2::event::emit<BountyPaid>(v3);
    }

    public fun pick<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg1.poster, 3);
        assert!(arg1.status == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < arg1.deadline_ms + arg1.judge_ms, 5);
        assert!(arg2 < 0x1::vector::length<Entry>(&arg1.entries), 10);
        let v1 = v0 + 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::review_ms(arg0);
        arg1.winner = 0x1::vector::borrow<Entry>(&arg1.entries, arg2).hunter;
        arg1.status = 6;
        let v2 = PickKey{dummy_field: false};
        let v3 = Pick{
            index      : arg2,
            picked_ms  : v0,
            until_ms   : v1,
            flagged_by : @0x0,
        };
        0x2::dynamic_field::add<PickKey, Pick>(&mut arg1.id, v2, v3);
        let v4 = BountyPicked{
            bounty   : 0x2::object::id<Bounty<T0>>(arg1),
            winner   : arg1.winner,
            index    : arg2,
            until_ms : v1,
        };
        0x2::event::emit<BountyPicked>(v4);
    }

    public fun pick_until_ms<T0>(arg0: &Bounty<T0>) : u64 {
        let v0 = PickKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<PickKey>(&arg0.id, v0)) {
            let v2 = PickKey{dummy_field: false};
            0x2::dynamic_field::borrow<PickKey, Pick>(&arg0.id, v2).until_ms
        } else {
            0
        }
    }

    public fun post<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        len_ok(&arg1, 80, false);
        len_ok(&arg2, 1000, false);
        assert!(arg3 >= 60000 && arg3 <= 5184000000, 13);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 12);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = Bounty<T0>{
            id          : 0x2::object::new(arg6),
            poster      : 0x2::tx_context::sender(arg6),
            title       : arg1,
            brief       : arg2,
            amount      : v0,
            escrow      : 0x2::coin::into_balance<T0>(arg4),
            entries     : 0x1::vector::empty<Entry>(),
            deadline_ms : v1 + arg3,
            judge_ms    : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::judge_ms(arg0),
            arbiter_ms  : 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter_ms(arg0),
            status      : 0,
            winner      : @0x0,
            reason      : 0x1::string::utf8(b""),
            created_ms  : v1,
            review_ms   : 0,
            version     : 1,
        };
        let v3 = 0x2::object::id<Bounty<T0>>(&v2);
        let v4 = BountyPosted{
            bounty      : v3,
            poster      : v2.poster,
            amount      : v0,
            deadline_ms : v2.deadline_ms,
            coin        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
        };
        0x2::event::emit<BountyPosted>(v4);
        0x2::transfer::share_object<Bounty<T0>>(v2);
        v3
    }

    fun refund<T0>(arg0: &mut Bounty<T0>, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0.escrow);
        let v1 = arg0.poster;
        0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::give_back<T0>(&mut arg0.escrow, v0, v1, arg3);
        arg0.status = arg1;
        let v2 = BountyRefunded{
            bounty : 0x2::object::id<Bounty<T0>>(arg0),
            poster : v1,
            amount : v0,
            how    : arg2,
        };
        0x2::event::emit<BountyRefunded>(v2);
    }

    public fun resolve_pick<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter(arg0), 11);
        assert!(arg1.status == 3 || arg1.status == 6, 2);
        pay_winner<T0>(arg0, arg1, arg2, 1, arg3);
    }

    public fun resolve_refund<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter(arg0), 11);
        assert!(arg1.status == 3 || arg1.status == 6, 2);
        refund<T0>(arg1, 4, 2, arg2);
    }

    public fun set_hidden<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: u64, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg1.poster || v0 == 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::arbiter(arg0), 3);
        assert!(arg2 < 0x1::vector::length<Entry>(&arg1.entries), 10);
        let v1 = HiddenKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<HiddenKey>(&arg1.id, v1)) {
            let v2 = HiddenKey{dummy_field: false};
            0x2::dynamic_field::add<HiddenKey, vector<u64>>(&mut arg1.id, v2, vector[]);
        };
        let v3 = HiddenKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<HiddenKey, vector<u64>>(&mut arg1.id, v3);
        let (v5, v6) = 0x1::vector::index_of<u64>(v4, &arg2);
        if (arg3 && !v5) {
            0x1::vector::push_back<u64>(v4, arg2);
        };
        if (!arg3 && v5) {
            0x1::vector::remove<u64>(v4, v6);
        };
        let v7 = EntryHidden{
            bounty : 0x2::object::id<Bounty<T0>>(arg1),
            index  : arg2,
            by     : v0,
            hidden : arg3,
        };
        0x2::event::emit<EntryHidden>(v7);
    }

    public fun settle<T0>(arg0: &mut Bounty<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.deadline_ms + arg0.judge_ms, 6);
        if (0x1::vector::is_empty<Entry>(&arg0.entries)) {
            refund<T0>(arg0, 4, 1, arg2);
        } else {
            to_review<T0>(arg0, 0x1::string::utf8(b"The poster didn't pick a winner in time."), v0);
        };
    }

    public fun split_after_silence<T0>(arg0: &0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::WorkConfig, arg1: &mut Bounty<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 3, 2);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.review_ms + arg1.arbiter_ms, 6);
        let v0 = 0x1::vector::length<Entry>(&arg1.entries);
        let v1 = 0x2::balance::value<T0>(&arg1.escrow);
        let v2 = v1 / v0;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = if (v3 == 0) {
                v2 + v1 % v0
            } else {
                v2
            };
            let (_, _) = 0x2ff3f89af85ea15b5561e0f25b447dc498105885f8d12e54849d8ea26e99b9b4::work::pay<T0>(arg0, &mut arg1.escrow, v4, 0x1::vector::borrow<Entry>(&arg1.entries, v3).hunter, arg1.poster, arg3);
            v3 = v3 + 1;
        };
        arg1.status = 5;
        let v7 = BountySplit{
            bounty   : 0x2::object::id<Bounty<T0>>(arg1),
            each     : v2,
            entrants : v0,
        };
        0x2::event::emit<BountySplit>(v7);
    }

    public fun status<T0>(arg0: &Bounty<T0>) : u8 {
        arg0.status
    }

    public fun submit<T0>(arg0: &mut Bounty<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.status == 0, 2);
        assert!(v0 != arg0.poster, 4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 < arg0.deadline_ms, 5);
        len_ok(&arg1, 300, false);
        len_ok(&arg2, 500, true);
        let v2 = Entry{
            hunter : v0,
            link   : arg1,
            note   : arg2,
            at_ms  : v1,
        };
        let (v3, v4) = find<T0>(arg0, v0);
        if (v3) {
            *0x1::vector::borrow_mut<Entry>(&mut arg0.entries, v4) = v2;
            let v5 = EntrySubmitted{
                bounty : 0x2::object::id<Bounty<T0>>(arg0),
                hunter : v0,
                index  : v4,
            };
            0x2::event::emit<EntrySubmitted>(v5);
        } else {
            assert!(0x1::vector::length<Entry>(&arg0.entries) < 100, 7);
            0x1::vector::push_back<Entry>(&mut arg0.entries, v2);
            let v6 = EntrySubmitted{
                bounty : 0x2::object::id<Bounty<T0>>(arg0),
                hunter : v0,
                index  : 0x1::vector::length<Entry>(&arg0.entries) - 1,
            };
            0x2::event::emit<EntrySubmitted>(v6);
        };
    }

    fun to_review<T0>(arg0: &mut Bounty<T0>, arg1: 0x1::string::String, arg2: u64) {
        arg0.status = 3;
        arg0.reason = arg1;
        arg0.review_ms = arg2;
        let v0 = BountyInReview{
            bounty : 0x2::object::id<Bounty<T0>>(arg0),
            reason : arg1,
        };
        0x2::event::emit<BountyInReview>(v0);
    }

    public fun winner<T0>(arg0: &Bounty<T0>) : address {
        arg0.winner
    }

    // decompiled from Move bytecode v7
}

