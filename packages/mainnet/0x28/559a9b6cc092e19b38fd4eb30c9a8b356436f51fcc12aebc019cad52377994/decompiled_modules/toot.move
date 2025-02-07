module 0x28559a9b6cc092e19b38fd4eb30c9a8b356436f51fcc12aebc019cad52377994::toot {
    struct TOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cs64QFcSh9nyDStRgdj3JaSxzyt6T51E9BPR382XbTxx.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TOOT        ")))), trim_right(b"Tootmeister by Fart Club        "), trim_right(x"57656c636f6d6520746f20546f6f746d656973746572206279204661727420436c7562202d204164616d2057616c6c61636520616e64204a616d657320486172740a0a5374657020696e746f2074686520666172742d74617374696320756e697665727365206f66204d617820416e64726577732c20616b612054686520546f6f746d65697374657274686520756c74696d6174652064696e6f736175722d6c6f76696e672c206761732d706f7765726564206865726f2120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOOT>>(v4);
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

