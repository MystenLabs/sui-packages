module 0xba4a351f647df54ae3ac9024b201e8ccf0d6ba471197b1202dfad87d6b517a85::wxjg {
    struct WXJG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WXJG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/OuaFNWuY58_iYyq0o9LaDLJbdoc0hfCopOHOrz9Cguo";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/OuaFNWuY58_iYyq0o9LaDLJbdoc0hfCopOHOrz9Cguo"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<WXJG>(arg0, 9, trim_right(b"WXJG"), trim_right(b"WXJG  "), trim_right(b"WXJGTOFAN"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WXJG>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WXJG>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WXJG>>(v4);
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

