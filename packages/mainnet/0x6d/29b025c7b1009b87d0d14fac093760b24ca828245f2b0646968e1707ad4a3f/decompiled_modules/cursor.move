module 0x6d29b025c7b1009b87d0d14fac093760b24ca828245f2b0646968e1707ad4a3f::cursor {
    struct Cursor has copy, drop {
        bytes: vector<u8>,
        pos: u64,
        failed: bool,
        failed_at: u64,
    }

    public fun length(arg0: &Cursor) : u64 {
        0x1::vector::length<u8>(&arg0.bytes)
    }

    public fun string(arg0: &mut Cursor) : 0x1::string::String {
        let v0 = bytes(arg0);
        let v1 = 0x1::string::try_utf8(v0);
        if (0x1::option::is_none<0x1::string::String>(&v1)) {
            fail(arg0);
            return 0x1::string::utf8(b"")
        };
        0x1::option::destroy_some<0x1::string::String>(v1)
    }

    public fun bytes(arg0: &mut Cursor) : vector<u8> {
        let v0 = uleb(arg0);
        take(arg0, v0)
    }

    public fun fail(arg0: &mut Cursor) {
        if (!arg0.failed) {
            arg0.failed_at = arg0.pos;
        };
        arg0.failed = true;
    }

    public fun failed(arg0: &Cursor) : bool {
        arg0.failed
    }

    public fun failed_at(arg0: &Cursor) : u64 {
        arg0.failed_at
    }

    public fun new(arg0: vector<u8>) : Cursor {
        Cursor{
            bytes     : arg0,
            pos       : 0,
            failed    : false,
            failed_at : 0,
        }
    }

    public fun ok(arg0: &Cursor) : bool {
        !arg0.failed && arg0.pos == 0x1::vector::length<u8>(&arg0.bytes)
    }

    public fun option_address(arg0: &mut Cursor) : 0x1::option::Option<address> {
        if (present(arg0)) {
            0x1::option::some<address>(read_address(arg0))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun option_bool(arg0: &mut Cursor) : 0x1::option::Option<bool> {
        if (present(arg0)) {
            0x1::option::some<bool>(read_bool(arg0))
        } else {
            0x1::option::none<bool>()
        }
    }

    public fun option_string(arg0: &mut Cursor) : 0x1::option::Option<0x1::string::String> {
        if (present(arg0)) {
            0x1::option::some<0x1::string::String>(string(arg0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    public fun pos(arg0: &Cursor) : u64 {
        arg0.pos
    }

    public fun prefix(arg0: &Cursor) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < arg0.pos) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.bytes, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun present(arg0: &mut Cursor) : bool {
        read_bool(arg0)
    }

    public fun read_address(arg0: &mut Cursor) : address {
        let v0 = take(arg0, 32);
        if (arg0.failed) {
            return @0x0
        };
        0x2::address::from_bytes(v0)
    }

    public fun read_bool(arg0: &mut Cursor) : bool {
        let v0 = read_u8(arg0);
        if (v0 > 1) {
            fail(arg0);
        };
        v0 == 1
    }

    public fun read_u64(arg0: &mut Cursor) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 8) {
            v0 = v0 | (read_u8(arg0) as u64) << v1;
            v1 = v1 + 8;
            v2 = v2 + 1;
        };
        v0
    }

    public fun read_u8(arg0: &mut Cursor) : u8 {
        if (arg0.failed || arg0.pos >= 0x1::vector::length<u8>(&arg0.bytes)) {
            fail(arg0);
            return 0
        };
        arg0.pos = arg0.pos + 1;
        *0x1::vector::borrow<u8>(&arg0.bytes, arg0.pos)
    }

    public fun take(arg0: &mut Cursor, arg1: u64) : vector<u8> {
        let v0 = b"";
        if (arg0.failed || arg0.pos + arg1 > 0x1::vector::length<u8>(&arg0.bytes)) {
            fail(arg0);
            return v0
        };
        let v1 = 0;
        while (v1 < arg1) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.bytes, arg0.pos + v1));
            v1 = v1 + 1;
        };
        arg0.pos = arg0.pos + arg1;
        v0
    }

    public fun uleb(arg0: &mut Cursor) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        loop {
            if (v2 > 4) {
                fail(arg0);
                return 0
            };
            let v3 = read_u8(arg0);
            let v4 = (v3 as u64);
            v2 = v2 + 1;
            v0 = v0 | (v4 & 127) << v1;
            if (v4 & 128 == 0) {
                break
            };
            v1 = v1 + 7;
        };
        if (v0 > 4294967295) {
            fail(arg0);
        };
        v0
    }

    public fun vec_bytes(arg0: &mut Cursor) : vector<vector<u8>> {
        let v0 = uleb(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0 && !arg0.failed) {
            0x1::vector::push_back<vector<u8>>(&mut v1, bytes(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    public fun vec_string(arg0: &mut Cursor) : vector<0x1::string::String> {
        let v0 = uleb(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 < v0 && !arg0.failed) {
            0x1::vector::push_back<0x1::string::String>(&mut v1, string(arg0));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v7
}

