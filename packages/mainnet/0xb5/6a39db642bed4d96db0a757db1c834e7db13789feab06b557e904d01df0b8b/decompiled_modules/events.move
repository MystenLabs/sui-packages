module 0xb56a39db642bed4d96db0a757db1c834e7db13789feab06b557e904d01df0b8b::events {
    struct BuyXstockEvent has copy, drop {
        sender: address,
        price_id: vector<u8>,
        amount: u64,
        volume: u64,
    }

    struct SellXstockEvent has copy, drop {
        sender: address,
        price_id: vector<u8>,
        amount: u64,
        volume: u64,
    }

    struct AddRegistryEvent has copy, drop {
        sender: address,
        coin_type: vector<u8>,
        price_id: vector<u8>,
    }

    struct RemoveRegistryEvent has copy, drop {
        sender: address,
        coin_type: vector<u8>,
        price_id: vector<u8>,
    }

    public(friend) fun emit_add_registry_event(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = AddRegistryEvent{
            sender    : 0x2::tx_context::sender(arg2),
            coin_type : arg1,
            price_id  : arg1,
        };
        0x2::event::emit<AddRegistryEvent>(v0);
    }

    public(friend) fun emit_buy_xstock_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = BuyXstockEvent{
            sender   : 0x2::tx_context::sender(arg3),
            price_id : arg0,
            amount   : arg1,
            volume   : arg2,
        };
        0x2::event::emit<BuyXstockEvent>(v0);
    }

    public(friend) fun emit_remove_registry_event(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        let v0 = RemoveRegistryEvent{
            sender    : 0x2::tx_context::sender(arg2),
            coin_type : arg1,
            price_id  : arg1,
        };
        0x2::event::emit<RemoveRegistryEvent>(v0);
    }

    public(friend) fun emit_sell_xstock_event(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = SellXstockEvent{
            sender   : 0x2::tx_context::sender(arg3),
            price_id : arg0,
            amount   : arg1,
            volume   : arg2,
        };
        0x2::event::emit<SellXstockEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

