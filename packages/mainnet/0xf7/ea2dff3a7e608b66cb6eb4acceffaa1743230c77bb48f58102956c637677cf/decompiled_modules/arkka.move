module 0xf7ea2dff3a7e608b66cb6eb4acceffaa1743230c77bb48f58102956c637677cf::arkka {
    struct ARKKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARKKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DJ9zjn7StopHFKAdpGiH17k2iQqZixkeugMsHo4kpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ARKKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ARKK        ")))), trim_right(b"Ark in vest                     "), trim_right(x"41726b20496e20766573740a0a612062657474657220696e766573746d656e74207468616e2041726b20696e76657374202c2043617468696520576f6f6420636f756c64206e65766572206c65616420736f6d657468696e67207468697320696e6e6f7661746976652c207374796c69736820616e642067726f777468206f7269656e746564200a0a696e7665737420696e202441524b4b20696e207665737420746f64617920202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARKKA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARKKA>>(v4);
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

