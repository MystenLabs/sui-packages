module 0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::display {
    entry fun update_display<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::market::Market<T0>>(arg0, arg1);
        0x2::display::add<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::market::Market<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        let v1 = 0x2::display::new<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::offer::Offer<T0>>(arg0, arg1);
        0x2::display::add<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::offer::Offer<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::market::Market<T0>>(&mut v0);
        0x2::display::update_version<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::offer::Offer<T0>>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::market::Market<T0>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xdf56690e21b47c32be7d473982b7f3e8460fc17461b2efd6c3f25af6e257c6cb::offer::Offer<T0>>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

