module 0x55be64715ad7699ae16e733f586ba62658cc3cd9463ba12aebfaf8b1a0a422f6::shitoshi {
    struct SHITOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2xBoJ3dvWZ2eyJeaxR2psqnHe3GftxUFiHkwzxPVpump.png?claimId=c0huohwFPWVPBa4-                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHITOSHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"shitoshi    ")))), trim_right(b"shitoshi fartamoto              "), trim_right(x"4d6164652062792046617274636f696e206465762e0a0a5468697320697320746865206f6666696369616c206e65772043544f210a0a5468652044657620626568696e6420626f7468202446617274636f696e20616e64202453686974636f696e2c20536869746f7368692046617274616d6f746f2c20686173206e6f77206d616465206120636f696e206261736564206f6e20686973206f776e20646576656c6f706572206e616d652024534849544f5348492028536869746f7368692046617274616d6f746f292e0a0a46617274636f696e2024312e3542206d63202843757272656e7429200a53686974636f696e202d202431392e374d696c206d632028415448290a476f6f636820636f696e202d202432322e374d696c206d632028415448290a0a536869746f7368692046617274616d6f746f2069732062617365"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITOSHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITOSHI>>(v4);
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

