module 0xfb50301c81340a8bcc558ef217b4422baf4d1b7e12ab1fb86f9089c464887dcd::cetus_dlmm {
    public fun fetch_surrounding_bins<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u64) : (u32, vector<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>) {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0));
        let v1 = if (v0 > (arg1 as u32)) {
            v0 - (arg1 as u32)
        } else {
            0
        };
        (v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::fetch_bins<T0, T1>(arg0, 0x1::option::some<u32>(v1), arg1 * 2 + 1))
    }

    // decompiled from Move bytecode v6
}

