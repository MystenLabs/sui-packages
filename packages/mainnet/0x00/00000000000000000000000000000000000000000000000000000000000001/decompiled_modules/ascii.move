module 0x1::ascii {
    struct String has copy, drop, store {
        bytes: vector<u8>,
    }

    struct Char has copy, drop, store {
        byte: u8,
    }

    public fun length(arg0: &String) : u64 {
        0x1::vector::length<u8>(as_bytes(arg0))
    }

    public fun all_characters_printable(arg0: &String) : bool {
        let v0 = &arg0.bytes;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            if (!is_printable_char(*0x1::vector::borrow<u8>(v0, v1))) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    public fun append(arg0: &mut String, arg1: String) {
        0x1::vector::append<u8>(&mut arg0.bytes, into_bytes(arg1));
    }

    public fun as_bytes(arg0: &String) : &vector<u8> {
        &arg0.bytes
    }

    public fun byte(arg0: Char) : u8 {
        let Char { byte: v0 } = arg0;
        v0
    }

    public fun char(arg0: u8) : Char {
        assert!(is_valid_char(arg0), 65536);
        Char{byte: arg0}
    }

    fun char_to_lowercase(arg0: u8) : u8 {
        if (arg0 >= 65 && arg0 <= 90) {
            arg0 + 32
        } else {
            arg0
        }
    }

    fun char_to_uppercase(arg0: u8) : u8 {
        if (arg0 >= 97 && arg0 <= 122) {
            arg0 - 32
        } else {
            arg0
        }
    }

    public fun index_of(arg0: &String, arg1: &String) : u64 {
        let v0 = 0;
        let v1 = length(arg0);
        let v2 = length(arg1);
        if (v1 < v2) {
            return v1
        };
        while (v0 <= v1 - v2) {
            let v3 = 0;
            while (v3 < v2 && *0x1::vector::borrow<u8>(&arg0.bytes, v0 + v3) == *0x1::vector::borrow<u8>(&arg1.bytes, v3)) {
                v3 = v3 + 1;
            };
            if (v3 == v2) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun insert(arg0: &mut String, arg1: u64, arg2: String) {
        assert!(arg1 <= length(arg0), 65537);
        let v0 = into_bytes(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            0x1::vector::insert<u8>(&mut arg0.bytes, 0x1::vector::pop_back<u8>(&mut v0), arg1);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<u8>(v0);
    }

    public fun into_bytes(arg0: String) : vector<u8> {
        let String { bytes: v0 } = arg0;
        v0
    }

    public fun is_empty(arg0: &String) : bool {
        0x1::vector::is_empty<u8>(&arg0.bytes)
    }

    public fun is_printable_char(arg0: u8) : bool {
        arg0 >= 32 && arg0 <= 126
    }

    public fun is_valid_char(arg0: u8) : bool {
        arg0 <= 127
    }

    public fun pop_char(arg0: &mut String) : Char {
        Char{byte: 0x1::vector::pop_back<u8>(&mut arg0.bytes)}
    }

    public fun push_char(arg0: &mut String, arg1: Char) {
        0x1::vector::push_back<u8>(&mut arg0.bytes, arg1.byte);
    }

    public fun string(arg0: vector<u8>) : String {
        let v0 = try_string(arg0);
        assert!(0x1::option::is_some<String>(&v0), 65536);
        0x1::option::destroy_some<String>(v0)
    }

    public fun substring(arg0: &String, arg1: u64, arg2: u64) : String {
        assert!(arg1 <= arg2 && arg2 <= length(arg0), 65537);
        let v0 = b"";
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0.bytes, arg1));
            arg1 = arg1 + 1;
        };
        String{bytes: v0}
    }

    public fun to_lowercase(arg0: &String) : String {
        let v0 = as_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, char_to_lowercase(*0x1::vector::borrow<u8>(v0, v2)));
            v2 = v2 + 1;
        };
        String{bytes: v1}
    }

    public fun to_uppercase(arg0: &String) : String {
        let v0 = as_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, char_to_uppercase(*0x1::vector::borrow<u8>(v0, v2)));
            v2 = v2 + 1;
        };
        String{bytes: v1}
    }

    public fun try_string(arg0: vector<u8>) : 0x1::option::Option<String> {
        let v0 = &arg0;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            if (!is_valid_char(*0x1::vector::borrow<u8>(v0, v1))) {
                v2 = false;
                /* label 6 */
                return if (v2) {
                    let v4 = String{bytes: arg0};
                    0x1::option::some<String>(v4)
                } else {
                    0x1::option::none<String>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    // decompiled from Move bytecode v6
}

