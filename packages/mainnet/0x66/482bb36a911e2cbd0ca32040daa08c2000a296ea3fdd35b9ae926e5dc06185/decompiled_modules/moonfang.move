module 0x66482bb36a911e2cbd0ca32040daa08c2000a296ea3fdd35b9ae926e5dc06185::moonfang {
    struct MOONFANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONFANG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/554nZhL7Enb6NWC7NSbJa1eD8hps5YyUKsqFTJzKpump.png?claimId=F0E9IcbCj-OF5q-Q                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOONFANG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MoonFang    ")))), trim_right(b"Moonfang                        "), trim_right(x"4d6f6f6e2046616e672043544f20706572666f726d65642062792074686520636f6d6d756e6974792e204f726967696e616c206465762077617320646973686f6e6573742064756d70656420686973206261672e205768696c6520646f696e67207468697320686520776173207275672070756c6c696e67206f7468657220636f696e7320737563682061732024537761726d2e0a0a5768616c657320686f6c64696e6720737570706c792061726520646f7878656420616e64206e6f7420676976696e672075702e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONFANG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONFANG>>(v4);
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

