module 0x3096c4d3f065c9d3e3adb67a70d262d990241d9232f3fc8e2a6f7531837745ad::enforced_options {
    struct EnforcedOptions has store {
        options: 0x2::table::Table<EnforcedOptionsKey, vector<u8>>,
    }

    struct EnforcedOptionsKey has copy, drop, store {
        eid: u32,
        msg_type: u16,
    }

    struct EnforcedOptionSetEvent has copy, drop {
        oapp: address,
        eid: u32,
        msg_type: u16,
        options: vector<u8>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : EnforcedOptions {
        EnforcedOptions{options: 0x2::table::new<EnforcedOptionsKey, vector<u8>>(arg0)}
    }

    fun assert_options_type3(arg0: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg0) >= 2, 2);
        let v0 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(arg0);
        assert!(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_u16(&mut v0) == 3, 3);
    }

    public(friend) fun combine_options(arg0: &EnforcedOptions, arg1: u32, arg2: u16, arg3: vector<u8>) : vector<u8> {
        let v0 = &arg0.options;
        let v1 = EnforcedOptionsKey{
            eid      : arg1,
            msg_type : arg2,
        };
        let v2 = if (0x2::table::contains<EnforcedOptionsKey, vector<u8>>(v0, v1)) {
            let v3 = EnforcedOptionsKey{
                eid      : arg1,
                msg_type : arg2,
            };
            0x2::table::borrow<EnforcedOptionsKey, vector<u8>>(v0, v3)
        } else {
            let v4 = b"";
            &v4
        };
        let v5 = *v2;
        if (0x1::vector::is_empty<u8>(&v5)) {
            return arg3
        };
        if (0x1::vector::is_empty<u8>(&arg3)) {
            return v5
        };
        assert_options_type3(arg3);
        let v6 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::create(arg3);
        let v7 = 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::create(v5);
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::write_bytes(&mut v7, 0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::read_bytes_until_end(0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_reader::skip(&mut v6, 2)));
        0xd35b1f15a0d77503d17611e52f9ef602192fed38bd5a6f30ceea390adb000dc0::buffer_writer::to_bytes(v7)
    }

    public(friend) fun get_enforced_options(arg0: &EnforcedOptions, arg1: u32, arg2: u16) : &vector<u8> {
        let v0 = &arg0.options;
        let v1 = EnforcedOptionsKey{
            eid      : arg1,
            msg_type : arg2,
        };
        assert!(0x2::table::contains<EnforcedOptionsKey, vector<u8>>(v0, v1), 1);
        let v2 = EnforcedOptionsKey{
            eid      : arg1,
            msg_type : arg2,
        };
        0x2::table::borrow<EnforcedOptionsKey, vector<u8>>(v0, v2)
    }

    public(friend) fun set_enforced_options(arg0: &mut EnforcedOptions, arg1: address, arg2: u32, arg3: u16, arg4: vector<u8>) {
        assert_options_type3(arg4);
        let v0 = &mut arg0.options;
        let v1 = EnforcedOptionsKey{
            eid      : arg2,
            msg_type : arg3,
        };
        if (0x2::table::contains<EnforcedOptionsKey, vector<u8>>(v0, v1)) {
            let v2 = EnforcedOptionsKey{
                eid      : arg2,
                msg_type : arg3,
            };
            *0x2::table::borrow_mut<EnforcedOptionsKey, vector<u8>>(v0, v2) = arg4;
        } else {
            let v3 = EnforcedOptionsKey{
                eid      : arg2,
                msg_type : arg3,
            };
            0x2::table::add<EnforcedOptionsKey, vector<u8>>(v0, v3, arg4);
        };
        let v4 = EnforcedOptionSetEvent{
            oapp     : arg1,
            eid      : arg2,
            msg_type : arg3,
            options  : arg4,
        };
        0x2::event::emit<EnforcedOptionSetEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

