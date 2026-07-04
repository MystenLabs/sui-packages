module 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::rlp {
    fun read_be_len(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader, arg1: u64) : u64 {
        assert!(arg1 >= 1 && arg1 <= 8, 2);
        let v0 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, arg1);
        assert!(*0x1::vector::borrow<u8>(&v0, 0) != 0, 2);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = v1 << 8;
            v1 = v3 | (*0x1::vector::borrow<u8>(&v0, v2) as u64);
            v2 = v2 + 1;
        };
        v1
    }

    public fun read_list_header(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader) : u64 {
        let v0 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0);
        if (v0 >= 192 && v0 <= 247) {
            ((v0 - 192) as u64)
        } else {
            assert!(v0 >= 248, 1);
            let v2 = read_be_len(arg0, ((v0 - 247) as u64));
            assert!(v2 > 55, 2);
            v2
        }
    }

    public fun read_scalar_bytes(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader) : vector<u8> {
        let v0 = read_string(arg0);
        if (0x1::vector::length<u8>(&v0) > 0) {
            assert!(*0x1::vector::borrow<u8>(&v0, 0) != 0, 2);
        };
        assert!(0x1::vector::length<u8>(&v0) <= 32, 3);
        v0
    }

    public fun read_scalar_u128(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader) : u128 {
        let v0 = read_string(arg0);
        if (0x1::vector::length<u8>(&v0) == 1 && *0x1::vector::borrow<u8>(&v0, 0) == 0) {
            abort 2
        };
        assert!(0x1::vector::length<u8>(&v0) <= 16, 3);
        if (0x1::vector::length<u8>(&v0) > 0) {
            assert!(*0x1::vector::borrow<u8>(&v0, 0) != 0, 2);
        };
        0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::be_bytes_to_u128(&v0)
    }

    public fun read_string(arg0: &mut 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::Reader) : vector<u8> {
        let v0 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_u8(arg0);
        if (v0 < 128) {
            let v2 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v2, v0);
            v2
        } else if (v0 <= 183) {
            let v3 = ((v0 - 128) as u64);
            let v4 = 0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, v3);
            let v5 = v3 == 1 && *0x1::vector::borrow<u8>(&v4, 0) < 128;
            assert!(!v5, 2);
            v4
        } else {
            assert!(v0 <= 191, 0);
            let v6 = read_be_len(arg0, ((v0 - 183) as u64));
            assert!(v6 > 55, 2);
            0x78a1fe63d6b76fe4eb8b442e82e21238c1ee59d516c2e690bfcd5884fec329c5::reader::read_bytes(arg0, v6)
        }
    }

    // decompiled from Move bytecode v7
}

