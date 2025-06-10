module 0x78b26cceef375434bff86a0cbc34379d44c68dc9445c4bbc03ef44f169bffae::holmes {
    struct HOLMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLMES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DvFh3mspfsZ9BAjp2oYqyUotVrKwjzvn2Pfbs8gCpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOLMES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Holmes      ")))), trim_right(b"Harold Holmes                   "), trim_right(x"4861726f6c6420486f6c6d65732028486f6c6d6573290a4a61636b205768697465732043727970746f2043756c74206c79726963732077657265206372656174656420666f722063727970746f20656e7468757369617374732120576174636820596f755475626520766964656f2077697468206c797269637321204920686176652061207370656369616c2066696e616e6369616c20626c657373696e672074686174206f6e63652049206861766520706c6163656420696e20796f75722068616e64205965616820492077616e7420796f7520746f20626567696e207573696e67207468697320626c657373696e67206f6e20746865207665727920666972737420646179207468617420796f752063616e2042792073756e646f776e2c204d6f6e64617920596f752077686f20636f6d652077696c6c20626520626c65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLMES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLMES>>(v4);
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

