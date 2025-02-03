module 0x7fb2e9c62b68bfe3568b9c5df5aecc2fe07f1830a34aee25f1a9dbc61d1b75d1::utils {
    public entry fun numbers_to_ascii_vector(arg0: u16) : vector<u8> {
        let v0 = b"";
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
            if (arg0 <= 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    // decompiled from Move bytecode v6
}

