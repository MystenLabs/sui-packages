module 0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::display {
    entry fun update<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::market::Market<T0>>(arg0, arg1);
        0x2::display::add<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::market::Market<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        let v1 = 0x2::display::new<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::offer::Offer<T0>>(arg0, arg1);
        0x2::display::add<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::offer::Offer<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::market::Market<T0>>(&mut v0);
        0x2::display::update_version<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::offer::Offer<T0>>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::market::Market<T0>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x603c17f1aa67409ab10639c442c63dbf818434c546d7f4242c8b58830061e0ba::offer::Offer<T0>>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

