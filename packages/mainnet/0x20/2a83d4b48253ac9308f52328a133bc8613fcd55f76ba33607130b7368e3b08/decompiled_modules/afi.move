module 0x202a83d4b48253ac9308f52328a133bc8613fcd55f76ba33607130b7368e3b08::afi {
    struct AFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f2c30fbe64c3e43f8f58fd572f90574fb8aabdfde40efb4fa7734bc193d9c6e1                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AFI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AFI         ")))), trim_right(b"AlphaFi                         "), trim_right(x"416c706861466920697320796f7572207072656d696572205765623320646576656c6f706d656e7420706172746e65722c207370656369616c697a696e6720696e20536f6c616e6120626c6f636b636861696e20736f6c7574696f6e732e2046726f6d2063727970746f20746f6b656e7320746f20646563656e7472616c697a6564206170706c69636174696f6e732c207765207475726e20796f757220626c6f636b636861696e20766973696f6e20696e746f207265616c6974792e0a0a417320746865206e617469766520746f6b656e206f66206f757220646576656c6f706d656e74206669726d206275696c74206f6e20536f6c616e612c2024414649207265776172647320686f6c64657273207769746820636f696e732066726f6d207468726976696e672070726f6a6563747320696e206f7572206e6574776f72"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFI>>(v4);
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

