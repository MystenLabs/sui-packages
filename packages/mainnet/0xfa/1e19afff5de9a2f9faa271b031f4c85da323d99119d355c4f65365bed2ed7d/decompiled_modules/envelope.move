module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::envelope {
    struct XCallEnvelope has drop {
        message_type: u8,
        message: vector<u8>,
        sources: vector<0x1::string::String>,
        destinations: vector<0x1::string::String>,
    }

    public fun encode(arg0: &XCallEnvelope) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_u8(arg0.message_type));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.message));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_strings(&arg0.sources));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_strings(&arg0.destinations));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
    }

    public fun msg_type(arg0: &XCallEnvelope) : u8 {
        arg0.message_type
    }

    public fun decode(arg0: &vector<u8>) : XCallEnvelope {
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        XCallEnvelope{
            message_type : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            message      : *0x1::vector::borrow<vector<u8>>(&v0, 1),
            sources      : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_strings(0x1::vector::borrow<vector<u8>>(&v0, 2)),
            destinations : 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_strings(0x1::vector::borrow<vector<u8>>(&v0, 3)),
        }
    }

    public fun rollback(arg0: &XCallEnvelope) : 0x1::option::Option<vector<u8>> {
        if (arg0.message_type == 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::msg_type()) {
            let v1 = 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::decode(&arg0.message);
            0x1::option::some<vector<u8>>(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::rollback(&v1))
        } else {
            0x1::option::none<vector<u8>>()
        }
    }

    public fun destinations(arg0: &XCallEnvelope) : vector<0x1::string::String> {
        arg0.destinations
    }

    public fun message(arg0: &XCallEnvelope) : vector<u8> {
        arg0.message
    }

    public fun sources(arg0: &XCallEnvelope) : vector<0x1::string::String> {
        arg0.sources
    }

    public fun wrap_call_message(arg0: vector<u8>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : XCallEnvelope {
        XCallEnvelope{
            message_type : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message::msg_type(),
            message      : arg0,
            sources      : arg1,
            destinations : arg2,
        }
    }

    public fun wrap_call_message_rollback(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) : XCallEnvelope {
        XCallEnvelope{
            message_type : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::msg_type(),
            message      : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::encode(0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback::create(arg0, arg1)),
            sources      : arg2,
            destinations : arg3,
        }
    }

    public fun wrap_persistent_message(arg0: vector<u8>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>) : XCallEnvelope {
        XCallEnvelope{
            message_type : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::persistent_message::msg_type(),
            message      : arg0,
            sources      : arg1,
            destinations : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

