module 0x2faec3e9459e5b389a5a8b5c1586a13532d2f02d3909126aea143a1e89ab712c::utils {
    public(friend) fun addr_payload(arg0: address) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_address(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(0x1::string::into_bytes(0x2::address::to_string(arg0))))
    }

    public(friend) fun append_json_string(arg0: &mut vector<u8>, arg1: &vector<u8>) {
        0x1::vector::push_back<u8>(arg0, 34);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            let v1 = *0x1::vector::borrow<u8>(arg1, v0);
            if (v1 == 34 || v1 == 92) {
                0x1::vector::push_back<u8>(arg0, 92);
            };
            0x1::vector::push_back<u8>(arg0, v1);
            v0 = v0 + 1;
        };
        0x1::vector::push_back<u8>(arg0, 34);
    }

    public(friend) fun append_num(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::append<u8>(arg0, 0x1::string::into_bytes(0x1::u64::to_string(arg1)));
    }

    public(friend) fun append_num32(arg0: &mut vector<u8>, arg1: u32) {
        append_num(arg0, (arg1 as u64));
    }

    public(friend) fun num_payload(arg0: u64) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_number(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(0x1::string::into_bytes(0x1::u64::to_string(arg0))))
    }

    public(friend) fun raw_json_payload(arg0: vector<u8>) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_raw(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(arg0))
    }

    public(friend) fun string_payload(arg0: vector<u8>) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_string(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(arg0))
    }

    // decompiled from Move bytecode v7
}

