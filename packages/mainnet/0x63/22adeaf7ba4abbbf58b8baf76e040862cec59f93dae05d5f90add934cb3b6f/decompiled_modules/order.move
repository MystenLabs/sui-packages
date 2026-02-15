module 0x6322adeaf7ba4abbbf58b8baf76e040862cec59f93dae05d5f90add934cb3b6f::order {
    struct Order has drop, store {
        nonce: u64,
        sender: address,
        recipient: address,
        amount: u64,
        destination_domain: u32,
        deadline: u64,
        status: u8,
        created_at: u64,
        solver: address,
        guaranteed_output: u64,
        output_token: vector<u8>,
    }

    public fun amount(arg0: &Order) : u64 {
        arg0.amount
    }

    public fun created_at(arg0: &Order) : u64 {
        arg0.created_at
    }

    public fun deadline(arg0: &Order) : u64 {
        arg0.deadline
    }

    public fun destination_domain(arg0: &Order) : u32 {
        arg0.destination_domain
    }

    public fun guaranteed_output(arg0: &Order) : u64 {
        arg0.guaranteed_output
    }

    public(friend) fun mark_cancelled(arg0: &mut Order) {
        arg0.status = 1;
    }

    public(friend) fun mark_settled(arg0: &mut Order) {
        arg0.status = 2;
    }

    public(friend) fun new(arg0: u64, arg1: address, arg2: address, arg3: u64, arg4: u32, arg5: u64) : Order {
        Order{
            nonce              : arg0,
            sender             : arg1,
            recipient          : arg2,
            amount             : arg3,
            destination_domain : arg4,
            deadline           : 0,
            status             : 0,
            created_at         : arg5,
            solver             : @0x0,
            guaranteed_output  : 0,
            output_token       : 0x1::vector::empty<u8>(),
        }
    }

    public fun nonce(arg0: &Order) : u64 {
        arg0.nonce
    }

    public fun output_token(arg0: &Order) : vector<u8> {
        arg0.output_token
    }

    public fun recipient(arg0: &Order) : address {
        arg0.recipient
    }

    public fun sender(arg0: &Order) : address {
        arg0.sender
    }

    public fun solver(arg0: &Order) : address {
        arg0.solver
    }

    public fun status(arg0: &Order) : u8 {
        arg0.status
    }

    public fun status_cancelled() : u8 {
        1
    }

    public fun status_created() : u8 {
        0
    }

    public fun status_settled() : u8 {
        2
    }

    // decompiled from Move bytecode v6
}

