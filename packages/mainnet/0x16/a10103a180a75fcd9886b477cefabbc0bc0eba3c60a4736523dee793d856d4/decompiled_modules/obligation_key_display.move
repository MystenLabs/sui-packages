module 0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation_key_display {
    public(friend) fun init_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Obligation Key"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Access key for managing a Scallop lending obligation"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nft.apis.scallop.io/render-obligation?obligationKey={id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.scallop.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Scallop Labs"));
        let v4 = 0x2::display::new_with_fields<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::ObligationKey>(arg0, v0, v2, arg1);
        0x2::display::update_version<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::ObligationKey>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0xd971609b7feb6230585831e7aeb3c121fb21b9431337a30fc99185eb459a05ee::obligation::ObligationKey>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

