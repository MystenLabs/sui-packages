module 0x26aace58b5c993898a4743448951a7ca6c92df9b873780cf5c9b5a92072ab542::surge {
    struct SURGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"uT5eZgKPiAAUqcpe                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SURGE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SURGE       ")))), trim_right(b"Surge Coin                      "), trim_right(x"537572676520436f696e202824535552474529202054686520556c74696d61746520426c617374206f6620456e65726779206f6e2074686520426c6f636b636861696e210d0a0d0a47657420726561647920666f722061206e6f7374616c6769632c20686967682d6f6374616e652072757368207769746820537572676520436f696e202824535552474529746865206d656d6520636f696e2074686174206869747320686172646572207468616e20612063616e206f66203930732065787472656d6520736f646121204675656c65642062792070757265206368616f732c206361666665696e652c20616e64206e6f7374616c6769612c207468697320636f696e2069732074616b696e67206f7665722074686520626c6f636b636861696e20666173746572207468616e206120736b617465626f6172646572206f6e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURGE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURGE>>(v4);
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

