module 0xc9b53416df21c941befef17b48d031e146a11617000c13ba751cc744737baf62::palette {
    public fun is_valid_color(arg0: 0x1::string::String) : bool {
        assert!(0x1::string::length(&arg0) == 6, 13906834247357825023);
        let v0 = vector[12470831, 14120515, 15389866, 14984818, 12087120, 7552569, 4073265, 10626611, 14957380, 16217634, 16690740, 16705377, 6539085, 4098376, 2513986, 1653822, 1199753, 39387, 2943221, 16777215, 12635100, 9149364, 5925256, 3818598, 2501444, 1578021, 16711748, 6830188, 11882632, 16151930, 15251350, 12748137];
        let v1 = string_to_rgb(arg0);
        0x1::vector::contains<u32>(&v0, &v1)
    }

    fun rgb_to_string(arg0: u32) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        0x1::string::utf8(0x2::hex::encode(v0))
    }

    fun string_to_rgb(arg0: 0x1::string::String) : u32 {
        assert!(0x1::string::length(&arg0) == 6, 13906834286012530687);
        let v0 = 0x2::hex::decode(0x1::string::into_bytes(arg0));
        (*0x1::vector::borrow<u8>(&v0, 0) as u32) << 16 | (*0x1::vector::borrow<u8>(&v0, 1) as u32) << 8 | (*0x1::vector::borrow<u8>(&v0, 2) as u32)
    }

    // decompiled from Move bytecode v6
}

