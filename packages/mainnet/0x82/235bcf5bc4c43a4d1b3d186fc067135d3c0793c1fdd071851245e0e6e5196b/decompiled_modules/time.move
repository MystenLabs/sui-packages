module 0x82235bcf5bc4c43a4d1b3d186fc067135d3c0793c1fdd071851245e0e6e5196b::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GSxtT2dkwmJQgUc2RMStHdqACozg8Txi3KjaxGdcPREV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TIME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TIME        ")))), trim_right(b"MOST VALUABLE ASSET             "), trim_right(x"54494d450a0a5468657265206973206e6f7468696e67206d6f72652076616c7561626c65207468616e2074696d652e576520617265207265666c656374696e672074686973206f6e20536f6c616e612e200a0a54686520737570706c79206973206f6e6520746f6b656e20626563617573652074696d652069732066696e6974652e204f6e63652069747320676f6e652c20796f752063616e7420676574206974206261636b2e20536f20746865726520617265206175746f6d61746963206275726e7320746f207265666c65637420746869732e2054696d65206973206d6f6e65792061732077656c6c2c20736f2074686572652069732061204c50206c6576656c20746178207573656420746f2073656e6420536f6c616e6120746f20686f6c646572732e200a0a496620796f752068617665206174206c656173742030"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIME>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

