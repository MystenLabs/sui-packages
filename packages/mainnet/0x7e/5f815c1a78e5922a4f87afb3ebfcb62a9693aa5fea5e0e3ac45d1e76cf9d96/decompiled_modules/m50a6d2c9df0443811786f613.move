module 0x7e5f815c1a78e5922a4f87afb3ebfcb62a9693aa5fea5e0e3ac45d1e76cf9d96::m50a6d2c9df0443811786f613 {
    public fun f5ac9839a3fd5b11a11b95c70(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update_v2(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

