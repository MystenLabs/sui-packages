module 0x838bbbd6c4137152f2592716a7b2d2c7f8a6ebc57f94d5d79adf01ff7e3ab9d6::aggregator {
    struct K7Vault has key {
        id: 0x2::object::UID,
        sui: 0x2::coin::Coin<0x2::sui::SUI>,
        trade_count: u64,
    }

    struct TradeEvent has copy, drop {
        trade_id: u64,
        amount: u64,
        timestamp: u64,
    }

    public fun balance(arg0: &K7Vault) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.sui)
    }

    public entry fun deposit(arg0: &mut K7Vault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0.sui, arg1);
    }

    public fun get_trade_count(arg0: &K7Vault) : u64 {
        arg0.trade_count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = K7Vault{
            id          : 0x2::object::new(arg0),
            sui         : 0x2::coin::zero<0x2::sui::SUI>(arg0),
            trade_count : 0,
        };
        0x2::transfer::share_object<K7Vault>(v0);
    }

    public entry fun record_trade(arg0: u64, arg1: &mut K7Vault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.trade_count = arg1.trade_count + 1;
        let v0 = TradeEvent{
            trade_id  : arg1.trade_count,
            amount    : arg0,
            timestamp : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<TradeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

