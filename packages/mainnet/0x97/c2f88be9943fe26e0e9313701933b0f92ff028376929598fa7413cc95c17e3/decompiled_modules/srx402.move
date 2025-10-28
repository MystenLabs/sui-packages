module 0x97c2f88be9943fe26e0e9313701933b0f92ff028376929598fa7413cc95c17e3::srx402 {
    struct SRX402 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX402, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"81accb0093f106799b7447312a04a53037d68ab44523b92dfe3f6528fd8e62f8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SRX402>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SRx402      ")))), trim_right(b"Silk-Roadx402                   "), trim_right(b"Silk Road x402 is an anonymous marketplace on Solana where developers can list and sell private, legal software tools like bots and scripts without revealing their identities. It leverages the x402 protocol for instant, micropayment transactions in USDC, enabling seamless pay-per-download or pay-per-use without account"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX402>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX402>>(v4);
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

