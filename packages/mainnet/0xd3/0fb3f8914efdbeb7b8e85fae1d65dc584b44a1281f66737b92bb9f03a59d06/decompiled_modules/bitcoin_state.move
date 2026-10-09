module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state {
    struct BitcoinStateKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BitcoinState has store, key {
        id: 0x2::object::UID,
        deposit_queue: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::DepositRequestQueue,
        withdrawal_queue: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::WithdrawalRequestQueue,
        utxo_pool: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::UtxoPool,
        user_requests: 0x2::table::Table<address, 0x2::bag::Bag>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : BitcoinState {
        BitcoinState{
            id               : 0x2::object::new(arg0),
            deposit_queue    : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::create(arg0),
            withdrawal_queue : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::create(arg0),
            utxo_pool        : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::create(arg0),
            user_requests    : 0x2::table::new<address, 0x2::bag::Bag>(arg0),
        }
    }

    public(friend) fun deposit_queue(arg0: &BitcoinState) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::DepositRequestQueue {
        &arg0.deposit_queue
    }

    public(friend) fun deposit_queue_mut(arg0: &mut BitcoinState) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::DepositRequestQueue {
        &mut arg0.deposit_queue
    }

    public(friend) fun has_user_requests(arg0: &BitcoinState, arg1: address) : bool {
        0x2::table::contains<address, 0x2::bag::Bag>(&arg0.user_requests, arg1)
    }

    public(friend) fun id(arg0: &BitcoinState) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun id_mut(arg0: &mut BitcoinState) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun index_user_request(arg0: &mut BitcoinState, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<address, 0x2::bag::Bag>(&arg0.user_requests, arg1)) {
            0x2::table::add<address, 0x2::bag::Bag>(&mut arg0.user_requests, arg1, 0x2::bag::new(arg3));
        };
        0x2::bag::add<address, bool>(0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.user_requests, arg1), arg2, true);
    }

    public(friend) fun key() : BitcoinStateKey {
        BitcoinStateKey{dummy_field: false}
    }

    public(friend) fun unindex_user_request(arg0: &mut BitcoinState, arg1: address, arg2: address) {
        if (0x2::table::contains<address, 0x2::bag::Bag>(&arg0.user_requests, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, 0x2::bag::Bag>(&mut arg0.user_requests, arg1);
            if (0x2::bag::contains<address>(v0, arg2)) {
                0x2::bag::remove<address, bool>(v0, arg2);
            };
            if (0x2::bag::is_empty(v0)) {
                0x2::bag::destroy_empty(0x2::table::remove<address, 0x2::bag::Bag>(&mut arg0.user_requests, arg1));
            };
        };
    }

    public(friend) fun user_has_request(arg0: &BitcoinState, arg1: address, arg2: address) : bool {
        0x2::table::contains<address, 0x2::bag::Bag>(&arg0.user_requests, arg1) && 0x2::bag::contains<address>(0x2::table::borrow<address, 0x2::bag::Bag>(&arg0.user_requests, arg1), arg2)
    }

    public(friend) fun utxo_pool(arg0: &BitcoinState) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::UtxoPool {
        &arg0.utxo_pool
    }

    public(friend) fun utxo_pool_mut(arg0: &mut BitcoinState) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::UtxoPool {
        &mut arg0.utxo_pool
    }

    public(friend) fun withdrawal_queue(arg0: &BitcoinState) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::WithdrawalRequestQueue {
        &arg0.withdrawal_queue
    }

    public(friend) fun withdrawal_queue_mut(arg0: &mut BitcoinState) : &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::WithdrawalRequestQueue {
        &mut arg0.withdrawal_queue
    }

    // decompiled from Move bytecode v7
}

