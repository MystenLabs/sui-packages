module 0x20c75db9d4df704aedefbe7ab044a5e29867b9e71092acd190959d327e1fd1bc::utils {
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

