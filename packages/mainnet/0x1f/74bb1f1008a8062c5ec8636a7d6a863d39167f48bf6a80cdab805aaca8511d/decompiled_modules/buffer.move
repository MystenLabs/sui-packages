module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::buffer {
    struct Buffer has store {
        id: 0x2::object::UID,
        length: u64,
        static: vector<u8>,
    }

    public(friend) fun length(arg0: &Buffer) : u64 {
        arg0.length
    }

    public(friend) fun delete(arg0: Buffer) {
        if (arg0.length > 0) {
            let (v0, _) = chunk_index(arg0.length - 1);
            let v2 = 0;
            while (v2 <= v0) {
                let v3 = &mut arg0;
                remove_chunk(v3, v2);
                v2 = v2 + 1;
            };
        };
        let Buffer {
            id     : v4,
            length : _,
            static : _,
        } = arg0;
        0x2::object::delete(v4);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Buffer {
        Buffer{
            id     : 0x2::object::new(arg0),
            length : 0,
            static : 0x1::vector::empty<u8>(),
        }
    }

    public(friend) fun borrow_chunk(arg0: &Buffer, arg1: u64) : &vector<u8> {
        if (arg1 == 0) {
            &arg0.static
        } else {
            0x2::dynamic_field::borrow<u64, vector<u8>>(&arg0.id, arg1)
        }
    }

    fun borrow_chunk_mut(arg0: &mut Buffer, arg1: u64) : &mut vector<u8> {
        if (arg1 == 0) {
            &mut arg0.static
        } else {
            0x2::dynamic_field::borrow_mut<u64, vector<u8>>(&mut arg0.id, arg1)
        }
    }

    public(friend) fun chunk_index(arg0: u64) : (u64, u64) {
        (arg0 / 16380, arg0 % 16380)
    }

    public(friend) fun has_chunk(arg0: &Buffer, arg1: u64) : bool {
        arg1 == 0 || 0x2::dynamic_field::exists_<u64>(&arg0.id, arg1)
    }

    fun insert_chunk(arg0: &mut Buffer, arg1: u64, arg2: vector<u8>) {
        0x2::dynamic_field::add<u64, vector<u8>>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun limit() : u64 {
        16380
    }

    fun remove_chunk(arg0: &mut Buffer, arg1: u64) : vector<u8> {
        if (arg1 == 0) {
            arg0.static = 0x1::vector::empty<u8>();
            arg0.static
        } else {
            0x2::dynamic_field::remove<u64, vector<u8>>(&mut arg0.id, arg1)
        }
    }

    public(friend) fun reset(arg0: &mut Buffer, arg1: u64) {
        truncate(arg0, arg1);
        arg0.length = 0;
    }

    public(friend) fun truncate(arg0: &mut Buffer, arg1: u64) {
        let (v0, v1) = chunk_index(arg1);
        if (!has_chunk(arg0, v0)) {
            return
        };
        if (v1 == 0) {
            remove_chunk(arg0, v0);
        } else {
            let v2 = borrow_chunk_mut(arg0, v0);
            while (v1 < 0x1::vector::length<u8>(v2)) {
                0x1::vector::pop_back<u8>(v2);
            };
        };
        let v3 = v0 + 1;
        while (has_chunk(arg0, v3)) {
            remove_chunk(arg0, v3);
            v3 = v3 + 1;
        };
    }

    public(friend) fun write(arg0: &mut Buffer, arg1: vector<u8>) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        let v1 = 0;
        while (v1 < v0) {
            let (v2, v3) = chunk_index(arg0.length);
            let v4 = v0 - v1;
            let v5 = v4;
            let v6 = 16380 - v3;
            if (v4 > v6) {
                v5 = v6;
            };
            if (has_chunk(arg0, v2)) {
                let v7 = borrow_chunk_mut(arg0, v2);
                if (v0 <= 16380 && v1 == 0 && v3 == 0) {
                    *v7 = arg1;
                } else {
                    0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::slice_into::slice_into(v7, v3, &arg1, v1, v5);
                };
            } else if (v0 <= 16380 && v1 == 0 && v3 == 0) {
                insert_chunk(arg0, v2, arg1);
            } else {
                let v8 = 0x1::vector::empty<u8>();
                0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::slice_into::slice_into(&mut v8, v3, &arg1, v1, v5);
                insert_chunk(arg0, v2, v8);
            };
            v1 = v1 + v5;
            arg0.length = arg0.length + v5;
        };
    }

    // decompiled from Move bytecode v6
}

