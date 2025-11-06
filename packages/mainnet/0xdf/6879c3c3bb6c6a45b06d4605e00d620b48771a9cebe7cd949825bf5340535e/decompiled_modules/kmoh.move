module 0xdf6879c3c3bb6c6a45b06d4605e00d620b48771a9cebe7cd949825bf5340535e::kmoh {
    struct KMOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: KMOH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/o9JiQ4v2-6I9Oiv90VzMOt7MsghM78e0HMbIVpSPhzg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/o9JiQ4v2-6I9Oiv90VzMOt7MsghM78e0HMbIVpSPhzg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<KMOH>(arg0, 9, trim_right(b"KMOH"), trim_right(b"KMOH  "), trim_right(b"KMOH Fan"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KMOH>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KMOH>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KMOH>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

