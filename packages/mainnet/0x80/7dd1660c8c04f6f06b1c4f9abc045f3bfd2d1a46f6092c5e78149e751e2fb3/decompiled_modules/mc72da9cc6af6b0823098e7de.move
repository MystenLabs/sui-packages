module 0x807dd1660c8c04f6f06b1c4f9abc045f3bfd2d1a46f6092c5e78149e751e2fb3::mc72da9cc6af6b0823098e7de {
    public fun f194cf14b09d432294ce20093(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update_v2(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

