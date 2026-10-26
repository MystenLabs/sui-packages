module 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::member {
    struct Member has copy, drop, store {
        name: 0x1::string::String,
        address: address,
        url: 0x2::url::Url,
    }

    public fun url(arg0: &Member) : &0x2::url::Url {
        &arg0.url
    }

    public fun member_address(arg0: &Member) : address {
        arg0.address
    }

    public fun name(arg0: &Member) : &0x1::string::String {
        &arg0.name
    }

    public fun new(arg0: 0x1::string::String, arg1: address) : Member {
        Member{
            name    : arg0,
            address : arg1,
            url     : 0x2::url::new_unsafe_from_bytes(b""),
        }
    }

    public(friend) fun set_name(arg0: &mut Member, arg1: 0x1::string::String) {
        arg0.name = arg1;
    }

    public fun update_name(arg0: &mut Member, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.address == 0x2::tx_context::sender(arg2), 0);
        arg0.name = arg1;
    }

    public fun update_url(arg0: &mut Member, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.address == 0x2::tx_context::sender(arg2), 0);
        arg0.url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v7
}

