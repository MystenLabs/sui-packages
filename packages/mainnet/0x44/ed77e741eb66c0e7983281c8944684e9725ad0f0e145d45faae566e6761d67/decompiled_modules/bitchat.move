module 0x44ed77e741eb66c0e7983281c8944684e9725ad0f0e145d45faae566e6761d67::bitchat {
    struct BITCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HsubwaQv2FvtgVc3gSMEu9GD5whey5BjmBCFo1zHR1wS.png?claimId=8FLuCzkT17gTWclM                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BITCHAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BITCHAT     ")))), trim_right(b"bitchat                         "), trim_right(b"Bitchat is a new messaging app that runs using Bluetooth. Bitchat also supports Nostr relays, meaning you can talk over the internet too, privately and peer to peer. Whether you're offline or online, Bitchat is designed for privacy and freedom. Theres deeper crypto integration in the code.                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITCHAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITCHAT>>(v4);
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

