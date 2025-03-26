module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::cluster_state {
    struct ValidatorSetAdded has copy, drop {
        validators: vector<vector<u8>>,
        threshold: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        connection_id: 0x1::string::String,
    }

    struct ReceiptKey has copy, drop, store {
        conn_sn: u128,
        nid: 0x1::string::String,
    }

    struct State has store {
        message_fee: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        response_fee: 0x2::vec_map::VecMap<0x1::string::String, u64>,
        receipts: 0x2::vec_map::VecMap<ReceiptKey, bool>,
        conn_sn: u128,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        validators: vector<vector<u8>>,
        validators_threshold: u64,
    }

    public fun get_fee(arg0: &State, arg1: &0x1::string::String, arg2: bool) : u64 {
        0
    }

    public fun get_state(arg0: &0x2::bag::Bag, arg1: 0x1::string::String) : &State {
        0x2::bag::borrow<0x1::string::String, State>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

