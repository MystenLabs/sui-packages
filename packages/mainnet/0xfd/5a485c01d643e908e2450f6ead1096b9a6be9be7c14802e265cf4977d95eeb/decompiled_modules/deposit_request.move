module 0xfd5a485c01d643e908e2450f6ead1096b9a6be9be7c14802e265cf4977d95eeb::deposit_request {
    struct DepositRequest has copy, drop, store {
        request_id: u64,
        receipt_id: address,
        recipient: address,
        vault_id: address,
        amount: u64,
        expected_shares: u256,
        request_time: u64,
    }

    public fun amount(arg0: &DepositRequest) : u64 {
        arg0.amount
    }

    public fun expected_shares(arg0: &DepositRequest) : u256 {
        arg0.expected_shares
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: u256, arg6: u64) : DepositRequest {
        DepositRequest{
            request_id      : arg0,
            receipt_id      : arg1,
            recipient       : arg2,
            vault_id        : arg3,
            amount          : arg4,
            expected_shares : arg5,
            request_time    : arg6,
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

    public fun request_time(arg0: &DepositRequest) : u64 {
        arg0.request_time
    }

    public fun vault_id(arg0: &DepositRequest) : address {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

