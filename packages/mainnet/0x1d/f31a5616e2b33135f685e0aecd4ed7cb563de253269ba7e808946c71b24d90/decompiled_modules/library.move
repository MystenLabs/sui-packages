module 0x1df31a5616e2b33135f685e0aecd4ed7cb563de253269ba7e808946c71b24d90::library {
    struct NetworkAddress has copy, drop, store {
        network: 0x1::string::String,
        address_raw: vector<u8>,
    }

    public fun create_network_address(arg0: 0x1::string::String, arg1: vector<u8>) : NetworkAddress {
        NetworkAddress{
            network     : arg0,
            address_raw : arg1,
        }
    }

    public fun get_address_raw(arg0: &NetworkAddress) : vector<u8> {
        arg0.address_raw
    }

    public fun get_network_id(arg0: &NetworkAddress) : 0x1::string::String {
        arg0.network
    }

    // decompiled from Move bytecode v6
}

