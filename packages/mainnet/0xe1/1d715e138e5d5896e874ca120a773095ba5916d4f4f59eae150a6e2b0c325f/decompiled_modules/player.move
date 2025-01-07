module 0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::player {
    struct MapRecord has copy, drop, store {
        passed: bool,
        time: u64,
        reset: u64,
    }

    struct Player has drop, store {
        nickname: 0x1::string::String,
        address: address,
        record_id: 0x2::object::ID,
        total_pass: u64,
        total_time: u128,
    }

    struct PlayerMinted has copy, drop {
        creator: address,
        name: 0x1::string::String,
    }

    public fun create_player(arg0: vector<u8>, arg1: &0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox, arg2: &mut 0x2::tx_context::TxContext) : Player {
        Player{
            nickname   : 0x1::string::utf8(arg0),
            address    : 0x2::tx_context::sender(arg2),
            record_id  : 0x2::object::id<0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::market::PushBox>(arg1),
            total_pass : 0,
            total_time : 0,
        }
    }

    public fun create_record(arg0: &0xe11d715e138e5d5896e874ca120a773095ba5916d4f4f59eae150a6e2b0c325f::map::Map, arg1: &mut 0x2::tx_context::TxContext) : MapRecord {
        MapRecord{
            passed : false,
            time   : 0,
            reset  : 0,
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

