module 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::sui {
    struct Sui has drop {
        dummy_field: bool,
    }

    struct LinkRequest has key {
        id: 0x2::object::UID,
        requester: address,
    }

    public fun sui(arg0: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::AdminCap) : Sui {
        Sui{dummy_field: false}
    }

    public fun create_and_transfer_link_request(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LinkRequest{
            id        : 0x2::object::new(arg1),
            requester : 0x2::tx_context::sender(arg1),
        };
        assert!(0x2::tx_context::sender(arg1) != arg0, 1);
        0x2::transfer::transfer<LinkRequest>(v0, arg0);
    }

    public fun link(arg0: &mut 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::SuiLinkRegistryV2, arg1: LinkRequest, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let LinkRequest {
            id        : v0,
            requester : v1,
        } = arg1;
        assert!(0x2::tx_context::sender(arg3) != v1, 1);
        let v2 = 0x1::string::utf8(b"0x");
        0x1::string::append_utf8(&mut v2, 0x1::string::into_bytes(0x2::address::to_string(v1)));
        0x2::object::delete(v0);
        0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::registry_v2::mint<Sui>(arg0, v2, arg2, 2, arg3);
    }

    // decompiled from Move bytecode v6
}

