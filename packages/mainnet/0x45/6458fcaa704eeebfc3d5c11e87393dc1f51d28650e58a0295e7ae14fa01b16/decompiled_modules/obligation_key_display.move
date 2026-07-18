module 0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation_key_display {
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
        let v4 = 0x2::display::new_with_fields<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey>(arg0, v0, v2, arg1);
        0x2::display::update_version<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<0x456458fcaa704eeebfc3d5c11e87393dc1f51d28650e58a0295e7ae14fa01b16::obligation::ObligationKey>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

