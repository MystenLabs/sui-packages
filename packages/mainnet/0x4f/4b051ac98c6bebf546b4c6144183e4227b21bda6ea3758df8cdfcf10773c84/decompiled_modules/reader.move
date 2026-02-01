module 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::reader {
    public fun get_timestamp(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun is_supported_dex(arg0: u8) : bool {
        if (arg0 == 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::types::dex_cetus()) {
            true
        } else if (arg0 == 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::types::dex_bluefin()) {
            true
        } else {
            arg0 == 0x4f4b051ac98c6bebf546b4c6144183e4227b21bda6ea3758df8cdfcf10773c84::types::dex_momentum()
        }
    }

    public fun max_batch_size() : u64 {
        50
    }

    // decompiled from Move bytecode v6
}

