module 0x8b5e9f5caa91bdeb119ce6fb044d44a533fd856bcecaa74fc705852d709f200::events_mint_from_receipt {
    struct MintFromReceiptEvent has copy, drop {
        receipt_id: 0x1::string::String,
        asset: 0x1::string::String,
        chain: 0x1::string::String,
        tx_id: 0x1::string::String,
        amount: u64,
        recipient: address,
        minter: address,
        total_supply_after: u64,
    }

    public(friend) fun emit_mint_from_receipt_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: address, arg6: address, arg7: u64) {
        let v0 = MintFromReceiptEvent{
            receipt_id         : arg0,
            asset              : arg1,
            chain              : arg2,
            tx_id              : arg3,
            amount             : arg4,
            recipient          : arg5,
            minter             : arg6,
            total_supply_after : arg7,
        };
        0x2::event::emit<MintFromReceiptEvent>(v0);
    }

    public(friend) fun get_amount(arg0: &MintFromReceiptEvent) : u64 {
        arg0.amount
    }

    public(friend) fun get_asset(arg0: &MintFromReceiptEvent) : 0x1::string::String {
        arg0.asset
    }

    public(friend) fun get_chain(arg0: &MintFromReceiptEvent) : 0x1::string::String {
        arg0.chain
    }

    public(friend) fun get_minter(arg0: &MintFromReceiptEvent) : address {
        arg0.minter
    }

    public(friend) fun get_receipt_id(arg0: &MintFromReceiptEvent) : 0x1::string::String {
        arg0.receipt_id
    }

    public(friend) fun get_recipient(arg0: &MintFromReceiptEvent) : address {
        arg0.recipient
    }

    public(friend) fun get_total_supply_after(arg0: &MintFromReceiptEvent) : u64 {
        arg0.total_supply_after
    }

    public(friend) fun get_tx_id(arg0: &MintFromReceiptEvent) : 0x1::string::String {
        arg0.tx_id
    }

    // decompiled from Move bytecode v6
}

