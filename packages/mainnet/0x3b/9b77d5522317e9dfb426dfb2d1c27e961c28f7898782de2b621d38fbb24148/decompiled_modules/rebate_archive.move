module 0x3b9b77d5522317e9dfb426dfb2d1c27e961c28f7898782de2b621d38fbb24148::rebate_archive {
    struct ArchiveChunk<T0: store> has store, key {
        id: 0x2::object::UID,
        values: vector<T0>,
    }

    public entry fun remove_to_chunk<T0: store>(arg0: &mut 0x2::table::Table<vector<u8>, T0>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<T0>();
        while (0x1::vector::length<vector<u8>>(&arg1) > 0) {
            0x1::vector::push_back<T0>(&mut v0, 0x2::table::remove<vector<u8>, T0>(arg0, 0x1::vector::pop_back<vector<u8>>(&mut arg1)));
        };
        while (0x1::vector::length<vector<u8>>(&arg2) > 0) {
            0x1::vector::push_back<T0>(&mut v0, 0x2::table::remove<vector<u8>, T0>(arg0, 0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
        let v1 = ArchiveChunk<T0>{
            id     : 0x2::object::new(arg4),
            values : v0,
        };
        0x2::transfer::public_transfer<ArchiveChunk<T0>>(v1, arg3);
    }

    // decompiled from Move bytecode v7
}

