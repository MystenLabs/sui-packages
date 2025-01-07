module 0x830fe26674dc638af7c3d84030e2575f44a2bdc1baa1f4757cfe010a4b106b6a::svg {
    public fun generateSVG(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) : vector<u8> {
        let v0 = b"data:image/svg+xml,%3Csvg%20width%3D%22120%22%20height%3D%22120%22%20viewBox%3D%220%200%20120%20120%22%20fill%3D%22none%22%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%3E%3Crect%20width%3D%22120%22%20height%3D%22120%22%20fill%3D%22%234CA2FF%22%2F%3E%3Ctext%20fill%3D%22%23EAF7FF%22%20xml%3Aspace%3D%22preserve%22%20style%3D%22white-space%3A%20pre%22%20font-family%3D%22Inter%22%20font-size%3D%2212%22%20letter-spacing%3D%220em%22%3E%3Ctspan%20x%3D%2215%22%20y%3D%2226.8636%22%3E%7B%26%2310%3B%3C%2Ftspan%3E%3Ctspan%20x%3D%2215%22%20y%3D%2241.8636%22%3E%20%20%20%20p%3A%20%26%2339%3B";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"%26%2339%3B%2C%26%2310%3B%3C%2Ftspan%3E%3Ctspan%20x%3D%2215%22%20y%3D%2256.8636%22%3E%20%20%20%20op%3A%20%26%2339%3B");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, b"%26%2339%3B%2C%26%2310%3B%3C%2Ftspan%3E%3Ctspan%20x%3D%2215%22%20y%3D%2271.8636%22%3E%20%20%20%20tick%3A%20%26%2339%3B");
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::vector::append<u8>(&mut v0, b"%26%2339%3B%2C%26%2310%3B%3C%2Ftspan%3E%3Ctspan%20x%3D%2215%22%20y%3D%2286.8636%22%3E%20%20%20%20amt%3A%20");
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, b"%26%2310%3B%3C%2Ftspan%3E%3Ctspan%20x%3D%2215%22%20y%3D%22101.864%22%3E%7D%3C%2Ftspan%3E%3C%2Ftext%3E%3C%2Fsvg%3E");
        v0
    }

    // decompiled from Move bytecode v6
}

