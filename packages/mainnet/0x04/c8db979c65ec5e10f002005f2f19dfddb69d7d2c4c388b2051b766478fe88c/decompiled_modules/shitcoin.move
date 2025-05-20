module 0x4c8db979c65ec5e10f002005f2f19dfddb69d7d2c4c388b2051b766478fe88c::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DD1Nxg9KZ9C2rBk96iMLkfJryttzK9U4wV936C4Qpump.png?claimId=qWZSBw04OPhasM5p                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SHITCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SHITCOIN    ")))), trim_right(b"The Final Bitcoin               "), trim_right(x"54686520444556204a414d45532073656e74207468697320636f696e20746f20364d2c20616e64206c656674206174203330304b2064756520746f2074686520636f696e206265696e67206661726d65642e0a4865206e6f77206c61756e636865642061206e657720636f696e20756e646572207468652074726164656d61726b6564206272616e642077697468203535304d20737570706c79206c6f636b65642e0a53656c6c207468697320636f696e20616e642062757920746865206e65772043410a43413a2046736f695654415a484370434d6433767051516b65627a4c5835713468436559435a7942374d4d6f70756d70202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITCOIN>>(v4);
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

