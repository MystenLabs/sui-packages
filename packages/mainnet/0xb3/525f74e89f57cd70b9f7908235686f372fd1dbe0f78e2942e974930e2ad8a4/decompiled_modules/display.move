module 0xa11aff0a107eed655dc0568b72edf1877d21fdaaccf9a8f00926625ae9060704::display {
    public entry fun update_object_display(arg0: &mut 0x2::display::Display<0xa11aff0a107eed655dc0568b72edf1877d21fdaaccf9a8f00926625ae9060704::nft_factory::BlockusNft>) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"attributes"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{custom_attributes}"));
        0x2::display::add_multiple<0xa11aff0a107eed655dc0568b72edf1877d21fdaaccf9a8f00926625ae9060704::nft_factory::BlockusNft>(arg0, v0, v1);
        0x2::display::update_version<0xa11aff0a107eed655dc0568b72edf1877d21fdaaccf9a8f00926625ae9060704::nft_factory::BlockusNft>(arg0);
    }

    // decompiled from Move bytecode v6
}

