module 0xc2e3911d5a8d57d515c4c476d74746f510bdf499104208e050d4ed7ac2ee688a::bitmap {
    struct Bitmap has store {
        inner: 0x2::table::Table<u64, u8>,
    }

    public fun empty(arg0: &mut 0x2::tx_context::TxContext) : Bitmap {
        Bitmap{inner: 0x2::table::new<u64, u8>(arg0)}
    }

    public fun flip_bit(arg0: &mut Bitmap, arg1: u64) {
        let (v0, _, v2) = index_to_byte_and_bit(arg1);
        let v3 = get_mut(arg0, v0);
        *v3 = ((*v3 ^ v2) as u8);
    }

    fun get(arg0: &Bitmap, arg1: u64) : u8 {
        if (0x2::table::contains<u64, u8>(&arg0.inner, arg1)) {
            *0x2::table::borrow<u64, u8>(&arg0.inner, arg1)
        } else {
            0
        }
    }

    fun get_mut(arg0: &mut Bitmap, arg1: u64) : &mut u8 {
        if (!0x2::table::contains<u64, u8>(&arg0.inner, arg1)) {
            0x2::table::add<u64, u8>(&mut arg0.inner, arg1, 0);
        };
        0x2::table::borrow_mut<u64, u8>(&mut arg0.inner, arg1)
    }

    fun index_to_byte_and_bit(arg0: u64) : (u64, u8, u8) {
        let v0 = arg0 / 8;
        let v1 = ((arg0 - v0 * 8) as u8);
        (v0, v1, 1 << v1)
    }

    public fun is_set(arg0: &Bitmap, arg1: u64) : bool {
        let (v0, v1, _) = index_to_byte_and_bit(arg1);
        (get(arg0, v0) >> v1) % 2 == 1
    }

    // decompiled from Move bytecode v6
}

