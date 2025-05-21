module 0xe27969a70f93034de9ce16e6ad661b480324574e68d15a64b513fd90eb2423e5::escrow {
    struct UnsettledBidReceipt has store {
        receipt: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>,
        position_id: u64,
        user: address,
        token_types: vector<0x1::type_name::TypeName>,
        unrealized_pnl_sign: bool,
        unrealized_pnl: u64,
        unrealized_trading_fee: u64,
        unrealized_borrow_fee: u64,
        unrealized_funding_fee_sign: bool,
        unrealized_funding_fee: u64,
        unrealized_liquidator_fee: u64,
    }

    public(friend) fun create_unsettled_bid_receipt(arg0: vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, arg1: u64, arg2: address, arg3: vector<0x1::type_name::TypeName>, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64) : UnsettledBidReceipt {
        UnsettledBidReceipt{
            receipt                     : arg0,
            position_id                 : arg1,
            user                        : arg2,
            token_types                 : arg3,
            unrealized_pnl_sign         : arg4,
            unrealized_pnl              : arg5,
            unrealized_trading_fee      : arg6,
            unrealized_borrow_fee       : arg7,
            unrealized_funding_fee_sign : arg8,
            unrealized_funding_fee      : arg9,
            unrealized_liquidator_fee   : arg10,
        }
    }

    public(friend) fun destruct_unsettled_bid_receipt(arg0: UnsettledBidReceipt) : (vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt>, u64, address, vector<0x1::type_name::TypeName>, bool, u64, u64, u64, bool, u64, u64) {
        let UnsettledBidReceipt {
            receipt                     : v0,
            position_id                 : v1,
            user                        : v2,
            token_types                 : v3,
            unrealized_pnl_sign         : v4,
            unrealized_pnl              : v5,
            unrealized_trading_fee      : v6,
            unrealized_borrow_fee       : v7,
            unrealized_funding_fee_sign : v8,
            unrealized_funding_fee      : v9,
            unrealized_liquidator_fee   : v10,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10)
    }

    public(friend) fun get_bid_receipts(arg0: &UnsettledBidReceipt) : &vector<0xb4f25230ba74837d8299e92951306100c4a532e8c48cc3d8828abe9b91c8b274::vault::TypusBidReceipt> {
        &arg0.receipt
    }

    // decompiled from Move bytecode v6
}

