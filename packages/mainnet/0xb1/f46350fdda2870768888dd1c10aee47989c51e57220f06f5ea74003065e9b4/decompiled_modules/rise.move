module 0xb1f46350fdda2870768888dd1c10aee47989c51e57220f06f5ea74003065e9b4::rise {
    struct RISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"zQTJ9BLweQukRRdY                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RISE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RISE        ")))), trim_right(b"$RISE - Official Black History  "), trim_right(x"20496e74726f647563696e6720245249534520207468652031737420616e64204f4646494349414c20746f6b656e20666f722065766572797468696e6720426c61636b20486973746f7279212043656c65627261746520426c61636b20486973746f7279204d6f6e7468206f6e2074686520626c6f636b636861696e2e2048656c702075732067697665206261636b2e0d0a0d0a2043413a200d0a20726973656f6e736f6c2e6f72670d0a2043727970746f50756d7043617573650d0a20742e6d652f726973656f6e736f6c0d0a2074696b746f6b2e636f6d2f40726973656f6e736f6c0d0a20696e7374616772616d2e636f6d2f63727970746f70756d7063617573650d0a0d0a2053686172652c206c6561726e2c20616e642072697365207769746820757321200d0a20446f75626c652d636865636b2074686520636f6e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISE>>(v4);
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

