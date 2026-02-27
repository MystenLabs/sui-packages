module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::events {
    struct DepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        timestamp: u64,
    }

    struct BatchDepositEvent has copy, drop {
        users: vector<address>,
        amounts: vector<u64>,
        shares_list: vector<u64>,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        shares: u64,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    struct BatchWithdrawEvent has copy, drop {
        users: vector<address>,
        shares_list: vector<u64>,
        amounts: vector<u64>,
        total_fee: u64,
        timestamp: u64,
    }

    struct YieldEvent has copy, drop {
        source: vector<u8>,
        amount: u64,
        total_assets: u64,
        timestamp: u64,
    }

    struct YieldDistributionEvent has copy, drop {
        user: address,
        yield_amount: u64,
        user_shares: u64,
        timestamp: u64,
    }

    struct ProtocolPaused has copy, drop {
        reason: vector<u8>,
        timestamp: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        timestamp: u64,
    }

    struct FeeRateChanged has copy, drop {
        old_rate: u64,
        new_rate: u64,
        timestamp: u64,
    }

    struct VaultParametersChanged has copy, drop {
        parameter: vector<u8>,
        old_value: u64,
        new_value: u64,
        timestamp: u64,
    }

    struct DepositRejected has copy, drop {
        user: address,
        reason: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct AnomalousTransaction has copy, drop {
        user: address,
        tx_type: vector<u8>,
        amount: u64,
        reason: vector<u8>,
        timestamp: u64,
    }

    struct EvmDepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        vaa_hash: vector<u8>,
        timestamp: u64,
    }

    struct EvmWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        dest_chain: u16,
        vaa_hash: vector<u8>,
        timestamp: u64,
    }

    struct SuiDepositEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u64,
        source_chain: u16,
        timestamp: u64,
    }

    struct SuiWithdrawEvent has copy, drop {
        user: address,
        amount: u64,
        shares: u16,
        dest_chain: u16,
        recipient: address,
        timestamp: u64,
    }

    struct CrossChainMessageEvent has copy, drop {
        msg_type: u8,
        source_chain: u16,
        dest_chain: u16,
        sender: address,
        amount: u64,
        message_hash: vector<u8>,
        timestamp: u64,
    }

    struct CrossChainMessageConfirmedEvent has copy, drop {
        message_hash: vector<u8>,
        confirmation_height: u64,
        timestamp: u64,
    }

    // decompiled from Move bytecode v6
}

