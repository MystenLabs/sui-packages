module 0xbb735479c1ac4adff867904bc1f913d48650a8c2afc08495064a2f0890da92a1::amm_config {
    struct GlobalPauseStatus has key {
        id: 0x2::object::UID,
        pause: bool,
    }

    struct SetPauseEvent has copy, drop {
        sender: address,
        status: bool,
    }

    struct Pair has copy, drop, store {
        pair_a: 0x1::ascii::String,
        pair_b: 0x1::ascii::String,
    }

    struct PairStore has key {
        id: 0x2::object::UID,
        pairs: 0x2::table::Table<Pair, bool>,
    }

    public fun assert_pause(arg0: &GlobalPauseStatus) {
        assert!(!get_pause_status(arg0), 1);
    }

    public(friend) fun borrow_mut_pair(arg0: &mut PairStore) : &mut 0x2::table::Table<Pair, bool> {
        &mut arg0.pairs
    }

    fun get_pause_status(arg0: &GlobalPauseStatus) : bool {
        arg0.pause
    }

    public(friend) fun new_global_pause_status_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = GlobalPauseStatus{
            id    : 0x2::object::new(arg0),
            pause : false,
        };
        0x2::transfer::share_object<GlobalPauseStatus>(v0);
        0x2::object::id<GlobalPauseStatus>(&v0)
    }

    public(friend) fun new_pair(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String) : Pair {
        Pair{
            pair_a : arg0,
            pair_b : arg1,
        }
    }

    public(friend) fun new_pair_store_and_shared(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PairStore{
            id    : 0x2::object::new(arg0),
            pairs : 0x2::table::new<Pair, bool>(arg0),
        };
        0x2::transfer::share_object<PairStore>(v0);
        0x2::object::id<PairStore>(&v0)
    }

    public(friend) fun set_status_and_emit_event(arg0: &mut GlobalPauseStatus, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.pause = arg1;
        let v0 = SetPauseEvent{
            sender : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<SetPauseEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

