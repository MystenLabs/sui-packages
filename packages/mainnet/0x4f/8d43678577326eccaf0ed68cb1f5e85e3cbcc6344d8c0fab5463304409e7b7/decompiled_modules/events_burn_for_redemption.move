module 0x4f8d43678577326eccaf0ed68cb1f5e85e3cbcc6344d8c0fab5463304409e7b7::events_burn_for_redemption {
    struct BurnForRedemptionEvent has copy, drop {
        request_id: 0x1::string::String,
        asset: 0x1::string::String,
        chain: 0x1::string::String,
        amount: u64,
        burner: address,
        total_supply_after: u64,
    }

    public(friend) fun emit_burn_for_redemption_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: u64) {
        let v0 = BurnForRedemptionEvent{
            request_id         : arg0,
            asset              : arg1,
            chain              : arg2,
            amount             : arg3,
            burner             : arg4,
            total_supply_after : arg5,
        };
        0x2::event::emit<BurnForRedemptionEvent>(v0);
    }

    public(friend) fun get_amount(arg0: &BurnForRedemptionEvent) : u64 {
        arg0.amount
    }

    public(friend) fun get_asset(arg0: &BurnForRedemptionEvent) : 0x1::string::String {
        arg0.asset
    }

    public(friend) fun get_burner(arg0: &BurnForRedemptionEvent) : address {
        arg0.burner
    }

    public(friend) fun get_chain(arg0: &BurnForRedemptionEvent) : 0x1::string::String {
        arg0.chain
    }

    public(friend) fun get_request_id(arg0: &BurnForRedemptionEvent) : 0x1::string::String {
        arg0.request_id
    }

    public(friend) fun get_total_supply_after(arg0: &BurnForRedemptionEvent) : u64 {
        arg0.total_supply_after
    }

    // decompiled from Move bytecode v6
}

