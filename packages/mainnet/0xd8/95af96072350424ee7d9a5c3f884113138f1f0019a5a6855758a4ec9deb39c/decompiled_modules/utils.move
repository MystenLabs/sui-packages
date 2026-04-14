module 0xd895af96072350424ee7d9a5c3f884113138f1f0019a5a6855758a4ec9deb39c::utils {
    public(friend) fun append_num(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::append<u8>(arg0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
    }

    public(friend) fun num_payload(arg0: u64) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_number(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(0x1::string::into_bytes(0x1::u64::to_string(arg0))))
    }

    public(friend) fun raw_json_payload(arg0: vector<u8>) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_raw(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(arg0))
    }

    public(friend) fun stat_cmp(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            2
        } else if (arg0 == arg1) {
            1
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

