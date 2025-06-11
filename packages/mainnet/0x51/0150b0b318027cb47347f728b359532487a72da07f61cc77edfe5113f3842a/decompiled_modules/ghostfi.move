module 0x510150b0b318027cb47347f728b359532487a72da07f61cc77edfe5113f3842a::ghostfi {
    struct GHOSTFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSTFI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3QYgRBYG8qQxKq8wkwrv7xZZATn2wozeVW7C7Aw6fREV.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GHOSTFI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GHOSTFI     ")))), trim_right(b"GhostFi                         "), trim_right(x"547261646520536d61727465722e20547261696e2053616665722e0a0a446f6d696e61746520746865204d656d65636f696e204d61726b65742e0a0a457870657269656e6365206e6578742d67656e2073696d756c617465642063727970746f2074726164696e67207468726f7567682054656c656772616d2e20506f77657265642062792047484f53544649206f6e2074686520536f6c616e6120626c6f636b636861696e2e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSTFI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GHOSTFI>>(v4);
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

