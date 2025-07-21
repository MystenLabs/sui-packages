module 0x24d2fd99dc9c6a58ea81607eff095e57cf29a609f480f1cb24d31d0d2fee301b::bd {
    struct BD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"HKlg009783btr6V_                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BD          ")))), trim_right(b"BlackDuckrwa                    "), trim_right(x"426c61636b4475636b20546f6b656e202852574129204465736372697074696f6e0d0a0d0a54686520426c61636b4475636b20546f6b656e20285257412920697320612063757474696e672d65646765206469676974616c2061737365742064657369676e656420746f207265766f6c7574696f6e697365207468652074726164696e6720616e6420646563656e7472616c697365642066696e616e636520284465466929206c616e6473636170652e20456163682052574120746f6b656e20726570726573656e7473206120313a312076616c756520646572697665642066726f6d206f757220696e6e6f7661746976652074726164696e6720737472617465676965732c207365616d6c6573736c79206c696e6b696e6720747261646974696f6e616c20666f7265782074726164696e6720776974682074686520666173"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BD>>(v4);
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

