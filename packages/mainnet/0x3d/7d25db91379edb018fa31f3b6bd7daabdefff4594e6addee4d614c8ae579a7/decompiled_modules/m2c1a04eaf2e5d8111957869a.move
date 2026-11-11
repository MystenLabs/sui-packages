module 0x3d7d25db91379edb018fa31f3b6bd7daabdefff4594e6addee4d614c8ae579a7::m2c1a04eaf2e5d8111957869a {
    public fun fd6ea7e3613a9bca1445ba526(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update_v2(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

