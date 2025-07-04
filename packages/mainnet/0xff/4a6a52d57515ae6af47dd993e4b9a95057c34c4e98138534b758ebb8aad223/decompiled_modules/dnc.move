module 0xff4a6a52d57515ae6af47dd993e4b9a95057c34c4e98138534b758ebb8aad223::dnc {
    struct DNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/42HsffEQoHqWoeiffksYayC75fQDxaoUdMBzmeXdpump.png?claimId=DBbrpLo3BK2zSva3                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DNC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DNC         ")))), trim_right(b"Diamond Nutted Chads            "), trim_right(x"24444e4320284469616d6f6e64204e75747465642043686164732920697320612066756c6c2d626c6f776e20436f6d6d756e6974792054616b656f766572202843544f292070726f6a6563742077697468207a65726f20646576732c206e6f205643206261636b696e676a75737420726177204368616420656e657267792e20416674657220737572766976696e67206120646f75626c65207363616d2c20612063726577206f6620756e7368616b656e20686f6c64657273207475726e656420777265636b61676520696e746f206f70706f7274756e6974792c2072656275696c64696e672024444e4320696e746f206120626f6c642047616d6546692065636f73797374656d2e0a5769746820626f756e7469657320666f7220686f6c646572732c20636f6e74656e742063726561746f72732c20616e6420636f6d6d75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNC>>(v4);
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

