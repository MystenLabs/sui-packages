module 0xb3d19f72fc73ead1b7b89fb46ab21e33fcca94e98e85025def164a791545b07a::vigi {
    struct VIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HeBCP2imwM8vosBqU5PBvm1PamCzWj2ch9ZhVrsLpump.png?claimId=eNSgiwNio3R4ER4E                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VIGI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VIGI        ")))), trim_right(b"Vigilante                       "), trim_right(x"5468652073747265657473206172652066696c6c65642077697468207275672070756c6c7320616e64207363616d732e2e2e206275742066656172206e6f742c20666f7220566967696c616e746520546f6b656e206973206865726520746f206272696e67207265747269627574696f6e20746f2074686520626c6f636b636861696e2120546869732069736e2774206a75737420616e6f74686572206d656d65636f696e2d697427732061206d6f76656d656e742e0a57686174206d616b657320245649474920646966666572656e743f0a4275696c7420666f72207468650a7265616c206f6e6573202d204e6f206465762064756d70732c206e6f20696e73696465722067616d65732d6f6e6c79207075726520636f6d6d756e6974792d64726976656e20616374696f6e2e0a537769667420616e6420666561726c6573"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIGI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIGI>>(v4);
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

