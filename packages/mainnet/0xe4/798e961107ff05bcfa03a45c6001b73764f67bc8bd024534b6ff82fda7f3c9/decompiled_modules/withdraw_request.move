module 0xe4798e961107ff05bcfa03a45c6001b73764f67bc8bd024534b6ff82fda7f3c9::withdraw_request {
    struct WithdrawRequest has copy, drop, store {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        shares: u256,
        expected_amount: u64,
        request_time: u64,
    }

    public fun expected_amount(arg0: &WithdrawRequest) : u64 {
        arg0.expected_amount
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u256, arg5: u64, arg6: u64) : WithdrawRequest {
        WithdrawRequest{
            request_id      : arg0,
            receipt_id      : arg1,
            recipient       : arg2,
            vault_id        : arg3,
            shares          : arg4,
            expected_amount : arg5,
            request_time    : arg6,
        }
    }

    public fun receipt_id(arg0: &WithdrawRequest) : address {
        arg0.receipt_id
    }

    public fun recipient(arg0: &WithdrawRequest) : address {
        arg0.recipient
    }

    public fun request_id(arg0: &WithdrawRequest) : u64 {
        arg0.request_id
    }

    public fun request_time(arg0: &WithdrawRequest) : u64 {
        arg0.request_time
    }

    public fun shares(arg0: &WithdrawRequest) : u256 {
        arg0.shares
    }

    public fun vault_id(arg0: &WithdrawRequest) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

