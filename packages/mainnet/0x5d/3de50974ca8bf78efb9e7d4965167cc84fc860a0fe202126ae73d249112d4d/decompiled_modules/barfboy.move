module 0x5d3de50974ca8bf78efb9e7d4965167cc84fc860a0fe202126ae73d249112d4d::barfboy {
    struct BARFBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARFBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/mVuzEMo5n4p6iHNFGWsFkACB2F1vNmW8BdwoyKApump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BARFBOY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Barfboy     ")))), trim_right(b"Barf Boy                        "), trim_right(x"496e74726f647563696e67204261726620426f7920282442415246424f592920746865206d656d65636f696e20736f2077696c642c2069746c6c206861766520796f757220706f7274666f6c696f206d6f6f6e696e6720616e6420796f75722073746f6d616368207475726e696e672120426f726e2066726f6d20746865206368616f73206f662063727970746f20726f6c6c6572636f6173746572732c202442415246424f5920697320666f7220746865207472756520646567656e732077686f20686f646c207468726f75676820746865206e617573656120616e6420656d627261636520746865207570732c20646f776e732c20616e642066756c6c2d626c6f776e206d6f6f6e2d696e6475636564206d6f74696f6e207369636b6e6573732e0a0a4a4f494e205448452054454c454752414d20202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARFBOY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARFBOY>>(v4);
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

