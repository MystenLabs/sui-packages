module 0x965486e55af85633d5b871dd378f3e3a5603accd3713b8acdd582f3a3693e3fd::epb {
    struct EPB has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GsKuLQsKCEnfQxuk4icTEQjc11Av8WiqW31CxZqZpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EPB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ePB         ")))), trim_right(b"BOUNCY BALL of OFiD Fun         "), trim_right(x"57656c636f6d6520746f204f4669444372797074732046756e20426f756e63792042616c6c2020486f6d65206f6620655020576562332120496620796f7520676f742062616c6c732c20636f6e67726174732120596f757265206e6f7720612062616c6c2d626167676572210a0a204c69766573747265616d2026205363686564756c653a0a5b534545204c494e4b535d0a0a4f46694443727970742046756e2069732061206469766973696f6e206f66206f75722065502057656233204d61726b6574696e6720706c6174666f726d2e2057652068617665206120726f61646d617020696e20646576656c6f706d656e7420666f722042616c6c20486f6c6465727320746f20686176652066757475726520766f74696e672072696768747320746f77617264732066756e20616374697669746965732c2067616d65732c20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPB>>(v4);
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

