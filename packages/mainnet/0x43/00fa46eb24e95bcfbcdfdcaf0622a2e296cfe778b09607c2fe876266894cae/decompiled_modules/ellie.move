module 0x4300fa46eb24e95bcfbcdfdcaf0622a2e296cfe778b09607c2fe876266894cae::ellie {
    struct ELLIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELLIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c8be709589514f84e52735fda2a755f5d0f82eb183ab848022929e8c170f6522                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ELLIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ELLIE       ")))), trim_right(b"ELLIE                           "), trim_right(x"456c6c69652069732074686520666972737420636174206576657220647261776e20627920612068756d616e207573696e67206f6e6c7920707572652074686f75676874207769746820746865204e7572616c696e6b206f776e656420627920456c6f6e204d75736b0a0a536865207761732063726561746564206279204175647265792043726577732c2077686f20686173206265656e20706172616c797a65642066726f6d20746865206e65636b20646f776e20666f72206f7665722074776f20646563616465732e20417564726579206973207468652066697273742066656d616c65204e657572616c696e6b204243492070617469656e742c20616e642074686174732077687920456c6c6965206973206b6e6f776e20617320746865204e657572616c696e6b204361742e0a0a31303025206f6620616c6c207472"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELLIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELLIE>>(v4);
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

