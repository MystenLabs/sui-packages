module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::centralized_state {
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
    }

    public(friend) fun check_save_receipt(arg0: &mut State, arg1: 0x1::string::String, arg2: u128) {
        let v0 = ReceiptKey{
            conn_sn : arg2,
            nid     : arg1,
        };
        assert!(!0x2::vec_map::contains<ReceiptKey, bool>(&arg0.receipts, &v0), 100);
        0x2::vec_map::insert<ReceiptKey, bool>(&mut arg0.receipts, v0, true);
    }

    public(friend) fun claim_fees(arg0: &mut State, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun create() : State {
        State{
            message_fee  : 0x2::vec_map::empty<0x1::string::String, u64>(),
            response_fee : 0x2::vec_map::empty<0x1::string::String, u64>(),
            receipts     : 0x2::vec_map::empty<ReceiptKey, bool>(),
            conn_sn      : 0,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    public(friend) fun deposit(arg0: &mut State, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public fun get_fee(arg0: &State, arg1: &0x1::string::String, arg2: bool) : u64 {
        if (arg2 == true) {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.message_fee, arg1, 0) + 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.response_fee, arg1, 0)
        } else {
            0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::xcall_utils::get_or_default<0x1::string::String, u64>(&arg0.message_fee, arg1, 0)
        }
    }

    public(friend) fun get_next_conn_sn(arg0: &mut State) : u128 {
        let v0 = arg0.conn_sn + 1;
        arg0.conn_sn = v0;
        v0
    }

    public(friend) fun get_receipt(arg0: &State, arg1: 0x1::string::String, arg2: u128) : bool {
        let v0 = ReceiptKey{
            conn_sn : arg2,
            nid     : arg1,
        };
        0x2::vec_map::contains<ReceiptKey, bool>(&arg0.receipts, &v0)
    }

    public fun get_state(arg0: &0x2::bag::Bag, arg1: 0x1::string::String) : &State {
        0x2::bag::borrow<0x1::string::String, State>(arg0, arg1)
    }

    public(friend) fun get_state_mut(arg0: &mut 0x2::bag::Bag, arg1: 0x1::string::String) : &mut State {
        0x2::bag::borrow_mut<0x1::string::String, State>(arg0, arg1)
    }

    public(friend) fun set_fee(arg0: &mut State, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: address) {
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.message_fee, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.message_fee, &arg1);
        };
        if (0x2::vec_map::contains<0x1::string::String, u64>(&arg0.response_fee, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, u64>(&mut arg0.response_fee, &arg1);
        };
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.message_fee, arg1, arg2);
        0x2::vec_map::insert<0x1::string::String, u64>(&mut arg0.response_fee, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

