module 0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::display {
    entry fun update<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::market::Market<T0>>(arg0, arg1);
        0x2::display::add<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::market::Market<T0>>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        let v1 = 0x2::display::new<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::offer::Offer<T0>>(arg0, arg1);
        0x2::display::add<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::offer::Offer<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::update_version<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::market::Market<T0>>(&mut v0);
        0x2::display::update_version<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::offer::Offer<T0>>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::market::Market<T0>>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x90c5c218ca5a3a6f00c985604894a28ccdf4eda59291b2acd6852e6fdcad0703::offer::Offer<T0>>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

