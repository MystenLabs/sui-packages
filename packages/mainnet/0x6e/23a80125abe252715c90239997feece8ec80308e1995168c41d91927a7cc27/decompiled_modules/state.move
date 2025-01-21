module 0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::state {
    struct MaxTradeSizeConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SignatureKey has copy, drop, store {
        bytes: vector<u8>,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        is_paused: bool,
        quote_seconds_to_live: u32,
        tx_count: u64,
        version: u64,
        guardians: vector<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>,
    }

    public(friend) fun new(arg0: u32, arg1: vector<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>, arg2: &mut 0x2::tx_context::TxContext) : State {
        State{
            id                    : 0x2::object::new(arg2),
            is_paused             : false,
            quote_seconds_to_live : arg0,
            tx_count              : 0,
            version               : 2,
            guardians             : arg1,
        }
    }

    public fun assert_not_pause(arg0: &State) {
        assert!(!arg0.is_paused, 3);
    }

    public fun assert_version(arg0: &State) {
        assert!(arg0.version == 2, 1);
    }

    public fun borrow_guardians(arg0: &State) : &vector<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian> {
        &arg0.guardians
    }

    public(friend) fun increase_tx_count(arg0: &mut State) : u64 {
        arg0.tx_count = arg0.tx_count + 1;
        arg0.tx_count
    }

    public fun is_paused(arg0: &State) : bool {
        arg0.is_paused
    }

    public(friend) fun mark_signatures(arg0: &mut State, arg1: vector<vector<u8>>) {
        0x1::vector::reverse<vector<u8>>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v1 = SignatureKey{bytes: 0x1::vector::pop_back<vector<u8>>(&mut arg1)};
            if (!0x2::dynamic_field::exists_<SignatureKey>(&arg0.id, v1)) {
                0x2::dynamic_field::add<SignatureKey, u64>(&mut arg0.id, v1, 0);
            };
            let v2 = 0x2::dynamic_field::borrow_mut<SignatureKey, u64>(&mut arg0.id, v1);
            assert!(*v2 < 5, 4);
            *v2 = *v2 + 1;
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<vector<u8>>(arg1);
    }

    public fun num_guardians(arg0: &State) : u64 {
        0x1::vector::length<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>(&arg0.guardians)
    }

    public(friend) fun pause(arg0: &mut State) {
        arg0.is_paused = true;
    }

    public fun quote_seconds_to_live(arg0: &State) : u32 {
        arg0.quote_seconds_to_live
    }

    public(friend) fun set_guardians(arg0: &mut State, arg1: vector<0xc83a99245618b05201f3fb04d3a22abbcbe82be7c847dd48a59a531f8feeb37c::guardian::Guardian>) {
        arg0.guardians = arg1;
    }

    public(friend) fun set_quote_seconds_to_live(arg0: &mut State, arg1: u32) {
        arg0.quote_seconds_to_live = arg1;
    }

    public fun signature_hits(arg0: &State, arg1: vector<u8>) : u64 {
        let v0 = SignatureKey{bytes: arg1};
        if (!0x2::dynamic_field::exists_<SignatureKey>(&arg0.id, v0)) {
            0
        } else {
            *0x2::dynamic_field::borrow<SignatureKey, u64>(&arg0.id, v0)
        }
    }

    public fun tx_count(arg0: &State) : u64 {
        arg0.tx_count
    }

    public(friend) fun unpause(arg0: &mut State) {
        arg0.is_paused = false;
    }

    public(friend) fun upgrade(arg0: &mut State) {
        assert!(arg0.version < 2, 2);
        arg0.version = 2;
    }

    public fun version(arg0: &State) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

