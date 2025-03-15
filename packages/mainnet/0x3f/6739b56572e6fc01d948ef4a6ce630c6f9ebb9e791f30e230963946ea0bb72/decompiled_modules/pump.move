module 0x3f6739b56572e6fc01d948ef4a6ce630c6f9ebb9e791f30e230963946ea0bb72::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://firebasestorage.googleapis.com/v0/b/pumpisland-32099.firebasestorage.app/o/uploads%2FLogo200_pumpisland-1740942985975-1742065511851.webp?alt=media&token=07e6835d-87df-4b75-ac53-365619749377                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PUMP    ")))), trim_right(b"Pumpisland V2                   "), trim_right(x"50554d502076322069732074686520666972737420746f6b656e206f6e2050756d7049736c616e642c20637265617465642062792074686520646576656c6f70657273206f6620506f7049736c616e642e2049742077696c6c206265207573656420666f72207374616b696e6720616e6420626f6f737473206f6e2074686520706c6174666f726d2e2054686520746f6b656e206973206465666c6174696f6e6172793a2065766572792050554d50207573656420746f207075726368617365206120626f6f73742077696c6c2062652073656e7420746f206120646561642077616c6c65742c207265647563696e672074686520737570706c79206f7665722074696d652e0a202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMP>>(v4);
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

