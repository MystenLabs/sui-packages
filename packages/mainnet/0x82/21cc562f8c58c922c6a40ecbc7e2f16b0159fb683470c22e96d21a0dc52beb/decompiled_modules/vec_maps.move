module 0x8221cc562f8c58c922c6a40ecbc7e2f16b0159fb683470c22e96d21a0dc52beb::vec_maps {
    public fun count_value<T0: copy, T1>(arg0: &0x2::vec_map::VecMap<T0, T1>, arg1: &T1) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<T0, T1>(arg0)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<T0, T1>(arg0, v1);
            if (v3 == arg1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

