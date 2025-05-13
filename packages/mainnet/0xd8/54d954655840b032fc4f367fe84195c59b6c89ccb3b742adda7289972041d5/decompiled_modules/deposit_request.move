module 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::deposit_request {
    struct DepositRequest has copy, drop, store {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        amount: u64,
        expected_shares: u256,
        is_executed: bool,
        is_cancelled: bool,
    }

    public fun amount(arg0: &DepositRequest) : u64 {
        arg0.amount
    }

    public(friend) fun cancel(arg0: &mut DepositRequest) {
        arg0.is_cancelled = true;
    }

    public(friend) fun execute(arg0: &mut DepositRequest) {
        arg0.is_executed = true;
    }

    public fun expected_shares(arg0: &DepositRequest) : u256 {
        arg0.expected_shares
    }

    public fun is_cancelled(arg0: &DepositRequest) : bool {
        arg0.is_cancelled
    }

    public fun is_executed(arg0: &DepositRequest) : bool {
        arg0.is_executed
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u256) : DepositRequest {
        DepositRequest{
            request_id      : arg0,
            receipt_id      : arg1,
            recipient       : arg2,
            vault_id        : arg3,
            amount          : arg4,
            expected_shares : arg5,
            is_executed     : false,
            is_cancelled    : false,
        }
    }

    public fun receipt_id(arg0: &DepositRequest) : address {
        arg0.receipt_id
    }

    public fun recipient(arg0: &DepositRequest) : address {
        arg0.recipient
    }

    public fun request_id(arg0: &DepositRequest) : u64 {
        arg0.request_id
    }

    public fun vault_id(arg0: &DepositRequest) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

