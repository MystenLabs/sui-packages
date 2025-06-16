module 0xa8bc36daa255e860fddeebeebc179ff278fa3ce19cbda7f35ce20391c7985f5::fartgoat {
    struct FARTGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DhUv2ryUP9MYAbBxxmL4yneczFAY6KvgnArCYpFVpump.png?claimId=TIO9hx5YYan53x6N                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTGOAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTGOAT    ")))), trim_right(b"Goatseus Fartimus               "), trim_right(x"5468652070726f706865637920636f6e74696e7565732e2e2e20627574206e6f772069742773206f757273210a476f6174736575732046617274696d7573206c69742074686520737061726b2c2062757420746865202446415254474f41542063756c7420686173206f6666696369616c6c79206265656e2074616b656e206f7665722062792074686520636f6d6d756e6974792e0a546865204f4720666172742d706f7765726564206d656d65636f696e206973206e6f772066756c6c792064726976656e206279207468652062656c6965766572736e6f20646576206f7665726c6f7264732c206e6f20727567732c206e6f2066616b65732e0a54686973206973206120707572652c20636f6d6d756e6974792d6c6564206d6f76656d656e74207769746820756e73746f707061626c6520676f6174656420656e657267"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTGOAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTGOAT>>(v4);
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

