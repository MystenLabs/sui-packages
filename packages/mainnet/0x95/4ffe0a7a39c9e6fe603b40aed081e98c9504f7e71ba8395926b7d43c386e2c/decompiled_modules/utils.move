module 0x954ffe0a7a39c9e6fe603b40aed081e98c9504f7e71ba8395926b7d43c386e2c::utils {
    public(friend) fun addr_payload(arg0: address) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::TypedNexusData {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::as_address(0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::inline_one(0x1::string::into_bytes(0x2::address::to_string(arg0))))
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

