module 0x7304f71f782b1058f79732f6c937256bd06830bd9ea6258b05063f150e869a3f::events {
    struct BuyXstockEvent has copy, drop {
        sender: address,
        price_id: 0x1::ascii::String,
        amount: u64,
        volume: u64,
    }

    struct SellXstockEvent has copy, drop {
        sender: address,
        price_id: 0x1::ascii::String,
        amount: u64,
        volume: u64,
    }

    public(friend) fun emit_buy_xstock_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = BuyXstockEvent{
            sender   : 0x2::tx_context::sender(arg3),
            price_id : 0x1::ascii::string(arg0),
            amount   : arg1,
            volume   : arg2,
        };
        0x2::event::emit<BuyXstockEvent>(v0);
    }

    public(friend) fun emit_sell_xstock_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = SellXstockEvent{
            sender   : 0x2::tx_context::sender(arg3),
            price_id : 0x1::ascii::string(arg0),
            amount   : arg1,
            volume   : arg2,
        };
        0x2::event::emit<SellXstockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

