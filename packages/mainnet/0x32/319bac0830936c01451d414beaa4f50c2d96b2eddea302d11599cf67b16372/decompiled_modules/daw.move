module 0x32319bac0830936c01451d414beaa4f50c2d96b2eddea302d11599cf67b16372::daw {
    struct DAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/aDniBKD8XpRP6Y4jBZQVwH1K1uf8NYZbG8Uz1wXpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DAW>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DAW         ")))), trim_right(b"Devs Are Working                "), trim_right(x"54686520556c74696d61746520536f6369616c204578706572696d656e743a20527567676564204e6f204d6f7265210a0a5469726564206f66206265696e67207275676765643f20576527766520616c6c206265656e207468657265202d206f7665722035302074696d65732c20746f2062652065786163742e2045766572792074696d652c2074686520636f6d6d756e69747920706f696e74732066696e676572732061742074686520646576732c206163637573696e67207468656d206f662070756c6c696e6720746865207275672e0a0a42757420776861742069662077652772652077726f6e673f205768617420696620746865207265616c2063756c70726974732061726520686964696e6720696e20706c61696e2073696768743f0a0a496e74726f647563696e6720244441572028446576732061726520576f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAW>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAW>>(v4);
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

