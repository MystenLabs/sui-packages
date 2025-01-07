module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::constants {
    public fun get_check_point_method_name() : vector<u8> {
        x"636865636b706f696e7400000000000000000000000000000000000000000000"
    }

    public fun get_constant_power_threshold() : u64 {
        2863311531
    }

    public fun get_i_ack_method_name() : vector<u8> {
        x"6941636b00000000000000000000000000000000000000000000000000000000"
    }

    public fun get_i_receive_method_name() : vector<u8> {
        x"6952656365697665000000000000000000000000000000000000000000000000"
    }

    public fun get_msg_prefix() : vector<u8> {
        x"19457468657265756d205369676e6564204d6573736167653a0a3332"
    }

    // decompiled from Move bytecode v6
}

