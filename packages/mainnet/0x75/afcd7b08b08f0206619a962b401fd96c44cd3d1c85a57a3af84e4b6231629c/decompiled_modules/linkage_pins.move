module 0x45564ea956f9b25890a5c1c3a199c8d86aabd5291b34723fb662283419ee2f4d::linkage_pins {
    fun pin_pyth_lazer(arg0: &0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed) : u32 {
        0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(arg0)
    }

    fun pin_pyth_pro_compatible(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::data_source::DataSource) : u64 {
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::data_source::emitter_chain(arg0)
    }

    // decompiled from Move bytecode v7
}

