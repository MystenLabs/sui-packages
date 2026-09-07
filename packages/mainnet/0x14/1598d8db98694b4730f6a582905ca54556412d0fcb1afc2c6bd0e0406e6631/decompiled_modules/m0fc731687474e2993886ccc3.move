module 0x141598d8db98694b4730f6a582905ca54556412d0fcb1afc2c6bd0e0406e6631::m0fc731687474e2993886ccc3 {
    public fun f1dcff49ad849bb66e19bab56(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::state::State, arg1: &0x2::clock::Clock, arg2: vector<u8>) : 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::pyth_lazer::parse_and_verify_le_ecdsa_update_v2(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

