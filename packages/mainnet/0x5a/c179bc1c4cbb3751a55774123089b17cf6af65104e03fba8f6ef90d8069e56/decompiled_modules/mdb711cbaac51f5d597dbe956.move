module 0x5ac179bc1c4cbb3751a55774123089b17cf6af65104e03fba8f6ef90d8069e56::mdb711cbaac51f5d597dbe956 {
    public fun fc1dafb6b4016d5aad2be0b3e(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update_v2(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

