module 0x78fc72a89343f4237448a79c4b1fcc158cfd612bb4a9813847ad2d5760cf5f3d::audio_channel_layout {
    struct ChannelLayout has copy, drop, store {
        pos0: vector<u8>,
    }

    public fun new(arg0: vector<u8>) : ChannelLayout {
        let v0 = 0x1::vector::length<u8>(&arg0);
        assert!(v0 > 0 && v0 <= 255, 0);
        let v1 = 0;
        let v2 = &arg0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u8>(v2)) {
            let v4 = *0x1::vector::borrow<u8>(v2, v3);
            if (v4 != 255) {
                assert!(v4 <= 17, 1);
                let v5 = 1 << v4;
                assert!(v1 & v5 == 0, 2);
                v1 = v1 | v5;
            };
            v3 = v3 + 1;
        };
        ChannelLayout{pos0: arg0}
    }

    public fun speakers(arg0: &ChannelLayout) : &vector<u8> {
        &arg0.pos0
    }

    // decompiled from Move bytecode v7
}

