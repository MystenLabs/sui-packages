module 0x74874fc76d1da6ead276fd095e1316a930c45fa6b7a600f60155e55ab6b2948d::dmdballsa {
    struct DMDBALLSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMDBALLSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"adb454953f7b9525b556fbb8e832c48b7856688edfde6fcddd8b76dfbd315ea3                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DMDBALLSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DMDBALLS    ")))), trim_right(b"Diamond Balls Only Auto Flywheel"), trim_right(x"4927766520646576656c6f7065642066756c6c79206175746f6d617465642063726561746f72207265776172647320666c79776865656c2074686174204f4e4c592070617973207468652054727565204469616d6f6e642042616c6c73204f6e6c792e0a0a546f20626520656c696769626c6520666f722074686520646973747269627574696f6e2c20796f75206d7573743b0a31292048617665206e6576657220736f6c64206f72207265647563656420796f757220706f736974696f6e0a322920486f6c642061206d696e696d756d206f66203432302c30303020746f6b656e730a0a45766572792035206d696e757465732061207363616e206f6363757273206f6e20616c6c20686f6c64696e672077616c6c6574732c206175746f6d61746963616c6c7920636c61696d732c207468656e2064697374726962757465"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMDBALLSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMDBALLSA>>(v4);
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

