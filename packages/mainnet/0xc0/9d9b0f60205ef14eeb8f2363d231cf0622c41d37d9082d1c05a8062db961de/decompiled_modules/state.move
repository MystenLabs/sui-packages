module 0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::state {
    struct MaxTradeSizeConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        quote_seconds_to_live: u32,
        tx_count: u64,
        version: u64,
        guardians: vector<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>,
    }

    public(friend) fun new(arg0: u32, arg1: vector<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>, arg2: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                    : 0x2::object::new(arg2),
            is_paused             : false,
            quote_seconds_to_live : arg0,
            tx_count              : 0,
            version               : 1,
            guardians             : arg1,
        }
    }

    public fun assert_not_pause(arg0: &State) {
        assert!(!arg0.is_paused, 3);
    }

    public fun assert_version(arg0: &State) {
        assert!(arg0.version == 1, 1);
    }

    public fun borrow_guardians(arg0: &State) : &vector<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian> {
        &arg0.guardians
    }

    public(friend) fun increase_tx_count(arg0: &mut State) : u64 {
        arg0.tx_count = arg0.tx_count + 1;
        arg0.tx_count
    }

    public fun is_paused(arg0: &State) : bool {
        arg0.is_paused
    }

    public fun num_guardians(arg0: &State) : u64 {
        0x1::vector::length<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>(&arg0.guardians)
    }

    public(friend) fun pause(arg0: &mut State) {
        arg0.is_paused = true;
    }

    public fun quote_seconds_to_live(arg0: &State) : u32 {
        arg0.quote_seconds_to_live
    }

    public(friend) fun set_guardians(arg0: &mut State, arg1: vector<0xc09d9b0f60205ef14eeb8f2363d231cf0622c41d37d9082d1c05a8062db961de::guardian::Guardian>) {
        arg0.guardians = arg1;
    }

    public(friend) fun set_quote_seconds_to_live(arg0: &mut State, arg1: u32) {
        arg0.quote_seconds_to_live = arg1;
    }

    public fun tx_count(arg0: &State) : u64 {
        arg0.tx_count
    }

    public(friend) fun unpause(arg0: &mut State) {
        arg0.is_paused = false;
    }

    public(friend) fun upgrade(arg0: &mut State) {
        assert!(arg0.version < 1, 2);
        arg0.version = 1;
    }

    public fun version(arg0: &State) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

