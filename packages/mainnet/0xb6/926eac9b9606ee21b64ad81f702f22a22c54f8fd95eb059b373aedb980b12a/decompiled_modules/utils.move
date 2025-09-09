module 0xb6926eac9b9606ee21b64ad81f702f22a22c54f8fd95eb059b373aedb980b12a::utils {
    public fun calculate_yield_performance_fee(arg0: &0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::AuthorizedTransferTicket, arg1: u64, arg2: u64) : u64 {
        if (arg1 > arg2) {
            0x44b06989cb7a6403320783c8a3c73774e50b07590e5010866d3503637ba50b0f::ticket::calculate_performance_fee(arg0, arg1 - arg2)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

