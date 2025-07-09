module 0xdab208178ce89a6bbece21bcf98c465ed3d8e5dba76fd02d36779167de9931ae::wtfo {
    struct WTFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/8C4RygkxmePm9ys1qCcAB46dUCXNQYTaqfxS5mBrpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WTFO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WTFO        ")))), trim_right(b"WTF Opossum                     "), trim_right(b"WE ARE A CLAN. A NEST OF ALPHA OPOSSUMS. A WTF LEVEL OF ALPHA OPOSSUM.  WE DECIDED TO BUILD OUR NEW HOME ON SOLANA BLOCKCHAIN WHERE WE CAN GROW OUR COMMUNITY TO CONQUER THE CRYPTO SPACE.   WTF I SOLD AND ITS PUMPING AGAIN!  REMEMBER THIS IF YOU ARE LOOKING FOR A DEGEN FLIP. OPOSSUM IS DIFFERENT, OPOSSUM IS ALPHA.      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTFO>>(v4);
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

