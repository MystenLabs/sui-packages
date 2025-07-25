module 0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::events {
    struct BuyXstockEvent has copy, drop {
        sender: address,
        xasset_type: 0x1::ascii::String,
        price_id: vector<u8>,
        amount: u64,
        volume: u64,
    }

    struct SellXstockEvent has copy, drop {
        sender: address,
        xasset_type: 0x1::ascii::String,
        price_id: vector<u8>,
        amount: u64,
        volume: u64,
    }

    struct AddRegistryEvent has copy, drop {
        sender: address,
        xasset_type: 0x1::ascii::String,
        price_id: vector<u8>,
    }

    struct RemoveRegistryEvent has copy, drop {
        sender: address,
        xasset_type: 0x1::ascii::String,
        price_id: vector<u8>,
    }

    struct StakeEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        sender: address,
        amount: u64,
    }

    public(friend) fun emit_add_registry_event<T0>(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = AddRegistryEvent{
            sender      : 0x2::tx_context::sender(arg1),
            xasset_type : 0x1::ascii::string(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::utils::type_to_bytes<T0>()),
            price_id    : arg0,
        };
        0x2::event::emit<AddRegistryEvent>(v0);
    }

    public(friend) fun emit_buy_xstock_event<T0>(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = BuyXstockEvent{
            sender      : 0x2::tx_context::sender(arg3),
            xasset_type : 0x1::ascii::string(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::utils::type_to_bytes<T0>()),
            price_id    : arg0,
            amount      : arg1,
            volume      : arg2,
        };
        0x2::event::emit<BuyXstockEvent>(v0);
    }

    public(friend) fun emit_remove_registry_event<T0>(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = RemoveRegistryEvent{
            sender      : 0x2::tx_context::sender(arg1),
            xasset_type : 0x1::ascii::string(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::utils::type_to_bytes<T0>()),
            price_id    : arg0,
        };
        0x2::event::emit<RemoveRegistryEvent>(v0);
    }

    public(friend) fun emit_sell_xstock_event<T0>(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = SellXstockEvent{
            sender      : 0x2::tx_context::sender(arg3),
            xasset_type : 0x1::ascii::string(0x3f4f8d793aeab1199c75bfb43c6d1ec4e5d7ed51697c802016fa7eafd091e74b::utils::type_to_bytes<T0>()),
            price_id    : arg0,
            amount      : arg1,
            volume      : arg2,
        };
        0x2::event::emit<SellXstockEvent>(v0);
    }

    public(friend) fun emit_stake_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = StakeEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<StakeEvent>(v0);
    }

    public(friend) fun emit_unstake_event(arg0: u64, arg1: &0x2::tx_context::TxContext) {
        let v0 = UnstakeEvent{
            sender : 0x2::tx_context::sender(arg1),
            amount : arg0,
        };
        0x2::event::emit<UnstakeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

