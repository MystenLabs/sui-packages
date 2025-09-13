module 0x43d055094a8999956bf5ff300e37894c99a000c2a1cd2310891f7391d4de65e3::msg_codec {
    public fun encode_msg(arg0: u8, arg1: u32, arg2: u256) : vector<u8> {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::new();
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u8(&mut v0, arg0), arg1);
        if (arg2 > 0) {
            0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_u256(&mut v0, arg2);
        };
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v0)
    }

    public fun get_msg_type(arg0: &vector<u8>) : u8 {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(*arg0);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u8(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::skip(&mut v0, 0))
    }

    public fun get_src_eid(arg0: &vector<u8>) : u32 {
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(*arg0);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u32(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::skip(&mut v0, 1))
    }

    public fun get_value(arg0: &vector<u8>) : u256 {
        if (0x1::vector::length<u8>(arg0) > (5 as u64)) {
            let v1 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(*arg0);
            0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u256(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::skip(&mut v1, 5))
        } else {
            0
        }
    }

    // decompiled from Move bytecode v6
}

