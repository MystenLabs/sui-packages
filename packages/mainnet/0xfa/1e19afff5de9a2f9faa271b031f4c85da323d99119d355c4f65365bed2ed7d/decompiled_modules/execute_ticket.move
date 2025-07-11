module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::execute_ticket {
    struct ExecuteTicket {
        dapp_id: 0x2::object::ID,
        request_id: u128,
        from: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress,
        protocols: vector<0x1::string::String>,
        message: vector<u8>,
    }

    public(friend) fun consume(arg0: ExecuteTicket) {
        let ExecuteTicket {
            dapp_id    : _,
            request_id : _,
            from       : _,
            protocols  : _,
            message    : _,
        } = arg0;
    }

    public fun dapp_id(arg0: &ExecuteTicket) : 0x2::object::ID {
        arg0.dapp_id
    }

    public fun from(arg0: &ExecuteTicket) : 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress {
        arg0.from
    }

    public fun message(arg0: &ExecuteTicket) : vector<u8> {
        arg0.message
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u128, arg2: 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::network_address::NetworkAddress, arg3: vector<0x1::string::String>, arg4: vector<u8>) : ExecuteTicket {
        ExecuteTicket{
            dapp_id    : arg0,
            request_id : arg1,
            from       : arg2,
            protocols  : arg3,
            message    : arg4,
        }
    }

    public fun protocols(arg0: &ExecuteTicket) : vector<0x1::string::String> {
        arg0.protocols
    }

    public fun request_id(arg0: &ExecuteTicket) : u128 {
        arg0.request_id
    }

    // decompiled from Move bytecode v6
}

