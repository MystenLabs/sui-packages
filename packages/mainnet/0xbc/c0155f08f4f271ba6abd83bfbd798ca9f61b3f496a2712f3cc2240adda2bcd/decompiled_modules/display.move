module 0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::display {
    entry fun update<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::market::Market<T0>>(arg0, arg1);
        0x2::display::add<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::market::Market<T0>>(&mut v0, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Market"));
        0x2::display::add<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::market::Market<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        let v1 = 0x2::display::new<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::offer::Offer<T0>>(arg0, arg1);
        0x2::display::add<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::offer::Offer<T0>>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Offer"));
        0x2::display::add<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::offer::Offer<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::market::Market<T0>>(&mut v0);
        0x2::display::update_version<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::offer::Offer<T0>>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::market::Market<T0>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xbcc0155f08f4f271ba6abd83bfbd798ca9f61b3f496a2712f3cc2240adda2bcd::offer::Offer<T0>>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

