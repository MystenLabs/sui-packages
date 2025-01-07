module 0xd281ea9613a67b88b1908aca5b0f0575fd01571992dcff9eede500a7ccd15b2c::collection {
    struct Collection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        url: 0x2::url::Url,
        image_url: 0x2::url::Url,
        project_url: 0x2::url::Url,
    }

    public(friend) fun display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"symbol"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{symbol}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://atlansui.xyz"));
        0x2::transfer::public_transfer<0x2::display::Display<Collection>>(0x2::display::new_with_fields<Collection>(arg0, v0, v2, arg1), 0x2::tx_context::sender(arg1));
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"AtlanSui Mermaid NFT Collection"),
            description : 0x1::string::utf8(b"AtlanSui Mermaid NFT"),
            symbol      : 0x1::string::utf8(b"MERMAID"),
            url         : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreib2rahqldelfcmoi6tc3y5mxri4acjeunpnebxef5nejseq2s5ble"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"ipfs://bafkreib2rahqldelfcmoi6tc3y5mxri4acjeunpnebxef5nejseq2s5ble"),
            project_url : 0x2::url::new_unsafe_from_bytes(b"https://atlansui.xyz"),
        }
    }

    public fun get_id(arg0: &Collection) : 0x2::object::ID {
        0x2::object::id<Collection>(arg0)
    }

    // decompiled from Move bytecode v6
}

